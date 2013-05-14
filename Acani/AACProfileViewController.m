#import "AACProfileViewController.h"
#import "AACUser.h"

@implementation AACProfileViewController

#pragma mark - Designated Initializer

- (id)initWithUser:(AACUser *)user
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _user = user;
    }
    return self;
}

#pragma mark - UIViewController

- (void)loadView
{
    NSString *pictureName = [NSString stringWithFormat:@"%@Large.jpg", _user.uniqueIdentifier];
    UIImage *picture = [UIImage imageNamed:pictureName];
    self.view = [[UIImageView alloc] initWithImage:picture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
