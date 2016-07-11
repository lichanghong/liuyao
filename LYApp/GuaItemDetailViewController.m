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
#import "LYTeacherViewController.h"
#import "LYTitleCell.h"
#import "Http/HttpUtil.h"
#import "ResultItem.h"
#import "LYLocalUtil.h"
#import "LYSolveCell.h"
#import "ResultDetailView.h"


@interface GuaItemDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UILabel *gua_who_ask_label;
@property (strong, nonatomic)  UILabel *gua_question_label;
@property (strong, nonatomic)  UILabel *gua_gua_name_label;
@property (strong, nonatomic)  UILabel *gua_liujia_label;

@property (strong, nonatomic)  UIView  *gua_contentView;
@property (strong, nonatomic)  BaGuaView *baGuaView;
@property (strong, nonatomic)  NSMutableArray *ResultItems;


@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)ResultDetailView *resultDetailView;


@property (nonatomic,assign)LYTitleCell_verifystate verifyState;


@end

@implementation GuaItemDetailViewController
{
    UIView *tableHeadView;
    UIView *tableFootView;
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
    UIButton *commentButton;
}



- (void)initUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40,
                                                              KScreenWidth, KScreenHeight-80) style:UITableViewStyleGrouped];
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
    tableHeadView.backgroundColor = [UIColor clearColor];

    if (self.isHelp) {
        tableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight-40, KScreenWidth, 40)];
        tableFootView.backgroundColor = [UIColor colorForHex:@"804000"];
        commentButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
        [commentButton setTitle:@"帮他解卦" forState:UIControlStateNormal];
        [commentButton addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
        [tableFootView addSubview:commentButton];
        [self.view addSubview:tableFootView];
        _tableView.frame=CGRectMake(0, 40,KScreenWidth, KScreenHeight-80);
    }
    else
    {
        _tableView.frame=CGRectMake(0, 40,KScreenWidth, KScreenHeight-40);
    }
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
    // 注册cell
    [LYSolveCell registerCellWithTableView:self.tableView];

    LYTitleCell_verifystate state = [_guaItem[@"verify_state"] intValue];
    self.verifyState = state;

}

- (void)setVerifyState:(LYTitleCell_verifystate)verifyState
{
    _verifyState = verifyState;
    switch (_verifyState) {
        case LYTitleCell_verifing:
        {
            [statusButton setTitle:@"审核中" forState:UIControlStateNormal];
            [statusButton setImage:[UIImage imageNamed:@"verify_ing"] forState:UIControlStateNormal];
        }
            break;
        case  LYTitleCell_verified:
        {
            [statusButton setTitle:@"审核通过" forState:UIControlStateNormal];
            statusButton.imageView.image = nil;
            [statusButton setImage:[UIImage imageNamed:@"verify_ok"] forState:UIControlStateNormal];
        }
            break;
        case  LYTitleCell_failed:
        {
            [statusButton setTitle:@"审核失败" forState:UIControlStateNormal];
            [statusButton setImage:[UIImage imageNamed:@"verify_fail"] forState:UIControlStateNormal];
        }
            break;
        case  LYTitleCell_solved:
        {
            [statusButton setTitle:@"解卦完成" forState:UIControlStateNormal];
            [statusButton setImage:[UIImage imageNamed:@"null"] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ResultItems.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ResultItem *item = [ResultItem responseWith:[_ResultItems objectAtIndex:indexPath.row]];
    [_resultDetailView showInView:self.view WithResultItem:item];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYSolveCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:[LYSolveCell identifier]];
    ResultItem *item = [ResultItem responseWith:[_ResultItems objectAtIndex:indexPath.row]];
    cell.name.text = [NSString stringWithFormat:@"卦师:%@", item.nickname];
    cell.time.text = item.commit_time;
    return cell;
}

- (void)createResultDetailView {
    if (!_resultDetailView) {
        _resultDetailView = [[ResultDetailView alloc]initWithTableHeadView:tableHeadView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self createResultDetailView];
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
    
    [self loadData:NO];
    
    _ResultItems = [NSMutableArray array];
    NSArray *resultitems = [LYLocalUtil unarchiveArrayWithFileName:[self resultItemsFileName]];
    if (resultitems) {
        for (NSDictionary *dic in resultitems) {
            if (dic[@"g_id"]==_guaItem[@"g_id"]) {
                [_ResultItems addObject:dic];
            }
        }
    }

    [self loadLiuJia];
   
    [self refreshData];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)handleAction:(id)sender
{
    if (sender == backbutton) {
        [self dismiss];
    }
    else if(sender == commentButton)
    {
        [self toTeacherCommentV];
    }
    
}

- (void)toTeacherCommentV
{
    LYTeacherViewController *VC = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"LYTeacherViewController"];
     VC.guaid = _guaItem[@"g_id"];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)dismiss
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadLiuJia
{
    __weak GuaItemDetailViewController *wself = self;
    if (timestr) {
        NSString *time=[timestr componentsJoinedByString:@":"];
        NSArray *liuj =[[NSUserDefaults standardUserDefaults]objectForKey:time];
        if (liuj) {
            liujiaArr=liuj;
            [self refreshData];
        }
        else
        {
            [[GuaManager shareManager]loadGanZhWith:@[timestr[0],timestr[1],timestr[2],timestr[3]] ganzhis:^(NSArray *nian) {
                if (nian.count>=4) {
                    liujiaArr = nian;
                    [[NSUserDefaults standardUserDefaults]setObject:liujiaArr forKey:time];
                    [[NSUserDefaults standardUserDefaults]synchronize];
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
    }
}

- (void)loadData:(BOOL)forceupdate
{
    // load gua question result
    NSString *gid = _guaItem[@"g_id"];
    __weak GuaItemDetailViewController *wself =self;
    [HttpUtil doGetGuaResultWithGid:gid success:^(id json) {
        NSLog(@"doGetGuaResultWithGid = %@",json);
        if (json) {
            NSString *errorno = json[@"errno"];
            if ([errorno intValue]==0) {
                NSArray *datalist = json[@"data"];
                if ([datalist respondsToSelector:@selector(count)]) {
                    if (datalist && datalist.count>0) {
                        wself.ResultItems = [datalist mutableCopy];
                        NSArray *guaitemArr = [LYLocalUtil unarchiveArrayWithFileName:[wself resultItemsFileName]];
                        if (guaitemArr && guaitemArr.count==datalist.count  && !forceupdate) {
                            //数据无更新，不处理
                        }
                        else
                        {
                            [LYLocalUtil archiveArray:wself.ResultItems withFileName:[wself resultItemsFileName]];
                        }
                        [wself.tableView reloadData];
                        
                    }
                    else
                    {
                        DDLogError(@"jkjkkk data nil ");
                        [LYToast showToast:@"服务器错误,请联系管理员(1060)"];
                    }
                }
                else
                {
                    [LYToast showToast:json[@"errmsg"]];
                }
            }
            else
            {
                NSString *errmsg = json[@"errmsg"];
                DDLogError(@" detailvC errmsg %@ ",errmsg);
                [LYToast showToast:errmsg];
            }
        }
        else
            DDLogError(@"lsjfllljklsdjkjsk = %@",json);

        
    } failure:^(NSString *errmsg) {
        [LYToast showToast:errmsg];
        DDLogError(@"%@",errmsg);
    }];
}

- (NSString *)resultItemsFileName
{
    return [NSString stringWithFormat:@"ashjfklsjfads%@",_guaItem[@"g_id"]];
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
