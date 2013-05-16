#import "AACImageScrollView.h"
#import "AACProfileViewController.h"
#import "AACUser.h"

@implementation AACProfileViewController

#pragma mark - Designated Initializer

- (id)initWithUser:(AACUser *)user
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _user = user;
        self.wantsFullScreenLayout = YES;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Add `_pictureImageScrollView`.
    _pictureImageScrollView = [[AACImageScrollView alloc] initWithFrame:self.view.frame];
    _pictureImageScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    NSString *imageName = [NSString stringWithFormat:@"%@Large.jpg", _user.uniqueIdentifier];
    [_pictureImageScrollView setImage:[UIImage imageNamed:imageName]];
    [self.view addSubview:_pictureImageScrollView];

    // Add `singleTapGestureRecoginzer` for `toggleChromeHiddenAction`.
    UITapGestureRecognizer *singleTapGestureRecoginzer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleChromeHiddenAction:)];
    [_pictureImageScrollView addGestureRecognizer:singleTapGestureRecoginzer];
    [singleTapGestureRecoginzer requireGestureRecognizerToFail:_pictureImageScrollView.doubleTapGestureRecognizer];

    // Add `_bioTextView`.
    _bioTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height-10-100, self.view.frame.size.width-20, 100)];
    _bioTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
    _bioTextView.backgroundColor = [UIColor clearColor];
    _bioTextView.dataDetectorTypes = UIDataDetectorTypeAll;
    _bioTextView.editable = NO;
    _bioTextView.text = _user.bio;
    _bioTextView.textColor = [UIColor whiteColor];
    [self.view addSubview:_bioTextView];
}

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
            _bioTextView.alpha = alpha;
        }];
    }
}

@end
