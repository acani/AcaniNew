#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AACUserPictureType) {
    AACUserPictureTypeSmall,
    AACUserPictureTypeLarge
};

@interface AACUser : NSObject

@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *facebookID;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *uniqueIdentifier;

- (NSString *)name;
- (NSString *)pictureNameOfType:(AACUserPictureType)pictureType;

@end

FOUNDATION_EXTERN AACUser *meUser;
