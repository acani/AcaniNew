#import "AACPageViewController.h"
#import "AACSpecs.h"
#import "AACUser.h"

@interface AACPageViewControllerSpecs : AACSpecs @end

@implementation AACPageViewControllerSpecs{
    AACPageViewController *_pageViewController;
    AACUser *_user;
}

#pragma mark - SenTest

- (void)setUp
{
    _user = [[AACUser alloc] init];
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
    STAssertEquals([AACPageViewController superclass], [UITableViewController class], nil);
}
//I didn't really understand what to do within specInitWithUser, so I gave it my best shot, even though I know it's all probably wrong.
- (void)specInitWithUser
{
    STAssertNotNil(_pageViewController, nil);
    STAssertEquals([_pageViewController class], [AACPageViewController class], nil);
    
    STAssertNotNil(_user, nil);
    STAssertEquals([_user class], [AACUser class], nil);
    UIBarButtonItem *rightBarButtonItem = _pageViewController.navigationItem.rightBarButtonItem;
    STAssertNotNil(rightBarButtonItem, nil);
    STAssertEqualObjects(rightBarButtonItem.title, NSLocalizedString(@"Edit", nil), nil);
    STAssertEquals(rightBarButtonItem.style, UIBarButtonItemStyleDone, nil);
    STAssertEquals(rightBarButtonItem.action, @selector(saveProfileAction), nil);
    
    STAssertEqualObjects(_pageViewController.title, NSLocalizedString(@"Edit Profile", nil), nil);
}

#pragma mark - UIViewController

- (void)specViewDidLoad
{
    UIView *view = _pageViewController.view;
    //How would this be turned into an STAssertEquals line?  Still unclear on how to break this type of statement down
    //CGRect frame = CGRectMake(0, view.frame.size.height-OUT, view.frame.size.width, OUT);
    

}
// TODO: Spec.

@end
