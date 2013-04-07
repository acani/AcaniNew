#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "AACAppDelegate.h"
#import "AACUsersViewController.h"

@interface AACAppDelegateSpecs : SenTestCase @end

@implementation AACAppDelegateSpecs

- (void)specLaunch
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    STAssertNotNil(window,                                                                            @"Create window.");
    STAssertEquals(window.frame, [[UIScreen mainScreen] bounds],                                      @"Set frame to main-screen bounds.");
    STAssertEquals(window, [UIApplication sharedApplication].keyWindow,                               @"Make key.");
    STAssertFalse (window.hidden,                                                                     @"Make visible.");

    UIViewController *rootViewController = window.rootViewController;
    STAssertNotNil(rootViewController,                                                                @"Create and set rootViewController.");
    STAssertTrue([rootViewController isMemberOfClass:[UINavigationController class]],                 @"Make UINavigationController.");

    UIViewController *topViewController = ((UINavigationController *)rootViewController).topViewController;
    STAssertNotNil(topViewController,                                                                 @"Create and set topViewController.");
    STAssertTrue([topViewController isMemberOfClass:[AACUsersViewController class]],                  @"Make AACUsersViewController.");
    STAssertEqualObjects(topViewController.title, NSLocalizedString(@"Users", nil),                   @"Set title to 'Users'.");

    UICollectionView *collectionView = ((UICollectionViewController *)topViewController).collectionView;
    STAssertNotNil(collectionView,                                                                    @"UIKit should load collectionView.");
    STAssertEqualObjects(collectionView.backgroundColor, [UIColor whiteColor],                        @"Set backgroundColor to white.");

    UICollectionViewFlowLayout *collectionViewFlowLayout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    STAssertNotNil(collectionViewFlowLayout,                                                          @"Create and set collectionViewLayout.");
    STAssertTrue([collectionViewFlowLayout isMemberOfClass:[UICollectionViewFlowLayout class]],       @"Make AACUsersViewController.");
    STAssertEquals(collectionViewFlowLayout.itemSize,           CGSizeMake(75, 75),                   @"Set itemSize to 75 x 75.");
    STAssertEquals(collectionViewFlowLayout.minimumInteritemSpacing,       4.0f,                      @"Set minimumInteritemSpacing to 4.");
    STAssertEquals(collectionViewFlowLayout.minimumLineSpacing,            4.0f,                      @"Set minimumLineSpacing to 4.");
    STAssertEquals(collectionViewFlowLayout.sectionInset, UIEdgeInsetsMake(4, 4, 4, 4),               @"Set sectionInset to (4, 4, 4, 4).");
}

@end
