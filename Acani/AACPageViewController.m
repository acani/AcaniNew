#import "AACPageViewController.h"
#import "AACProfileViewController.h"
#import "AACUser.h"

#define BIO_TAG              810
#define FOOTER_HEIGHT        44
#define FOOTER_BUTTON_HEIGHT 30
#define FOOTER_PADDING       (FOOTER_HEIGHT-FOOTER_BUTTON_HEIGHT)/2 // 14/2 = 7

@implementation AACPageViewController

#pragma mark - Designated Initializer

- (id)initWithUser:(AACUser *)user
{
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self) {
        if (user == [AACUser meUser]) self.navigationItem.rightBarButtonItem = self.editButtonItem;
        AACProfileViewController *profileViewController = [[AACProfileViewController alloc] initWithUser:user];
        self.title = profileViewController.title;
        self.wantsFullScreenLayout = YES;
        [self setViewControllers:@[profileViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    return self;
}

#pragma mark - Properties

- (UITextView *)bioTextView
{
    return (UITextView *)[_footer viewWithTag:BIO_TAG];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *view = self.view;

    CGRect frame = CGRectMake(0, view.frame.size.height-FOOTER_HEIGHT, view.frame.size.width, FOOTER_HEIGHT);
    _footer = [[UIView alloc] initWithFrame:frame];
    _footer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _footer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];

    // TODO: change UITextView link color. Use a UIWebView instead with dataDetectorTypes = All and custom CSS.
    UITextView *bioTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-FOOTER_BUTTON_HEIGHT-FOOTER_PADDING, FOOTER_HEIGHT)];
    bioTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bioTextView.backgroundColor = [UIColor clearColor];
    bioTextView.dataDetectorTypes = UIDataDetectorTypeAll;
    bioTextView.editable = NO;
    bioTextView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    bioTextView.tag = BIO_TAG;
    bioTextView.text = ((AACUser *)[self.viewControllers[0] user]).bio;
    bioTextView.textColor = [UIColor whiteColor];
    [_footer addSubview:bioTextView];

    UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    facebookButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    facebookButton.frame = CGRectMake(frame.size.width-FOOTER_BUTTON_HEIGHT-FOOTER_PADDING, FOOTER_PADDING, FOOTER_BUTTON_HEIGHT, FOOTER_BUTTON_HEIGHT);
    [facebookButton setBackgroundImage:[UIImage imageNamed:@"FacebookIcon"] forState:UIControlStateNormal];
    [facebookButton addTarget:self action:@selector(facebookAction) forControlEvents:UIControlEventTouchUpInside];
    [_footer addSubview:facebookButton];

    [view addSubview:_footer];
}

#pragma mark - Actions

- (void)facebookAction
{
    NSString *facebookID = ((AACUser *)[self.viewControllers[0] user]).facebookID;
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *facebookURL = [NSURL URLWithString:[NSString stringWithFormat:@"fb://profile/%@", facebookID]];
    if (![application canOpenURL:facebookURL]) {
        facebookURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.facebook.com/%@", facebookID]];
    }
    [application openURL:facebookURL];
}

@end
