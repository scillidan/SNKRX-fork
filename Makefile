GAME_NAME = SNKRX
DIST_DIR = dist
ENGINE_DIR = engine/love
BUILD_DIR = build

EXCLUDE_FILES = engine engine/love builds steam .git *.moon conf.lua

.PHONY: all clean windows linux linux-arm

all: windows linux linux-arm

clean:
	rm -rf $(DIST_DIR) $(BUILD_DIR)

$(DIST_DIR):
	mkdir -p $(DIST_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/$(GAME_NAME).love: | $(BUILD_DIR)
	cd . && zip -r $(BUILD_DIR)/$(GAME_NAME).love . \
		-x "engine/love/*" \
		-x "builds/*" \
		-x "steam/*" \
		-x ".git/*" \
		-x "*.moon" \
		-x "conf.lua" \
		-x "Makefile" \
		-x "build.sh"

windows: $(BUILD_DIR)/$(GAME_NAME).love | $(DIST_DIR)
	mkdir -p $(BUILD_DIR)/windows
	cp $(ENGINE_DIR)/love.exe $(BUILD_DIR)/windows/
	cp $(ENGINE_DIR)/*.dll $(BUILD_DIR)/windows/
	cat $(ENGINE_DIR)/love.exe $(BUILD_DIR)/$(GAME_NAME).love > $(BUILD_DIR)/windows/$(GAME_NAME).exe
	cp $(ENGINE_DIR)/license.txt $(BUILD_DIR)/windows/ 2>/dev/null || true
	cp $(ENGINE_DIR)/changes.txt $(BUILD_DIR)/windows/ 2>/dev/null || true
	cd $(BUILD_DIR) && zip -r ../$(DIST_DIR)/$(GAME_NAME)-windows.zip windows

linux: $(BUILD_DIR)/$(GAME_NAME).love | $(DIST_DIR)
	mkdir -p $(BUILD_DIR)/linux
	@if [ -f $(ENGINE_DIR)/love-linux/love ]; then \
		cp $(ENGINE_DIR)/love-linux/love $(BUILD_DIR)/linux/$(GAME_NAME); \
		cat $(BUILD_DIR)/linux/$(GAME_NAME) $(BUILD_DIR)/$(GAME_NAME).love > $(BUILD_DIR)/linux/$(GAME_NAME).tmp && \
		mv $(BUILD_DIR)/linux/$(GAME_NAME).tmp $(BUILD_DIR)/linux/$(GAME_NAME); \
		chmod +x $(BUILD_DIR)/linux/$(GAME_NAME); \
		cp $(ENGINE_DIR)/love-linux/*.so $(BUILD_DIR)/linux/ 2>/dev/null || true; \
		cp $(ENGINE_DIR)/love-linux/license.txt $(BUILD_DIR)/linux/ 2>/dev/null || true; \
		cd $(BUILD_DIR) && zip -r ../$(DIST_DIR)/$(GAME_NAME)-linux.zip linux; \
	else \
		echo "Linux love binaries not found in $(ENGINE_DIR)/love-linux/"; \
		echo "Please download from https://github.com/love2d/love/releases"; \
	fi

linux-arm: $(BUILD_DIR)/$(GAME_NAME).love | $(DIST_DIR)
	mkdir -p $(BUILD_DIR)/linux-arm
	@if [ -f $(ENGINE_DIR)/love-linux-arm/love ]; then \
		cp $(ENGINE_DIR)/love-linux-arm/love $(BUILD_DIR)/linux-arm/$(GAME_NAME); \
		cat $(BUILD_DIR)/linux-arm/$(GAME_NAME) $(BUILD_DIR)/$(GAME_NAME).love > $(BUILD_DIR)/linux-arm/$(GAME_NAME).tmp && \
		mv $(BUILD_DIR)/linux-arm/$(GAME_NAME).tmp $(BUILD_DIR)/linux-arm/$(GAME_NAME); \
		chmod +x $(BUILD_DIR)/linux-arm/$(GAME_NAME); \
		cp $(ENGINE_DIR)/love-linux-arm/*.so $(BUILD_DIR)/linux-arm/ 2>/dev/null || true; \
		cp $(ENGINE_DIR)/love-linux-arm/license.txt $(BUILD_DIR)/linux-arm/ 2>/dev/null || true; \
		cd $(BUILD_DIR) && zip -r ../$(DIST_DIR)/$(GAME_NAME)-linux-arm.zip linux-arm; \
	else \
		echo "Linux ARM love binaries not found in $(ENGINE_DIR)/love-linux-arm/"; \
		echo "Please build love for ARM or download from https://github.com/love2d/love/releases"; \
	fi

love: $(BUILD_DIR)/$(GAME_NAME).love
	cp $(BUILD_DIR)/$(GAME_NAME).love $(DIST_DIR)/