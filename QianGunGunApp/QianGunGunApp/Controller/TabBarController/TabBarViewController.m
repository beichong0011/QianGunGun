//
//  TabBarViewController.m
//  QianGunGunApp
//
//  Created by Heaven on 15-3-19.
//  Copyright (c) 2015年 Heaven_sun. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBarTintColor:[UIColor whiteColor]];
    [self addAllChildVcs];
}
-(void)addAllChildVcs
{
    _assetsVC = [[AssetsViewController alloc] initWithNibName:@"AssetsViewController" bundle:nil];
    _myaccountVC = [[MyAccountViewController alloc] initWithNibName:@"MyAccountViewController" bundle:nil];
//    _recommentVC = [[RecommendViewController alloc] initWithNibName:@"RecommendViewController" bundle:nil];
    _homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    _sortVC = [[SortViewController alloc] initWithNibName:@"SortViewController" bundle:nil];
    [self addOneChildVc:_homeVC title:@"精品推荐" imageName:@"tabbar_limitfree" selectedImageName:@""];
    [self addOneChildVc:_sortVC title:@"产品分类" imageName:@"tabbar_reduceprice" selectedImageName:@""];
    [self addOneChildVc:_assetsVC title:@"我的资产" imageName:@"tabbar_subject" selectedImageName:@""];
    [self addOneChildVc:_myaccountVC title:@"个人账户" imageName:@"tabbar_account" selectedImageName:@""];
   }
-(void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //设置标题
    childVc.title = title;

    //设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    //设置选中时的图标
    UIImage * selectedImage = [UIImage imageNamed:selectedImageName];
    if (iOS7) {
        //不渲染原图
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    //设置tabBarItem普通状态下文字的颜色
    NSMutableDictionary * textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    textAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:11];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置tabBarItem普通状态下文字的颜色
    NSMutableDictionary *selectedtextAttrs=[NSMutableDictionary dictionary];
    selectedtextAttrs[NSForegroundColorAttributeName]= RGBA(0, 100, 255, 1);
    [childVc.tabBarItem setTitleTextAttributes:selectedtextAttrs forState:UIControlStateSelected];

    childVc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 0);

    UINavigationController  * nav = [[UINavigationController
                                      alloc]initWithRootViewController:childVc];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        UIView *iew = [[UIView alloc]init];
    nav.navigationItem.titleView =iew;
    iew.backgroundColor = [UIColor blackColor];

    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar_black"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    
    [self addChildViewController:nav];
//    NSLog(@"%@",self.viewControllers);
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
