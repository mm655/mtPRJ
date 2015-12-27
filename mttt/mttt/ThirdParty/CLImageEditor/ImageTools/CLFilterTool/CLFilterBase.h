/*=====================
 -- PhotoGram --
 
 by AppsVilla Inc.
 =====================*/

#import <Foundation/Foundation.h>

#import "CLImageToolSettings.h"

@protocol CLFilterBaseProtocol <NSObject>

@required
+ (UIImage*)applyFilter:(UIImage*)image;

@end


@interface CLFilterBase : NSObject<CLImageToolProtocol, CLFilterBaseProtocol>

@end


@interface CLDefaultEmptyFilter : CLFilterBase

+ (UIImage*)filteredImage:(UIImage*)image withFilterName:(NSString*)filterName;

@end


@interface CLDefaultLinearFilter : CLDefaultEmptyFilter
@end


@interface CLDefaultVignetteFilter : CLDefaultEmptyFilter
@end

@interface CLDefaultInstantFilter : CLDefaultEmptyFilter
@end

@interface CLDefaultProcessFilter : CLDefaultEmptyFilter
@end


@interface CLDefaultTransferFilter : CLDefaultEmptyFilter
@end

@interface CLDefaultSepiaFilter : CLDefaultEmptyFilter
@end


@interface CLDefaultChromeFilter : CLDefaultEmptyFilter
@end


@interface CLDefaultFadeFilter : CLDefaultEmptyFilter
@end


@interface CLDefaultCurveFilter : CLDefaultEmptyFilter
@end


@interface CLDefaultTonalFilter : CLDefaultEmptyFilter
@end


@interface CLDefaultNoirFilter : CLDefaultEmptyFilter
@end


@interface CLDefaultMonoFilter : CLDefaultEmptyFilter
@end


@interface CLDefaultInvertFilter : CLDefaultEmptyFilter
@end



