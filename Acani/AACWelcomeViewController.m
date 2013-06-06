#import <FacebookSDK/FacebookSDK.h>
#import "AACDefines.h"
#import "AACLogoLabel.h"
#import "AACWelcomeViewController.h"

@implementation AACWelcomeViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView *view = self.view;
    view.backgroundColor = AAC_ROSE_QUARTZ_COLOR;

    CGRect frame = CGRectMake(20, 40, view.frame.size.width-20*2, 80);
    AACLogoLabel *logoLabel = [[AACLogoLabel alloc] initWithFrame:frame];
    [view addSubview:logoLabel];

    UIButton *logInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    logInButton.frame = CGRectMake(70, 300, 180, 44);
    [logInButton setTitle:NSLocalizedString(@"Log In with Facebook", nil) forState:UIControlStateNormal];
    [logInButton addTarget:self action:@selector(logInAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:logInButton];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - Actions

- (void)logInAction {
    NSString *facebookAccessToken = @"FACEBOOK_ACCESS_TOKEN";
    NSLog(@"facebookAccessToken: %@", facebookAccessToken);

//    [FBSession openActiveSessionWithAllowLoginUI:YES]; // TODO: get this working
}

@end
