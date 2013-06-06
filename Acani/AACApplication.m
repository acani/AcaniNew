#import "AACApplication.h"

// HACK: Status bar width & height are swapped in landscape mode.
// http://stackoverflow.com/a/16598350/242933
// TODO: Spec.
CGFloat AACStatusBarHeight()
{
    CGSize statusBarSize = [UIApplication sharedApplication].statusBarFrame.size;
    return MIN(statusBarSize.width, statusBarSize.height);
}
