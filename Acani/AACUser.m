#import "AACUser.h"

@implementation AACUser

- (NSString *)pictureNameOfType:(AACUserPictureType)pictureType
{
    NSString *pictureTypeString = (pictureType == AACUserPictureTypeLarge ? @"Large" : @"Small");
    return [NSString stringWithFormat:@"%@%@.jpg", _uniqueIdentifier, pictureTypeString];
}

@end
