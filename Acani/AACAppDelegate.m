#import <FacebookSDK/FacebookSDK.h>
#import "AACAppDelegate.h"
#import "AACDefines.h"
#import "AACUsersViewController.h"
#import "AACWelcomeViewController.h"

@interface AACAppDelegate () <UIActionSheetDelegate> @end

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
    UIActionSheet *actionSheetLogout = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:NSLocalizedString(@"Log Out", nil) otherButtonTitles:nil];
    [actionSheetLogout showInView:_window];
}

#pragma mark - Helpers

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

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) { // "Log Out" tapped
        AACWelcomeViewController *welcomeViewController = [[AACWelcomeViewController alloc] initWithNibName:nil bundle:nil];
        [self transitionViewController:welcomeViewController options:UIViewAnimationOptionTransitionFlipFromLeft];
    }
}

@end
