//
//  LYClientViewController.m
//  LYApp
//
//  Created by lichanghong on 16/6/20.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYClientViewController.h"
#import "QiGuaAlertView.h"

@interface LYClientViewController () 

@end

@implementation LYClientViewController
{
    QiGuaAlertView *_qiguaAlertView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    else
    [_qiguaAlertView showInView:self.view];
    
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
