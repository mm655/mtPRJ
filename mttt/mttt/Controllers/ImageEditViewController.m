//
//  ImageEditViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/26.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "ImageEditViewController.h"
#import "MTFilterCollectionView.h"
#import "MTFilterFlowLayout.h"
@interface ImageEditViewController ()

@end

@implementation ImageEditViewController

-(instancetype)initWithOrgImage:(UIImage *)image
{
    self = [super init];
    self.orgImage = image;
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MTBlack;
    UIButton * disButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [disButton setImage:[UIImage imageNamed:@"back_array_left"] forState:UIControlStateNormal];
    [self.view addSubview:disButton];
    [disButton addTarget:self action:@selector(disButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, SCWidth, SCWidth)];
    _mainImageView.image = _orgImage;
    _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_mainImageView];
    
    UIButton * nextStepButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
    [nextStepButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"下一步" attributes:@{NSForegroundColorAttributeName : MTBlue, NSFontAttributeName : [UIFont systemFontOfSize:14.0f]}] forState:UIControlStateNormal];
    nextStepButton.right = SCWidth;
    [self.view addSubview:nextStepButton];
    [nextStepButton addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * actionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, 64)];
    actionView.top = _mainImageView.bottom;
    actionView.backgroundColor = MTGray;
    [self.view addSubview:actionView];
    
    UIButton * filterButton = [[UIButton alloc] init];
    _filterButton = filterButton;
    [actionView addSubview:filterButton];
    PREPCONSTRAINTS(filterButton);
    ALIGN_LEFT(filterButton, 0);
    ALIGN_TOP(filterButton, 0);
    ALIGN_BOTTOM(filterButton, 0);
    ALIGN_RIGHT(filterButton, SCWidth / 2);
    _filterButton.contentMode = UIViewContentModeScaleAspectFit;
    [filterButton setImage:[[UIImage imageNamed:@"filter_icon_blue"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
//    [filterButton setBackgroundImage:[UIImage imageNamed:@"filter_icon_blue"] forState:UIControlStateNormal];
    filterButton.tag = 1000;
    [filterButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    filterButton.backgroundColor = MTGreen;
    
    UIButton * blurButton = [[UIButton alloc] init];
    _blurButton = blurButton;
    [actionView addSubview:blurButton];
    PREPCONSTRAINTS(blurButton);
    ALIGN_TOP(blurButton, 0);
    ALIGN_BOTTOM(blurButton, 0);
    ALIGN_RIGHT(blurButton, 0);
    ALIGN_LEFT(blurButton, SCWidth / 2);
//    blurButton.backgroundColor = MTBlue;
    [blurButton setImage:[[UIImage imageNamed:@"move_icon_white"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    blurButton.tag = 1001;
    [blurButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat remainingSpace = SCHeight - actionView.bottom;

    MTFilterCollectionView * MTFCView = [[MTFilterCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, remainingSpace) collectionViewLayout:[[MTFilterFlowLayout alloc] initWithItemHeight:remainingSpace - 5]];
    MTFCView.bottom = SCHeight;
    MTFCView.backgroundColor = MTGreen;
    [self.view addSubview:MTFCView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) disButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) actionButtonClick : (UIButton *) button
{
    if(button.tag == 1000)
    {
        [_filterButton setImage:[UIImage imageNamed:@"filter_icon_blue"] forState:UIControlStateNormal];
        [_blurButton setImage:[UIImage imageNamed:@"move_icon_white"] forState:UIControlStateNormal];
    }else{
        [_filterButton setImage:[UIImage imageNamed:@"filter_icon_white"] forState:UIControlStateNormal];
        [_blurButton setImage:[UIImage imageNamed:@"move_icon_blue"] forState:UIControlStateNormal];
    }
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void) nextStepClick
{
    
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
