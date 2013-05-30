#import <FacebookSDK/FacebookSDK.h>
#import "AACWelcomeViewController.h"
#import "AACDefines.h"

@implementation AACWelcomeViewController

#pragma mark - UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = AAC_ROSE_QUARTZ_COLOR;

    // Add `logoLabel`.
    UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 280, 80)];
    logoLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    logoLabel.backgroundColor = [UIColor clearColor];
    logoLabel.font = [UIFont fontWithName:@"AvenirNext-Heavy" size:72];
    logoLabel.shadowOffset = CGSizeMake(0, -2);
    logoLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
    logoLabel.text = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"] lowercaseString]; // acani
    logoLabel.textAlignment = NSTextAlignmentCenter;
    logoLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:logoLabel];

    // Add logInButton.
    UIButton *logInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    logInButton.frame = CGRectMake(70, 300, 180, 44);
    [logInButton setTitle:@"Log In with Facebook" forState:UIControlStateNormal];
    [logInButton addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logInButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)logIn {
    NSString *facebookAccessToken = @"FACEBOOK_ACCESS_TOKEN";
    NSLog(@"facebookAccessToken: %@", facebookAccessToken);

//    [FBSession openActiveSessionWithAllowLoginUI:YES]; // TODO: get this working
}

@end
