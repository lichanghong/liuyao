//
//  GuaManager.m
//  LYApp
//
//  Created by lichanghong on 16/5/13.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "GuaManager.h"

@implementation GuaManager
{
    NSArray *gua1;    NSArray *gua21;    NSArray *gua41;    NSArray *gua61;
    NSArray *gua2;    NSArray *gua22;    NSArray *gua42;    NSArray *gua62;
    NSArray *gua3;    NSArray *gua23;   NSArray *gua43;     NSArray *gua63;
    NSArray *gua4;    NSArray *gua24;   NSArray *gua44;     NSArray *gua64;
    NSArray *gua5;  NSArray *gua25;     NSArray *gua45;
    NSArray *gua6;  NSArray *gua26;     NSArray *gua46;
    NSArray *gua7;  NSArray *gua27;     NSArray *gua47;     NSArray *arrs;
    NSArray *gua8;  NSArray *gua28;     NSArray *gua48;    
    NSArray *gua9;  NSArray *gua29;     NSArray *gua49;     NSArray *wuxings; //五行
    NSArray *gua10; NSArray *gua30;     NSArray *gua50;    
    NSArray *gua11; NSArray *gua31;     NSArray *gua51;    
    NSArray *gua12; NSArray *gua32;     NSArray *gua52;    
    NSArray *gua13; NSArray *gua33;     NSArray *gua53;    
    NSArray *gua14; NSArray *gua34;     NSArray *gua54;    
    NSArray *gua15; NSArray *gua35;     NSArray *gua55;    
    NSArray *gua16; NSArray *gua36;     NSArray *gua56;    
    NSArray *gua17; NSArray *gua37;     NSArray *gua57;    
    NSArray *gua18; NSArray *gua38;     NSArray *gua58;    
    NSArray *gua19; NSArray *gua39;     NSArray *gua59;    
    NSArray *gua20; NSArray *gua40;     NSArray *gua60;
   
}

