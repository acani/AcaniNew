#import "AACImageScrollView.h"

#define ZOOM_STEP 3
#define IS_ZOOMED_OUT() self.zoomScale == self.minimumZoomScale

@interface AACImageScrollView () <UIScrollViewDelegate, UIActionSheetDelegate> {
    UIImageView *_imageView;
}

@end

@implementation AACImageScrollView

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];              // triggers gesture recognizers
        self.decelerationRate = UIScrollViewDecelerationRateFast;
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

    // Center `_imageView` if it's smaller than the screen size.
    CGSize boundsSize = self.bounds.size;
    CGRect frame = _imageView.frame;

    // horizontally
    if (frame.size.width < boundsSize.width) {
        frame.origin.x = (boundsSize.width - frame.size.width) / 2;
    } else {
        frame.origin.x = 0;
    }

    // vertically
    if (frame.size.height < boundsSize.height) {
        frame.origin.y = (boundsSize.height - frame.size.height) / 2;
    } else {
        frame.origin.y = 0;
    }

    _imageView.frame = frame;
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
    [self addSubview:_imageView];
    [self setMaxMinZoomScales];
}

- (void)setMaxMinZoomScales
{
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = _imageView.bounds.size;

    // Calculate min/max zoomscale.
    CGFloat imageMaxDimension = MAX(imageSize.width, imageSize.height);
    CGFloat frameMinDimension = MIN(boundsSize.width, boundsSize.height);

    self.minimumZoomScale = frameMinDimension / imageMaxDimension;
    self.maximumZoomScale = self.minimumZoomScale * ZOOM_STEP;
}

- (void)setZoomScale
{
    CGSize frameSize = self.frame.size;
    CGSize imageSize = _imageView.frame.size;

    // Calculate zoomscale.
    CGFloat xScale = frameSize.width  / imageSize.width;  // perfectly fits image width-wise
    CGFloat yScale = frameSize.height / imageSize.height; // perfectly fits image height-wise
    self.zoomScale = MIN(xScale, yScale);                 // allows image to become fully visible

//    NSLog(@"frameSize: %@", NSStringFromCGSize(frameSize));
//    NSLog(@"imageSize: %@", NSStringFromCGSize(imageSize));
//
//    NSLog(@"xScale: %f", xScale);
//    NSLog(@"yScale: %f", yScale);
//
//    NSLog(@"minimumZoomScale: %f", self.minimumZoomScale);
//    NSLog(@"maximumZoomScale: %f", self.maximumZoomScale);
//
//    NSLog(@"zoomScale: %f", self.zoomScale);
}

#pragma mark - Actions

- (void)toggleZoomAction:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (IS_ZOOMED_OUT()) {
            CGPoint center = [gestureRecognizer locationInView:_imageView];
            float scale = self.maximumZoomScale;
            CGFloat width  = self.frame.size.width  / scale;
            CGFloat height = self.frame.size.height / scale;
            CGRect zoomRect = CGRectMake(center.x-width/2, center.y-height/2, width, height);
            [self zoomToRect:zoomRect animated:YES];
        } else {
            [self setZoomScale:self.minimumZoomScale animated:YES];
        }
    }
}

- (void)saveOrCopyAction:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Save Picture", nil), NSLocalizedString(@"Copy", nil), nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [actionSheet showInView:self.window];
    }
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
