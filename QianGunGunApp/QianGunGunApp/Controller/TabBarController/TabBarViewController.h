//
//  TabBarViewController.h
//  QianGunGunApp
//
//  Created by Heaven on 15-3-19.
//  Copyright (c) 2015年 Heaven_sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetsViewController.h"
#import "MyAccountViewController.h"
#import "SortViewController.h"
#import "HomeViewController.h"

@interface TabBarViewController : UITabBarController
@property (nonatomic, strong)AssetsViewController *assetsVC;
@property (nonatomic, strong)MyAccountViewController *myaccountVC;
@property (nonatomic, strong)SortViewController *sortVC;
@property (nonatomic, strong)HomeViewController *homeVC;
@end
