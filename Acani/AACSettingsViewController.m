#import <MessageUI/MessageUI.h>
#import <QuartzCore/QuartzCore.h>
#import "AACAppDelegate.h"
#import "AACDefines.h"
#import "AACWebViewController.h"
#import "AACSettingsViewController.h"

#define INFO_SECTION       0
#define PRIVACY_POLICY_ROW 0

#define SUPPORT_SECTION    1
#define SEND_FEEDBACK_ROW  0

#define LOG_OUT_SECTION    2
#define LOG_OUT_ROW        0

#define LOG_OUT_TAG        706
#define DELETE_ACCOUNT_TAG 631

@interface AACSettingsViewController () <MFMailComposeViewControllerDelegate, UIActionSheetDelegate> @end

@implementation AACSettingsViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = AAC_LIGHT_GRAY_COLOR;
    self.tableView.backgroundView = nil;

    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44+30)];
    tableFooterView.backgroundColor = [UIColor clearColor];

    UIButton *deleteAccountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteAccountButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    deleteAccountButton.frame = CGRectMake(10, 30, self.view.frame.size.width-10*2, 44);
    deleteAccountButton.layer.cornerRadius = 8;
    deleteAccountButton.layer.masksToBounds = YES;
    deleteAccountButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [deleteAccountButton setBackgroundImage:[UIImage imageNamed:@"DeleteBackground"] forState:UIControlStateNormal];
    [deleteAccountButton setTitle:NSLocalizedString(@"Delete Account", nil) forState:UIControlStateNormal];
    [deleteAccountButton addTarget:self action:@selector(deleteAccountAction) forControlEvents:UIControlEventTouchUpInside];
    [tableFooterView addSubview:deleteAccountButton];

    self.tableView.tableFooterView = tableFooterView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case INFO_SECTION:
            return 1;
        case SUPPORT_SECTION:
            return 1;
        case LOG_OUT_SECTION:
            return 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;

    NSString *cellText;
    switch (indexPath.section) {
        case INFO_SECTION:
            switch (indexPath.row) {
                case PRIVACY_POLICY_ROW:
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cellText = @"Privacy Policy";
                    cell.textLabel.textAlignment = NSTextAlignmentLeft;
                    break;
            }
            break;
        case SUPPORT_SECTION:
            switch (indexPath.row) {
                case SEND_FEEDBACK_ROW:
                    cellText = @"Send Feedback";
                    break;
            }
            break;
        case LOG_OUT_SECTION:
            switch (indexPath.row) {
                case LOG_OUT_ROW:
                    cellText = @"Log Out";
                    break;
            }
            break;
    }

    cell.textLabel.text = NSLocalizedString(cellText, nil);

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    switch (section) {
        case SUPPORT_SECTION:
            return [NSLocalizedString(@"Version", nil) stringByAppendingFormat:@" %@", AAC_APP_VERSION];
            break;
        default:
            return nil;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case INFO_SECTION:
            switch (indexPath.row) {
                case PRIVACY_POLICY_ROW:
                    [self pushWebViewControllerWithURLString:@"https://path.com/privacy"];
                    break;
            }
            break;
        case SUPPORT_SECTION:
            switch (indexPath.row) {
                case SEND_FEEDBACK_ROW:
                    [self presentMailComposeViewController];
                    break;
            }
            break;
        case LOG_OUT_SECTION:
            switch (indexPath.row) {
                case LOG_OUT_ROW:
                    [self logOutAction];
                    break;
            }
            break;
    }
}

#pragma mark - Actions

- (void)pushWebViewControllerWithURLString:(NSString *)URLString
{
    AACWebViewController *webViewController = [[AACWebViewController alloc] initWithURLString:URLString];
    webViewController.title = NSLocalizedString(@"Privacy Policy", nil);
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)presentMailComposeViewController
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
        mailComposeViewController.mailComposeDelegate = self;
        [mailComposeViewController setToRecipients:@[@"support@acani.com"]];
        [mailComposeViewController setSubject:[NSString stringWithFormat:NSLocalizedString(@"Feedback (v%@)", nil), AAC_APP_VERSION]];
        [self presentViewController:mailComposeViewController animated:YES completion:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Cannot Send Feedback", nil) message:NSLocalizedString(@"No email account has been set up on this device.", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)logOutAction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:NSLocalizedString(@"Log Out", nil) otherButtonTitles:nil];
    actionSheet.tag = LOG_OUT_TAG;
    [actionSheet showInView:self.view.window];
}

- (void)deleteAccountAction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:NSLocalizedString(@"Delete Account", nil) otherButtonTitles:nil];
    actionSheet.tag = DELETE_ACCOUNT_TAG;
    [actionSheet showInView:self.view.window];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    AACAppDelegate *appDelegate = (AACAppDelegate *)[UIApplication sharedApplication].delegate;

    switch (actionSheet.tag) {
        case LOG_OUT_TAG:
            if (buttonIndex == actionSheet.cancelButtonIndex) {
                [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:LOG_OUT_ROW inSection:LOG_OUT_SECTION] animated:YES];
            } else {
                [appDelegate logOutAction];
            }
            break;
        case DELETE_ACCOUNT_TAG:
            if (buttonIndex != actionSheet.cancelButtonIndex) {
                [appDelegate deleteAccountAction];
            }
    }
}

@end
