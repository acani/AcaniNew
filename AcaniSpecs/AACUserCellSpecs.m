#import "AACSpecs.h"
#import "AACUserCell.h"

@interface AACUserCellSpecs : AACSpecs @end

@implementation AACUserCellSpecs {
    AACUserCell *_userCell;
}

#pragma mark - SenTest

- (void)setUp
{
    _userCell = [[AACUserCell alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
}

- (void)tearDown
{
    _userCell = nil;
}

#pragma mark - NSObject

- (void)spec_superclass
{
    STAssertEquals([AACUserCell superclass], [UICollectionViewCell class], nil);
}

#pragma mark - UIView

- (void)specInitWithFrame_
{
    STAssertEquals(_userCell.backgroundColor, [UIColor lightGrayColor], nil);

    UIImageView *backgroundView = (UIImageView *)_userCell.backgroundView;
    STAssertNotNil(backgroundView, nil);
    STAssertEquals([backgroundView class], [UIImageView class], nil);
    STAssertEquals(backgroundView.frame, _userCell.frame, nil);

    UIView *selectedBackgroundView = _userCell.selectedBackgroundView;
    STAssertNotNil(selectedBackgroundView, nil);
    STAssertEquals([selectedBackgroundView class], [UIView class], nil);
    STAssertEquals(selectedBackgroundView.frame, _userCell.frame, nil);
    STAssertEqualObjects(selectedBackgroundView.backgroundColor, [UIColor colorWithWhite:0 alpha:0.5], nil);

    UILabel *nameLabel = _userCell.nameLabel;
    STAssertNotNil(nameLabel, nil);
    STAssertEquals([nameLabel class], [UILabel class], nil);
    STAssertEquals(nameLabel.frame, CGRectMake(3, 0, 75-3, 16), nil);
    STAssertEqualObjects(nameLabel.backgroundColor, [UIColor clearColor], nil);
    STAssertEqualObjects(nameLabel.font, [UIFont boldSystemFontOfSize:12], nil);
    STAssertEqualObjects(nameLabel.shadowColor, [UIColor blackColor], nil);
    STAssertEquals(nameLabel.shadowOffset, CGSizeMake(0, 1), nil);
    STAssertEqualObjects(nameLabel.textColor, [UIColor whiteColor], nil);
    STAssertEquals(nameLabel.superview, _userCell.contentView, nil);
}

@end