+(instancetype)shareManager
{
    static GuaManager *s_manager =nil;
    @synchronized(self)
    {
        if(s_manager)
        {
            return s_manager;
        }
        s_manager = [[GuaManager alloc]init];
    }
    return s_manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _guaNames = [NSArray arrayWithObjects:@{@"乾为天":@"乾金"},@{@"坤为地":@"坤土"},@{@"水雷屯":@"坎水"},
  @{@"山水蒙":@"离火"}, @{@"水天需":@"坤土"},@{@"天水讼":@"离火"},@{@"地水师":@"坎水"},
  @{@"水地比":@"坤土"},@{@"风天小畜":@"巽木"},@{@"天泽履":@"艮土"},@{@"地天泰":@"坤土"},
  @{@"天地否":@"乾金"},@{@"天火同人":@"离火"},@{@"火天大有":@"乾金"},@{@"地山谦":@"兑金"},
  @{@"雷地豫":@"震木"},@{@"泽雷随":@"震木"},@{@"山风蛊":@"巽木"},@{@"地泽临":@"坤土"},
  @{@"风地观":@"乾金"},@{@"火雷噬嗑":@"巽木"},@{@"山火贲":@"艮土"},@{@"山地剥":@"乾金"},
  @{@"地雷复":@"坤土"},@{@"天雷无妄":@"巽木"},@{@"山天大畜":@"艮土"},
  @{@"山雷颐":@"巽木"},@{@"泽风大过":@"震木"},@{@"坎为水":@"坎水"},
  @{@"离为火":@"离火"},@{@"泽山咸":@"兑金"}, @{@"雷风恒":@"震木"},
  @{@"天山遯":@"乾金"},@{@"雷天大壮":@"坤土"},@{@"火地晋":@"乾金"},
  @{@"地火明夷":@"坎水"},@{@"风火家人":@"巽木"},@{@"火泽睽":@"艮土"},
  @{@"水山蹇":@"兑金"},@{@"雷水解":@"震木"},@{@"山泽损":@"艮土"},
  @{@"风雷益":@"巽木"}, @{@"泽天夬":@"坤土"},@{@"天风姤":@"乾金"},
  @{@"泽地萃":@"兑金"},@{@"地风升":@"震木"},@{@"泽水困":@"兑金"},
  @{@"水风井":@"震木"},@{@"泽火革":@"坎水"},@{@"火风鼎":@"离火"},
  @{@"震为雷":@"震木"},@{@"艮为山":@"艮土"},@{@"风山渐":@"艮土"},
  @{@"雷泽归妹":@"兑金"},@{@"雷火丰":@"坎水"},@{@"火山旅":@"离火"},
  @{@"巽为风":@"巽木"},@{@"兑为泽":@"兑金"},@{@"风水涣":@"离火"},
  @{@"水泽节":@"坎水"},@{@"风泽中孚":@"艮土"},@{@"雷山小过":@"兑金"},
  @{@"水火既济":@"坎水"},@{@"火水未济":@"离火"},nil];
        
        wuxings = [NSArray arrayWithObjects:
                   
                   @[@"父戌土",@"兄申金",@"官午火",@"父辰土", @"才寅木", @"子子水",@"6",@"3"], //乾
                   @[@"子酉金",@"才亥水",@"兄丑土",@"官卯木", @"父巳火", @"兄未土",@"6",@"3"], //坤
                   @[@"兄子水",@"官戌土",@"父申金",@"官丑土", @"子卯木", @"子寅木",@"2",@"5"], //水雷屯
                   @[@"父寅木",@"官子水",@"子戌土",@"兄午火", @"子辰土", @"父寅木",@"4",@"1"], //山水蒙
                   @[@"才子水",@"兄戌土",@"子申金",@"兄辰土", @"官寅木", @"才子水",@"4",@"1"], //水天需
                   @[@"子戌土",@"才申金",@"兄午火",@"兄午火", @"子辰土", @"父寅木",@"4",@"1"], //天水讼
                   @[@"父酉金",@"兄亥水",@"官丑土",@"才午火", @"官辰土", @"子寅木",@"3",@"6"], // 地水师
                   @[@"才子水",@"兄戌土",@"子申金",@"官卯木", @"父巳火", @"兄未土",@"3",@"6"], //水地比
                   @[@"兄卯木",@"子巳火",@"才未土",@"才辰土", @"兄寅木", @"父子水",@"1",@"4"], //风天小畜
                   @[@"兄戌土",@"子申金",@"父午火",@"兄丑土", @"官卯木", @"父巳火",@"5",@"2"], //天泽履
                   @[@"子酉金",@"才亥水",@"兄丑土",@"兄辰土", @"官寅木", @"才子水",@"3",@"6"], //地天泰
                   @[@"父戌土",@"兄申金",@"官午火",@"才卯木", @"官巳火", @"父未土",@"3",@"6"], //天地否
                   @[@"子戌土",@"才申金",@"兄午火",@"官亥水", @"子丑土", @"父卯木",@"3",@"6"], //天火同人
                   @[@"官巳火",@"父未土",@"兄酉金",@"父辰土", @"才寅木", @"子子水",@"3",@"6"], //火天大有
                   @[@"兄酉金",@"子亥水",@"父丑土",@"兄申金", @"官午火", @"父辰土",@"5",@"2"], //地山谦
                   @[@"才戌土",@"官申金",@"子午火",@"兄卯木", @"子巳火", @"才未土",@"1",@"4"], //雷地豫
                   @[@"才未土",@"官酉金",@"父亥水",@"才辰土", @"兄寅木", @"父子水",@"3",@"6"], //泽雷随
                   @[@"兄寅木",@"父子水",@"才戌土",@"官酉金", @"父亥水", @"才丑土",@"3",@"6"], //山风蛊
                   @[@"子酉金",@"才亥水",@"兄丑土",@"兄丑土", @"官卯木", @"父巳火",@"2",@"5"], //地泽临
                   @[@"才卯木",@"官巳火",@"父未土",@"才卯木", @"官巳火", @"父未土",@"4",@"1"], //风地观
                   @[@"子巳火",@"才未土",@"官酉金",@"才辰土", @"兄寅木", @"父子水",@"5",@"2"], //火雷噬嗑
                   @[@"官寅木",@"才子水",@"兄戌土",@"才亥水", @"兄丑土", @"官卯木",@"1",@"4"], //山火贲
                   @[@"才寅木",@"子子水",@"父戌土",@"才卯木", @"官巳火", @"父未土",@"5",@"2"], //山地剥
                   @[@"子酉金",@"才亥水",@"兄丑土",@"兄辰土", @"官寅木", @"才子水",@"1",@"4"], //地雷复
                   @[@"才戌土",@"官申金",@"子午火",@"才辰土", @"兄寅木", @"父子水",@"4",@"1"], //天雷无妄
                   @[@"官寅木",@"才子水",@"兄戌土",@"兄辰土", @"官寅木", @"才子水",@"2",@"5"], //山天大蓄
                   @[@"兄寅木",@"父子水",@"才戌土",@"才辰土", @"兄寅木", @"父子水",@"4",@"1"], //山雷颐
                   @[@"才未土",@"官酉金",@"父亥水",@"官申金", @"父亥水", @"才丑土",@"4",@"1"], //泽风大过
                   @[@"兄子水",@"官戌土",@"父申金",@"才午火", @"官辰土", @"子寅木",@"6",@"3"], //坎
                   @[@"兄巳火",@"子未土",@"才酉金",@"官亥水", @"子丑土", @"父卯木",@"6",@"3"], //离
                   @[@"父未土",@"兄酉金",@"子亥水",@"兄申金", @"官午火", @"父辰土",@"3",@"6"], //泽山咸
                   @[@"才戌土",@"官申金",@"子午火",@"官酉金", @"父亥水", @"才丑土",@"3",@"6"], //雷风恒
                   @[@"父戌土",@"兄申金",@"官午火",@"兄申金", @"官午火", @"父辰土",@"2",@"5"], //天山遁
                   @[@"兄戌土",@"子申金",@"父午火",@"兄辰土", @"官寅木", @"才子水",@"4",@"1"], //雷天大壮
                   @[@"官巳火",@"父未土",@"兄酉金",@"才卯木", @"官巳火", @"父未土",@"4",@"1"], //火地晋
                   @[@"父酉金",@"兄亥水",@"官丑土",@"兄亥水", @"官丑土", @"子卯木",@"4",@"1"], //地火明夷
                   @[@"兄卯木",@"子巳火",@"才未土",@"父亥水", @"才丑土", @"兄卯木",@"2",@"5"], //风火家人
                   @[@"父巳火",@"兄未土",@"子酉金",@"兄丑土", @"官卯木", @"父巳火",@"4",@"1"], //火泽睽
                   @[@"子子水",@"父戌土",@"兄申金",@"兄申金", @"官午火", @"父辰土",@"4",@"1"], //水山蹇
                   @[@"才戌土",@"官申金",@"子午火",@"子午火", @"才辰土", @"兄寅木",@"2",@"5"], //雷水解
                   @[@"官寅木",@"才子水",@"兄戌土",@"兄丑土", @"官卯木", @"父巳火",@"3",@"6"], //山泽损
                   @[@"兄卯木",@"子巳火",@"才未土",@"才辰土", @"兄寅木", @"父子水",@"3",@"6"], //风雷益
                   @[@"兄未土",@"子酉金",@"才亥水",@"兄辰土", @"官寅木", @"才子水",@"5",@"2"], //泽天夬
                   @[@"父戌土",@"兄申金",@"官午火",@"兄酉金", @"子亥水", @"父丑土",@"1",@"4"], //天风姤
                   @[@"父未土",@"兄酉金",@"子亥水",@"才卯木", @"官巳火", @"父未土",@"2",@"5"], //泽地萃
                   @[@"官酉金",@"父亥水", @"才丑土"@"官酉金", @"父亥水", @"才丑土",@"4",@"1"], //地风升
                   @[@"父未土",@"兄酉金",@"子亥水",@"官午火", @"父辰土", @"才寅木",@"1",@"4"], //泽水困
                   @[@"父子水",@"才戌土",@"官申金",@"官申金", @"父亥水", @"才丑土",@"5",@"2"], //水风井
                   @[@"官未土",@"父酉金",@"兄亥水",@"兄亥水", @"官丑土", @"子卯木",@"4",@"1"], //泽火革
                   @[@"兄巳火",@"子未土",@"才酉金",@"才酉金", @"官亥水", @"子丑土",@"2",@"5"], //火风鼎
                   @[@"才戌土",@"官申金",@"子午火",@"才辰土", @"兄寅木", @"父子水",@"6",@"3"], //震
                   @[@"官寅木",@"才子水",@"兄戌土",@"子申金", @"父午火", @"兄辰土",@"6",@"3"], //艮
                   @[@"官卯木",@"父巳火",@"兄未土",@"子申金", @"父午火", @"兄辰土",@"3",@"6"], //风山渐
                   @[@"父戌土",@"兄申金",@"官午火",@"父丑土", @"才卯木", @"官巳火",@"3",@"6"], //雷泽归妹
                   @[@"官戌土",@"父申金",@"才午火",@"兄亥水", @"官丑土", @"子卯木",@"5",@"2"], //雷火丰
                   @[@"兄巳火",@"子未土",@"才酉金",@"才申金", @"兄午火", @"子辰土",@"1",@"4"], //火山旅
                   @[@"兄卯木",@"子巳火",@"才未土",@"官酉金", @"父巳火", @"才丑土",@"6",@"3"], //巽
                   @[@"父未土",@"兄酉金",@"子亥水",@"父丑土", @"才卯木", @"官巳火",@"6",@"3"], //兑
                   @[@"父卯木",@"兄巳火",@"子未土",@"兄午火", @"子辰土", @"父寅木",@"5",@"2"], //风水涣
                   @[@"兄子水",@"官戌土",@"父申金",@"才午火", @"官辰土", @"才巳火",@"1",@"4"], //水泽节
                   @[@"官卯木",@"父巳火",@"兄未土",@"兄丑土", @"官卯木", @"父巳火",@"4",@"1"], //风泽中孚
                   @[@"父戌土",@"兄申金",@"官午火",@"兄申金", @"官午火", @"父辰土",@"4",@"1"], //雷山小过
                   @[@"兄子水",@"官戌土",@"父申金",@"兄亥水", @"官丑土", @"子卯木",@"3",@"6"], //水火既济
                   @[@"兄巳火",@"子未土",@"才酉金",@"兄午火", @"子辰土", @"父寅木",@"3",@"6"], //火水未济
                   nil];
        
                                                                    
                                                                    
        gua1 = [NSArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
        gua2 = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", @"2",nil];
        gua3 = [NSArray arrayWithObjects:@"0",@"1",@"0",@"0",@"0",@"1",@"3", nil];
        gua4 = [NSArray arrayWithObjects:@"1",@"0",@"0",@"0",@"1",@"0",@"4", nil];
        gua5 = [NSArray arrayWithObjects:@"0",@"1",@"0",@"1",@"1",@"1",@"5", nil];
        gua6 = [NSArray arrayWithObjects:@"1",@"1",@"1",@"0",@"1",@"0",@"6", nil];
        gua7 = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"1",@"0", @"7",nil];
        gua8 = [NSArray arrayWithObjects:@"0",@"1",@"0",@"0",@"0",@"0", @"8",nil];
        gua9 = [NSArray arrayWithObjects:@"1",@"1",@"0",@"1",@"1",@"1", @"9",nil];
        gua10 = [NSArray arrayWithObjects:@"1",@"1",@"1",@"0",@"1",@"1",@"10", nil];
        gua11 = [NSArray arrayWithObjects:@"0",@"0",@"0",@"1",@"1",@"1",@"11", nil];
        gua12 = [NSArray arrayWithObjects:@"1",@"1",@"1",@"0",@"0",@"0",@"12", nil];
        gua13 = [NSArray arrayWithObjects:@"1",@"1",@"1",@"1",@"0",@"1",@"13", nil];
        gua14 = [NSArray arrayWithObjects:@"1",@"0",@"1",@"1",@"1",@"1",@"14", nil];
        gua15 = [NSArray arrayWithObjects:@"0",@"0",@"0",@"1",@"0",@"0",@"15", nil];
        gua16 = [NSArray arrayWithObjects:@"0",@"0",@"1",@"0",@"0",@"0",@"16", nil];
        gua17 = [NSArray arrayWithObjects:@"0",@"1",@"1",@"0",@"0",@"1",@"17", nil];
        gua18 = [NSArray arrayWithObjects:@"1",@"0",@"0",@"1",@"1",@"0", @"18",nil];
        gua19 = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"1",@"1", @"19",nil];
        gua20 = [NSArray arrayWithObjects:@"1",@"1",@"0",@"0",@"0",@"0", @"20",nil];
        gua21 = [NSArray arrayWithObjects:@"1",@"0",@"1",@"0",@"0",@"1", @"21",nil];
        gua22 = [NSArray arrayWithObjects:@"1",@"0",@"0",@"1",@"0",@"1", @"22",nil];
        gua23 = [NSArray arrayWithObjects:@"1",@"0",@"0",@"0",@"0",@"0", @"23",nil];
        gua24 = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"1", @"24",nil];
        gua25 = [NSArray arrayWithObjects:@"1",@"1",@"1",@"0",@"0",@"1", @"25",nil];
        gua26 = [NSArray arrayWithObjects:@"1",@"0",@"0",@"1",@"1",@"1", @"26",nil];
        gua27 = [NSArray arrayWithObjects:@"1",@"0",@"0",@"0",@"0",@"1", @"27",nil];
        gua28 = [NSArray arrayWithObjects:@"0",@"1",@"1",@"1",@"1",@"0", @"28",nil];
        gua29 = [NSArray arrayWithObjects:@"0",@"1",@"0",@"0",@"1",@"0", @"29",nil];
        gua30 = [NSArray arrayWithObjects:@"1",@"0",@"1",@"1",@"0",@"1", @"30",nil];
        gua31 = [NSArray arrayWithObjects:@"0",@"1",@"1",@"1",@"0",@"0", @"31",nil];
        gua32 = [NSArray arrayWithObjects:@"1",@"0",@"0",@"1",@"1",@"0",@"32", nil];
        gua33 = [NSArray arrayWithObjects:@"1",@"1",@"1",@"1",@"0",@"0", @"33",nil];
        gua34 = [NSArray arrayWithObjects:@"0",@"0",@"1",@"1",@"1",@"1", @"34",nil];
        gua35 = [NSArray arrayWithObjects:@"1",@"0",@"1",@"0",@"0",@"0", @"35",nil];
        gua36 = [NSArray arrayWithObjects:@"0",@"0",@"0",@"1",@"0",@"1", @"36",nil];
        gua37 = [NSArray arrayWithObjects:@"1",@"1",@"0",@"1",@"0",@"1", @"37",nil];
        gua38 = [NSArray arrayWithObjects:@"1",@"0",@"1",@"0",@"1",@"1", @"38",nil];
        gua39 = [NSArray arrayWithObjects:@"0",@"1",@"0",@"1",@"0",@"0", @"39",nil];
        gua40 = [NSArray arrayWithObjects:@"0",@"0",@"1",@"0",@"1",@"0", @"40",nil];
        gua41 = [NSArray arrayWithObjects:@"1",@"0",@"0",@"0",@"1",@"1", @"41",nil];
        gua42 = [NSArray arrayWithObjects:@"1",@"1",@"0",@"0",@"0",@"1", @"42",nil];
        gua43 = [NSArray arrayWithObjects:@"0",@"1",@"1",@"1",@"1",@"1", @"43",nil];
        gua44 = [NSArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"0", @"44",nil];
        gua45 = [NSArray arrayWithObjects:@"0",@"1",@"1",@"0",@"0",@"0", @"45",nil];
        gua46 = [NSArray arrayWithObjects:@"0",@"0",@"0",@"1",@"1",@"0", @"46",nil];
        gua47 = [NSArray arrayWithObjects:@"0",@"1",@"1",@"0",@"1",@"0", @"47",nil];
        gua48 = [NSArray arrayWithObjects:@"0",@"1",@"0",@"1",@"1",@"0", @"48",nil];
        gua49 = [NSArray arrayWithObjects:@"0",@"1",@"1",@"1",@"0",@"1", @"49",nil];
        gua50 = [NSArray arrayWithObjects:@"1",@"0",@"1",@"1",@"1",@"0", @"50",nil];
        gua51 = [NSArray arrayWithObjects:@"0",@"0",@"1",@"0",@"0",@"1", @"51",nil];
        gua52 = [NSArray arrayWithObjects:@"1",@"0",@"0",@"1",@"0",@"0", @"52",nil];
        gua53 = [NSArray arrayWithObjects:@"1",@"1",@"0",@"1",@"0",@"0", @"53",nil];
        gua54 = [NSArray arrayWithObjects:@"0",@"0",@"1",@"0",@"1",@"1", @"54",nil];
        gua55 = [NSArray arrayWithObjects:@"0",@"0",@"1",@"1",@"0",@"1", @"55",nil];
        gua56 = [NSArray arrayWithObjects:@"1",@"0",@"1",@"1",@"0",@"0", @"56", nil];
        gua57 = [NSArray arrayWithObjects:@"1",@"1",@"0",@"1",@"1",@"0", @"57",nil];
        gua58 = [NSArray arrayWithObjects:@"0",@"1",@"1",@"0",@"1",@"1", @"58",nil];
        
        gua59 = [NSArray arrayWithObjects:@"1",@"1",@"0",@"0",@"1",@"0", @"59",nil];
        gua60 = [NSArray arrayWithObjects:@"0",@"1",@"0",@"0",@"1",@"1", @"60",nil];
        gua61 = [NSArray arrayWithObjects:@"1",@"1",@"0",@"0",@"1",@"1", @"61",nil];
        gua62 = [NSArray arrayWithObjects:@"0",@"0",@"1",@"1",@"0",@"0", @"62",nil];
        gua63 = [NSArray arrayWithObjects:@"0",@"1",@"0",@"1",@"0",@"1", @"63",nil];
        gua64 = [NSArray arrayWithObjects:@"1",@"0",@"1",@"0",@"1",@"0", @"64",nil];
      
        arrs = [NSArray arrayWithObjects:gua1,gua2,gua3,gua4,gua5,gua6,gua7,gua8,gua9,gua10,
                gua11,gua12,gua13,gua14,gua15,gua16,gua17,gua18,gua19,gua20,gua21,gua22,gua23,gua24,gua25,
                gua26,gua27,gua28,gua29,gua30,gua31,gua32,gua33,gua34,gua35,gua36,gua37,gua38,gua39,gua40,
                gua41,gua42,gua43,gua44,gua45,gua46,gua47,gua48,gua49,gua50,gua51,gua52,gua53,gua54,gua55,
                gua56,gua57,gua58,gua59,gua60,gua61,gua62,gua63,gua64,nil];
        
        _tiangans=@{@"甲":@"0",@"乙":@"1",@"丙":@"2",@"丁":@"3",@"戊":@"4",@"己":@"5",@"庚":@"6",@"辛":@"7",@"壬":@"8",@"癸":@"9",};
        _dizhis=@{@"子":@"0",@"丑":@"1",@"寅":@"2",@"卯":@"3",@"辰":@"4",@"巳":@"5",@"午":@"6",@"未":@"7",@"申":@"8",@"酉":@"9",@"戌":@"10",@"亥":@"11"};
        
    }
    return self;
}

