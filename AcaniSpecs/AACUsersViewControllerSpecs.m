#import "AACApplication.h"
#import "AACDefines.h"
#import "AACLogoLabel.h"
#import "AACPageViewController.h"
#import "AACSpecs.h"
#import "AACUsersViewController.h"
#import "AACUserCell.h"

#define FIRST_NAMES @[@"Lauren", @"Matt", @"Earth", @"Nature", @"Beach", @"Courage", @"Leadership", @"GitHub"]
#define NAMES @[@"Lauren Di Pasquale", @"Matt Di Pasquale", @"Earth Living", @"Nature Love", @"Beach Water", @"Courage Love", @"Leadership Power", @"GitHub Inc."]

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

    UIBarButtonItem *settingsBarButtonItem = _usersViewController.navigationItem.rightBarButtonItem;
    STAssertNotNil(settingsBarButtonItem, nil);
    STAssertEquals(settingsBarButtonItem.action, @selector(settingsAction), nil);
    STAssertEqualObjects(settingsBarButtonItem.image, [UIImage imageNamed:@"SettingsCog"], nil);
    STAssertEquals(settingsBarButtonItem.style, UIBarButtonItemStyleBordered, nil);
    STAssertEqualObjects(settingsBarButtonItem.target, _usersViewController, nil);
    STAssertTrue([_usersViewController respondsToSelector:@selector(settingsAction)], nil);

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

    STAssertEquals(_navigationController.navigationBar.barStyle, UIBarStyleBlack, nil);
    STAssertTrue(_navigationController.navigationBar.translucent, nil);

    STAssertTrue(collectionView.alwaysBounceVertical, nil);
    STAssertEqualObjects(collectionView.backgroundColor, AAC_LIGHT_GRAY_COLOR, nil);
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

- (void)specCollectionView_numberOfItemsInSection_
{
    UICollectionView *collectionView = _usersViewController.collectionView;
    STAssertEquals([collectionView numberOfSections], 1, nil);
    STAssertEquals([collectionView numberOfItemsInSection:0], 8, nil);
}

- (void)specCollectionView_cellForItemAtIndexPath_
{
    UICollectionView *collectionView = _usersViewController.collectionView;
    NSInteger item = 0;
    for (NSString *firstName in FIRST_NAMES) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        AACUserCell *cell = (AACUserCell *)[_usersViewController collectionView:collectionView cellForItemAtIndexPath:indexPath];
        STAssertEquals([cell class], [AACUserCell class], nil);
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%iSmall.jpg", item]];
        STAssertEqualObjects(((UIImageView *)cell.backgroundView).image, image, nil);
        STAssertEqualObjects(cell.nameLabel.text, firstName, nil);
        item++;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)specCollectionView_didSelectItemAtIndexPath_
{
    UICollectionView *collectionView = _usersViewController.collectionView;
    NSInteger item = 0;
    for (NSString *name in NAMES) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        [_usersViewController collectionView:collectionView didSelectItemAtIndexPath:indexPath];
        AACPageViewController *pageViewController = (AACPageViewController *)_navigationController.topViewController;
        STAssertEquals([pageViewController class], [AACPageViewController class], nil);
        STAssertEquals(pageViewController.dataSource, _usersViewController, nil);
        STAssertEquals(pageViewController.delegate, _usersViewController, nil);
        STAssertEqualObjects(pageViewController.title, name, nil);
        [_navigationController popViewControllerAnimated:NO];
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
