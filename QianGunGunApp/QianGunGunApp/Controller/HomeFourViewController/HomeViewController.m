//
//  HomeViewController.m
//  QianGunGun
//
//  Created by Heaven on 15-3-17.
//  Copyright (c) 2015年 Heaven_sun. All rights reserved.
//

#import "HomeViewController.h"
#import "ResourceViewController.h"
#import "LoginViewController.h"
#import "UMSocial.h"

@interface HomeViewController ()<UMSocialDataDelegate,UMSocialUIDelegate>

@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (self.view.frame.size.width == 320) {
        _btnHome.layer.cornerRadius = 105;
    }else if (self.view.frame.size.width == 375)
    {
        _btnHome.layer.cornerRadius = 130;
    }else{
        _btnHome.layer.cornerRadius = 150;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self homeGetUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)homeGetUI
{
    _btnHome.layer.borderWidth = 3.0;
    _btnHome.layer.borderColor = [UIColor grayColor].CGColor;
    _number.font = [UIFont systemFontOfSize:62.0f];
   
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
//分享
- (IBAction)umengShare:(UIButton *)sender {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:QIANGUNGUN_APPID
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                       delegate:self];
}
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

- (IBAction)btnBuy:(UIButton *)sender {
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}

@end
