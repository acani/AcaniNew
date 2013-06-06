#import "AACApplication.h"
#import "AACLogoLabel.h"
#import "AACSpecs.h"
#import "AACUsersViewController.h"
#import "AACUserCell.h"

@interface AACUsersViewControllerSpecs : AACSpecs @end

@implementation AACUsersViewControllerSpecs {
    UINavigationController *_navigationController;
    AACUsersViewController *_usersViewController;
}

#pragma mark - SenTest

- (void)setUp
{
    _usersViewController = [[AACUsersViewController alloc] init];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:_usersViewController];
}

- (void)tearDown
{
    _usersViewController = nil;
    _navigationController = nil;
}

#pragma mark - NSObject

- (void)spec_superclass
{
    STAssertEquals([AACUsersViewController superclass], [UICollectionViewController class], nil);
}

- (void)specInit
{
    STAssertNotNil(_usersViewController, nil);
    STAssertEquals([_usersViewController class], [AACUsersViewController class], nil);

    STAssertEqualObjects(_usersViewController.title, NSLocalizedString(@"Users", nil), nil);
    STAssertTrue(_usersViewController.wantsFullScreenLayout, nil);

    UILabel *logoLabel = (UILabel *)_usersViewController.navigationItem.titleView;
    STAssertNotNil(logoLabel, nil);
    STAssertEquals([logoLabel class], [AACLogoLabel class], nil);
    STAssertEquals(logoLabel.frame.size, CGSizeMake(100, 44), nil);
    UIViewAutoresizing autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    STAssertEquals(logoLabel.autoresizingMask, autoresizingMask, nil);
    STAssertEqualObjects(logoLabel.font, [UIFont fontWithName:@"AvenirNext-Heavy" size:27], nil);
    STAssertEquals(logoLabel.shadowOffset, CGSizeMake(0, -1), nil);
}

#pragma mark - UIViewController

- (void)specViewDidLoad
{
    UICollectionView *collectionView = _usersViewController.collectionView;

    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    STAssertNotNil(layout, nil);
    STAssertEquals([layout class], [UICollectionViewFlowLayout class], nil);
    STAssertEquals(layout.itemSize, CGSizeMake(75, 75), nil);
    STAssertEquals(layout.minimumInteritemSpacing, (CGFloat)4, nil);
    STAssertEquals(layout.minimumLineSpacing, (CGFloat)4, nil);
    STAssertEquals(layout.sectionInset, UIEdgeInsetsMake(4, 4, 4, 4), nil);

    STAssertEquals([UIApplication sharedApplication].statusBarStyle, UIStatusBarStyleBlackTranslucent, nil);

    STAssertEquals(_navigationController.navigationBar.barStyle, UIBarStyleBlack, nil);
    STAssertTrue(_navigationController.navigationBar.translucent, nil);

    STAssertTrue(collectionView.alwaysBounceVertical, nil);
    STAssertEqualObjects(collectionView.backgroundColor, [UIColor whiteColor], nil);
}

- (void)specViewWillAppear_
{
    [_usersViewController viewWillAppear:YES];
    UICollectionView *collectionView = _usersViewController.collectionView;
    UIEdgeInsets insets = [self insets];
    STAssertEquals(collectionView.contentInset, insets, nil);
    STAssertEquals(collectionView.scrollIndicatorInsets, insets, nil);
}

- (void)specWillRotateToInterfaceOrientation_duration_
{
    UICollectionView *collectionView = _usersViewController.collectionView;
    UILabel *logoLabel = (UILabel *)_usersViewController.navigationItem.titleView;
    UIEdgeInsets insets = [self insets];

    [_usersViewController willRotateToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft duration:0];
    STAssertEqualObjects(logoLabel.font, [UIFont fontWithName:@"AvenirNext-Heavy" size:20], nil);
    insets.top = 52;
    STAssertEquals(collectionView.contentInset, insets, nil);
    STAssertEquals(collectionView.scrollIndicatorInsets, insets, nil);

    [_usersViewController willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:0];
    STAssertEqualObjects(logoLabel.font, [UIFont fontWithName:@"AvenirNext-Heavy" size:27], nil);
    insets.top = 64;
    STAssertEquals(collectionView.contentInset, insets, nil);
    STAssertEquals(collectionView.scrollIndicatorInsets, insets, nil);
}

#pragma mark - UICollectionViewDataSource

- (void)specCollectionViewDataSource
{
    UICollectionView *collectionView = _usersViewController.collectionView;

    STAssertEquals([collectionView numberOfSections], 1, nil);
    STAssertEquals([collectionView numberOfItemsInSection:0], 8, nil);

    // TODO: Fix this. Outdated. There are no visible cells.
    NSInteger item = 0;
    for (AACUserCell *cell in [collectionView visibleCells]) {
        STAssertEquals([cell class], [AACUserCell class], nil);

        NSString *name;
        NSString *pictureName;
        if (item % 2) {
            name = @"Matt";
            pictureName = @"1Small.jpg";
        } else {
            name = @"Lauren";
            pictureName = @"0Small.jpg";
        }
        UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:pictureName]];
        STAssertEqualObjects(cell.backgroundColor, color, nil);
        STAssertEqualObjects(cell.nameLabel.text, name, nil);

        item++;
    }
}

#pragma mark - Helpers

- (UIEdgeInsets)insets
{
    CGFloat top = AACStatusBarHeight() + _navigationController.navigationBar.frame.size.height;
    return UIEdgeInsetsMake(top, 0, 0, 0);
}

@end
