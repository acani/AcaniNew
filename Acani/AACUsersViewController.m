#import "AACProfileViewController.h"
#import "AACUser.h"
#import "AACUserCell.h"
#import "AACUsersViewController.h"

#define TITLE_FONT_SIZE_PORTRAIT  27  // standard title ratio: 20 : 16
#define TITLE_FONT_SIZE_LANDSCAPE 20

static NSString *CellIdentifier = @"ACUserCell";

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

    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;

    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];

    [self.collectionView registerClass:[AACUserCell class] forCellWithReuseIdentifier:CellIdentifier];

    AACUser *user0 = [[AACUser alloc] init];
    user0.bio = @"Hello! My name is Lauren. I am *Amazing*, gorgeous, intelligent, genius, loving, courageous, fun, funny, healthy, wealthy, wise, playful, happy, flexible, open-minded, confident, and sexy.";
    user0.name = @"Lauren";
    user0.uniqueIdentifier = @"0";

    AACUser *user1 = [[AACUser alloc] init];
    user1.bio = @"Hello! My name is Matt. I am *Amazing*, gorgeous, intelligent, genius, loving, courageous, fun, funny, healthy, wealthy, wise, playful, happy, flexible, open-minded, confident, and sexy.";
    user1.name = @"Matt";
    user1.uniqueIdentifier = @"1";

    _users = @[user0, user1, user0, user1, user0, user1, user0, user1, user0, user1, user0, user1, user0, user1, user0, user1, user0, user1, user0, user1, user0, user1, user0, user1, user0, user1, user0, user1, user0, user1];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    UIEdgeInsets insets = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height, 0, 0, 0);
    self.collectionView.contentInset = insets;
    self.collectionView.scrollIndicatorInsets = insets;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

    CGFloat fontSize;
    UIEdgeInsets insets;
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        fontSize = TITLE_FONT_SIZE_PORTRAIT;
        insets = UIEdgeInsetsMake(44, 0, 0, 0);
    } else {
        insets = UIEdgeInsetsMake(32, 0, 0, 0);
        fontSize = TITLE_FONT_SIZE_LANDSCAPE;
    }
    UILabel *logoLabel = (UILabel *)self.navigationItem.titleView;
    logoLabel.font = [UIFont fontWithName:@"AvenirNext-Heavy" size:fontSize];
    self.collectionView.contentInset = insets;
    self.collectionView.scrollIndicatorInsets = insets;
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
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[user pictureNameOfType:AACUserPictureTypeSmall]]];
    cell.nameLabel.text = user.name;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AACUser *user = _users[indexPath.item];
    AACProfileViewController *profileViewController = [[AACProfileViewController alloc] initWithUser:user];
    [self.navigationController pushViewController:profileViewController animated:YES];
}

@end
