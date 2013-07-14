#import <UIKit/UIKit.h>

@class AACUser;

@interface AACEditProfileViewController : UITableViewController

@property (nonatomic) AACUser *user;

- (id)initWithUser:(AACUser *)user;

@end
