/*=====================
 -- PhotoGram --
 
 by AppsVilla Inc.
 =====================*/

#import <UIKit/UIKit.h>

@protocol CLColorPickerViewDelegate;

@interface CLColorPickerView : UIView

@property (nonatomic, weak) id<CLColorPickerViewDelegate> delegate;
@property (nonatomic, strong) UIColor *color;

@end




@protocol CLColorPickerViewDelegate <NSObject>
@optional
- (void)colorPickerView:(CLColorPickerView*)picker colorDidChange:(UIColor*)color;

@end