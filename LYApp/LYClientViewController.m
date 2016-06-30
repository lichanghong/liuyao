//
//  LYClientViewController.m
//  LYApp
//
//  Created by lichanghong on 16/6/20.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYClientViewController.h"
#import "QiGuaAlertView.h"
#import "LYHelpViewController.h"
#import "GuaManager.h"
#import "JingRoundView.h"

@interface LYClientViewController () <UIAlertViewDelegate,QiGuaAlertViewDelegate,UITextFieldDelegate>

@end

@implementation LYClientViewController
{
    QiGuaAlertView *_qiguaAlertView;
    
    __weak IBOutlet UISegmentedControl *_segmentControl;
    __weak IBOutlet UITextField *questionText;
    
    __weak IBOutlet UITextField *nianTextField;
    __weak IBOutlet UITextField *yueTextField;
    __weak IBOutlet UITextField *riTextField;
    __weak IBOutlet UITextField *shiTextField;
    
    
    __weak IBOutlet UIButton *helpButton;
    __weak IBOutlet UIButton *startButton;
    __weak IBOutlet UITextView *resultText;
    
    __weak IBOutlet UIButton *resetButton;
    
    __weak IBOutlet UIButton *backButton;
    __weak IBOutlet UIButton *releaseButton;
    
    
    __weak IBOutlet UIView *roundViewContent;
    JingRoundView *_roundView;
    
    BOOL _isWoman;
    NSArray *_alertResult;
    
}

