#import "AACUser.h"

@implementation AACUser

- (NSString *)name
{
    if ([_lastName length]) {
        return [_firstName stringByAppendingFormat:@" %@", _lastName];
    } else {
        return _firstName;
    }
}

- (NSString *)pictureNameOfType:(AACUserPictureType)pictureType
{
    NSString *pictureTypeString = (pictureType == AACUserPictureTypeLarge ? @"Large" : @"Small");
    return [NSString stringWithFormat:@"%@%@.jpg", _uniqueIdentifier, pictureTypeString];
}

@end
