#import "AACSpecs.h"
#import "AACUser.h"

@interface AACUserSpecs : AACSpecs @end

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

#pragma mark - NSObject

- (void)spec_superclass
{
    STAssertEquals([AACUser superclass], [NSObject class], nil);
}

#pragma mark - AACUser

- (void)specBio
{
    STAssertNil(_user.bio, nil);
    _user.bio = @"Hello! My name is Lauren.";
    STAssertEqualObjects(_user.bio, @"Hello! My name is Lauren.", nil);
}

- (void)specFirstName
{
    STAssertNil(_user.firstName, nil);
    _user.firstName = @"Lauren";
    STAssertEqualObjects(_user.firstName, @"Lauren", nil);
}

- (void)specLastName
{
    STAssertNil(_user.lastName, nil);
    _user.lastName = @"Di Pasquale";
    STAssertEqualObjects(_user.lastName, @"Di Pasquale", nil);
}

- (void)specUniqueIdentifier
{
    STAssertNil(_user.uniqueIdentifier, nil);
    _user.uniqueIdentifier = @"0";
    STAssertEqualObjects(_user.uniqueIdentifier, @"0", nil);
}

- (void)specName
{
    _user.firstName = @"Lauren";
    STAssertEqualObjects([_user name], @"Lauren", nil);

    _user.lastName = @"Di Pasquale";
    STAssertEqualObjects([_user name], @"Lauren Di Pasquale", nil);

    _user.firstName = @"";
    STAssertEqualObjects([_user name], @"Di Pasquale", nil);
}

- (void)specPictureNameOfType_
{
    _user.uniqueIdentifier = @"0";
    STAssertEqualObjects([_user pictureNameOfType:AACUserPictureTypeLarge], @"0Large.jpg", nil);
    STAssertEqualObjects([_user pictureNameOfType:AACUserPictureTypeSmall], @"0Small.jpg", nil);

    _user.uniqueIdentifier = @"1";
    STAssertEqualObjects([_user pictureNameOfType:AACUserPictureTypeLarge], @"1Large.jpg", nil);
    STAssertEqualObjects([_user pictureNameOfType:AACUserPictureTypeSmall], @"1Small.jpg", nil);
}

@end
