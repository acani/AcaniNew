#import "AACEditProfileViewController.h"
#import "AACPageViewController.h"
#import "AACProfileViewController.h"
#import "AACUser.h"
#import "AACUserCell.h"
#import "AACUsersViewController.h"

#define TITLE_FONT_SIZE_PORTRAIT  27  // standard title ratio: 20 : 16
#define TITLE_FONT_SIZE_LANDSCAPE 20

static NSString *CellIdentifier = @"ACUserCell";

// HACK: Status bar width & height are swapped in landscape mode.
// http://stackoverflow.com/a/16598350/242933
CGFloat AACStatusBarHeight()
{
    CGSize statusBarSize = [UIApplication sharedApplication].statusBarFrame.size;
    return MIN(statusBarSize.width, statusBarSize.height);
}

@interface AACUsersViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@end

@implementation AACUsersViewController {
    NSArray *_users;
}

#pragma mark - NSObject

- (id)init
{
    // Create `layout`.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(75, 75);
    layout.minimumInteritemSpacing = 4;
    layout.minimumLineSpacing = 4;
    layout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4);
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.title = NSLocalizedString(@"Users", nil); // for back button of pushed page
        self.wantsFullScreenLayout = YES;

        // Create `logoLabel`.
        UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        logoLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        logoLabel.backgroundColor = [UIColor clearColor];
        logoLabel.font = [UIFont fontWithName:@"AvenirNext-Heavy" size:TITLE_FONT_SIZE_PORTRAIT];
        logoLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
        logoLabel.text = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"] lowercaseString]; // acani
        logoLabel.textAlignment = NSTextAlignmentCenter;
        logoLabel.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = logoLabel;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:NO];

    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;

    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];

    [self.collectionView registerClass:[AACUserCell class] forCellWithReuseIdentifier:CellIdentifier];

    AACUser *user0 = [[AACUser alloc] init];
    user0.bio = @"Hello! My name is Lauren. I am *Amazing*, gorgeous, intelligent, genius, loving, courageous, fun, funny, healthy, wealthy, wise, playful, happy, flexible, open-minded, confident, and sexy.";
    user0.firstName = @"Lauren";
    user0.lastName = @"Di Pasquale";
    user0.uniqueIdentifier = @"0";

    AACUser *user1 = [[AACUser alloc] init];
    user1.bio = @"Hello! My name is Matt. I am *Amazing*, gorgeous, intelligent, genius, loving, courageous, fun, funny, healthy, wealthy, wise, playful, happy, flexible, open-minded, confident, and sexy. Check out my website: mattdipasquale.com";
    user1.firstName = @"Matt";
    user1.uniqueIdentifier = @"1";

    AACUser *user2 = [[AACUser alloc] init];
    user2.bio = @"Hello! My name is Earth. I am big & round, magnificent!";
    user2.firstName = @"Earth";
    user2.uniqueIdentifier = @"2";

    AACUser *user3 = [[AACUser alloc] init];
    user3.bio = @"Hello! My name is Nature. I am beautiful.";
    user3.firstName = @"Nature";
    user3.uniqueIdentifier = @"3";

    AACUser *user4 = [[AACUser alloc] init];
    user4.bio = @"Hello! My name is Beach. I am amazing.";
    user4.firstName = @"Beach";
    user4.uniqueIdentifier = @"4";

    AACUser *user5 = [[AACUser alloc] init];
    user5.bio = @"Hello! My name is Courage. I am wise.";
    user5.firstName = @"Courage";
    user5.uniqueIdentifier = @"5";

    AACUser *user6 = [[AACUser alloc] init];
    user6.bio = @"Hello! My name is Leadership. I am creative.";
    user6.firstName = @"Leadership";
    user6.uniqueIdentifier = @"6";

    AACUser *user7 = [[AACUser alloc] init];
    user7.bio = @"Hello! My name is GitHub. I am collaborative.";
    user7.firstName = @"GitHub";
    user7.uniqueIdentifier = @"7";

    _users = @[user0, user1, user2, user3, user4, user5, user6, user7];

    // Temporary
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit Profile", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(editProfileAction)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    CGFloat top = AACStatusBarHeight() + self.navigationController.navigationBar.frame.size.height;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, 0, 0, 0);
    self.collectionView.contentInset = insets;
    self.collectionView.scrollIndicatorInsets = insets;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

    // TODO: How do I get `navigationBarHeight` programmatically, without hard coding it, in case it's changed in a future version of iOS.
    CGFloat fontSize;
    CGFloat navigationBarHeight;
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        fontSize = TITLE_FONT_SIZE_PORTRAIT;
        navigationBarHeight = 44;
    } else {
        fontSize = TITLE_FONT_SIZE_LANDSCAPE;
        navigationBarHeight = 32;
    }

    UILabel *logoLabel = (UILabel *)self.navigationItem.titleView;
    logoLabel.font = [UIFont fontWithName:@"AvenirNext-Heavy" size:fontSize];

    UIEdgeInsets insets = UIEdgeInsetsMake(AACStatusBarHeight()+navigationBarHeight, 0, 0, 0);
    self.collectionView.contentInset = insets;
    self.collectionView.scrollIndicatorInsets = insets;
}

#pragma mark - Actions

- (void)editProfileAction
{
    AACEditProfileViewController *editProfileViewController = [[AACEditProfileViewController alloc] initWithUser:_users[0]];
    [self.navigationController pushViewController:editProfileViewController animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_users count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AACUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    AACUser *user = _users[indexPath.item];
    UIImage *pictureImage = [UIImage imageNamed:[user pictureNameOfType:AACUserPictureTypeSmall]];
    ((UIImageView *)cell.backgroundView).image = pictureImage;
    cell.nameLabel.text = user.firstName;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AACUser *user = _users[indexPath.item];
    AACPageViewController *pageViewController = [[AACPageViewController alloc] initWithUser:user];
    pageViewController.dataSource = self;
    pageViewController.delegate = self;
    [self.navigationController pushViewController:pageViewController animated:YES];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(AACProfileViewController *)profileViewController
{
    NSUInteger index = [_users indexOfObject:profileViewController.user] - 1;
    return (index < [_users count] ? [[AACProfileViewController alloc] initWithUser:_users[index]] : nil);
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(AACProfileViewController *)profileViewController
{
    NSUInteger index = [_users indexOfObject:profileViewController.user] + 1;
    return (index < [_users count] ? [[AACProfileViewController alloc] initWithUser:_users[index]] : nil);
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(AACPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        AACProfileViewController *profileViewController = (AACProfileViewController *)[pageViewController.viewControllers lastObject];
        pageViewController.title = profileViewController.title;
        pageViewController.bioTextView.text = profileViewController.user.bio;
    }
}

@end
