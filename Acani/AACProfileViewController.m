#import "AACImageScrollView.h"
#import "AACProfileViewController.h"
#import "AACUser.h"

@implementation AACProfileViewController

#pragma mark - Designated Initializer

- (id)initWithUser:(AACUser *)user
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = _user.name;
        _user = user;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Add `scrollView`.
    AACImageScrollView *scrollView = [[AACImageScrollView alloc] initWithFrame:self.view.frame];
    NSString *imageName = [NSString stringWithFormat:@"%@Large.jpg", _user.uniqueIdentifier];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [scrollView displayImage:[UIImage imageNamed:imageName]];
    [self.view addSubview:scrollView];

    // Add `bioTextView`.
    _bioTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height-10-100, self.view.frame.size.width-20, 100)];
    _bioTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
    _bioTextView.backgroundColor = [UIColor clearColor];
    _bioTextView.textColor = [UIColor whiteColor];
    _bioTextView.text = _user.bio;
    [self.view addSubview:_bioTextView];
}

@end
