#import "AACDefines.h"
#import "AACLogoLabel.h"
#import "AACSpecs.h"
#import "AACWelcomeViewController.h"

@interface AACWelcomeViewControllerSpecs : AACSpecs @end

@implementation AACWelcomeViewControllerSpecs {
    AACWelcomeViewController *_welcomeViewController;
}

#pragma mark - SenTest

- (void)setUp
{
    _welcomeViewController = [[AACWelcomeViewController alloc] initWithNibName:nil bundle:nil];
}

- (void)tearDown
{
    _welcomeViewController = nil;
}

#pragma mark - NSObject

- (void)spec_superclass
{
    STAssertEquals([AACWelcomeViewController superclass], [UIViewController class], nil);
}

#pragma mark - UIViewController

- (void)specViewDidLoad
{
    UIView *view = _welcomeViewController.view;
    STAssertEqualObjects(view.backgroundColor, AAC_ROSE_QUARTZ_COLOR, nil);

    UILabel *logoLabel = view.subviews[0];
    STAssertEquals([logoLabel class], [AACLogoLabel class], nil);
    STAssertEquals(logoLabel.frame, CGRectMake(20, 40, view.frame.size.width-20*2, 80), nil);

    UIButton *logInButton = view.subviews[1];
    STAssertEquals(logInButton.buttonType, UIButtonTypeRoundedRect, nil);
    STAssertEquals(logInButton.frame, CGRectMake(70, 300, 180, 44), nil);
    STAssertEqualObjects([logInButton titleForState:UIControlStateNormal], NSLocalizedString(@"Log In with Facebook", nil), nil);
    [self control:logInButton specTarget:_welcomeViewController action:@selector(logInAction) forControlEvents:UIControlEventTouchUpInside];

}

- (void)specShouldAutorotato
{
    STAssertFalse([_welcomeViewController shouldAutorotate], nil);
}

@end
