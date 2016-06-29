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
        if ([self checkUsernameAndPwd]) {
            
        }
        else
        {
//            [LYToast showToast:@"用户名密码格式错误"];
        }
    }
    else if(sender == registerButton)
    {
        [self showDetailViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LYRegisterViewController"] sender:self];

    }
}

- (BOOL)checkUsernameAndPwd
{
    NSString *name = username.text;
    NSString *pwd  = password.text;
    if (([self validateEmail:name]||[self validateMobile:name]) && pwd.length>6 && ![self isBlankString:pwd]) {
        return true;
    }
    return NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//邮箱
- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
- (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
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
