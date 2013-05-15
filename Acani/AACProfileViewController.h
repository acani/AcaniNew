#import <UIKit/UIKit.h>

@class AACImageScrollView;
@class AACUser;

@interface AACProfileViewController : UIViewController

@property (strong, nonatomic) UITextView *bioTextView;
@property (strong, nonatomic) AACImageScrollView *pictureImageScrollView;
@property (strong, nonatomic) AACUser *user;

- (id)initWithUser:(AACUser *)user;

@end
