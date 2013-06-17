#import "AACEditProfileViewController.h"
#import "AACSpecs.h"
#import "AACUser.h"

@interface AACEditProfileViewControllerSpecs : AACSpecs @end

@implementation AACEditProfileViewControllerSpecs {
    AACEditProfileViewController *_editProfileViewController;
    AACUser *_user;
}

#pragma mark - SenTest

- (void)setUp
{
    _user = [[AACUser alloc] init];
    _user.bio = @"Hello! This is my bio.";
    _user.firstName = @"Matt";
    _user.lastName = @"Di Pasquale";
    _user.uniqueIdentifier = @"1";

    _editProfileViewController = [[AACEditProfileViewController alloc] initWithUser:_user];
}

- (void)tearDown
{
    _editProfileViewController = nil;
    _user = nil;
}

#pragma mark - NSObject

- (void)spec_superclass
{
    STAssertEquals([AACEditProfileViewController superclass], [UITableViewController class], nil);
}

#pragma mark - Designated Initializer

- (void)specInitWithUser_
{
    STAssertNotNil(_editProfileViewController, nil);
    STAssertEquals([_editProfileViewController class], [AACEditProfileViewController class], nil);

    STAssertNotNil(_user, nil);
    STAssertEquals([_user class], [AACUser class], nil);

    UIBarButtonItem *rightBarButtonItem = _editProfileViewController.navigationItem.rightBarButtonItem;
    STAssertNotNil(rightBarButtonItem, nil);
    STAssertEqualObjects(rightBarButtonItem.title, NSLocalizedString(@"Save", nil), nil);
    STAssertEquals(rightBarButtonItem.style, UIBarButtonItemStyleDone, nil);
    STAssertEquals(rightBarButtonItem.action, @selector(saveProfileAction), nil);

    STAssertEqualObjects(_editProfileViewController.title, NSLocalizedString(@"Edit Profile", nil), nil);
}

#pragma mark - UIViewController

- (void)specViewDidLoad
{
    UITableView *tableView = _editProfileViewController.tableView;

    STAssertEquals(tableView.rowHeight, (CGFloat)72, nil);

    UIView *tableHeaderView = tableView.tableHeaderView;
    STAssertNotNil(tableHeaderView, nil);
    STAssertEquals([tableHeaderView class], [UIView class], nil);
    STAssertEquals(tableHeaderView.frame, CGRectMake(0, 0, _editProfileViewController.view.frame.size.width, 60+16*2-10), nil);
    NSArray *subviews = tableHeaderView.subviews;
    STAssertEquals([subviews count], (NSUInteger)2, nil);

    UIButton *profilePictureButton = tableHeaderView.subviews[0];
    STAssertEquals([profilePictureButton class], [UIButton class], nil);
    STAssertEqualObjects(profilePictureButton.accessibilityLabel, NSLocalizedString(@"Profile Picture", nil), nil);
    STAssertEquals(profilePictureButton.frame, CGRectMake(12, 16, 60, 60), nil);
    NSString *pictureName = [_user pictureNameOfType:AACUserPictureTypeSmall];
    UIImage *pictureImage = [UIImage imageNamed:pictureName];
    STAssertNotNil(pictureImage, nil);
    STAssertEqualObjects([profilePictureButton backgroundImageForState:UIControlStateNormal], pictureImage, nil);
    [self control:profilePictureButton specTarget:_editProfileViewController action:@selector(editProfilePictureAction) forControlEvents:UIControlEventTouchUpInside];

    UILabel *editPictureLabel = profilePictureButton.subviews[0];
    STAssertEquals([editPictureLabel class], [UILabel class], nil);
    STAssertEqualObjects(editPictureLabel.backgroundColor, [UIColor colorWithWhite:0 alpha:0.5], nil);
    STAssertEquals(editPictureLabel.frame, CGRectMake(0, 44, 60, 16), nil);
    STAssertEqualObjects(editPictureLabel.font, [UIFont boldSystemFontOfSize:12],nil);
    STAssertEqualObjects(editPictureLabel.text, NSLocalizedString(@"edit", nil), nil);
    STAssertEquals(editPictureLabel.textAlignment, NSTextAlignmentCenter, nil);
    STAssertEqualObjects(editPictureLabel.textColor, [UIColor whiteColor], nil);
    STAssertEquals(editPictureLabel.userInteractionEnabled, NO, nil);

    UILabel *nameLabel = tableHeaderView.subviews[1];
    STAssertEquals([nameLabel class], [UILabel class], nil);
    STAssertEquals(nameLabel.frame, CGRectMake(86, 30, 224, 21), nil);
    STAssertEquals(nameLabel.autoresizingMask, UIViewAutoresizingFlexibleWidth, nil);
    STAssertEqualObjects(nameLabel.backgroundColor, [UIColor clearColor], nil);
    STAssertEqualObjects(nameLabel.font, [UIFont boldSystemFontOfSize:16], nil);
    STAssertEqualObjects(nameLabel.shadowColor, [UIColor whiteColor], nil);
    STAssertEquals(nameLabel.shadowOffset, CGSizeMake(0, 1), nil);
    STAssertEqualObjects(nameLabel.text, [_user name], nil);
}

#pragma mark - UITableViewDataSource

- (void)specTableViewDataSource
{
    UITableView *tableView = _editProfileViewController.tableView;

    STAssertEquals([tableView numberOfSections], 1, nil);
    STAssertEquals([tableView numberOfRowsInSection:0], 1, nil);
    NSString *sectionTitle = [_editProfileViewController tableView:_editProfileViewController.tableView titleForHeaderInSection:0];
    STAssertEqualObjects(sectionTitle, NSLocalizedString(@"Bio", nil), nil);

    UITableViewCell *cell = [tableView visibleCells][0];

    UITextView *bioTextView = (UITextView *)[cell.contentView viewWithTag:810];
    STAssertEquals([bioTextView class], [UITextView class], nil);
    STAssertEquals(bioTextView.frame, CGRectMake(0, 4, cell.contentView.frame.size.width, 64), nil);
    STAssertEquals(bioTextView.autoresizingMask, UIViewAutoresizingFlexibleWidth, nil);
    STAssertEqualObjects(bioTextView.backgroundColor, [UIColor clearColor], nil);
    STAssertEqualObjects(bioTextView.text, _user.bio, nil);
}

@end
