//
//  ResourceViewController.m
//  QianGunGunApp
//
//  Created by Heaven on 15-3-21.
//  Copyright (c) 2015年 Heaven_sun. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginPasswordViewController.h"
#import "RegisteredViewController.h"
#import "Utility+Encrypt.h"
//#import "Utility.h"
@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = NO;
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customUI];
}
- (void)customUI
{
    _phoneTextFile.delegate = self;
    self.title = @"手机号";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_returnBtn];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phoneTextFile resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionBtn:(UIButton *)sender {
    if (self.phoneTextFile.text.length < 11) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"手机号无效" message:@"请输入正确的11位手机号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    if (![Utility isPhoneNumber:_phoneTextFile.text]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"手机号无效" message:@"请输入正确的11位手机号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.tag = 1003;
        [alert show];
        return;
    }else{
        int num = arc4random()%2;
        if (num == 0) {
            LoginPasswordViewController *passwordVC = [[LoginPasswordViewController alloc] initWithNibName:@"LoginPasswordViewController" bundle:nil];
            [self.navigationController pushViewController:passwordVC animated:YES];
        }else{
            RegisteredViewController *registeredVC = [[RegisteredViewController alloc] initWithNibName:@"RegisteredViewController" bundle:nil];
            [self.navigationController pushViewController:registeredVC animated:YES];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length == 11) {
//        UIAlertView *arrr = [[UIAlertView alloc] initWithTitle:@"您好" message:@"文字长度不能超过11位数哦" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [arrr show];
        return NO;
    }
    return YES;
}- (IBAction)returnbtn:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
