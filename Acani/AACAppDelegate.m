#import <FacebookSDK/FacebookSDK.h>
#import "AACAppDelegate.h"
#import "AACDefines.h"
#import "AACUsersViewController.h"
#import "AACWelcomeViewController.h"

//// Testing
//#import "AACSettingsViewController.h"

@implementation AACAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setTintColor:AAC_ROSE_QUARTZ_COLOR];

    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.rootViewController = [[AACWelcomeViewController alloc] initWithNibName:nil bundle:nil];
//    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[AACSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped]];
    [_window makeKeyAndVisible];

    return YES;
}

// Keep navigation bar below status bar. #hacw[k
// http://stackoverflow.com/a/6190485/242933
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    UINavigationController *navigationController = (UINavigationController *)_window.rootViewController;
    if ([navigationController respondsToSelector:@selector(topViewController)]) {
        if ([navigationController.topViewController respondsToSelector:@selector(facebookAction)]) {
            if (!navigationController.navigationBar.alpha) {
                [UIApplication sharedApplication].statusBarHidden = NO;
                [self performSelector:@selector(hideStatusBar) withObject:nil afterDelay:0];
            }
        }
    }
}

#pragma mark - Actions

- (void)logInAction
{
    NSString *facebookAccessToken = @"FACEBOOK_ACCESS_TOKEN";
    NSLog(@"facebookAccessToken: %@", facebookAccessToken);

    //    [FBSession openActiveSessionWithAllowLoginUI:YES]; // TODO: get this working

    // TODO: Open URL (for specific page) in completion block if app was last opened with one.
    AACUsersViewController *usersViewController = [[AACUsersViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:usersViewController];
    [self transitionViewController:navigationController options:UIViewAnimationOptionTransitionFlipFromRight];
}

- (void)logOutAction
{
    AACWelcomeViewController *welcomeViewController = [[AACWelcomeViewController alloc] initWithNibName:nil bundle:nil];
    [self transitionViewController:welcomeViewController options:UIViewAnimationOptionTransitionFlipFromLeft];
}

- (void)deleteAccountAction
{
    // TODO: Delete account.
    NSLog(@"deleteAccountAction");
    [self logOutAction];
}

#pragma mark - Helpers

- (void)hideStatusBar
{
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)transitionViewController:(UIViewController *)viewController options:(UIViewAnimationOptions)options
{
    // HACK: Load `viewController` before transition.
    UIViewController *rootViewController = _window.rootViewController;
    _window.rootViewController = viewController;
    _window.rootViewController = rootViewController;

    [UIView transitionWithView:_window duration:0.6 options:UIViewAnimationOptionAllowAnimatedContent|options animations:^{
        _window.rootViewController = viewController;
    } completion:nil];
}

@end
