#import <UIKit/UIKit.h>

// This class is based on the PhotoScroller sample app.
// New: https://github.com/kirbyt/KTPhotoBrowser
@interface AACImageScrollView : UIScrollView

@property (strong, nonatomic) UITapGestureRecognizer *doubleTapGestureRecognizer;

- (void)displayImage:(UIImage *)image;

@end