- (void)fetchDate
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute;
    comps = [calendar components:unitFlags fromDate:date];
    int year = (int)[comps year];
    int mouth = (int)[comps month];
    int day = (int)[comps day];
    int hour = (int)[comps hour];
    nianTextField.text = [NSString stringWithFormat:@"%d",year];
    yueTextField.text = [NSString stringWithFormat:@"%d",mouth];
    riTextField.text = [NSString stringWithFormat:@"%d",day];
    shiTextField.text = [NSString stringWithFormat:@"%d",hour];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchDate];
 
    _roundView = [[JingRoundView alloc]initWithFrame:CGRectMake(0, 0, 54, 54)];
    _roundView.roundImage = [UIImage imageNamed:@"qiguaBtn"];
    [roundViewContent addSubview:_roundView];
    
    [nianTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [yueTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [riTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [shiTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(fetchDate) userInfo:nil repeats:YES];
    
    _isWoman = false;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired =1;
    [self.view addGestureRecognizer: tap];
    _qiguaAlertView = [QiGuaAlertView createView];
    _qiguaAlertView.delegate =self;
     // Do any additional setup after loading the view.
}

-(void) startRotation
{
    JingRoundView *roundView = [[JingRoundView alloc]initWithFrame:CGRectMake(0, 0, 54, 54)];
    roundView.roundImage = [UIImage imageNamed:@"qiguaBtn"];
    roundView.isPlay = YES;
    [roundViewContent addSubview:roundView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static bool isfirsttime=true;
- (IBAction)handleAction:(id)sender {
    [self.view endEditing:YES];
    
    if ([sender isKindOfClass: [UISegmentedControl class]]) {
        if (_segmentControl.selectedSegmentIndex == 0) {
            _isWoman = false;
        }
        else _isWoman = true;
    }
    else if ([sender isKindOfClass: [UIButton class]]) {
        if (sender == startButton) {
            if (_segmentControl.selectedSegmentIndex!=0 && _segmentControl.selectedSegmentIndex!=1) {
                [self alertErrorWithMessage:@"请选择性别"];
            }
            else
            {
                if (questionText.text.length>4) {
                    if (isfirsttime) {
                        isfirsttime = false;
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"请确认起卦时间是正确的" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                        [alert show];
                    }
                    else
                    {
                        [self showAlertView];
                    }
                }
                else
                {
                    [self alertErrorWithMessage:@"请填写您想要预测的事情"];
                }
            }
        }
       else if(sender == helpButton)
       {
           [LYHelpViewController pushToHelpVCWithNav:self.navigationController];
       }
        else if(sender == backButton)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (sender == resetButton)
        {
            [_segmentControl setSelected:false];
            questionText.text= @"";
            [self fetchDate];
            resultText.text = @"请按照原来的规则重新起卦";
            resultText.textColor = [UIColor whiteColor];
            [resetButton setHidden:YES];
            [releaseButton setHidden:YES];
        }
        else if (sender == releaseButton)
        {
            [self refreshData:YES];
        }
    }
}

- (void)alertErrorWithMessage:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)showAlertView
{
    NSString *year  = [nianTextField text];
    NSString *mouth = [yueTextField text];
    NSString *day   = [riTextField text];
    NSString *hour  = [shiTextField text];
    __weak LYClientViewController *wself = self;
    [[GuaManager shareManager]loadGanZhWith:@[year,mouth,day,hour] ganzhis:^(NSArray *nian) {
        [GuaManager shareManager].bazi = [NSMutableArray arrayWithArray:nian];
        [wself refreshData:NO];
        
    }];
    [_qiguaAlertView showInView:self.view];
}

- (void)refreshData:(BOOL)upload
{
    NSArray *arr = _alertResult;
    NSArray *bazi  =[GuaManager shareManager].bazi;
    
    int guaindex = [arr[0] intValue];
    int bianguaindex = [arr[1] intValue];
    //        NSArray* gua = arr[2];
    
    NSDictionary *guaNames = [[GuaManager shareManager].guaNames objectAtIndex:guaindex];
    NSDictionary *bguaNames = [[GuaManager shareManager].guaNames objectAtIndex:bianguaindex];
    
    NSString *year  = [nianTextField text];
    NSString *mouth = [yueTextField text];
    NSString *day   = [riTextField text];
    NSString *hour  = [shiTextField text];
    NSString *desc = nil;
    if (bazi && bazi.count >0) {
         desc = [NSString stringWithFormat:@"您的摇卦结果是:\"%@ 之 %@\" 卦，您的性别:%@ 您想从此卦中预测的事情是:\"%@\" 根据您输入的阳历时间%@年%@月%@日%@时 算出起卦时的八字为：%@ %@ %@ %@",
                          [[guaNames allKeys]lastObject],
                          [[bguaNames allKeys]lastObject],
                            _isWoman?@"女":@"男",
                           questionText.text,
                          year,mouth,day,hour,
                          bazi[0],bazi[1],bazi[2],bazi[3]];
        [self beginSuan];
    }
    else
    {
       desc = [NSString stringWithFormat:@"您的摇卦结果是:\"%@ 之 %@\" 卦，根据您输入的阳历时间%@年%@月%@日%@时 正在计算您的八字，请稍后......",
                          [[guaNames allKeys]lastObject],
                          [[bguaNames allKeys]lastObject],
                          year,mouth,day,hour];
    }
    resultText.text = desc;
    resultText.textColor = [UIColor whiteColor];
    
    if (upload) {
        UserManager *manager= [UserManager defaultManager];
         
        //上传到服务器
        [[UIApplication sharedApplication]beginIgnoringInteractionEvents];
        [startButton setTitle:@"正在发送..." forState:UIControlStateNormal];
        [_roundView forcePlay];
        

        
        
        
    }

}

//信息全部采集，开始算
- (void)beginSuan
{
    
}

- (void)QiGuaAlertViewResult:(NSArray *)arr
{
    [resetButton setHidden:NO];
    [releaseButton setHidden:NO];
    _alertResult = arr;
    [self refreshData:NO];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self showAlertView];
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    int len=0;
    if (textField == nianTextField) {
        len=4;
    }
    else len=2;
    if (!textField.markedTextRange && textField.text.length > len) {
        textField.text = [textField.text substringToIndex:len];
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
