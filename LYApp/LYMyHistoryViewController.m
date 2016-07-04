//
//  LYMyHistoryViewController.m
//  LYApp
//
//  Created by lichanghong on 16/6/23.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYMyHistoryViewController.h"
#import "LYTitleCell.h"
#import "GuaItemDetailViewController.h"
#import "GuaManager.h"
#import "HttpUtil.h"

@interface LYMyHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation LYMyHistoryViewController
{
    __weak IBOutlet UIButton *_backButton;
    NSMutableArray    *_guaItems;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _guaItems.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GuaItemDetailViewController *detailVC =[[GuaItemDetailViewController alloc]init];
    detailVC.guaItem = [_guaItems objectAtIndex:indexPath.row];
    detailVC.isyourself = true;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYTitleCell *cell;
    static NSString *CellIdentifier = @"LYLearnCell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *dic = [_guaItems objectAtIndex:indexPath.row];
    NSArray *guaa = [dic[@"g_gua"]componentsSeparatedByString:@":"];
    
    int guaindex = [[guaa firstObject]intValue];
    int bianguaindex = [guaa[1] intValue];
    NSDictionary *guaNames = [[GuaManager shareManager].guaNames objectAtIndex:guaindex];
    NSDictionary *bguaNames = [[GuaManager shareManager].guaNames objectAtIndex:bianguaindex];
    NSArray      *timestr = [dic[@"g_date"] componentsSeparatedByString:@":"];
    cell.titleLabel.text = [NSString stringWithFormat:@"您问:%@",dic[@"g_question"]];
    
    if (timestr.count > 3 && [guaNames allKeys].count>0) {
        NSString *time=   [NSString stringWithFormat:@"%@年%@月%@日%@时",timestr[0],timestr[1],timestr[2],timestr[3]];
        cell.detailLabel.text = [NSString stringWithFormat:@"%@起卦  %@ 之 %@ 卦",time,                                                    [[guaNames allKeys]lastObject],[[bguaNames allKeys]lastObject]];
    }
    cell.verifyImage.image = [UIImage imageNamed:@"verify_ing"];
    return cell;
}
- (void)loadData
{
    __weak LYMyHistoryViewController *wself = self;
    [HttpUtil doLoadGuaItemsSuccess:^(id json) {
        if (json) {
            NSString *errorno = json[@"errno"];
            if ([errorno intValue]==0) {
                NSArray *datalist = json[@"data"];
                if (datalist && datalist.count>0) {
                    _guaItems = [datalist mutableCopy];
                    [wself.tableView reloadData];
                }
                else
                {
                    NSLog(@"LYMyHistoryViewController data nil ");
                    [LYToast showToast:@"服务器错误,请联系管理员(10060)"];
                }
            }
        }
        else
            NSLog(@"LYMyHistoryViewControllererr = %@",json);
    } failure:^(NSString *errmsg) {
        NSLog(@"sdfsfffaa = %@",errmsg);
        [LYToast showToast:errmsg];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView setTableHeaderView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0,1)]];

    [self loadData];

    _guaItems = [NSMutableArray array];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)handleAction:(id)sender {
    if (sender == _backButton) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
