#import <QuartzCore/QuartzCore.h>
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
    STAssertEquals(logoLabel.frame, CGRectMake(20, 40, 280, 80), nil);

    UIButton *logInButton = view.subviews[1];
    STAssertEquals(logInButton.buttonType, UIButtonTypeCustom, nil);
    STAssertEquals(logInButton.frame, CGRectMake(46, 310, 228, 44), nil);
    STAssertEquals(logInButton.layer.cornerRadius, (CGFloat)7, nil);
    STAssertTrue(logInButton.layer.masksToBounds, nil);
    STAssertEqualObjects(logInButton.titleLabel.font, [UIFont boldSystemFontOfSize:16], nil);
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 46, 0, 8);
    UIImage *image = [UIImage imageNamed:@"FacebookButton"];
    image = [image resizableImageWithCapInsets:insets];
    STAssertEqualObjects(UIImagePNGRepresentation([logInButton backgroundImageForState:UIControlStateNormal]), UIImagePNGRepresentation(image), nil);
    image = [UIImage imageNamed:@"FacebookButtonHighlighted"];
    image = [image resizableImageWithCapInsets:insets];
    STAssertEqualObjects(UIImagePNGRepresentation([logInButton backgroundImageForState:UIControlStateHighlighted]), UIImagePNGRepresentation(image), nil);
    STAssertEqualObjects([logInButton titleForState:UIControlStateNormal], NSLocalizedString(@"Log In with Facebook", nil), nil);
    STAssertEquals(logInButton.titleEdgeInsets, insets, nil);
    [self control:logInButton specTarget:[UIApplication sharedApplication].delegate action:@selector(logInAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)specShouldAutorotato
{
    STAssertFalse([_welcomeViewController shouldAutorotate], nil);
}

@end
