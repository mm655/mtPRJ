//
//  MTTestViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/27.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTTestViewController.h"
#import "CLBlurTool.h"


@interface MTTestViewController ()

@end

@implementation MTTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    return;
    UIImageView * orgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    orgImageView.image = [UIImage imageNamed:@"login_pic2"];
    [self.view addSubview:orgImageView];
    
    UIImageView * rstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 200, 200)];
    [self.view addSubview:rstImageView];
    
    CLBlurTool * tT = [CLBlurTool new];
    tT.originalImage = orgImageView.image;
    tT.blurSlider = [UISlider new];
    tT.blurSlider.value = 0.8f;
    tT.blurType = kCLBlurTypeCircle;
    
    CLBlurBand * bView = [[CLBlurBand alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    bView.color = MTBlack;
    bView.scale = 1.0f;
    bView.offset = 0;
    tT.bandImageRect = CGRectMake(-100, -200, 400, 400);
    tT.bandView = bView;
    
    
    CLBlurCircle * cView = [[CLBlurCircle alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    tT.circleView = cView;
    
    [tT executeWithCompletionBlock:^(UIImage *image, NSError *error, NSDictionary *userInfo) {
        rstImageView.image = image;
        ;
    }];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    UIImage * orgImage = [UIImage imageNamed:@"login_pic1"];
//    
//    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
//    
//    CGContextRef context =  UIGraphicsGetCurrentContext();
//    
//    [orgImage drawInRect:CGRectMake(-50, -50, 150, 150)];
//    UIImage * resultIamge = UIGraphicsGetImageFromCurrentImageContext();
//    
//    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
//    CGContextFillRect(context, CGRectMake(0, 0, 20, 20));
//    
//    
////    CGContextRestoreGState(context);
//    
//    UIGraphicsEndImageContext();

}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIImage * image = [UIImage imageNamed:@"login_pic1"];
    UIImage *mask = [CLImageEditorTheme imageNamed:[NSString stringWithFormat:@"%@/band.png", [self class]]];
    
    UIGraphicsBeginImageContext(image.size);
    
    
    CGRect rct = CGRectMake(0, 0, 100, 100);
    
    
    [mask drawInRect:rct];
    
    //        CGContextRestoreGState(context);
    
    mask = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
