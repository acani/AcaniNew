#import <SenTestingKit/SenTestingKit.h>

@interface AACSpecs : SenTestCase

- (void)control:(UIControl *)control specTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
