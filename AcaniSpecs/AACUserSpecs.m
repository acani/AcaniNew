#import <SenTestingKit/SenTestingKit.h>
#import "AACUser.h"

@interface AACUserSpecs : SenTestCase @end

@implementation AACUserSpecs {
    AACUser *_user;
}

- (void)setUp
{
    _user = [[AACUser alloc] init];
}

- (void)tearDown
{
    _user = nil;
}

- (void)specProperties
{
    STAssertNil(_user.bio,                                                                            @"Start bio nil.");
    STAssertNil(_user.name,                                                                           @"Start name nil.");
    STAssertNil(_user.uniqueIdentifier,                                                               @"Start uniqueIdentifier nil.");

    _user.bio = @"Hello! My name is Lauren.";
    _user.name = @"Lauren";
    _user.uniqueIdentifier = @"0";

    STAssertEqualObjects(_user.bio, @"Hello! My name is Lauren.",                                     @"Add bio property.");
    STAssertEqualObjects(_user.name, @"Lauren",                                                       @"Add name property.");
    STAssertEqualObjects(_user.uniqueIdentifier, @"0",                                                @"Add uniqueIdentifier property.");
}

- (void)specPictureNameOfType
{
    _user.uniqueIdentifier = @"0";
    STAssertEqualObjects([_user pictureNameOfType:AACUserPictureTypeLarge], @"0Large.jpg",            @"Return large name.");
    STAssertEqualObjects([_user pictureNameOfType:AACUserPictureTypeSmall], @"0Small.jpg",            @"Return small name.");

    _user.uniqueIdentifier = @"1";
    STAssertEqualObjects([_user pictureNameOfType:AACUserPictureTypeLarge], @"1Large.jpg",            @"Return large name.");
    STAssertEqualObjects([_user pictureNameOfType:AACUserPictureTypeSmall], @"1Small.jpg",            @"Return small name.");
}

@end
