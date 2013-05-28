#import <UIKit/UIKit.h>

@class AACUser;

@interface AACEditProfileViewController : UITableViewController

@property (strong, nonatomic) AACUser *user;

- (id)initWithUser:(AACUser *)user;

@end
