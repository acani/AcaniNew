#import "AACAppDelegate.h"
#import "AACDefines.h"
//#import "AACUsersViewController.h"
#import "AACWelcomeViewController.h"

@implementation AACAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Style `UINavigationBar`.
    [[UINavigationBar appearance] setTintColor:AAC_ROSE_QUARTZ_COLOR]; // #d999a6

    // Create `_window`.
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[AACUsersViewController alloc] init]];
    _window.rootViewController = [[AACWelcomeViewController alloc] init];
    [_window makeKeyAndVisible];

    return YES;
}

@end
