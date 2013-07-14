#import <UIKit/UIKit.h>

@class AACUser;

@interface AACProfileViewController : UIViewController

@property (nonatomic) AACUser *user;

- (id)initWithUser:(AACUser *)user;

@end
