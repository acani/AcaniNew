#import <UIKit/UIKit.h>

@class AACUser;

@interface AACPageViewController : UIPageViewController

@property (strong, nonatomic) UITextView *bioTextView;

- (id)initWithUser:(AACUser *)user;

@end
