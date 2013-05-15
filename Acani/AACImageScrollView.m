#import "AACImageScrollView.h"

@interface AACImageScrollView () <UIScrollViewDelegate> {
    UIImageView *_imageView;

    CGSize _imageSize;

    CGPoint _pointToCenterAfterResize;
    CGFloat _scaleToRestoreAfterResize;
}

@end

@implementation AACImageScrollView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // Center `_imageView` as it becomes smaller than the size of the screen.
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = _imageView.frame;

    // Center horizontally.
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    } else {
        frameToCenter.origin.x = 0;
    }

    // Center vertically.
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    } else {
        frameToCenter.origin.y = 0;
    }

    _imageView.frame = frameToCenter;
}

- (void)setFrame:(CGRect)frame
{
    BOOL sizeChanging = !CGSizeEqualToSize(frame.size, self.frame.size);

    if (sizeChanging) {
        [self prepareToResize];
    }

    [super setFrame:frame];

    if (sizeChanging) {
        [self recoverFromResizing];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

#pragma mark - `scrollView` Configuration

- (void)displayImage:(UIImage *)image
{
    _imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_imageView];
    _imageSize = image.size;
    self.contentSize = _imageSize;
    [self setMaxMinZoomScalesForCurrentBounds];
    self.zoomScale = self.minimumZoomScale;
}

- (void)setMaxMinZoomScalesForCurrentBounds
{
    CGSize boundsSize = self.bounds.size;

    // Calculate min/max zoomscale.
    CGFloat xScale = boundsSize.width  / _imageSize.width;    // scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / _imageSize.height;   // scale needed to perfectly fit the image height-wise

    // Fill width if the image & screen are both portrait or both landscape; else, take smaller scale.
    BOOL imagePortrait = _imageSize.height > _imageSize.width;
    BOOL devicePortrait = boundsSize.height > boundsSize.width;
    CGFloat minScale = imagePortrait == devicePortrait ? xScale : MIN(xScale, yScale);

    // On high resolution screens, we have double the pixel density, so we will be seeing every pixel if we limit the maximum zoom scale to 0.5.
    CGFloat maxScale = 1.0 / [UIScreen mainScreen].scale;

    // Don't let minScale exceed maxScale. (If the image is smaller than the screen, we don't want to force it to be zoomed.)
    if (minScale > maxScale) {
        minScale = maxScale;
    }

    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;
}

#pragma mark - Rotation Support

- (void)prepareToResize
{
    CGPoint boundsCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _pointToCenterAfterResize = [self convertPoint:boundsCenter toView:_imageView];

    _scaleToRestoreAfterResize = self.zoomScale;

    // If we're at the minimum zoom scale, preserve that by returning 0, which will be converted to the minimum allowable scale when the scale is restored.
    if (_scaleToRestoreAfterResize <= self.minimumZoomScale + FLT_EPSILON) {
        _scaleToRestoreAfterResize = 0;
    }
}

- (void)recoverFromResizing
{
    [self setMaxMinZoomScalesForCurrentBounds];

    // Step 1: Restore zoom scale, first making sure it's within the allowable range.
    CGFloat maxZoomScale = MAX(self.minimumZoomScale, _scaleToRestoreAfterResize);
    self.zoomScale = MIN(self.maximumZoomScale, maxZoomScale);

    // Step 2: Restore center point, first making sure it is within the allowable range.

    // 2a: Convert our desired center point back to our own coordinate space.
    CGPoint boundsCenter = [self convertPoint:_pointToCenterAfterResize fromView:_imageView];

    // 2b: Calculate the content offset that would yield that center point.
    CGPoint offset = CGPointMake(boundsCenter.x - self.bounds.size.width / 2.0,
                                 boundsCenter.y - self.bounds.size.height / 2.0);

    // 2c: Restore offset, adjusted to be within the allowable range.
    CGPoint maxOffset = [self maximumContentOffset];
    CGPoint minOffset = [self minimumContentOffset];

    CGFloat realMaxOffset = MIN(maxOffset.x, offset.x);
    offset.x = MAX(minOffset.x, realMaxOffset);

    realMaxOffset = MIN(maxOffset.y, offset.y);
    offset.y = MAX(minOffset.y, realMaxOffset);

    self.contentOffset = offset;
}

- (CGPoint)maximumContentOffset
{
    CGSize contentSize = self.contentSize;
    CGSize boundsSize = self.bounds.size;
    return CGPointMake(contentSize.width - boundsSize.width, contentSize.height - boundsSize.height);
}

- (CGPoint)minimumContentOffset
{
    return CGPointZero;
}

@end
