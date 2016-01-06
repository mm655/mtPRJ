//
//  MTSettingTableViewController.m
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTSettingTableViewController.h"
#import "MTEditViewController.h"
#import "MTResetPassViewController.h"

@interface MTSettingTableViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation MTSettingTableViewController
{
    UITableView * _mainTableView;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    UITableView * fakeView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCHeight)];
    [self.view addSubview:fakeView];
//    fakeView.delegate = self;
//    fakeView.dataSource = self;
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCWidth, SCHeight - 64)];
    [self.view addSubview:_mainTableView];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_array_left"] style:UIBarButtonItemStylePlain target:self action:@selector(leftitemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.title = @"设置";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark tableview dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        default:
            return 2;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    cell.textLabel.text = @"text";
    if(indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"编辑个人资料";
                break;
            case 1:
                cell.textLabel.text = @"修改密码";
            default:
                break;
        }
    }else if(indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"隐私政策";
                break;
            case 1:
                cell.textLabel.text = @"问题反馈";
            default:
                break;
        }
    }else{
        cell.textLabel.text = @"退出登录";
    }
    
    
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, 30)];
    view.backgroundColor = MTRGBAColor(0, 0, 0, 0.1);
    UILabel * label = [[UILabel alloc] initWithFrame:view.frame];
    label.left = 5;
    [view addSubview:label];
    label.userInteractionEnabled = NO;
    label.textAlignment = NSTextAlignmentLeft;
    switch (section) {
        case 0:
            label.text = @"账户";
            break;
        case 1:
            label.text = @"支持";
            ;
            break;
        case 2:
            label.text = @"退出";
            break;
        default:
            break;
    }
    return view;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark tableview delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
//                cell.textLabel.text = @"编辑个人资料";
                [self editClick];
                break;
            case 1:
                [self changePassClick];
//                cell.textLabel.text = @"修改密码";
            default:
                break;
        }
    }else if(indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
                [self secureClick];
//                cell.textLabel.text = @"隐私政策";
                break;
            case 1:
                [self fankuiClick];
//                cell.textLabel.text = @"问题反馈";
            default:
                break;
        }
    }else{
        [self exitClick];
//        cell.textLabel.text = @"退出登录";
    }
    
    
}


-(void) leftitemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) editClick
{
    MTEditViewController *eVC = [MTEditViewController new];
    [self.navigationController pushViewController:eVC animated:YES];
}

-(void) changePassClick
{
    MTResetPassViewController * vC = [MTResetPassViewController new];
    [self.navigationController pushViewController:vC animated:YES];
}

-(void) secureClick
{
    
}

-(void) fankuiClick
{
    
}

-(void)exitClick
{
    UIAlertController * aC = [UIAlertController alertControllerWithTitle:@"退出登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * a1 = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    
    UIAlertAction * a2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    
    [aC addAction:a1];
    [aC addAction:a2];
    [self presentViewController:aC animated:YES completion:nil];
    
    
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
