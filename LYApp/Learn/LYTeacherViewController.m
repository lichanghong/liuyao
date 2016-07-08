//
//  LYTeacherViewController.m
//  LYApp
//
//  Created by lichanghong on 16/7/7.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYTeacherViewController.h"
#import "LYCommentCell.h"
#import "JingRoundView.h"
#import "HttpUtil.h"

@interface LYTeacherViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong)JingRoundView *roundView;

@end

@implementation LYTeacherViewController
{
    UIView *tableHeadView;
    UITextField *nameTextField;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setAllowsSelection:NO];
    tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, KScreenWidth, 180)];
    nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(12, ViewH(tableHeadView)-72, KScreenWidth-24, 40)];
    nameTextField.placeholder = @"请输入您的称呼";
    nameTextField.font = [UIFont systemFontOfSize:13];
    [nameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    tableHeadView.backgroundColor = [UIColor clearColor];
    [nameTextField setTextColor:[UIColor grayColor]];
    [_tableView setTableHeaderView:tableHeadView];
    [tableHeadView addSubview:nameTextField];
    
    UILabel *input = [[UILabel alloc]initWithFrame:CGRectMake(15, MaxY(nameTextField)+5, KScreenWidth-28, 20)];
    input.text = @"您对此卦的具体解析是：";
    input.textColor = [UIColor grayColor];
    input.font = [UIFont systemFontOfSize:13];
    [tableHeadView addSubview:input];
    
    [self startRotation:NO];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)handleAction:(id)sender {
    if (sender == _backButton) {
        [self dismiss];
    }
    else if (sender == _commitButton)
    {
        [self.view endEditing:YES];
        [self.tableView setContentOffset:CGPointZero animated:YES];
        [_roundView forcePlay];
        [self.tableView setUserInteractionEnabled:NO];
        [self commitResult];
    }
}

- (void)commitResult
{
    LYCommentCell *cell1=[self.tableView cellForRowAtIndexPath:[NSIndexPath
                                                                indexPathForRow:0 inSection:0]];
    LYCommentCell *cell2=[self.tableView cellForRowAtIndexPath:[NSIndexPath
                                                                indexPathForRow:0 inSection:1]];
    NSString *name =  nameTextField.text;
    NSString *detail = cell1.textView.text;
    NSString *result = cell2.textView.text;
    BOOL hasErr=false;
    if (name && name.length>2 && ![self isBlankString:name]) {
        if (name.length>20) {
            [LYToast showToast:@"称呼过长！"];
            hasErr=true;
        }
        else
        {
            if (detail && detail.length<500 && ![self isBlankString:detail]) {
                if (result && result.length<500 && ![self isBlankString:result]) {
                    NSString *dd=[NSString stringWithFormat:@"%@{[]}%@",detail,result];
                    [self doCommitWithName:name detail:dd];
                }
                else
                {
                    [LYToast showToast:@"您的解卦结果过长或格式错误"];
                    hasErr=true;
                }
            }
            else
            {
                [LYToast showToast:@"您的分析内容过长或格式错误"];
                hasErr=true;
            }
        }
    }
    else
    {
        [LYToast showToast:@"请填写您的称呼"];
        hasErr=true;
    }
    
    if (hasErr) {
        [self endCommit];
    }
}

- (void)endCommit
{
    [_roundView forceStop];
    [self.tableView setUserInteractionEnabled:YES];
}
- (void)doCommitWithName:(NSString *)name detail:(NSString *)detail
{
    if (_guaid) {
        [HttpUtil doCommitGuaDetail:detail name:name gid:_guaid success:^(id json) {
            NSLog(@"sdjalfsdjf = %@",json);
            [LYToast showToast:@"已提交审核"];
            [self endCommit];
            [self dismiss];
        } failure:^(NSString *fail) {
            [LYToast showToast:fail];
            DDLogError(@"doCommitGuaDetail%@",fail);
            [self endCommit];
        }];
    }
    else
    {
        [LYToast showToast:@"未知错误,请联系管理员(9909)"];
        DDLogError(@"未知错误,请联系管理员(9909)");
        [self endCommit];
    }
}

-(void) startRotation:(bool)isplay
{
    _roundView = [[JingRoundView alloc]initWithFrame:CGRectMake(KScreenWidth/2.0-30, 28, 60, 60)];
    _roundView.roundImage = [UIImage imageNamed:@"qiguaBtn"];
    _roundView.isPlay = isplay;
    [tableHeadView addSubview:_roundView];
}

- (void)dismiss
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return @"根据以上分析，问题结果是：";
    }
    else
        return @"您对此卦的具体解析是：";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 130;
    }
    else
        return 100;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 0;
    }
    else return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYCommentCell *cell;
    static NSString *CellIdentifier = @"LYCommentCell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.textView.delegate = self;
    return cell;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 1) {
        [self.tableView setContentOffset:CGPointMake(0, 200) animated:YES];
    }
    else
        [self.tableView setContentOffset:CGPointMake(0, 100) animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
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
