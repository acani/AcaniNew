#import <QuartzCore/QuartzCore.h>
#import "AACDefines.h"
#import "AACLogoLabel.h"
#import "AACWelcomeViewController.h"

@implementation AACWelcomeViewController {
    UIButton *_logInButton;
    UIActivityIndicatorView *_activityIndicatorView;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView *view = self.view;
    view.backgroundColor = AAC_ROSE_QUARTZ_COLOR;

    CGRect frame = CGRectMake(20, 40, 280, 80);
    AACLogoLabel *logoLabel = [[AACLogoLabel alloc] initWithFrame:frame];
    [view addSubview:logoLabel];

    _logInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _logInButton.frame = CGRectMake(46, 310, 228, 44);
    _logInButton.layer.cornerRadius = 7;
    _logInButton.layer.masksToBounds = YES;
    _logInButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 46, 0, 8);
    UIImage *image = [UIImage imageNamed:@"FacebookButton"];
    image = [image resizableImageWithCapInsets:insets];
    [_logInButton setBackgroundImage:image forState:UIControlStateNormal];
    image = [UIImage imageNamed:@"FacebookButtonHighlighted"];
    image = [image resizableImageWithCapInsets:insets];
    [_logInButton setBackgroundImage:image forState:UIControlStateHighlighted];
    [_logInButton setTitle:NSLocalizedString(@"Log In with Facebook", nil) forState:UIControlStateNormal];
    [_logInButton setTitle:NSLocalizedString(@"Logging In...", nil) forState:UIControlStateSelected];
    _logInButton.titleEdgeInsets = insets;
    [_logInButton addTarget:[UIApplication sharedApplication].delegate action:@selector(logInAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_logInButton];
}

#pragma mark - AACWelcomeViewController

- (void)beginLoggingIn
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    _logInButton.selected = YES;
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityIndicatorView.center = CGPointMake(_logInButton.frame.size.width - _activityIndicatorView.frame.size.width, _logInButton.frame.size.height/2);
        [_logInButton addSubview:_activityIndicatorView];
    }
    [_activityIndicatorView startAnimating];
}

- (void)endLoggingIn
{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    _logInButton.selected = NO;
    [_activityIndicatorView stopAnimating];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

@end
