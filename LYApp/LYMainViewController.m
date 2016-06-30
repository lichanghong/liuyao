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
    
    __weak IBOutlet UIButton *button4;
    

}


- (IBAction)handleAction:(id)sender {
    if (sender == button3) {
        if (false) { //已经登录
            [self performSegueWithIdentifier:@"main_to_history" sender:nil];
        }
        else
        {
            [self toLoginPage];
        }
    }
}

//跳转到login界面
- (void)toLoginPage
{
    [self showDetailViewController:[self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"LYLoginViewController"] sender:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    button1.layer.cornerRadius = 6;
    button2.layer.cornerRadius = 6;
    button3.layer.cornerRadius = 6;
    button4.layer.cornerRadius = 6;
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
