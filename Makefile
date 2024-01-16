red = "\033[31m"
green = "\033[32m"
yellow = "\033[33m"
blue = "\033[34m"
magenta = "\033[35m"
cyan = "\033[36m"
white = "\033[37m"
reset = "\033[0m"

.PHONY: run
run:
	@echo $(red)Compiling...$(reset)
	flutter run --no-sound-null-safety
	@echo $(green)Done!$(reset)

.PHONY: apk
apk:
	@echo $(red)Compiling...$(reset)
	flutter build apk --release --no-sound-null-safety
	@echo $(green)Done!$(reset)

.PHONY: cp
cp:
	@echo $(red)Copying...$(reset)
	cp build/app/outputs/flutter-apk/app-release.apk . && mv app-release.apk musaneda.apk
	@echo $(green)Done!$(reset)

.PHONY: cli
cli:
	@echo $(red)Global activate GET CLI...$(reset)
	flutter pub global activate get_cli
	@echo $(green)Done!$(reset)

.PHONY: exports
exports:
	@echo $(red)Exporting...$(reset)
	export PATH="$PATH":"$HOME/.pub-cache/bin"
	@echo $(green)Done!$(reset)

.PHONY: clean
clean:
	@echo $(red)Cleaning...$(reset)
	rm -rf build
	@echo $(green)Done!$(reset)

.PHONY: install
install:
	@echo $(red)Installing...$(reset)
	flutter pub get
	@echo $(green)Done!$(reset)
	@echo $(red)Upgrading...$(reset)
	flutter pub upgrade
	@echo $(green)Done!$(reset)

.PHONY: web
web:
	@echo $(red)Compiling Web...$(reset)
	flutter build web --release --no-sound-null-safety --web-renderer=html
	@echo $(green)Done!$(reset)
.PHONY: help
help:
	@echo $(red)Available commands:$(reset)
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  run     Run the app on your connected device"
	@echo "  apk     Build an APK"
	@echo "  cp      Copy the APK to the root directory"
	@echo "  clean   Clean the build directory"
	@echo "  install Install dependencies"
	@echo "  help    Show this help message"
	@echo "  web     Build the web version"
	@echo "  get     Install the get_cli"
	@echo ""
	@echo $(green)Done!$(reset)