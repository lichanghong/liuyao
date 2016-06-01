//
//  ViewController.m
//  LYApp
//
//  Created by lichanghong on 16/5/13.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "ViewController.h"
#import "GuaManager.h"
#import "BaGuaView.h"



@interface ViewController ()<BaGuaViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *guaTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *timeSegment;

@property (weak, nonatomic) IBOutlet BaGuaView *firseBaGuaView;
@property (weak, nonatomic) IBOutlet BaGuaView *secondBaGuaView;

@property (weak, nonatomic) IBOutlet UILabel *liushou1;
@property (weak, nonatomic) IBOutlet UILabel *liushou2;
@property (weak, nonatomic) IBOutlet UILabel *liushou3;
@property (weak, nonatomic) IBOutlet UILabel *liushou4;
@property (weak, nonatomic) IBOutlet UILabel *liushou5;
@property (weak, nonatomic) IBOutlet UILabel *liushou6;


@property (weak, nonatomic) IBOutlet UILabel *wuxing1;
@property (weak, nonatomic) IBOutlet UILabel *wuxing2;
@property (weak, nonatomic) IBOutlet UILabel *wuxing3;
@property (weak, nonatomic) IBOutlet UILabel *wuxing4;
@property (weak, nonatomic) IBOutlet UILabel *wuxing5;
@property (weak, nonatomic) IBOutlet UILabel *wuxing6;

@property (weak, nonatomic) IBOutlet UILabel *kongwu;

@property (weak, nonatomic) IBOutlet UILabel *shiying1;

@property (weak, nonatomic) IBOutlet UILabel *shiying2;
@property (weak, nonatomic) IBOutlet UILabel *shiying3;
@property (weak, nonatomic) IBOutlet UILabel *shiying4;
@property (weak, nonatomic) IBOutlet UILabel *shiying5;
@property (weak, nonatomic) IBOutlet UILabel *shiying6;

@property (weak, nonatomic) IBOutlet UILabel *bianWuxing;
@property (weak, nonatomic) IBOutlet UILabel *bianWuxing1;
@property (weak, nonatomic) IBOutlet UILabel *bianWuxing2;
@property (weak, nonatomic) IBOutlet UILabel *bianWuxing3;
@property (weak, nonatomic) IBOutlet UILabel *bianWuxing4;
@property (weak, nonatomic) IBOutlet UILabel *bianWuxing5;

@property (weak, nonatomic) IBOutlet UIPickerView *selectPickerView;

@property (weak, nonatomic) IBOutlet UIView *pickerViewContent;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end

