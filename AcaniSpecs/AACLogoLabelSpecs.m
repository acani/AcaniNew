#import "AACDefines.h"
#import "AACLogoLabel.h"
#import "AACSpecs.h"

@interface AACLogoLabelSpecs : AACSpecs @end

@implementation AACLogoLabelSpecs {
    AACLogoLabel *_logoLabel;
}

#pragma mark - SenTest

- (void)setUp
{
    _logoLabel = [[AACLogoLabel alloc] initWithFrame:CGRectMake(20, 40, 280, 80)];
}

- (void)tearDown
{
    _logoLabel = nil;
}

#pragma mark - NSObject

- (void)spec_superclass
{
    STAssertEquals([AACLogoLabel superclass], [UILabel class], nil);
}

#pragma mark - UIView

- (void)specInitWithFrame_
{
    STAssertNotNil(_logoLabel, nil);
    STAssertEquals([_logoLabel class], [AACLogoLabel class], nil);
    STAssertEquals(_logoLabel.frame, CGRectMake(20, 40, 280, 80), nil);
    STAssertEqualObjects(_logoLabel.backgroundColor, [UIColor clearColor], nil);
    STAssertEqualObjects(_logoLabel.font, [UIFont fontWithName:@"AvenirNext-Heavy" size:72], nil);
    STAssertEqualObjects(_logoLabel.shadowColor, [UIColor colorWithWhite:0 alpha:0.5], nil);
    STAssertEquals(_logoLabel.shadowOffset, CGSizeMake(0, -2), nil);
    STAssertEqualObjects(_logoLabel.text, [AAC_APP_NAME lowercaseString], nil);
    STAssertEquals(_logoLabel.textAlignment, NSTextAlignmentCenter, nil);
    STAssertEqualObjects(_logoLabel.textColor, [UIColor whiteColor], nil);
}

@end
