//
//  LoginPasswordViewController.m
//  QianGunGunApp
//
//  Created by Heaven on 15-3-23.
//  Copyright (c) 2015年 Heaven_sun. All rights reserved.
//

#import "LoginPasswordViewController.h"

@interface LoginPasswordViewController ()

@end

@implementation LoginPasswordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)customUI{
    self.title = @"登录";
//    self.paswordTextFlid.secureTextEntry = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_returnBtn];
    [self customKeyboard];
}
//自定义键盘
- (void)customKeyboard
{
    _keyBoardView = [[PNC_KeyboardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260) isNumKeyboardOnly:NO isRandom:YES isSecure:YES showToolBar:YES];
    self.keyBoardView.delegate = self;
    self.keyBoardView.keyboardValue = @"";
    self.keyBoardView.maxLength = 12;
    self.keyBoardView.defaultTextField = _paswordTextFlid;
    _paswordTextFlid.inputView = self.keyBoardView;
}
- (void)pncKeyboardView:(PNC_KeyboardView *)keyboardView keyClickWithValue:(NSString *)value{
    if (keyboardView.secure == NO) {
        _paswordTextFlid.secureTextEntry = NO;
    }else{
        _paswordTextFlid.secureTextEntry = YES;
    }
    self.password = keyboardView.keyboardValue;
    self.paswordTextFlid.text = self.password;
    [keyboardView.defaultTextField setText:value];
//    if (keyboardView.defaultTextField == _paswordTextFlid) {
//        self.password = keyboardView.keyboardValue;
//    }
//    [keyboardView.defaultTextField setText:value];
//    _paswordTextFlid.text = [ProjectUtil maskString:_paswordTextFlid.text];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//-(NSString *)password
//{
//    if (_password != nil)
//    {
//        return _password;
//    }
//    else
//    {
//        _password = @"";
//    }
//    
//    return _password;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
