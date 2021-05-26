#import <Cephei/HBPreferences.h>

@import Foundation;
@import UIKit;

@interface PSUIAppleAccountCell : UITableViewCell
@property (nonatomic, retain) UIImageView *imageView;
@end

#define PLIST_PATH @"/var/mobile/Library/Preferences/dev.cobre.namerprefs.plist"

static NSString *customText = @"Name";

UIImage *pfpImage;
UIImageView* pfpImageView;

BOOL NAMEnabled;

%group Tweak

%hook PSUIAppleAccountCell
- (UILabel *)textLabel {

    UILabel *origVar = %orig;
    [origVar setText:customText];
    return origVar;
}

// -(void)layoutSubviews{
-(void)setCenter{

	%orig;
    NSLog(@"NAMERTWEAK: setCenter");
}

%end

%end

static void loadPrefs() {

    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];

    customText = [settings objectForKey:@"customText"] ?[settings objectForKey : @"customText"]  : @"Name";
}

%ctor {

    loadPrefs();

	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"dev.cobre.namerprefs"];

	[preferences registerBool:&NAMEnabled default:YES forKey:@"NAMEnabled"];

	if (NAMEnabled) {
      %init(Tweak);
    }
}