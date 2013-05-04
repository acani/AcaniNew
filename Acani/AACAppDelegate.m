#import "AACAppDelegate.h"
#import "AACUsersViewController.h"

@implementation AACAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Style `UINavigationBar`.
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:217/255.0 green:153/255.0 blue:166/255.0 alpha:1]]; // #d999a6

    // Create `_window`.
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[AACUsersViewController alloc] init]];;
    [_window makeKeyAndVisible];

    return YES;
}

@end
