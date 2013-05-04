#import <SenTestingKit/SenTestingKit.h>
#import "AACUser.h"

@interface AACUserSpecs : SenTestCase @end

@implementation AACUserSpecs {
    AACUser *_user;
}

#pragma mark - SenTest

- (void)setUp
{
    _user = [[AACUser alloc] init];
}

- (void)tearDown
{
    _user = nil;
}

#pragma mark - AACUser

- (void)specProperties
{
    STAssertNil(_user.bio, nil);
    STAssertNil(_user.name, nil);
    STAssertNil(_user.uniqueIdentifier, nil);

    _user.bio = @"Hello! My name is Lauren.";
    _user.name = @"Lauren";
    _user.uniqueIdentifier = @"0";

    STAssertEqualObjects(_user.bio, @"Hello! My name is Lauren.", nil);
    STAssertEqualObjects(_user.name, @"Lauren", nil);
    STAssertEqualObjects(_user.uniqueIdentifier, @"0", nil);
}

- (void)specPictureNameOfType
{
    _user.uniqueIdentifier = @"0";
    STAssertEqualObjects([_user pictureNameOfType:AACUserPictureTypeLarge], @"0Large.jpg", nil);
    STAssertEqualObjects([_user pictureNameOfType:AACUserPictureTypeSmall], @"0Small.jpg", nil);

    _user.uniqueIdentifier = @"1";
    STAssertEqualObjects([_user pictureNameOfType:AACUserPictureTypeLarge], @"1Large.jpg", nil);
    STAssertEqualObjects([_user pictureNameOfType:AACUserPictureTypeSmall], @"1Small.jpg", nil);
}

@end
