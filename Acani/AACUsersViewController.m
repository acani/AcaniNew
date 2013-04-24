#import "AACUser.h"
#import "AACUserCell.h"
#import "AACUsersViewController.h"

static NSString *CellIdentifier = @"ACUserCell";

@implementation AACUsersViewController {
    NSArray *_users;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

@end
