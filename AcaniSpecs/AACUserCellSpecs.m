#import <SenTestingKit/SenTestingKit.h>
#import "AACUserCell.h"

@interface AACUserCellSpecs : SenTestCase @end

@implementation AACUserCellSpecs {
    AACUserCell *_userCell;
}

- (void)setUp
{
    _userCell = [[AACUserCell alloc] initWithFrame:CGRectMake(4, 4, 75, 75)];
}

- (void)tearDown
{
    _userCell = nil;
}

- (void)specInitWithFrame
{
    UILabel *nameLabel = _userCell.nameLabel;
    STAssertNotNil(nameLabel,                                                                         @"Create and set nameLabel.");
    STAssertEquals(nameLabel.frame, CGRectMake(3, 0, 75-3, 16),                                       @"Set frame.");
    STAssertEqualObjects(nameLabel.backgroundColor, [UIColor clearColor],                             @"Set backgroundColor.");
    STAssertEqualObjects(nameLabel.font, [UIFont boldSystemFontOfSize:12],                            @"Set font.");
    STAssertEqualObjects(nameLabel.shadowColor, [UIColor blackColor],                                 @"Set shadowColor.");
    STAssertEquals(nameLabel.shadowOffset, CGSizeMake(0, 1),                                          @"Set shadowOffset.");
    STAssertEqualObjects(nameLabel.textColor, [UIColor whiteColor],                                   @"Set textColor.");
    STAssertEquals(nameLabel.superview, _userCell.contentView,                                        @"Set superview.");
}

@end
