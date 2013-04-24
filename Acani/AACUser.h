#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AACUserPictureType) {
    AACUserPictureTypeSmall,
    AACUserPictureTypeLarge
};

@interface AACUser : NSObject

@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *uniqueIdentifier;

- (NSString *)pictureNameOfType:(AACUserPictureType)pictureType;

@end
