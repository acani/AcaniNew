#import "AACDefines.h"
#import "AACSpecs.h"

@interface AACDefinesSpecs : AACSpecs @end

@implementation AACDefinesSpecs

- (void)specDefines
{
    STAssertEqualObjects(AAC_APP_NAME, @"Acani", nil);
    STAssertEqualObjects(AAC_ROSE_QUARTZ_COLOR, [UIColor colorWithRed:217/255.0 green:153/255.0 blue:166/255.0 alpha:1], nil);
}

@end
