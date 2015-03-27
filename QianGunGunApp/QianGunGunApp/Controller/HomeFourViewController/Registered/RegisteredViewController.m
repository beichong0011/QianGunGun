//
//  RegisteredViewController.m
//  QianGunGunApp
//
//  Created by Heaven on 15-3-23.
//  Copyright (c) 2015年 Heaven_sun. All rights reserved.
//

#import "RegisteredViewController.h"

@interface RegisteredViewController ()

@end

@implementation RegisteredViewController

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
- (void)customUI
{
    self.title = @"注册";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_returnBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)chooseBtn:(UIButton *)sender {
    if (_chooseBtn.selected == NO) {
        [_chooseBtn setSelected:YES];
    }else if (_chooseBtn.selected == YES){
        [_chooseBtn setSelected:NO];
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
