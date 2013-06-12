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

    CGRect frame = CGRectMake(20, 40, 280, 80);
    AACLogoLabel *logoLabel = [[AACLogoLabel alloc] initWithFrame:frame];
    [view addSubview:logoLabel];

    UIButton *logInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logInButton.frame = CGRectMake(46, 310, 228, 44);
    logInButton.layer.cornerRadius = 7;
    logInButton.layer.masksToBounds = YES;
    logInButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 46, 0, 8);
    UIImage *image = [UIImage imageNamed:@"FacebookButton"];
    image = [image resizableImageWithCapInsets:insets];
    [logInButton setBackgroundImage:image forState:UIControlStateNormal];
    image = [UIImage imageNamed:@"FacebookButtonHighlighted"];
    image = [image resizableImageWithCapInsets:insets];
    [logInButton setBackgroundImage:image forState:UIControlStateHighlighted];
    [logInButton setTitle:NSLocalizedString(@"Log In with Facebook", nil) forState:UIControlStateNormal];
    logInButton.titleEdgeInsets = insets;
    [logInButton addTarget:[UIApplication sharedApplication].delegate action:@selector(logInAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:logInButton];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

@end
