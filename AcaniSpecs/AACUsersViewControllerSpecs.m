#import <SenTestingKit/SenTestingKit.h>
#import "AACUserCell.h"

@interface AACUsersViewControllerSpecs : SenTestCase @end

@implementation AACUsersViewControllerSpecs

- (void)specLaunch
{
    UICollectionView *collectionView = ((UICollectionViewController *)((UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController).topViewController).collectionView;
    STAssertEquals(collectionView.alwaysBounceVertical, YES,                                          @"Set alwaysBounceVertical to YES.");
    STAssertEqualObjects(collectionView.backgroundColor, [UIColor whiteColor],                        @"Set backgroundColor to white.");

    NSInteger numberOfItems = [collectionView numberOfItemsInSection:0];
    STAssertEquals([collectionView numberOfSections], 1,                                              @"Add one section.");
    STAssertEquals(numberOfItems, 30,                                                                 @"Add 30 items to section 0.");

    NSInteger item = 0;
    for (AACUserCell *cell in [collectionView visibleCells]) {
        STAssertTrue([cell isMemberOfClass:[AACUserCell class]],                                      @"Register class AACUserCell.");

        NSString *name;
        NSString *pictureName;

        if (item % 2) {
            name = @"Matt";
            pictureName = @"1Small.jpg";
        } else {
            name = @"Lauren";
            pictureName = @"0Small.jpg";
        }

        UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:pictureName]];
        STAssertEqualObjects(cell.backgroundColor, color,                                             @"Set background color.");
        STAssertEqualObjects(cell.nameLabel.text, name,                                               @"Set nameLabel.text.");

        item++;
    }
}

@end
