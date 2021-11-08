# Run via `make setup` in commandline
# to download example audio files. After download add files to your target.

IOSDIR="http://dev.mach1.tech/mach1-sdk-sample-audio/ios"

# getting OS type
ifeq ($(OS),Windows_NT)
	detected_OS := Windows
else
	detected_OS := $(shell uname)
endif

# Run via `make build` in command line
build:
	cd Mach1AudioPlayerAPI && pod install
	cd ios-app && pod install && pod update