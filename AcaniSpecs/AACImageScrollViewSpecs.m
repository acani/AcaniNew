#import "AACImageScrollView.h"
#import "AACSpecs.h"

@interface AACImageScrollViewSpecs : AACSpecs @end

@implementation AACImageScrollViewSpecs {
    AACImageScrollView *_imageScrollView;
}

#pragma mark - SenTest

- (void)setUp
{
    _imageScrollView = [[AACImageScrollView alloc] initWithFrame:CGRectMake(20, 40, 280, 80)];
}

- (void)tearDown
{
    _imageScrollView = nil;
}

#pragma mark - NSObject

- (void)spec_superclass
{
    STAssertEquals([AACImageScrollView superclass], [UIScrollView class], nil);
}

#pragma mark - UIView

- (void)specInitWithFrame_
{
    STAssertNotNil(_imageScrollView, nil);
    STAssertEquals([_imageScrollView class], [AACImageScrollView class], nil);
    STAssertEquals(_imageScrollView.frame, CGRectMake(20, 40, 280, 80), nil);
    STAssertEqualObjects(_imageScrollView.backgroundColor, [UIColor blackColor], nil);
    STAssertEquals(_imageScrollView.decelerationRate, UIScrollViewDecelerationRateFast, nil);
    STAssertEquals(_imageScrollView.delegate, _imageScrollView, nil);
    STAssertFalse(_imageScrollView.showsHorizontalScrollIndicator, nil);
    STAssertFalse(_imageScrollView.showsVerticalScrollIndicator, nil);

    // TODO: Spec `_doubleTapGestureRecognizer` & `longPressGestureRecognizer`.
}

// TODO: Complete specs.

@end
