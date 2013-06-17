#import "AACPageViewController.h"
#import "AACProfileViewController.h"
#import "AACSpecs.h"
#import "AACUser.h"

#define FOOTER_HEIGHT        44
#define FOOTER_BUTTON_HEIGHT 30
#define FOOTER_PADDING       (FOOTER_HEIGHT-FOOTER_BUTTON_HEIGHT)/2

@interface AACPageViewControllerSpecs : AACSpecs @end

@implementation AACPageViewControllerSpecs {
    AACPageViewController *_pageViewController;
    AACUser *_user;
}

#pragma mark - SenTest

- (void)setUp
{
    _user = [[AACUser alloc] init];
    _user.bio = @"Hello! This is my bio.";
    _user.firstName = @"Matt";
    _user.lastName = @"Di Pasquale";
    _user.uniqueIdentifier = @"1";
    
    _pageViewController = [[AACPageViewController alloc] initWithUser:_user];
}

- (void)tearDown
{
    _pageViewController = nil;
    _user = nil;
}

#pragma mark - NSObject

- (void)spec_superclass
{
    STAssertEquals([AACPageViewController superclass], [UIPageViewController class], nil);
}

#pragma mark - Designated Initializer

- (void)specInitWithUser_
{
    STAssertNotNil(_pageViewController, nil);
    STAssertEquals([_pageViewController class], [AACPageViewController class], nil);
    
    STAssertNotNil(_user, nil);
    STAssertEquals([_user class], [AACUser class], nil);

    STAssertNil(_pageViewController.navigationItem.rightBarButtonItem, nil);
    AACProfileViewController *profileViewController = (AACProfileViewController *)_pageViewController.viewControllers[0];
    STAssertEquals([profileViewController class], [AACProfileViewController class], nil);
    STAssertEquals(profileViewController.user, _user, nil);
    STAssertEqualObjects(_pageViewController.title, profileViewController.title, nil);
    STAssertTrue(_pageViewController.wantsFullScreenLayout, nil);
}

- (void)specInitWithMeUser_
{
    meUser = _user;
    _pageViewController = [[AACPageViewController alloc] initWithUser:_user];
    UIBarButtonItem *rightBarButtonItem = _pageViewController.navigationItem.rightBarButtonItem;
    STAssertEquals(rightBarButtonItem, _pageViewController.editButtonItem, nil);
    meUser = nil;
}

#pragma mark - UIViewController

- (void)specViewDidLoad
{
    UIView *view = _pageViewController.view;

    UIView *footer = _pageViewController.footer;
    STAssertNotNil(footer, nil);
    STAssertEquals([footer class], [UIView class], nil);
    CGRect frame = CGRectMake(0, view.frame.size.height-FOOTER_HEIGHT, view.frame.size.width, FOOTER_HEIGHT);
    STAssertEquals(footer.frame, frame, nil);
    STAssertEquals(footer.autoresizingMask, UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin, nil);
    STAssertEqualObjects(footer.backgroundColor, [UIColor colorWithWhite:0 alpha:0.5], nil);
    STAssertEquals(footer.superview, view, nil);

    UITextView *bioTextView = _pageViewController.bioTextView;
    STAssertNotNil(bioTextView, nil);
    STAssertEquals([bioTextView class], [UITextView class], nil);
    STAssertEquals(bioTextView.autoresizingMask, UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight, nil);
    STAssertEqualObjects(bioTextView.backgroundColor, [UIColor clearColor], nil);
    STAssertEquals(bioTextView.dataDetectorTypes, UIDataDetectorTypeAll, nil);
    STAssertFalse(bioTextView.editable, nil);
    STAssertEquals(bioTextView.indicatorStyle, UIScrollViewIndicatorStyleWhite, nil);
    STAssertEqualObjects(bioTextView.text, _user.bio, nil);
    STAssertEqualObjects(bioTextView.textColor, [UIColor whiteColor], nil);
    STAssertEquals(bioTextView.superview, footer, nil);

    UIButton *facebookButton = footer.subviews[1];
    STAssertEquals([facebookButton class], [UIButton class], nil);
    STAssertEquals(facebookButton.autoresizingMask, UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin, nil);
    frame = CGRectMake(frame.size.width-FOOTER_BUTTON_HEIGHT-FOOTER_PADDING, FOOTER_PADDING, FOOTER_BUTTON_HEIGHT, FOOTER_BUTTON_HEIGHT);
    STAssertEquals(facebookButton.frame, frame, nil);
    STAssertEqualObjects([facebookButton backgroundImageForState:UIControlStateNormal], [UIImage imageNamed:@"FacebookIcon"], nil);
    [self control:facebookButton specTarget:_pageViewController action:@selector(facebookAction) forControlEvents:UIControlEventTouchUpInside];
}

@end
