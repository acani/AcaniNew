#import "AACPageViewController.h"
#import "AACProfileViewController.h"
#import "AACUser.h"

#define BIO_TAG 810

@implementation AACPageViewController

#pragma mark - Designated Initializer

- (id)initWithUser:(AACUser *)user
{
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self) {
        AACProfileViewController *profileViewController = [[AACProfileViewController alloc] initWithUser:user];
        if (user == meUser) self.navigationItem.rightBarButtonItem = self.editButtonItem;
        self.title = profileViewController.title;
        self.wantsFullScreenLayout = YES;
        [self setViewControllers:@[profileViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    return self;
}

- (UITextView *)bioTextView
{
    return (UITextView *)[_footer viewWithTag:BIO_TAG];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *view = self.view;

#define OUT  44
#define IN   30
#define GAP (OUT-IN)/2 // 14/2 = 7

    CGRect frame = CGRectMake(0, view.frame.size.height-OUT, view.frame.size.width, OUT);
    _footer = [[UIView alloc] initWithFrame:frame];
    _footer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _footer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];

    // TODO: change UITextView link color. Use a UIWebView instead with dataDetectorTypes = All and custom CSS.
    UITextView *bioTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-IN-GAP, OUT)];
    bioTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bioTextView.backgroundColor = [UIColor clearColor];
    bioTextView.dataDetectorTypes = UIDataDetectorTypeAll;
    bioTextView.editable = NO;
    bioTextView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    bioTextView.tag = BIO_TAG;
    bioTextView.text = ((AACUser *)[[self.viewControllers lastObject] user]).bio;
    bioTextView.textColor = [UIColor whiteColor];
    [_footer addSubview:bioTextView];

    UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    facebookButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    facebookButton.frame = CGRectMake(frame.size.width-IN-GAP, GAP, IN, IN);
    [facebookButton setBackgroundImage:[UIImage imageNamed:@"FacebookIcon"] forState:UIControlStateNormal];
    [facebookButton addTarget:self action:@selector(facebookAction) forControlEvents:UIControlEventTouchUpInside];
    [_footer addSubview:facebookButton];

    [view addSubview:_footer];
}

#pragma mark - Actions

- (void)facebookAction
{
    NSString *facebookID = ((AACUser *)[[self.viewControllers lastObject] user]).facebookID;
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *facebookURL = [NSURL URLWithString:[NSString stringWithFormat:@"fb://profile/%@", facebookID]];
    if (![application canOpenURL:facebookURL]) {
        facebookURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.facebook.com/%@", facebookID]];
    }
    [application openURL:facebookURL];
}

@end
