//
//  LYHelpViewController.m
//  LYApp
//
//  Created by lichanghong on 16/6/22.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYHelpViewController.h"

@interface LYHelpViewController ()

@end

@implementation LYHelpViewController
{
    __weak IBOutlet UIView *navView;
    __weak IBOutlet UITextView *firstQuestion;
    __weak IBOutlet UITextView *secondQuestion;

    __weak IBOutlet NSLayoutConstraint *firstH;
    
    __weak IBOutlet NSLayoutConstraint *secondH;
    
    IBOutlet NSObject *_backButton;

    
    
}


+ (void)pushToHelpVCWithNav:(UINavigationController *)nav
{
    [nav pushViewController:[nav.storyboard instantiateViewControllerWithIdentifier:@"LYHelpViewController"] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[self firstStr]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];//调整行间距
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [[self firstStr] length])];
    firstQuestion.attributedText = attributedString;
    NSDictionary *attr =@{NSParagraphStyleAttributeName:paragraphStyle};
    
    CGFloat height = [[self firstStr] boundingRectWithSize:CGSizeMake(ViewW(firstQuestion), 142)
                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                          attributes:attr context:nil].size.height;
    
    firstH.constant = height;
    firstQuestion.textColor = [UIColor colorForHex:@"AC00FF"];
         // Do any additional setup after loading the view.
    
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:[self secondStr]];
     [attributedString2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [[self secondStr] length])];
    secondQuestion.attributedText = attributedString2;
    
    CGFloat height2 = [[self firstStr] boundingRectWithSize:CGSizeMake(ViewW(firstQuestion), 142)
                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                                attributes:attr context:nil].size.height;
    
    secondH.constant = height2;
    secondQuestion.textColor = [UIColor colorForHex:@"AC00FF"];
}

- (IBAction)handleAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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








- (NSString *)firstStr
{
    return @"摇卦时请集中精神！心中想着所问之事，使用三个铜钱或硬币在手中摇动，然后抛向空中，铜钱/硬币，无字的一面叫做“背”或叫“反”，本程序点击开始起卦按钮之后，会弹出六个：“两反一正”、“两正一反”、“三个正”、“三个反”的选项，根据你的结果选择，共摇６次成卦。最后点击确定按钮即可完成起卦。";
}

- (NSString *)secondStr
{
    return @"首先需要选择性别（男、女），然后写上自己所要问的事情，一卦一问，不可求多个问题。其次设定起卦时间，默认是当前时间，点击时间可以修改。最后，确定写入的时间是否正确，如果确定没问题就点击开始起卦，此时会弹出一卦界面，一共六个爻对应着你六次摇卦结果。比如第一次摇卦结果是三个反，那就在第一爻处选择三个反，以此类推。";
}

@end
