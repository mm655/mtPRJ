//
//  MTItemDetailViewController.m
//  mttt
//
//  Created by 张勐 on 16/1/5.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTItemDetailViewController.h"
#import "MTNetworkAddComment.h"
#import "MTNetworkAddFocus.h"
#import "MTNetworkZan.h"
#import "MTNetworkJubao.h"
#import "MTCommentPack.h"
#import "MTUserInfoPack.h"

@interface MTItemDetailViewController ()
{
    dispatch_semaphore_t mySemaphore;
    CGFloat pingBaseTop;
}
@end

@implementation MTItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.infoPack == nil)
    {
        NSLog(@"no info pack");
        exit(1);
    }
    
    self.navigationItem.leftItemsSupplementBackButton = NO;
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_array_left"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    mySemaphore = dispatch_semaphore_create(1);
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCHeight)];
    self.mainScrollView.backgroundColor = MTWhite;
    [self.view addSubview:self.mainScrollView];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
    _headImageView.layer.cornerRadius = 22;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.image = [UIImage imageNamed:@"login_pic1"];
    if(self.infoPack.user.headPic.length != 0)
    {
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:self.infoPack.user.headPic] placeholderImage:[UIImage imageNamed:@"login_pic1"]];
    }
    [self.mainScrollView addSubview:_headImageView];
    UIButton * userDButton = [[UIButton alloc] initWithFrame:_headImageView.frame];
    [self.mainScrollView addSubview:userDButton];
    [userDButton addTarget:self action:@selector(userDetailRequest:) forControlEvents:UIControlEventTouchUpInside];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 3, 44)];
    _nameLabel.left = _headImageView.right + 5;
    _nameLabel.y = _headImageView.y;
    _nameLabel.font = [UIFont systemFontOfSize:12.0f];
    _nameLabel.textColor = MTBlue;
    _nameLabel.text = self.infoPack.user.nickName;
    if(_nameLabel.text.length == 0)
    {
        _nameLabel.text = @"无名氏";
    }
    [self.mainScrollView addSubview:_nameLabel];
    
    _focusButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 44)];
    _focusButton.right = SCWidth - 5;
    _focusButton.y = _nameLabel.y;
    _focusButton.layer.cornerRadius = 6;
    _focusButton.backgroundColor = MTGreen;
    [_focusButton setImage:[UIImage imageNamed:@"back_array_left"] forState:UIControlStateNormal];
    [_focusButton setTitle:@"关注" forState:UIControlStateNormal];
    [_focusButton setTitleColor:MTWhite forState:UIControlStateNormal];
    [_focusButton addTarget:self action:@selector(focusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:_focusButton];
    
    _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCWidth)];
    _mainImageView.top = 64;
//    _mainImageView.image = [UIImage imageNamed:@"login_pic2"];
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:self.infoPack.pictureUrl]];
    
    
    [self.mainScrollView addSubview:_mainImageView];
    