- (NSArray *)wuxingAtIndex:(int)index
{
    return [wuxings objectAtIndex:index];
}



- (NSString *)kongwuWithDay:(NSString *)day
{
    
    NSString *gan =[day substringWithRange:NSMakeRange(0, 1)];
    NSString *zhi = [day substringWithRange:NSMakeRange(1, 1)];
    NSString * tianganindex = [_tiangans objectForKey: gan];
    
    NSString * dizhiindex = [_dizhis objectForKey: zhi];
    
    int index = (11-[tianganindex intValue]+ [dizhiindex intValue])%12;
    NSString *k1 =[NSString stringWithFormat:@"%d",index];
    NSString *kong1 = [[_dizhis allKeysForObject:k1]lastObject];
    NSString *kong2 = [[_dizhis allKeysForObject:[NSString stringWithFormat:@"%d",index-1]] lastObject];
    return [NSString stringWithFormat:@"%@%@ 空",kong2,kong1];
}


//返回卦序
- (int)chargeGuaWithYao1:(BOOL)isyang0 Yao2:(BOOL)isyang1 Yao3:(BOOL)isyang2 Yao4:(BOOL)isyang3 Yao5:(BOOL)isyang4 Yao6:(BOOL)isyang5
{
    //找出与第一爻相同的所有卦
    NSMutableArray *oneYaoArr = [NSMutableArray array];
    for (NSArray *arr in arrs) {
        if (isyang0) {
            if ([arr[0]intValue]==1) {
                [oneYaoArr addObject:arr];
            }
        }
        else{
            if ([arr[0]intValue]==0) {
                [oneYaoArr addObject:arr];
            }
        }
    }
    //找出与第二爻相同的所有卦
    NSMutableArray *twoYaoArr = [NSMutableArray array];
    for (NSArray *arr in oneYaoArr) {
        if (isyang1) {
            if ([arr[1]intValue]==1) {
                [twoYaoArr addObject:arr];
            }
        }
        else{
            if ([arr[1]intValue]==0) {
                [twoYaoArr addObject:arr];
            }
        }
    }
    
    //找出与第三爻相同的所有卦
    NSMutableArray *threeYaoArr = [NSMutableArray array];
    for (NSArray *arr in twoYaoArr) {
        if (isyang2) {
            if ([arr[2]intValue]==1) {
                [threeYaoArr addObject:arr];
            }
        }
        else{
            if ([arr[2]intValue]==0) {
                [threeYaoArr addObject:arr];
            }
        }
    }
    //找出与第四爻相同的所有卦
    NSMutableArray *fourYaoArr = [NSMutableArray array];
    for (NSArray *arr in threeYaoArr) {
        if (isyang3) {
            if ([arr[3]intValue]==1) {
                [fourYaoArr addObject:arr];
            }
        }
        else{
            if ([arr[3]intValue]==0) {
                [fourYaoArr addObject:arr];
            }
        }
    }
    //找出与第五爻相同的所有卦
    NSMutableArray *fiveYaoArr = [NSMutableArray array];
    for (NSArray *arr in fourYaoArr) {
        if (isyang4) {
            if ([arr[4]intValue]==1) {
                [fiveYaoArr addObject:arr];
            }
        }
        else{
            if ([arr[4]intValue]==0) {
                [fiveYaoArr addObject:arr];
            }
        }
    }
    //找出与第六爻相同的所有卦
    NSMutableArray *sixYaoArr = [NSMutableArray array];
    for (NSArray *arr in fiveYaoArr) {
        if (isyang5) {
            if ([arr[5]intValue]==1) {
                [sixYaoArr addObject:arr];
            }
        }
        else{
            if ([arr[5]intValue]==0) {
                [sixYaoArr addObject:arr];
            }
        }
    }
    int index =  [[[sixYaoArr lastObject]lastObject] intValue]-1;
    return index;
}

