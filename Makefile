# Run via `make setup` in commandline
# to download example audio files. After download add files to your target.

IOSDIR="http://dev.mach1.tech/mach1-sdk-sample-audio/ios"

# getting OS type
ifeq ($(OS),Windows_NT)
	detected_OS := Windows
else
	detected_OS := $(shell uname)
endif

setup: 
	mkdir -p "TestingAudioFiles"
ifeq ($(detected_OS),Darwin)
	cd "TestingAudioFiles" && wget $(IOSDIR)/mach1-decode-example/000.aif && wget $(IOSDIR)/mach1-decode-example/001.aif && wget $(IOSDIR)/mach1-decode-example/002.aif && wget $(IOSDIR)/mach1-decode-example/003.aif && wget $(IOSDIR)/mach1-decode-example/004.aif && wget $(IOSDIR)/mach1-decode-example/005.aif && wget $(IOSDIR)/mach1-decode-example/006.aif && wget $(IOSDIR)/mach1-decode-example/007.aif && wget $(IOSDIR)/mach1-decode-example/stereo.wav
endif
ifeq ($(detected_OS),Windows)
endif

# Run via `make build` in command line
build: setup
	cd Mach1AudioPlayerAPI && pod install
	cd ios-app && pod install && pod update