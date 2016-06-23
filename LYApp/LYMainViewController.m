//
//  LYMainViewController.m
//  LYApp
//
//  Created by lichanghong on 16/6/20.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYMainViewController.h"

@interface LYMainViewController ()

@end

@implementation LYMainViewController
{
    __weak IBOutlet UIButton *button1;
    
    __weak IBOutlet UIButton *button2;
    
    __weak IBOutlet UIButton *button3;
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    button1.layer.cornerRadius = 6;
    button2.layer.cornerRadius = 6;
    button3.layer.cornerRadius = 6;
    // Do any additional setup after loading the view.
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
