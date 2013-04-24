#import "AACUserCell.h"

@implementation AACUserCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
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
