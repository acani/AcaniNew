#import "AACImageScrollView.h"

@interface AACImageScrollView () <UIScrollViewDelegate, UIActionSheetDelegate> {
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
        self.decelerationRate = UIScrollViewDecelerationRateFast; // good?
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;

        // Add `_doubleTapGestureRecognizer` for `toggleZoomAction:`.
        _doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleZoomAction:)];
        _doubleTapGestureRecognizer.numberOfTapsRequired = 2;
        [self addGestureRecognizer:_doubleTapGestureRecognizer];

        // Add `longPressGestureRecognizer` for `saveOrCopyAction:`.
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveOrCopyAction:)];
        [self addGestureRecognizer:longPressGestureRecognizer];
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

- (void)setImage:(UIImage *)image
{
    _imageView = [[UIImageView alloc] initWithImage:image];
//    _imageView = [[UIImageView alloc] initWithFrame:self.frame];
//    _imageView.contentMode = UIViewContentModeScaleAspectFit;
//    _imageView.image = image;
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

#pragma mark - Double Tap to Zoom

- (void)toggleZoomAction:(UITapGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self zoomToLocation:[gestureRecognizer locationInView:self]];
    }
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;

    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;

    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);

    return zoomRect;
}

- (void)zoomToLocation:(CGPoint)location
{
    float newScale;
    CGRect zoomRect;
    if (self.zoomScale != self.minimumZoomScale) {
        zoomRect = self.bounds;
    } else {
        newScale = self.maximumZoomScale;
        zoomRect = [self zoomRectForScale:newScale withCenter:location];
    }

    [self zoomToRect:zoomRect animated:YES];
}

- (void)saveOrCopyAction:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Save Picture", nil), NSLocalizedString(@"Copy", nil), nil];
        [actionSheet showInView:self];
    }
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

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // TODO: Both cases below slightly alter the image.
    // To fix, use the actual data downloaded and stored as a file.
    switch (buttonIndex) {
        case 0: // Save Picture
            UIImageWriteToSavedPhotosAlbum(_imageView.image, nil, NULL, NULL);
            break;
        case 1: // Copy
            [[UIPasteboard generalPasteboard] setData:UIImageJPEGRepresentation(_imageView.image, 0.8) forPasteboardType:@"public.jpeg"];
            break;
    }
}

@end