- (NSArray *)liushenArrWithDay:(NSString *)day
{
    NSArray *result = nil;
    NSString *tiangan = [day substringWithRange:NSMakeRange(0, 1)];
     if ([tiangan isEqualToString:@"甲"] || [tiangan isEqualToString:@"乙"]) {
        result = [NSArray arrayWithObjects:@"龙",@"雀",@"勾",@"蛇",@"虎",@"武", nil];
    }
    if ([tiangan isEqualToString:@"丙"] || [tiangan isEqualToString:@"丁"]) {
        result = [NSArray arrayWithObjects:@"雀",@"勾",@"蛇",@"虎",@"武",@"龙", nil];
    }
    if ([tiangan isEqualToString:@"戊"] ) {
        result = [NSArray arrayWithObjects:@"勾",@"蛇",@"虎",@"武",@"龙",@"雀", nil];
    }
    if ([tiangan isEqualToString:@"己"]) {
        result = [NSArray arrayWithObjects:@"蛇",@"虎",@"武",@"龙",@"雀",@"勾", nil];
    }
    if ([tiangan isEqualToString:@"庚"] || [tiangan isEqualToString:@"辛"]) {
        result = [NSArray arrayWithObjects:@"虎",@"武",@"龙",@"雀",@"陈",@"蛇", nil];
    }
    if ([tiangan isEqualToString:@"壬"] || [tiangan isEqualToString:@"癸"]) {
        result = [NSArray arrayWithObjects:@"武",@"龙",@"雀",@"陈",@"蛇",@"虎", nil];
    }
   
    return result;
}
- (void)loadGanZhi:(void(^)(NSArray *nian))nianyueri
{
    NSString *hostname = @"http://www.laohuangli.net/wannianli/";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:hostname]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data) {
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSString *utf8str = [[NSString alloc] initWithData:data encoding:enc];
            utf8str = [utf8str stringByReplacingOccurrencesOfString:@"\"GB2312\"" withString:@"\"utf-8\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0,40)];
            NSArray *firstarr =  [utf8str componentsSeparatedByString:@"target=\"_blank\"><span class=\"rl_txt_1\">"];
            utf8str = [[[firstarr objectAtIndex:2] componentsSeparatedByString:@"</span></a>"]firstObject];
            utf8str = [[utf8str componentsSeparatedByString:@"<br>"] lastObject];
            NSArray *resultArr = [utf8str componentsSeparatedByString:@" "];
            NSArray *nian = [NSArray arrayWithObjects:resultArr[0],resultArr[2],resultArr[4], nil];
            
            NSMutableString *nianstr =  [NSMutableString stringWithString: nian[0]];
            nianstr = [nianstr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年"]];
            NSMutableString *yuestr =  [NSMutableString stringWithString: nian[1]];
            yuestr = [yuestr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"月"]];
            NSMutableString *ristr =  [NSMutableString stringWithString: nian[2]];
            ristr = [ristr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"日"]];
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
           NSString *shiStr = @"";
            int hour = [comps hour];
            if (hour>=23 || hour<=1) {
                shiStr = @"子时";
            }
            else if(hour>1 && hour<3) {
                shiStr = @"丑时";
            }
            else if(hour>=3 && hour<5) {
                shiStr = @"寅时";
            }
            else if(hour>=5 && hour<7) {
                shiStr = @"卯时";
            }
            else if(hour>=7 && hour<9) {
                shiStr = @"辰时";
            }
            else if(hour>=9 && hour<11) {
                shiStr = @"巳时";
            }
            else if(hour>=11 && hour<13) {
                shiStr = @"午时";
            }
            else if(hour>=13 && hour<15) {
                shiStr = @"未时";
            }
            else if(hour>=15 && hour<17) {
                shiStr = @"申时";
            }
            else if(hour>=17 && hour<19) {
                shiStr = @"酉时";
            }
            else if(hour>=19 && hour<21) {
                shiStr = @"戌时";
            }
            else if(hour>=21 && hour<23) {
                shiStr = @"亥时";
            }
            NSArray *results = [NSArray arrayWithObjects:nianstr,yuestr,ristr,shiStr, nil];
            [[NSUserDefaults standardUserDefaults]setObject:results forKey:@"timeresult"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            nianyueri( results);
            
        }
        else
        {
            NSArray *results = [[NSUserDefaults standardUserDefaults]objectForKey: @"timeresult"];
            nianyueri( results);
            NSLog(@"data = nil");
        }
    }];
    
    
}




@end
