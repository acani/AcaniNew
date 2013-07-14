#import <UIKit/UIKit.h>

// This class is based on the PhotoScroller sample app.
// New: https://github.com/kirbyt/KTPhotoBrowser
@interface AACImageScrollView : UIScrollView

@property (nonatomic) UITapGestureRecognizer *doubleTapGestureRecognizer;

- (void)setImage:(UIImage *)image;
- (void)setZoomScale;

@end
