//
//  ViewController.m
//  LYApp
//
//  Created by lichanghong on 16/5/13.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "GuaItemDetailViewController.h"
#import "GuaManager.h"
#import "BaGuaView.h"



@interface GuaItemDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UILabel *gua_who_ask_label;
@property (strong, nonatomic)  UILabel *gua_question_label;
@property (strong, nonatomic)  UILabel *gua_gua_name_label;
@property (strong, nonatomic)  UILabel *gua_liujia_label;

@property (strong, nonatomic)  UIView  *gua_contentView;
@property (strong, nonatomic)  BaGuaView *baGuaView;


@property (nonatomic,strong)UITableView *tableView;


@end

@implementation GuaItemDetailViewController
{
    UIView *tableHeadView;
    NSArray *liujiaArr;
    
    NSArray      *timestr;
    NSString *gua_date;
    NSString *gua_sex;
    NSString *gua_question;
    NSString *gua_name;
    NSString *gua_liujia;
    
    int guaindex;
    int bianguaindex;
    UIButton *backbutton;
    UILabel *navLabel;
    UIButton *statusButton;
}

- (void)initUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, KScreenWidth, KScreenHeight-40) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    navLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    navLabel.backgroundColor = [UIColor colorForHex:@"804000"];
    navLabel.text = @"经典卦例";
    if (_isyourself) {
        navLabel.text = @"您的历史";
    }
    navLabel.textAlignment = NSTextAlignmentCenter;
    navLabel.textColor = [UIColor whiteColor];
    navLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:navLabel];
    
    UIImageView *imagev = [[UIImageView alloc]initWithFrame: CGRectMake(9, 1, 34, 36)];
    imagev.image = [UIImage imageNamed:@"backbutton"];
    [self.view addSubview:imagev];
    backbutton = [[UIButton alloc]initWithFrame:CGRectMake(17, 4, 46, 30)];
    backbutton.titleLabel.font = [UIFont systemFontOfSize:15];
    [backbutton setTitle:@"返回" forState:UIControlStateNormal];

    [backbutton addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    
    self.view.backgroundColor = [UIColor whiteColor];
    tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, KScreenWidth, 270)];
    [self.view addSubview:tableHeadView];
    tableHeadView.backgroundColor = [UIColor clearColor];
    
    _gua_who_ask_label = [self createGuaBaseLabel];
    [tableHeadView addSubview:_gua_who_ask_label];
    
    CGFloat statusW = 83;
    statusButton = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-statusW-12, MinY(_gua_who_ask_label), statusW, 20)];
    statusButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [statusButton setTitle:@"审核中" forState:UIControlStateNormal];
    [statusButton setImage:[UIImage imageNamed:@"verify_ing"] forState:UIControlStateNormal];
    [statusButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 2)];
    [statusButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [statusButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    statusButton.backgroundColor = [UIColor clearColor];
    [tableHeadView addSubview:statusButton];
    
    _gua_question_label = [self createGuaBaseLabel];
    setY(_gua_question_label, MaxY(_gua_who_ask_label)+3);
    [tableHeadView addSubview:_gua_question_label];

    _gua_gua_name_label  =[self createGuaBaseLabel];
    setY(_gua_gua_name_label, MaxY(_gua_question_label)+3);
    [tableHeadView addSubview:_gua_gua_name_label];
    
    _gua_liujia_label=[self createGuaBaseLabel];
    setY(_gua_liujia_label, MaxY(_gua_gua_name_label)+3);
    _gua_liujia_label.textColor =  [UIColor colorForHex:@"408000"];
    _gua_liujia_label.font = [UIFont systemFontOfSize:13];
    [tableHeadView addSubview:_gua_liujia_label];
    
    CGFloat contentW = 200;
    CGFloat contentX = (KScreenWidth-contentW)/2.0;
    _gua_contentView = [[UIView alloc]initWithFrame:CGRectMake(contentX, MaxY(_gua_liujia_label)+20, contentW, 150)];
    [tableHeadView addSubview:_gua_contentView];
    
    _baGuaView = [[BaGuaView alloc]initWithFrame:CGRectMake(0, 0, 180, ViewH(_gua_contentView))];
    [_gua_contentView addSubview:_baGuaView];
    
    [_tableView setTableHeaderView:tableHeadView];

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
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    GuaItemDetailViewController *detailVC =[[GuaItemDetailViewController alloc]init];
//    detailVC.guaItem = [_guaItems objectAtIndex:indexPath.row];
//    detailVC.isyourself = true;
//    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    LYTitleCell *cell;
//    static NSString *CellIdentifier = @"LYLearnCell";
//    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    NSDictionary *dic = [_guaItems objectAtIndex:indexPath.row];
//    NSArray *guaa = [dic[@"g_gua"]componentsSeparatedByString:@":"];
//    
//    int guaindex = [[guaa firstObject]intValue];
//    int bianguaindex = [guaa[1] intValue];
//    NSDictionary *guaNames = [[GuaManager shareManager].guaNames objectAtIndex:guaindex];
//    NSDictionary *bguaNames = [[GuaManager shareManager].guaNames objectAtIndex:bianguaindex];
//    NSArray      *timestr = [dic[@"g_date"] componentsSeparatedByString:@":"];
//    cell.titleLabel.text = [NSString stringWithFormat:@"您问:%@",dic[@"g_question"]];
//    
//    if (timestr.count > 3 && [guaNames allKeys].count>0) {
//        NSString *time=   [NSString stringWithFormat:@"%@年%@月%@日%@时",timestr[0],timestr[1],timestr[2],timestr[3]];
//        cell.detailLabel.text = [NSString stringWithFormat:@"%@起卦  %@ 之 %@ 卦",time,                                                    [[guaNames allKeys]lastObject],[[bguaNames allKeys]lastObject]];
//    }
//    cell.verifyImage.image = [UIImage imageNamed:@"verify_ing"];
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    NSDictionary *dic = _guaItem;
    NSArray *guaa = [dic[@"g_gua"]componentsSeparatedByString:@":"];
    guaindex = [[guaa firstObject]intValue];
    bianguaindex = [guaa[1] intValue];
    
    NSDictionary *guaNames = [[GuaManager shareManager].guaNames objectAtIndex:guaindex];
    NSDictionary *bguaNames = [[GuaManager shareManager].guaNames objectAtIndex:bianguaindex];
    
    timestr = [dic[@"g_date"] componentsSeparatedByString:@":"];
    gua_sex = [dic[@"g_gender"] isEqualToString:@"1"]?@"一位先生问：":@"一位女士问：";
    if (_isyourself) {
       gua_sex = @"您问：";
        
    }
    else
    {
        [statusButton setHidden:YES];
    }
    gua_question = [NSString stringWithFormat:@"%@",dic[@"g_question"]];
    
    if (timestr.count > 3 && [guaNames allKeys].count>0) {
        gua_date =   [NSString stringWithFormat:@"%@年%@月%@日%@时",timestr[0],timestr[1],timestr[2],timestr[3]];
        gua_name = [NSString stringWithFormat:@"%@起卦  %@ 》%@ 之 %@卦",gua_date,                                                    [[guaNames allValues]lastObject],[[guaNames allKeys]lastObject],[[bguaNames allKeys]lastObject]];
    }
    
    [self loadLiuJia];
   
    [self refreshData];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)handleAction:(id)sender
{
    if (sender == backbutton) {
        [self.navigationController popViewControllerAnimated:YES];
 
    }
}

- (void)loadLiuJia
{
    __weak GuaItemDetailViewController *wself = self;
    [[GuaManager shareManager]loadGanZhWith:@[timestr[0],timestr[1],timestr[2],timestr[3]] ganzhis:^(NSArray *nian) {
        if (nian.count>=4) {
            liujiaArr = nian;
            [self refreshData];
        }
        else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [wself loadLiuJia];
            });
            DDLogError(@"时间错误");
        }
        
    }];

}

- (void)refreshData
{
    _gua_who_ask_label.text = gua_sex;
    _gua_question_label.text = gua_question;
    _gua_gua_name_label.text = gua_name;
    if (liujiaArr.count>0 ) {
        
        gua_liujia = [NSString stringWithFormat:@"%@年 %@月 %@日 %@",
                      liujiaArr[0],liujiaArr[1],liujiaArr[2],liujiaArr[3]];
        NSString *kongwu =  [[GuaManager shareManager]kongwuWithDay:liujiaArr[2]];
        _gua_liujia_label.text = [NSString stringWithFormat:@"%@      %@",gua_liujia,kongwu];
        
        _baGuaView.liushenArr = [[GuaManager shareManager]liushenArrWithDay:liujiaArr[2]];
        
    }

    _baGuaView.guaItem = _guaItem;
    
}


//--------------------------------base action --------------------------

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)createGuaBaseLabel
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 8, KScreenWidth-24, 14.5)];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor darkGrayColor];
    return label;
}

@end
