#import "AACAppDelegate.h"
#import "AACDefines.h"
#import "AACUsersViewController.h"
#import "AACWelcomeViewController.h"

@implementation AACAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setTintColor:AAC_ROSE_QUARTZ_COLOR];

    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[AACUsersViewController alloc] init]];
    _window.rootViewController = [[AACWelcomeViewController alloc] initWithNibName:nil bundle:nil];
    [_window makeKeyAndVisible];

    return YES;
}

@end