//    UIButton * mainButton = [[UIButton alloc] initWithFrame:_mainImageView.frame];
//    [self.view addSubview:mainButton];
//    [mainButton addTarget:self action:@selector(mainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _zanField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    _zanField.top = _mainImageView.bottom + 5;
    _zanField.left = 5;
    _zanField.userInteractionEnabled = NO;
    _zanField.textColor = MTGray;
    UIImageView * ZLImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    ZLImageView.image = [UIImage imageNamed:@"zan_red"];
    _zanField.leftView = ZLImageView;
    _zanField.leftViewMode = UITextFieldViewModeAlways;
    _zanField.text = @" 100";
    [self.mainScrollView addSubview:_zanField];
    UIButton * zanButton = [[UIButton alloc] initWithFrame:_zanField.frame];
    [self.mainScrollView addSubview:zanButton];
    [zanButton addTarget:self action:@selector(zanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _pingField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    _pingField.top = _zanField.top;
    _pingField.left = _zanField.right;
    _pingField.textColor = MTGray;
    UIImageView * PLImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    //    PLImageView.backgroundColor = MTGreen;
    PLImageView.image = [UIImage imageNamed:@"comment"];
    _pingField.userInteractionEnabled = NO;
    _pingField.leftView = PLImageView;
    _pingField.leftViewMode = UITextFieldViewModeAlways;
    _pingField.text = @" 100";
    [self.mainScrollView addSubview:_pingField];
    
    _jubaoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [_jubaoButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    _jubaoButton.right = SCWidth - 5;
    _jubaoButton.y = _pingField.y;
    [self.mainScrollView addSubview:_jubaoButton];
    [_jubaoButton addTarget:self action:@selector(jubaoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    pingBaseTop = _jubaoButton.bottom + 5;
    for(NSDictionary * tmpDic in self.infoPack.comment)
    {
        MTCommentPack * comment = [[MTCommentPack alloc] initWithDictionary:tmpDic error:nil];
        NSString * commentString = @"";
        if(self.infoPack.user.nickName.length != 0)
        {
            commentString = [self.infoPack.user.nickName stringByAppendingString:[NSString stringWithFormat:@":%@",comment.comments]];
        }else{
            commentString = [@"无名氏" stringByAppendingString:[NSString stringWithFormat:@":%@",comment.comments]];
        }
        CGRect cRect = [commentString boundingRectWithSize:CGSizeMake(SCWidth - 20, SCHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} context:NULL];
        UITextView * ctView = [[UITextView alloc] initWithFrame:CGRectMake(10, pingBaseTop, SCWidth - 20, cRect.size.height)];
        ctView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        ctView.font = [UIFont systemFontOfSize:12.0f];
        ctView.text = commentString;
        ctView.userInteractionEnabled = NO;
        
        [self.mainScrollView addSubview:ctView];
        pingBaseTop = ctView.bottom + 5;
    }
    
    UIView * pingBView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, 44)];
    pingBView.bottom = SCHeight;
    pingBView.backgroundColor = MTBlack;
    [self.view addSubview:pingBView];
    
    UITextView * ptView = [[UITextView alloc] initWithFrame:CGRectMake(4, 6, SCWidth - 70, 32)];
    ptView.textAlignment = NSTextAlignmentLeft;
    ptView.layer.masksToBounds = YES;
    ptView.layer.cornerRadius = 5;
    ptView.layer.borderColor = MTGray.CGColor;
    ptView.layer.borderWidth = 1.0f;
    ptView.font = [UIFont systemFontOfSize:15.0f];
    [pingBView addSubview:ptView];
    self.ptView = ptView;
    
    UIButton * pButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 30)];
    pButton.left = ptView.right + 5;
    pButton.y = ptView.y;
    [pButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"评论" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f],NSForegroundColorAttributeName : MTWhite}] forState:UIControlStateNormal];
    pButton.layer.masksToBounds = YES;
    pButton.layer.cornerRadius = 5;
    pButton.backgroundColor = MTGreen;
    [pButton addTarget:self action:@selector(pButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [pingBView addSubview:pButton];
    
    self.mainScrollView.contentSize = CGSizeMake(SCWidth, pingBaseTop);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) focusButtonClick
{
    if(dispatch_semaphore_wait(mySemaphore, 0) != 0)
    {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    MTNetworkAddFocus * focus = [MTNetworkAddFocus new];
    [focus addFocusUser:self.infoPack.user.userID byUser:[MTAccountMgr getLoginInfo].userID rBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        if(resultType == MTNetworkResultTypeSuccess || resultType == MTNetworkResultTypeError)
        {
            [SVProgressHUD showSuccessWithStatus:@"已关注"];
        }else{
            [SVProgressHUD showErrorWithStatus:(NSString *) addInfo];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        dispatch_semaphore_signal(mySemaphore);
        ;
    }];
}

-(void) userDetailRequest : (UIButton *) button
{
    
}

-(void) zanButtonClick : (UIButton *) button
{
    
    if(dispatch_semaphore_wait(mySemaphore, 0) != 0)
    {
        return;
    }
    
    MTNetworkZan * zan = [MTNetworkZan new];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [zan zanByUserId:[MTAccountMgr getLoginInfo].userID picId:self.infoPack.picID rBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        if(resultType != MTNetworkResultTypeNetFail)
        {
            [SVProgressHUD showSuccessWithStatus:@"已赞"];
        }else{
            [SVProgressHUD showErrorWithStatus:(NSString *)addInfo];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        dispatch_semaphore_signal(mySemaphore);
    }];
}


-(void) jubaoButtonClick : (UIButton *) button
{
    UIAlertController * aC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * a1 = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if(dispatch_semaphore_wait(mySemaphore, 0) != 0)
        {
            return ;
        }
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        MTNetworkJubao * jubao = [MTNetworkJubao new];
        [jubao jubaoByUserId:[MTAccountMgr getLoginInfo].userID picId:self.infoPack.picID rBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
            if(resultType != MTNetworkResultTypeNetFail)
            {
                [SVProgressHUD showSuccessWithStatus:@"已举报"];
            }else{
                [SVProgressHUD showErrorWithStatus:(NSString *)addInfo];
            }
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            dispatch_semaphore_signal(mySemaphore);
            ;
        }];
        ;
    }];
    UIAlertAction * a2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    [aC addAction:a1];
    [aC addAction:a2];
    [self presentViewController:aC animated:YES completion:nil];
}

-(void) backBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) pButtonClick
{
    if(self.ptView.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入评论内容"];
        return;
    }
    
    if(dispatch_semaphore_wait(mySemaphore, 0) != 0)
    {
        return;
    }
    
//    dispatch_semaphore_wait(mySemaphore, 0);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    MTNetworkAddComment * comment = [MTNetworkAddComment new];
    [comment commentByUserID:GetMyUserID picID:self.infoPack.picID comments:self.ptView.text rBlock:^(MTNetworkResultType resultType, NSObject *addInfo) {
        if(resultType == MTNetworkResultTypeSuccess)
        {
            [SVProgressHUD showSuccessWithStatus:@"评论成功"];
            NSMutableArray * cMArray = [NSMutableArray array];
            if(self.infoPack.comment)
            {
                cMArray = [self.infoPack.comment mutableCopy];
            }
            
            MTCommentPack * newPack = [MTCommentPack new];
            newPack.user = [MTUserInfoPack new];
            newPack.comments = self.ptView.text;
            
            [cMArray addObject:newPack];
            self.infoPack.comment = [cMArray copy];
            
            NSString * commentString = [@"me:" stringByAppendingString:[NSString stringWithFormat:@"%@",self.ptView.text]];
            
            CGRect cRect = [commentString boundingRectWithSize:CGSizeMake(SCWidth - 20, SCHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} context:NULL];
            UITextView * ctView = [[UITextView alloc] initWithFrame:CGRectMake(10, pingBaseTop, SCWidth - 20, cRect.size.height)];
            ctView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
            ctView.font = [UIFont systemFontOfSize:12.0f];
            ctView.text = commentString;
            ctView.userInteractionEnabled = NO;
            
            [self.mainScrollView addSubview:ctView];
            pingBaseTop = ctView.bottom + 5;
            self.mainScrollView.contentSize = CGSizeMake(SCWidth, pingBaseTop);
        }else{
            [SVProgressHUD showErrorWithStatus:(NSString *)addInfo];
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        dispatch_semaphore_signal(mySemaphore);
        ;
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
