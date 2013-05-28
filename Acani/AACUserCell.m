#import "AACUserCell.h"

@implementation AACUserCell

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];

        // Create `self.backgroundView` & `self.selectedBackgroundView` for picture.
        self.backgroundView = [[UIImageView alloc] initWithFrame:frame];
        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:frame];
        selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.selectedBackgroundView = selectedBackgroundView;

        // Create `_nameLabel`.
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, 75-3, 16)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:12];
        _nameLabel.shadowColor = [UIColor blackColor];
        _nameLabel.shadowOffset = CGSizeMake(0, 1);
        _nameLabel.textColor = [UIColor whiteColor];

        [self.contentView addSubview:_nameLabel];
    }
    return self;
}

@end
