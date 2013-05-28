#import "AACPageViewController.h"
#import "AACProfileViewController.h"
#import "AACUser.h"

@implementation AACPageViewController

- (id)initWithUser:(AACUser *)user
{
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self) {
        AACProfileViewController *profileViewController = [[AACProfileViewController alloc] initWithUser:user];
        self.title = profileViewController.title;
        self.wantsFullScreenLayout = YES;
        [self setViewControllers:@[profileViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Add `_bioTextView`.
    // TODO: change UITextView link color. Use a UIWebView instead with dataDetectorTypes = All and custom CSS.
#define BIO_HEIGHT 49
    _bioTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-BIO_HEIGHT, self.view.frame.size.width, BIO_HEIGHT)];
    _bioTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _bioTextView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    _bioTextView.dataDetectorTypes = UIDataDetectorTypeAll;
    _bioTextView.editable = NO;
    _bioTextView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    AACProfileViewController *profileViewController = [self.viewControllers lastObject];
    _bioTextView.text = profileViewController.user.bio;
    _bioTextView.textColor = [UIColor whiteColor];
    [self.view addSubview:_bioTextView];
}

@end
