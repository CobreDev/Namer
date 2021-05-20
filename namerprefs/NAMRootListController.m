#include "NAMRootListController.h"
#include <spawn.h>
#import <UIKit/UIKit.h>
#import "NSTask.h"

@implementation NAMRootListController

- (instancetype)init {
    self = [super init];

    if (self) {
        HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
        appearanceSettings.tintColor = [UIColor colorWithRed: 0.72 green: 0.36 blue: 0.00 alpha: 1.00];
		appearanceSettings.largeTitleStyle = HBAppearanceSettingsLargeTitleStyleNever;
        self.hb_appearanceSettings = appearanceSettings;
    }

    return self;
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)confirmation {
	UIAlertController *confirmation = [UIAlertController alertControllerWithTitle:@"Namer"
													 message:@"Relaunch Settings?"
													 preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
			[self applySettings];
	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
	[confirmation addAction:confirmAction];
	[confirmation addAction:cancelAction];
	[self presentViewController:confirmation animated:YES completion:nil];

}

-(void)applySettings {

    NSTask *t = [[NSTask alloc] init];
    [t setLaunchPath:@"/usr/bin/killall"];
    [t setArguments:[NSArray arrayWithObjects:@"Preferences", nil]];
    [t launch];

}

- (void)loadView {
    [super loadView];
    ((UITableView *)[self table]).keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

-(void)_returnKeyPressed:(id)arg1 {
    [self.view endEditing:YES];
}

@end
