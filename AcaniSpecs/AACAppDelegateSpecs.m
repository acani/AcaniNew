#import <SenTestingKit/SenTestingKit.h>
#import "AACAppDelegate.h"
#import "AACUsersViewController.h"

@interface AACAppDelegateSpecs : SenTestCase @end

@implementation AACAppDelegateSpecs

- (void)specLaunch
{
    // Spec `appDelegate`.
    AACAppDelegate *appDelegate = (AACAppDelegate *)[UIApplication sharedApplication].delegate;
    STAssertNotNil(appDelegate, nil);
    STAssertTrue([appDelegate isMemberOfClass:[AACAppDelegate class]], nil);

    // Spec `_window`.
    UIWindow *window = appDelegate.window;
    STAssertNotNil(window, nil);
    STAssertEquals(window.frame, [[UIScreen mainScreen] bounds], nil);
    STAssertEquals(window, [UIApplication sharedApplication].keyWindow, nil);
    STAssertFalse(window.hidden, nil);

    // Spec `navigationController`.
    UINavigationController *navigationController = (UINavigationController *)window.rootViewController;
    STAssertNotNil(navigationController, nil);
    STAssertTrue([navigationController isMemberOfClass:[UINavigationController class]], nil);

    // Spec `UINavigationBar`.
    UIColor *tintColor = [UIColor colorWithRed:217/255.0 green:153/255.0 blue:166/255.0 alpha:1];
    STAssertEqualObjects(navigationController.navigationBar.tintColor, tintColor, nil);
}

@end
