# Makefile

BIN_DIR  := $(HOME)/dotfile/bin
DEST_DIR := /usr/local/bin
SCRIPTS  := kubectl helm

OWNER    := $(shell if [ -n "$$SUDO_USER" ]; then echo $$SUDO_USER; else whoami; fi)

.PHONY: install
install:
	@echo "→ Installing scripts to $(BIN_DIR) as $(OWNER)…"
	@mkdir -p $(BIN_DIR)
	@for script in $(SCRIPTS); do \
		echo "→ Copying $$script to $(BIN_DIR)/$$script"; \
		cp ./$$script $(BIN_DIR)/$$script; \
		chmod +x $(BIN_DIR)/$$script; \
		sudo chown $(OWNER):$(OWNER) $(BIN_DIR)/$$script; \
		echo "→ Linking $$script to $(DEST_DIR)/$$script"; \
		sudo ln -sf $(BIN_DIR)/$$script $(DEST_DIR)/$$script; \
	done
	@echo "✔ Installed all scripts."

.PHONY: uninstall
uninstall:
	@echo "→ Removing scripts from $(DEST_DIR) and $(BIN_DIR)…"
	@for script in $(SCRIPTS); do \
		echo "→ Removing link $(DEST_DIR)/$$script"; \
		sudo rm -f $(DEST_DIR)/$$script; \
		echo "→ Removing $(BIN_DIR)/$$script"; \
		sudo rm -f $(BIN_DIR)/$$script; \
	done
	@echo "✔ Uninstalled all scripts."