@implementation ViewController
{
    NSMutableArray *_yaos;
    NSMutableArray *_bianyaos;
    NSArray *liushenArr;//六神
    NSArray *shiyingArr;
    NSString *pickerViewValue;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    pickerViewValue = @"甲子";
    [_pickerViewContent setHidden:YES];
    _firseBaGuaView.delegate = self;
    _secondBaGuaView.delegate = self;
    _secondBaGuaView.isbianyao = true;
    [_timeSegment addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventValueChanged];
    shiyingArr = [NSArray arrayWithObjects:_shiying6,_shiying5, _shiying4,_shiying3,_shiying2, _shiying1,nil];
    [self createData];
  
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int year = [comps year];
    int mouth = [comps month];
    int day = [comps day];
    int hour = [comps hour];
    [[GuaManager shareManager]loadGanZhWith:@[@(year),@(mouth),@(day),@(hour)] ganzhis:^(NSArray *nian) {
        if (nian.count>=4) {
            [_timeSegment setTitle:nian[0] forSegmentAtIndex:0];
            [_timeSegment setTitle:nian[1] forSegmentAtIndex:1];
            [_timeSegment setTitle:nian[2] forSegmentAtIndex:2];
            [_timeSegment setTitle:nian[3] forSegmentAtIndex:3];
            liushenArr = [[GuaManager shareManager]liushenArrWithDay:nian[2]];
            
            _liushou1.text = liushenArr[0];
            _liushou2.text = liushenArr[1];
            _liushou3.text = liushenArr[2];
            _liushou4.text = liushenArr[3];
            _liushou5.text = liushenArr[4];
            _liushou6.text = liushenArr[5];
            _kongwu.text = [[GuaManager shareManager]kongwuWithDay:nian[2]];
        }
        else
        {
            NSLog(@"时间错误");
        }
        
    }];
  
    [self refreshData];
    [self refreshBianData];

    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)handleAction:(id)sender {
    if (sender == _okButton) {
//        [_timeSegment setSelected:NO];
//        [_timeSegment setMomentary:NO];
        [_pickerViewContent setHidden:YES];
        if ([pickerViewValue isEqualToString:@"error"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"您选的天干地支是错误的" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            [_timeSegment setTitle:pickerViewValue forSegmentAtIndex: _timeSegment.selectedSegmentIndex];
        }
    }
}

- (void)changeTime:(id)sender
{
    [_pickerViewContent setHidden:NO];
//    [_timeSegment setMomentary:YES];
    [_timeSegment setSelected:YES];
   int index = _timeSegment.selectedSegmentIndex;
    if (index == 0) {
        NSLog(@"0");
    }
    if (index == 1) {
        NSLog(@"1");
    }
    if (index == 2) {
        NSLog(@"2");
    }
    if (index == 3) {
        NSLog(@"3");
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [[[GuaManager shareManager]tiangans]count];
    }
    else return [[[GuaManager shareManager]dizhis]count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        NSString *value = [[self sortedTianganValues] objectAtIndex:row];
        NSDictionary *tiangans = [[GuaManager shareManager]tiangans];
        NSString *obj =[[tiangans allKeysForObject:value]lastObject];
        return obj;
    }
    else
    {
        NSString *value = [[self sortedDizhiValues] objectAtIndex:row];
        NSDictionary *dizhis = [[GuaManager shareManager]dizhis];
        NSString *obj =[[dizhis allKeysForObject:value]lastObject];
        return obj;
    }
}

- (NSArray *)sortedDizhiValues
{
    NSArray *dAllvalues = [[[GuaManager shareManager]dizhis]allValues];
    NSArray *dSortedArr = [dAllvalues sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    return dSortedArr;
}

- (NSArray *)sortedTianganValues
{
    NSArray *allvalues =[[[GuaManager shareManager]tiangans]allValues];
    NSArray *sortedArr = [allvalues sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return  [obj1 compare:obj2];
    }];
    return sortedArr;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *tianzhi = @"甲",*dizhi = @"子";
    NSString *tianzhivalue=nil,*dizhivalue=nil;
    if (component == 0) {
        tianzhivalue = [[self sortedTianganValues] objectAtIndex:row];
        NSDictionary *tiangans = [[GuaManager shareManager]tiangans];
         tianzhi =[[tiangans allKeysForObject:tianzhivalue]lastObject];
    }
    else
    {
        dizhivalue = [[self sortedDizhiValues] objectAtIndex:row];
        NSDictionary *dizhis = [[GuaManager shareManager]dizhis];
        dizhi =[[dizhis allKeysForObject:dizhivalue]lastObject];
    }
    if (([tianzhivalue intValue]+1)%2 != ([dizhivalue intValue]+1)%2) {
       pickerViewValue = @"error";
    }
    else
    {
        pickerViewValue = [NSString stringWithFormat:@"%@%@",tianzhi,dizhi ];
    }
}

- (void)BaGuaView:(id)sender ActionType:(SelectType)type
{
        switch (type) {
            case selectOne:
                [self modifyAtIndex:0 sender:sender];
                break;
            case selectTwo:
                [self modifyAtIndex:1 sender:sender];
                
                break;
            case selectThree:
                [self modifyAtIndex:2 sender:sender];
                
                break;
            case selectFore:
                [self modifyAtIndex:3 sender:sender];
                
                break;
            case selectFive:
                [self modifyAtIndex:4 sender:sender];
                
                break;
            case selectSix:
                [self modifyAtIndex:5 sender:sender];
                
                break;
                
            default:
                break;
        }
}

- (void)modifyAtIndex:(int)index sender:(id)sender
{
    int  item =[[_bianyaos objectAtIndex:index]intValue];
    if(item==1)
    {
        [_bianyaos replaceObjectAtIndex:index withObject:@"0"];
    }
    else{
        [_bianyaos replaceObjectAtIndex:index withObject:@"1"];
    }
    [_secondBaGuaView changeAtIndex:index];
    
    if (sender == _firseBaGuaView) {
        [_secondBaGuaView clearBianAtIndex:index];
        int  item =[[_yaos objectAtIndex:index]intValue];
        if(item==1)
        {
            [_yaos replaceObjectAtIndex:index withObject:@"0"];
        }
        else{
            [_yaos replaceObjectAtIndex:index withObject:@"1"];
        }
        [self refreshData];

    }
       [self refreshBianData];
}

- (void)refreshBianData
{
    int index = [[GuaManager  shareManager]chargeGuaWithYao1:[( NSString *)_bianyaos[0] boolValue]
                                                        Yao2:[( NSString *)_bianyaos[1] boolValue]
                                                        Yao3:[( NSString *)_bianyaos[2] boolValue]
                                                        Yao4:[( NSString *)_bianyaos[3] boolValue]
                                                        Yao5:[( NSString *)_bianyaos[4] boolValue]
                                                        Yao6:[( NSString *)_bianyaos[5] boolValue]];
    NSArray *wuxingArr =[[GuaManager shareManager]wuxingAtIndex:index];
    _bianWuxing.text = [ wuxingArr[0] substringWithRange:NSMakeRange(1, 2)];
    _bianWuxing1.text = [wuxingArr[1] substringWithRange:NSMakeRange(1, 2)];
    _bianWuxing2.text = [wuxingArr[2]substringWithRange:NSMakeRange(1, 2)];
    _bianWuxing3.text = [wuxingArr[3]substringWithRange:NSMakeRange(1, 2)];
    _bianWuxing4.text = [wuxingArr[4]substringWithRange:NSMakeRange(1, 2)];
    _bianWuxing5.text = [wuxingArr[5]substringWithRange:NSMakeRange(1, 2)];

}
- (void)refreshData
{
   
    int index = [[GuaManager  shareManager]chargeGuaWithYao1:[( NSString *)_yaos[0] boolValue]
                                                        Yao2:[( NSString *)_yaos[1] boolValue]
                                                        Yao3:[( NSString *)_yaos[2] boolValue]
                                                        Yao4:[( NSString *)_yaos[3] boolValue]
                                                        Yao5:[( NSString *)_yaos[4] boolValue]
                                                        Yao6:[( NSString *)_yaos[5] boolValue]];
    NSDictionary *guaNames = [[GuaManager shareManager].guaNames objectAtIndex:index];
    _guaTitle.text = [NSString stringWithFormat:@"%@ 》%@",[[guaNames allValues]lastObject],[[guaNames allKeys]lastObject]];
    NSArray *wuxingArr =[[GuaManager shareManager]wuxingAtIndex:index];
    _wuxing1.text = wuxingArr[0];
    _wuxing2.text = wuxingArr[1];
    _wuxing3.text = wuxingArr[2];
    _wuxing4.text = wuxingArr[3];
    _wuxing5.text = wuxingArr[4];
    _wuxing6.text = wuxingArr[5];
    //世应
    int shiindex = [wuxingArr[6]intValue]-1;
    int yingindex = [wuxingArr[7]intValue]-1;
    
    for (int i=0;i<6; i++) {
        UILabel *shilabel = shiyingArr[i];

        if (i!=shiindex && i!=yingindex) {
            [shilabel setHidden:YES];
        }
        else
        {
            [shilabel setHidden:NO];

            if (i==shiindex) {
                shilabel.text = @"世";
            }
            else
                shilabel.text = @"应";
        }
    }
 
}

- (void)createData
{
    _yaos = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"1", nil];
    _bianyaos = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"1", nil];

    int index = [[GuaManager  shareManager]chargeGuaWithYao1:YES Yao2:YES Yao3:YES Yao4:YES Yao5:YES Yao6:YES];
    NSDictionary *guaNames = [[GuaManager shareManager].guaNames objectAtIndex:index];
    _guaTitle.text = [NSString stringWithFormat:@"%@ 》%@",[[guaNames allValues]lastObject],[[guaNames allKeys]lastObject]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
