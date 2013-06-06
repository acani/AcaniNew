#import "AACSpecs.h"

@implementation AACSpecs

- (void)control:(UIControl *)control specTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    NSSet *targets = [control allTargets];
    STAssertEquals([targets count], (NSUInteger)1, nil);
    STAssertEquals([targets anyObject], target, nil);
    STAssertEquals([control allControlEvents], controlEvents, nil);
    NSArray *actions = [control actionsForTarget:target forControlEvent:UIControlEventTouchUpInside];
    STAssertEquals([actions count], (NSUInteger)1, nil);
    STAssertEqualObjects(actions[0], NSStringFromSelector(action) , nil);
}

@end
