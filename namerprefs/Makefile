TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = NamerPrefs

NamerPrefs_FILES = NAMRootListController.m NAMSwitchWithInfoCell.m
NamerPrefs_FRAMEWORKS = UIKit
NamerPrefs_PRIVATE_FRAMEWORKS = Preferences
NamerPrefs_INSTALL_PATH = /Library/PreferenceBundles
NamerPrefs_CFLAGS = -fobjc-arc
NamerPrefs_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
NamerPrefs_LIBRARIES = gcuniversal

include $(THEOS_MAKE_PATH)/bundle.mk
