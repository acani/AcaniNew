#import "AACImageScrollView.h"
#import "AACPageViewController.h"
#import "AACProfileViewController.h"
#import "AACUser.h"

@implementation AACProfileViewController

#pragma mark - Designated Initializer

- (id)initWithUser:(AACUser *)user
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _user = user;
        self.title = user.name;
        self.wantsFullScreenLayout = YES;
    }
    return self;
}

#pragma mark - Properties

- (AACImageScrollView *)imageScrollView
{
    return (AACImageScrollView *)self.view;
}

- (void)setImageScrollView:(AACImageScrollView *)imageScrollView
{
    self.view = imageScrollView;
}

#pragma mark - UIViewController

- (void)loadView
{
    AACImageScrollView *imageScrollView = [[AACImageScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    NSString *imageName = [NSString stringWithFormat:@"%@Large.jpg", _user.uniqueIdentifier];
    [imageScrollView setImage:[UIImage imageNamed:imageName]];
    self.view = imageScrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Add `singleTapGestureRecoginzer` for `toggleChromeHiddenAction`.
    UITapGestureRecognizer *singleTapGestureRecoginzer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleChromeHiddenAction:)];
    AACImageScrollView *imageScrollView = (AACImageScrollView *)self.view;
    [imageScrollView addGestureRecognizer:singleTapGestureRecoginzer];
    [singleTapGestureRecoginzer requireGestureRecognizerToFail:imageScrollView.doubleTapGestureRecognizer];
}

// TODO: Remove this method and set zoomScale properly, including for rotation.
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [(AACImageScrollView *)self.view setZoomScale];
}

// HACK: Fixes rotation bug.
// http://stackoverflow.com/a/6190485/242933
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (!self.navigationController.navigationBar.alpha) {
        [UIApplication sharedApplication].statusBarHidden = NO;
    }
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (!self.navigationController.navigationBar.alpha) {
        [UIApplication sharedApplication].statusBarHidden = YES;
    }
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

#pragma mark - Actions

// Fade out status & navigation bars and `_bioTextView`.
- (void)toggleChromeHiddenAction:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        UIApplication *application = [UIApplication sharedApplication];
        BOOL hidden = !application.statusBarHidden;
        CGFloat alpha = hidden ? 0 : 1;

        [UIView animateWithDuration:1/3.0 animations:^{
            [application setStatusBarHidden:hidden withAnimation:UIStatusBarAnimationNone];
            self.navigationController.navigationBar.alpha = alpha;
            ((AACPageViewController *)self.parentViewController).bioTextView.alpha = alpha;
        }];
    }
}

@end
