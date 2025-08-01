.PHONY: prepare build build-development build-beta load

GLOBAL_BUILD_DIR = /tmp/.kiwi-build-results
TARGET_DIR = $(GLOBAL_BUILD_DIR)/ark-survival-ascended-linux-container-image
THREADS = $(shell nproc)

prepare:
	- sudo rm -rf $(TARGET_DIR)
	- mkdir -p $(GLOBAL_BUILD_DIR)
	- python3 -m venv ./venv
	- ./venv/bin/pip install -r requirements.txt

build: prepare
	- sudo ./venv/bin/kiwi-ng --profile stable --color-output --debug system build --target-dir $(TARGET_DIR) --description .
	- ls $(TARGET_DIR)/*.tar >/dev/null 2>&1 && sudo xz --threads $(THREADS) -z $(TARGET_DIR)/*.tar

build-development: prepare
	- sudo ./venv/bin/kiwi-ng --profile development --color-output --debug system build --target-dir $(TARGET_DIR) --description .
	- ls $(TARGET_DIR)/*.tar >/dev/null 2>&1 && sudo xz --threads $(THREADS) -z $(TARGET_DIR)/*.tar

build-beta: prepare
	- sudo ./venv/bin/kiwi-ng --profile beta --color-output --debug system build --target-dir $(TARGET_DIR) --description .
	- ls $(TARGET_DIR)/*.tar >/dev/null 2>&1 && sudo xz --threads $(THREADS) -z $(TARGET_DIR)/*.tar

load:
	- sudo docker load -i $(TARGET_DIR)/*.xz
