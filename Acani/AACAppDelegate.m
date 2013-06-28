#import <Crashlytics/Crashlytics.h>
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
    [Crashlytics startWithAPIKey:@"ed486ebce97cfed0fdfc621c09ac7d777cbadd03"];

    [[UINavigationBar appearance] setTintColor:AAC_ROSE_QUARTZ_COLOR];

    if (![[FBSession activeSession] isOpen]) {
        [FBSession openActiveSessionWithAllowLoginUI:NO];
    }

    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if ([FBSession activeSession].isOpen) {
        _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[AACUsersViewController alloc] init]];
    } else {
        _window.rootViewController = [[AACWelcomeViewController alloc] initWithNibName:nil bundle:nil];
    }
    [_window makeKeyAndVisible];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppCall handleDidBecomeActive];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[FBSession activeSession] close];
}

// Keep navigation bar below status bar. #hack
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
    [FBSession openActiveSessionWithReadPermissions:@[@"user_photos"] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
        NSLog(@"facebookAccessToken: %@", session.accessTokenData.accessToken);
        NSLog(@"state: %i", state);
        NSLog(@"\n");
        NSLog(@"FBSessionStateOpen: %i", FBSessionStateOpen);
        NSLog(@"FBSessionStateOpenTokenExtended: %i", FBSessionStateOpenTokenExtended);
        NSLog(@"FBSessionStateClosedLoginFailed: %i", FBSessionStateClosedLoginFailed);
        NSLog(@"FBSessionStateClosed: %i", FBSessionStateClosed);

        switch (state) {
            case FBSessionStateOpen:
                [self logIn];
                break;
            case FBSessionStateClosed:
            case FBSessionStateClosedLoginFailed:
                [[FBSession activeSession] closeAndClearTokenInformation];
                break;
            default:
                break;
        }

        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:error.localizedDescription delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alertView show];
        }
    }];
}

- (void)logOutAction
{
    [[FBSession activeSession] closeAndClearTokenInformation];
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

- (void)logIn
{
    // TODO: Open URL (for specific page) in completion block if app was last opened with one.
    AACUsersViewController *usersViewController = [[AACUsersViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:usersViewController];
    [self transitionViewController:navigationController options:UIViewAnimationOptionTransitionFlipFromRight];
}

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
