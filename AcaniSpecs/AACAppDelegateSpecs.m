#import "AACAppDelegate.h"
#import "AACSpecs.h"
#import "AACWelcomeViewController.h"

@interface AACAppDelegateSpecs : AACSpecs @end

@implementation AACAppDelegateSpecs

- (void)spec_superclass
{
    STAssertEquals([AACAppDelegate superclass], [UIResponder class], nil);
}

- (void)specProtocols
{
    STAssertTrue([AACAppDelegate conformsToProtocol:@protocol(UIApplicationDelegate)], nil);
}

- (void)specApplication_didFinishLaunchingWithOptions_
{
    UIApplication *application = [UIApplication sharedApplication];
    STAssertEquals(application.statusBarStyle, UIStatusBarStyleBlackTranslucent, nil); // Info.plist

    AACAppDelegate *appDelegate = (AACAppDelegate *)application.delegate;
    STAssertNotNil(appDelegate, nil);
    STAssertEquals([appDelegate class], [AACAppDelegate class], nil);

    STAssertTrue([appDelegate application:application didFinishLaunchingWithOptions:nil], nil);

    UIColor *tintColor = [UIColor colorWithRed:217/255.0 green:153/255.0 blue:166/255.0 alpha:1];
    STAssertEqualObjects([[UINavigationBar appearance] tintColor], tintColor, nil);

    UIWindow *window = appDelegate.window;
    STAssertNotNil(window, nil);
    STAssertEquals(window.frame, [[UIScreen mainScreen] bounds], nil);
    AACWelcomeViewController *welcomeViewController = (AACWelcomeViewController *)window.rootViewController;
    STAssertNotNil(welcomeViewController, nil);
    STAssertEquals([welcomeViewController class], [AACWelcomeViewController class], nil);
    STAssertEquals(window, [UIApplication sharedApplication].keyWindow, nil);
    STAssertFalse(window.hidden, nil);
}

@end
