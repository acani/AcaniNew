#import <UIKit/UIKit.h>

@class AACUser;

@interface AACPageViewController : UIPageViewController

@property (nonatomic, readonly) UITextView *bioTextView;
@property (nonatomic, readonly) UIView *footer;

- (id)initWithUser:(AACUser *)user;

@end
