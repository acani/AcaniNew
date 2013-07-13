#import "AACUser.h"

static AACUser *_meUser;

@implementation AACUser

+ (AACUser *)meUser
{
    return _meUser;
}

+ (void)setMeUser:(AACUser *)user
{
    _meUser = user;
}

- (NSString *)name
{
    if ([_firstName length]) {
        if ([_lastName length]) {
            return [_firstName stringByAppendingFormat:@" %@", _lastName];
        } else {
            return _firstName;
        }
    } else {
        return (_lastName ? _lastName : _firstName);
    }
}

- (NSString *)pictureNameOfType:(AACUserPictureType)pictureType
{
    NSString *pictureTypeString = (pictureType == AACUserPictureTypeLarge ? @"Large" : @"Small");
    return [NSString stringWithFormat:@"%@%@.jpg", _uniqueIdentifier, pictureTypeString];
}

@end
