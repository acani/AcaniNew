#import <QuartzCore/QuartzCore.h>
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

    UIButton *logInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logInButton.frame = CGRectMake(60, 300, 200, 44);
    logInButton.layer.cornerRadius = 7;
    logInButton.layer.masksToBounds = YES;
    logInButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [logInButton setBackgroundImage:[UIImage imageNamed:@"FacebookBackground"] forState:UIControlStateNormal];
    [logInButton setTitle:NSLocalizedString(@"Log In with Facebook", nil) forState:UIControlStateNormal];
    [logInButton addTarget:[UIApplication sharedApplication].delegate action:@selector(logInAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:logInButton];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

@end
