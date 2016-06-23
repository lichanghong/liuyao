//
//  LYProtocalViewController.m
//  LYApp
//
//  Created by lichanghong on 16/6/23.
//  Copyright © 2016年 lichanghong. All rights reserved.
//

#import "LYProtocalViewController.h"

@interface LYProtocalViewController ()


@end

@implementation LYProtocalViewController
{
    __weak IBOutlet UIButton *_backButton;

    __weak IBOutlet UITextView *textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *txtPath = [mainBundle pathForResource:@"protocal" ofType:@"txt"];
    NSString * content = [[NSString alloc] initWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
    [textView setText:content];

}

- (IBAction)handleAction:(id)sender {
    if (sender == _backButton) {
        [self dismissViewControllerAnimated:YES completion:nil];
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
