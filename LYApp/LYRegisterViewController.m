//
//  LYRegisterViewController.m
//  LYApp
//
//  Created by lichanghong on 16/6/23.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYRegisterViewController.h"
#import "HttpUtil.h"


@interface LYRegisterViewController ()

@end

@implementation LYRegisterViewController
{
    __weak IBOutlet UIButton *_backButton;
    
    __weak IBOutlet UITextField *username;
    __weak IBOutlet UITextField *password;
    __weak IBOutlet UIButton *_registerButton;
    __weak IBOutlet UIButton *_protocolButton;
    UIActivityIndicatorView  *_indicatorView;
}

- (IBAction)handleAction:(id)sender {
    if (sender == _backButton) {
        [self dismiss];
    }
    else if(sender == _registerButton)
    {
        if ([self checkUsernameAndPwd]) {
            [self startRegist];
            [HttpUtil doRegistNewUserWithUsername:username.text PW:password.text success:^(id json) {
                [self endRegist];
                if (json) {
                    NSString *errorno = json[@"errno"];
                    if ([errorno intValue]==0) {
                        UserManager *manager= [UserManager defaultManager];
                        manager.userid = json[@"uid"];
                        manager.username = json[@"username"];
                        manager.gender = json[@"gender"];
                        manager.nickname = json[@"nickname"];
                        manager.blocked = json[@"blocked"];
                        BOOL archived = [UserManager archiveUserManager:manager];
                        if (!archived) {
                            DDLogError(@"archive usernanager fail for register");
                        }
                        [self dismiss];
                    }
                    else
                    {
                        [LYToast showToast:json[@"errmsg"]];
                    }
                }
                else
                    DDLogError(@"result = %@",json);
                
            } failure:^(NSString *errmsg) {
                [self endRegist];
                [LYToast showToast:errmsg];
            }];
        }
        else
        {
            [LYToast showToast:@"用户名密码格式错误"];
        }
    }
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)checkUsernameAndPwd
{
    NSString *name = username.text;
    NSString *pwd  = password.text;
    if (([self validateEmail:name]||[self validateMobile:name]) && pwd.length>5 && ![self isBlankString:pwd]) {
        return true;
    }
    return NO;
}

- (void)startRegist
{
    [_indicatorView startAnimating];
    [self.view endEditing:YES];
    [username setEnabled:NO];
    [password setEnabled:NO];
    [_registerButton setEnabled:NO];
    [_protocolButton setEnabled:NO];
}

- (void)endRegist
{
    [_indicatorView stopAnimating];
    [self.view endEditing:YES];
    [username setEnabled:YES];
    [password setEnabled:YES];
    [_registerButton setEnabled:YES];
    [_protocolButton setEnabled:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _registerButton.layer.cornerRadius = _registerButton.frame.size.height/2.0;
    [username becomeFirstResponder];
    _indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(100, 0, 30, 30)];
    [_registerButton addSubview:_indicatorView];
    
    
    username.text = @"15652285555";
    password.text = @"111111";
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
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


@end
