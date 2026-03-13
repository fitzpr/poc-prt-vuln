# Legitimate Makefile — this is what lives in the "upstream" repo.
# It does nothing interesting; the attacker replaces it in their fork.

.PHONY: build

build:
	@echo "Building project..."
	@echo "Build complete."
