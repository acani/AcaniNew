#import "AACDefines.h"
#import "AACEditProfileViewController.h"
#import "AACUser.h"

#define BIO_TAG 810

@implementation AACEditProfileViewController

#pragma mark - Designated Initializer

- (id)initWithUser:(AACUser *)user
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _user = user;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Save", nil) style:UIBarButtonItemStyleDone target:self action:@selector(saveProfileAction)];
        self.title = NSLocalizedString(@"Edit Profile", nil);
    }
    return self;
}

#pragma mark - Properties

- (UITextView *)bioTextView
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    return (UITextView *)[cell.contentView viewWithTag:BIO_TAG];
}

#pragma mark - UIView

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = AAC_LIGHT_GRAY_COLOR;
    self.tableView.backgroundView = nil;
    self.tableView.rowHeight = 72;

    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60+16*2-10)];

    UIButton *profilePictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    profilePictureButton.accessibilityLabel = NSLocalizedString(@"Profile Picture", nil);
    profilePictureButton.frame = CGRectMake(12, 16, 60, 60);
    UIImage *pictureImage = [UIImage imageNamed:[_user pictureNameOfType:AACUserPictureTypeSmall]];
    [profilePictureButton setBackgroundImage:pictureImage forState:UIControlStateNormal];
    [profilePictureButton addTarget:self action:@selector(editProfilePictureAction) forControlEvents:UIControlEventTouchUpInside];
    [tableHeaderView addSubview:profilePictureButton];
    
    UILabel *editPictureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 60, 16)];
    editPictureLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    editPictureLabel.font = [UIFont boldSystemFontOfSize:12];
    editPictureLabel.text = NSLocalizedString(@"edit", nil);
    editPictureLabel.textAlignment = NSTextAlignmentCenter;
    editPictureLabel.textColor = [UIColor whiteColor];
    editPictureLabel.userInteractionEnabled = NO;
    [profilePictureButton addSubview:editPictureLabel];

    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(86, 30, 224, 21)];
    nameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:16];
    nameLabel.shadowColor = [UIColor whiteColor];
    nameLabel.shadowOffset = CGSizeMake(0, 1);
    nameLabel.text = [_user name];
    [tableHeaderView addSubview:nameLabel];

    self.tableView.tableHeaderView = tableHeaderView;

    [[self bioTextView] becomeFirstResponder];
}

#pragma mark - Actions

- (void)editProfilePictureAction
{
    [[self bioTextView] resignFirstResponder];
    // TODO: Get picture from Facebook.
}

- (void)saveProfileAction
{
    UITextView *bioTextView = [self bioTextView];
    [bioTextView resignFirstResponder];
    _user.bio = bioTextView.text;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"Bio", nil);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    UITextView *bioTextView;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        bioTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 4, cell.contentView.frame.size.width, 64)];
        bioTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        bioTextView.backgroundColor = [UIColor clearColor];
        bioTextView.tag = BIO_TAG;
        [cell.contentView addSubview:bioTextView];
    } else {
        bioTextView = (UITextView *)[cell.contentView viewWithTag:BIO_TAG];
    }

    bioTextView.text = _user.bio;

    return cell;
}

@end
