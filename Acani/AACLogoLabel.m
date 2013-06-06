#import "AACDefines.h"
#import "AACLogoLabel.h"

@implementation AACLogoLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont fontWithName:@"AvenirNext-Heavy" size:72];
        self.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.shadowOffset = CGSizeMake(0, -2);
        self.text = [AAC_APP_NAME lowercaseString]; // acani
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
    }
    return self;
}

@end
