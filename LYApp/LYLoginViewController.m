//
//  LYLoginViewController.m
//  LYApp
//
//  Created by lichanghong on 16/6/23.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYLoginViewController.h"

@interface LYLoginViewController ()<UIScrollViewDelegate>

@end

@implementation LYLoginViewController
{
    __weak IBOutlet UIButton *_backButton;
 
    __weak IBOutlet NSLayoutConstraint *baseW;
    
    
    __weak IBOutlet UITextField *username;
    
    __weak IBOutlet UITextField *password;
    
    __weak IBOutlet UIButton *forgetPassword;
    
    __weak IBOutlet UIButton *loginButton;
    
    __weak IBOutlet UIButton *registerButton;
    
    __weak IBOutlet UIScrollView *_scrollView;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    baseW.constant = KScreenWidth+5;
    loginButton.layer.cornerRadius = loginButton.frame.size.height/2.0;
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


- (IBAction)handleAction:(id)sender {
    [self.view endEditing:YES];

    if (sender == _backButton) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if(sender == forgetPassword)
    {
        
    }
    else if(sender == loginButton)
    {
        
    }
    else if(sender == registerButton)
    {
        [self showDetailViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LYRegisterViewController"] sender:self];

    }
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
