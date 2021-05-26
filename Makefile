THEOS_DEVICE_IP=hackingdevice

AARCHS = arm64 arm64e
TARGET := iphone:clang:latest:11.0
INSTALL_TARGET_PROCESSES = Preferences


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Namer

Namer_FILES = Tweak.xm
Namer_CFLAGS = -fobjc-arc
Namer_EXTRA_FRAMEWORKS += Cephei
Namer_LIBRARIES = gcuniversal

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += namerprefs
include $(THEOS_MAKE_PATH)/aggregate.mk