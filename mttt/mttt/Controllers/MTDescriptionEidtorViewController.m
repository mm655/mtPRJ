//
//  MTDescriptionEidtorViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/29.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTDescriptionEidtorViewController.h"
#import "MTNetworkUpLoadPic.h"
#import "MTShotViewController.h"

@interface MTDescriptionEidtorViewController ()

@property (strong, nonatomic) UITextField * descriptionField;
@property (strong, nonatomic) UIView * progressView;

@end

@implementation MTDescriptionEidtorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = MTWhite;
    
    UIView * topBlue = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, 64)];
    topBlue.backgroundColor = MTBlue;
    [self.view addSubview:topBlue];
    
    UIButton * rtButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 44, 44)];
    [rtButton setImage:[UIImage imageNamed:@"back_array_left"] forState:UIControlStateNormal];
    [self.view addSubview:rtButton];
    [rtButton addTarget:self action:@selector(rtButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 74, 44, 44)];
    leftImageView.image = self.finalImage;
    [self.view addSubview:leftImageView];
    
    UITextField * descriptionField = [[UITextField alloc] initWithFrame:CGRectMake(64, 74, SCWidth - 74, 44)];
//    descriptionView.
    self.descriptionField = descriptionField;
    descriptionField.placeholder = @"添加图片说明";
//    descriptionField
    [self.view addSubview:descriptionField];
//    descriptionField.textAlignment = NSTextAlignmentLeft;
    
    UIView * bottomBlue = [[UIView alloc] initWithFrame:CGRectMake(0, SCHeight - 64, SCWidth, 64)];
    bottomBlue.backgroundColor = MTBlue;
    bottomBlue.alpha = 0.5f;
    [self.view addSubview:bottomBlue];
    
    _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, SCHeight - 64, 0, 64)];
    _progressView.backgroundColor = MTBlue;
    [self.view addSubview:_progressView];
    
    UIButton * upButton = [[UIButton alloc] initWithFrame:bottomBlue.frame];
    [upButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"上传" attributes:@{NSForegroundColorAttributeName : MTWhite, NSFontAttributeName : [UIFont systemFontOfSize:20.0f]}] forState:UIControlStateNormal];
    [self.view addSubview:upButton];
    [upButton addTarget:self action:@selector(upButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, SCWidth / 2, 44)];
    titleLabel.textColor = MTWhite;
    titleLabel.font = [UIFont systemFontOfSize:22.0f];
    titleLabel.text = @"分享图片";
    titleLabel.x = SCWidth / 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) rtButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) upButtonClick : (UIButton *) button
{
    NSLog(@"up button click");
    
    MTNetworkUpLoadPic * upLoad = [MTNetworkUpLoadPic new];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [upLoad uploadPic:self.finalImage userID:nil description:self.descriptionField.text block:^(MTNetworkResultType resultType, NSObject *addInfo) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if(resultType == MTNetworkResultTypeSuccess)
        {
            [SVProgressHUD showSuccessWithStatus:(NSString *) addInfo];
            
            UIViewController * controller = self;
            while (![controller isMemberOfClass:[MTShotViewController class]]) {
                controller = controller.presentingViewController;
            }
            [controller dismissViewControllerAnimated:YES completion:nil];
//            [controller dismissViewControllerAnimated:NO completion:nil];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [controller dismissViewControllerAnimated:YES completion:nil];
//            });
            
        }else{
            [SVProgressHUD showErrorWithStatus:(NSString *) addInfo];
        }
        
        
        ;
    } cccBlock:^(CGFloat completion, NSObject *addInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
             _progressView.width = SCWidth * completion;
        });
    }];
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
