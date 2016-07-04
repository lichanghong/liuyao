//
//  LYSettingViewController.m
//  LYApp
//
//  Created by lichanghong on 16/7/4.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYSettingViewController.h"
#import "LYSettingCell.h"
#import "UserManager.h"

@interface LYSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) UITableView* tableView;
@property (nonatomic,strong)UIImageView *logoView;
@property (nonatomic,strong)UILabel *versionLabel;


@end

@implementation LYSettingViewController{
    IBOutlet NSObject *_backButton;

}

- (IBAction)handleAction:(id)sender {
    if (sender == _backButton) {
        [self dismiss];
    }
}

- (void)dismiss
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];//login refresh
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView setFrame:CGRectMake(0, 40, KScreenWidth, KScreenHeight-40)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 150)];
    [tableHeader addSubview:self.logoView];
    _versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, MaxY(self.logoView), KScreenWidth, 30)];
    _versionLabel.text = VERSION_STRING;
    _versionLabel.font = [UIFont systemFontOfSize:12];
    _versionLabel.textAlignment = NSTextAlignmentCenter;
    [_versionLabel setTextColor:[UIColor lightGrayColor]];
    [tableHeader addSubview:_versionLabel];
    self.tableView.tableHeaderView = tableHeader;
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYSettingCell *cell;
    static NSString *CellIdentifier1 = @"LYSettingCell_logout";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil) {
        cell = [[LYSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    
    if ([UserManager defaultManager].userid) {
        cell.nameLabel.text = [NSString stringWithFormat:@"退出登录"];
        cell.nameLabel.textColor = [UIColor redColor];

    }else
    {
        cell.nameLabel.text = [NSString stringWithFormat:@"登录"];
        cell.nameLabel.textColor = [UIColor colorForHex:@"1DA645"];
    }
    cell.accessoryType =  UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self logout];
}

- (void)logout
{
    if ([UserManager defaultManager].userid) {
        if ([UserManager clearData]) {
            [LYToast showToast:@"退出成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        else
        {
            [LYToast showToast:@"退出失败"];
        }
    }
    else
    {
        [self toLoginPage];
    }
}

//跳转到login界面
- (void)toLoginPage
{
    [self showDetailViewController:[self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"LYLoginViewController"] sender:self];
}


- (UIImageView*)logoView
{
    if (_logoView == nil) {
        UIImage* logo;
        logo = [UIImage imageNamed:@"qiguaBtn"];
        _logoView = [[UIImageView alloc] initWithImage:logo];
        CGFloat x,y,w,h;
        w = 80;
        h = 80;
        y= (150)/2.0-50;
        x = (KScreenWidth-80)/2.0;
        _logoView.frame = CGRectMake(x,y,w,h);
    }
    return _logoView;
}


- (UITableView*)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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
