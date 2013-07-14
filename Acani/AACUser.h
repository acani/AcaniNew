#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AACUserPictureType) {
    AACUserPictureTypeSmall,
    AACUserPictureTypeLarge
};

@interface AACUser : NSObject

@property (copy, nonatomic) NSString *bio;
@property (copy, nonatomic) NSString *facebookID;
@property (copy, nonatomic) NSString *firstName;
@property (copy, nonatomic) NSString *lastName;
@property (copy, nonatomic) NSString *uniqueIdentifier;

+ (AACUser *)meUser;
+ (void)setMeUser:(AACUser *)user;

- (NSString *)name;
- (NSString *)pictureNameOfType:(AACUserPictureType)pictureType;

@end
