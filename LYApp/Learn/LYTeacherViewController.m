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
    [nameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    tableHeadView.backgroundColor = [UIColor clearColor];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
