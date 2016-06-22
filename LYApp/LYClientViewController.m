//
//  LYClientViewController.m
//  LYApp
//
//  Created by lichanghong on 16/6/20.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYClientViewController.h"
#import "QiGuaAlertView.h"

@interface LYClientViewController () <UIAlertViewDelegate>

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
    BOOL _isWoman;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isWoman = false;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired =1;
    [self.view addGestureRecognizer: tap];
    _qiguaAlertView = [QiGuaAlertView createView];
     // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)handleAction:(id)sender {
    if ([sender isKindOfClass: [UIGestureRecognizer class]]) {
        [self.view endEditing:YES];
    }
    else if ([sender isKindOfClass: [UISegmentedControl class]]) {
        if (_segmentControl.selectedSegmentIndex == 0) {
            _isWoman = false;
        }
        else _isWoman = true;
    }
    else if ([sender isKindOfClass: [UIButton class]]) {
        if (sender == startButton) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"请确认起卦时间是正确的" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
       else if(sender == helpButton)
       {
           
       }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [_qiguaAlertView showInView:self.view];
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
