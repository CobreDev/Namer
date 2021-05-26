#import <Cephei/HBPreferences.h>
#import "GcUniversal/GcImagePickerUtils.h"
#import <QuartzCore/QuartzCore.h> // Required for corner radius (I think)

@import Foundation;
@import UIKit;

@interface PSUIAppleAccountCell : UITableViewCell
@property (nonatomic, retain) UIImageView *imageView;
@end

// Also for corner radius
@interface CALayer (Undocumented) 
@property (assign) BOOL continuousCorners;
@end

// Our pref file
#define PLIST_PATH @"/var/mobile/Library/Preferences/dev.cobre.namerprefs.plist"

// Initialize the custom text, this is a fallback for when there's no pref file (Like on the initial install)
static NSString *customText = @"Name";

// Initialize both switches
BOOL NAMEnabled;
BOOL NAMcustomPic;

%group Tweak

%hook PSUIAppleAccountCell

// This was ~~stolen~~ inspired by Kritanta's "NotDoxxed" tweak
- (UILabel *)textLabel {

    UILabel *origVar = %orig;
    [origVar setText:customText];
    return origVar;

}

-(void)layoutSubviews { // Only using layoutSubviews until I can find a good method to use

	%orig;
    if (NAMcustomPic) {
        self.imageView.image = [GcImagePickerUtils imageFromDefaults:@"dev.cobre.namerprefs" withKey:@"YourImage"];
        self.imageView.layer.masksToBounds = YES;
        
        // Some continuous corner trickery I heard I'm supposed to do
        self.imageView.layer.cornerRadius = self.imageView.frame.size.height/2;
        if (@available(iOS 13.0, *)) {
            self.imageView.layer.cornerCurve = kCACornerCurveContinuous;
        }
        
        else {
            self.imageView.layer.continuousCorners = YES;
        }

        // I'm still not super happy with the corner radii, but it'll work for now
    }
}

%end

%end

// I don't understand what all of this stuff does, but prefs don't work without it so I'm keeping it :)
static void loadPrefs() {

    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];

    customText = [settings objectForKey:@"customText"] ?[settings objectForKey : @"customText"]  : @"Name";
}

%ctor {

    loadPrefs();

	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"dev.cobre.namerprefs"];

	[preferences registerBool:&NAMEnabled default:YES forKey:@"NAMEnabled"];
	[preferences registerBool:&NAMcustomPic default:YES forKey:@"NAMcustomPic"];

	if (NAMEnabled) {
      %init(Tweak);
    }
}