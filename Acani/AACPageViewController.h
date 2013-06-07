#import <UIKit/UIKit.h>

@class AACUser;

@interface AACPageViewController : UIPageViewController

@property (strong, nonatomic, readonly) UITextView *bioTextView;
@property (strong, nonatomic) UIView *footer;

- (id)initWithUser:(AACUser *)user;

@end
