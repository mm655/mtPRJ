/*=====================
 -- PhotoGram --
 
 by AppsVilla Inc.
 =====================*/

#import "CLImageToolBase.h"

typedef NS_ENUM(NSUInteger, CLBlurType)
{
    kCLBlurTypeNormal = 0,
    kCLBlurTypeCircle,
    kCLBlurTypeBand,
};

@interface CLBlurCircle : UIView
@property (nonatomic, strong) UIColor *color;
@end

@interface CLBlurBand : UIView
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat rotation;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat offset;
@end

@interface CLBlurTool : CLImageToolBase

@property (strong, nonatomic) UIImage *originalImage;
@property (strong, nonatomic) UIImage *thumnailImage;
@property (strong, nonatomic) UIImage *blurImage;

@property (strong, nonatomic) UISlider *blurSlider;
@property (strong, nonatomic) UIScrollView *menuScroll;

@property (strong, nonatomic) UIView *handlerView;

@property (strong, nonatomic) CLBlurCircle *circleView;
@property (strong, nonatomic) CLBlurBand *bandView;
@property (assign, nonatomic) CGRect bandImageRect;

@property (assign, nonatomic) CLBlurType blurType;

@end



