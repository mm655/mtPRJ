/*=====================
 -- PhotoGram --
 
 by AppsVilla Inc.
 =====================*/

#import <Foundation/Foundation.h>

@interface CLImageToolInfo : NSObject

@property (nonatomic, readonly) NSString *toolName;
@property (nonatomic, strong)   NSString *title;
@property (nonatomic, assign)   BOOL      available;
@property (nonatomic, assign)   CGFloat   dockedNumber;
@property (nonatomic, strong)   NSString *iconImagePath;
@property (nonatomic, readonly) UIImage  *iconImage;
@property (nonatomic, readonly) NSArray  *subtools;
@property (nonatomic, strong) NSMutableDictionary *optionalInfo;


- (NSString*)toolTreeDescription;
- (NSArray*)sortedSubtools;

- (CLImageToolInfo*)subToolInfoWithToolName:(NSString*)toolName recursive:(BOOL)recursive;

@end
