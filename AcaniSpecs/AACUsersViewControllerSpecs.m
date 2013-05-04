#import <SenTestingKit/SenTestingKit.h>
#import "AACUsersViewController.h"
#import "AACUserCell.h"

@interface AACUsersViewControllerSpecs : SenTestCase @end

@implementation AACUsersViewControllerSpecs

- (void)specLaunch
{
    UINavigationController *_navigationController = (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    AACUsersViewController *_usersViewController = (AACUsersViewController *)_navigationController.topViewController;

    // Spec `init`.
    STAssertNotNil(_usersViewController, nil);
    STAssertTrue([_usersViewController isMemberOfClass:[AACUsersViewController class]], nil);
    STAssertEqualObjects(_usersViewController.title, NSLocalizedString(@"Users", nil), nil);

    // Spec `layout`.
    UICollectionView *_collectionView = _usersViewController.collectionView;
    STAssertNotNil(_collectionView, nil);
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    STAssertNotNil(layout, nil);
    STAssertTrue([layout isMemberOfClass:[UICollectionViewFlowLayout class]], nil);
    STAssertEquals(layout.itemSize, CGSizeMake(75, 75), nil);
    STAssertEquals(layout.minimumInteritemSpacing, 4.0f, nil);
    STAssertEquals(layout.minimumLineSpacing, 4.0f, nil);
    STAssertEquals(layout.sectionInset, UIEdgeInsetsMake(4, 4, 4, 4), nil);

    // Spec `titleLabel`.
    UILabel *_titleLabel = (UILabel *)_usersViewController.navigationItem.titleView;
    STAssertNotNil(_titleLabel, nil);
    STAssertTrue([_titleLabel isMemberOfClass:[UILabel class]], nil);
    STAssertEquals(_titleLabel.frame.size, CGSizeMake(100, 44), nil);
    UIViewAutoresizing autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    STAssertEquals(_titleLabel.autoresizingMask, autoresizingMask, nil);
    STAssertEqualObjects(_titleLabel.backgroundColor, [UIColor clearColor], nil);
    STAssertEqualObjects(_titleLabel.font, [UIFont fontWithName:@"AvenirNext-Heavy" size:27], nil);
    STAssertEqualObjects(_titleLabel.shadowColor, [UIColor colorWithWhite:0 alpha:0.5], nil);
    STAssertEqualObjects(_titleLabel.text, @"acani", nil);
    STAssertEquals(_titleLabel.textAlignment, NSTextAlignmentCenter, nil);
    STAssertEqualObjects(_titleLabel.textColor, [UIColor whiteColor], nil);

    // Spec `viewDidLoad`.
    STAssertEquals(_navigationController.navigationBar.barStyle, UIBarStyleBlack, nil);
    STAssertEquals(_navigationController.navigationBar.translucent, YES, nil);

    STAssertEquals(_collectionView.alwaysBounceVertical, YES, nil);
    STAssertEqualObjects(_collectionView.backgroundColor, [UIColor whiteColor], nil);

    UIEdgeInsets insets = UIEdgeInsetsMake(_navigationController.navigationBar.frame.size.height, 0, 0, 0);
    STAssertEquals(_collectionView.contentInset, insets, nil);
    STAssertEquals(_collectionView.scrollIndicatorInsets, insets, nil);

    // Spec rotate to landscape.
    [_usersViewController willRotateToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft duration:0];
    STAssertEqualObjects(_titleLabel.font, [UIFont fontWithName:@"AvenirNext-Heavy" size:20], nil);
    insets.top = 32;
    STAssertEquals(_collectionView.contentInset, insets, nil);
    STAssertEquals(_collectionView.scrollIndicatorInsets, insets, nil);

    // Spec rotate back to portrait.
    [_usersViewController willRotateToInterfaceOrientation:UIInterfaceOrientationPortrait duration:0];
    STAssertEqualObjects(_titleLabel.font, [UIFont fontWithName:@"AvenirNext-Heavy" size:27], nil);
    insets.top = 44;
    STAssertEquals(_collectionView.contentInset, insets, nil);
    STAssertEquals(_collectionView.scrollIndicatorInsets, insets, nil);

    // Spec `UICollectionViewDataSource` methods.
    STAssertEquals([_collectionView numberOfSections], 1, nil);
    STAssertEquals([_collectionView numberOfItemsInSection:0], 30, nil);

    NSInteger item = 0;
    for (AACUserCell *cell in [_collectionView visibleCells]) {
        STAssertTrue([cell isMemberOfClass:[AACUserCell class]], nil);

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

@end
