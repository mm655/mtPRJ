//
//  ImageEditViewController.h
//  mttt
//
//  Created by 张勐 on 15/12/26.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageEditViewController : UIViewController
{
    UIImageView * _mainImageView;
    UIButton * _filterButton;
    UIButton * _blurButton;
}
@property (strong, nonatomic) UIImage * orgImage;

-(instancetype) initWithOrgImage : (UIImage *) image;

@end
