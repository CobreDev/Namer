THEOS_DEVICE_IP=192.168.1.47

TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = Preferences


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Namer

Namer_FILES = Tweak.xm
Namer_CFLAGS = -fobjc-arc
Namer_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += namerprefs
include $(THEOS_MAKE_PATH)/aggregate.mk