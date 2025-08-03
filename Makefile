.PHONY: prepare build build-development build-beta load

GLOBAL_BUILD_DIR = /tmp/.kiwi-build-results
TARGET_DIR = $(GLOBAL_BUILD_DIR)/ark-survival-ascended-linux-container-image
THREADS = $(shell nproc)
BUILD_OPTS = --color-output --debug system build --target-dir $(TARGET_DIR) --description .

prepare:
	- sudo rm -rf $(TARGET_DIR)
	- mkdir -p $(GLOBAL_BUILD_DIR)
	- python3 -m venv ./venv
	- ./venv/bin/pip install -r requirements.txt

build: prepare
	- sudo ./venv/bin/kiwi-ng --profile stable $(BUILD_OPTS)

build-development: prepare
	- sudo ./venv/bin/kiwi-ng --profile development $(BUILD_OPTS)

build-beta: prepare
	- sudo ./venv/bin/kiwi-ng --profile beta $(BUILD_OPTS)

load:
	- sudo docker load -i $(TARGET_DIR)/*.xz
