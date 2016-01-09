//
//  MTMsgViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTMsgViewController.h"
#import "MTMsgTableViewCell.h"

@interface MTMsgViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _mainTableView;
}
@end

@implementation MTMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"消息";
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCHeight - 44)];
    _mainTableView.delegate   = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[MTMsgTableViewCell class] forCellReuseIdentifier:@"MsgCell"];
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTMsgTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MsgCell"];
    return cell;
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
