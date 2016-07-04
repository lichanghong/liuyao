//
//  LYLoginViewController.m
//  LYApp
//
//  Created by lichanghong on 16/6/23.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYLoginViewController.h"
#import "HttpUtil.h"
#import "JingRoundView.h"

@interface LYLoginViewController ()<UIScrollViewDelegate,UIAlertViewDelegate>

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
    JingRoundView *roundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    baseW.constant = KScreenWidth+5;
    loginButton.layer.cornerRadius = loginButton.frame.size.height/2.0;
    [self startRotation:NO];
    
    
    username.text = @"15652285555";
    password.text = @"111111";
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([UserManager defaultManager].userid) {
        [self dismiss];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


- (IBAction)handleAction:(id)sender {
    [self.view endEditing:YES];

    if (sender == _backButton) {
        [self dismiss];
    }
    else if(sender == forgetPassword)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"忘记密码？" message:@"发短信/邮件给我们找回密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else if(sender == loginButton)
    {
        if ([self checkUsernameAndPwd]) {
            [self startLogin];
            [HttpUtil doLoginWithUsername:username.text PW:password.text success:^(id json) {
                [self endLogin];
                if (json) {
                    NSString *errorno = json[@"errno"];
                    if ([errorno intValue]==0) {
                        UserManager *manager= [UserManager defaultManager];
                        NSArray *datalist = json[@"data"];
                        if (datalist && datalist.count>0) {
                            NSDictionary *data = [datalist lastObject];
                            if (data) {
                                manager.userid = data[@"uid"];
                                manager.username = data[@"username"];
                                manager.gender = data[@"gender"];
                                manager.nickname = data[@"nickname"];
                                manager.blocked = data[@"blocked"];
                                BOOL archived = [UserManager archiveUserManager:manager];
                                if (!archived) {
                                    NSLog(@"archive usernanager fail for login");
                                }
                                [self dismiss];
                            }
                            else
                            {
                                NSLog(@"sfdasfasfasdf data nil ");
                                [LYToast showToast:@"服务器错误,请联系管理员(10090)"];
                            }
                        }
                        else
                        {
                            NSLog(@"sfdasfasfasdf datalist nil ");
                            [LYToast showToast:@"用户不存在！您是否已注册？"];
                        }
                    }
                    else
                    {
                        [LYToast showToast:json[@"errmsg"]];
                    }
                }
                else
                    NSLog(@"resultsdfsfdaaa = %@",json);

            } failure:^(NSString* errmsg) {
                [self endLogin];
                [LYToast showToast:errmsg];
            }];
        }
        else
        {
            [LYToast showToast:@"用户名密码格式错误"];
        }
    }
    else if(sender == registerButton)
    {
        [self showDetailViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LYRegisterViewController"] sender:self];

    }
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        if ([self validateMobile: username.text]) {
            NSString *smsstr = [NSString stringWithFormat:@"sms://18010476637"];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:smsstr]];
        }
        else if([self validateEmail:username.text])
        {
            NSString *url = @"mailto:haihong189@189.cn?subject=找回密码&body=我的邮箱是：手机号是：\n\n\n请填写您注册用的手机号或邮箱地址发给我们，以便确认。如果无法发送，请直接联系我们haihong189@189.cn";
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
        }
        else
        {
            NSLog(@"why?flajfsjfljllll.1900");
            [LYToast showToast:@"请填写您注册时的用户名再找回密码！"];
        }
    }
}

- (void)startLogin
{
    [roundView forcePlay];
    [self.view endEditing:YES];
    [username setEnabled:NO];
    [password setEnabled:NO];
    [forgetPassword setEnabled:NO];
    [registerButton setEnabled:NO];
    [loginButton setEnabled:NO];
    [_scrollView setScrollEnabled:NO];
}

- (void)endLogin
{
    [roundView pause];
    [self.view endEditing:YES];
    [username setEnabled:YES];
    [password setEnabled:YES];
    [forgetPassword setEnabled:YES];
    [registerButton setEnabled:YES];
    [loginButton setEnabled:YES];
    [_scrollView setScrollEnabled:YES];
}

-(void) startRotation:(bool)isplay
{
    roundView = [[JingRoundView alloc]initWithFrame:CGRectMake(KScreenWidth/2.0-46, 72, 100, 100)];
    roundView.roundImage = [UIImage imageNamed:@"qiguaBtn"];
    roundView.isPlay = isplay;
    [_scrollView addSubview:roundView];
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
