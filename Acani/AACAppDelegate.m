#import "AACAppDelegate.h"
#import "AACUsersViewController.h"

@implementation AACAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Create `usersViewController` with custom title, item size, and spacing.
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.itemSize = CGSizeMake(75, 75);
    collectionViewFlowLayout.minimumInteritemSpacing = 4;
    collectionViewFlowLayout.minimumLineSpacing = 4;
    collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4);
    AACUsersViewController *usersViewController = [[AACUsersViewController alloc] initWithCollectionViewLayout:collectionViewFlowLayout];
    usersViewController.title = NSLocalizedString(@"Users", nil);

    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:usersViewController];
    [_window makeKeyAndVisible];
    return YES;
}

@end
