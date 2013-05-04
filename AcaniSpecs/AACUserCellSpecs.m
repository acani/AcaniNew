#import <SenTestingKit/SenTestingKit.h>
#import "AACUserCell.h"

@interface AACUserCellSpecs : SenTestCase @end

@implementation AACUserCellSpecs {
    AACUserCell *_userCell;
}

#pragma mark - SenTest

- (void)setUp
{
    _userCell = [[AACUserCell alloc] initWithFrame:CGRectMake(4, 4, 75, 75)];
}

- (void)tearDown
{
    _userCell = nil;
}

#pragma mark - UIView

- (void)specInitWithFrame
{
    // Spec `nameLabel`.
    UILabel *nameLabel = _userCell.nameLabel;
    STAssertNotNil(nameLabel, nil);
    STAssertEquals(nameLabel.frame, CGRectMake(3, 0, 75-3, 16), nil);
    STAssertEqualObjects(nameLabel.backgroundColor, [UIColor clearColor], nil);
    STAssertEqualObjects(nameLabel.font, [UIFont boldSystemFontOfSize:12], nil);
    STAssertEqualObjects(nameLabel.shadowColor, [UIColor blackColor], nil);
    STAssertEquals(nameLabel.shadowOffset, CGSizeMake(0, 1), nil);
    STAssertEqualObjects(nameLabel.textColor, [UIColor whiteColor], nil);
    STAssertEquals(nameLabel.superview, _userCell.contentView, nil);
}

@end
