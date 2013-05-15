#import <UIKit/UIKit.h>

@class AACUser;

@interface AACProfileViewController : UIViewController

@property (strong, nonatomic) UITextView *bioTextView;
@property (strong, nonatomic) AACUser *user;

- (id)initWithUser:(AACUser *)user;

@end
