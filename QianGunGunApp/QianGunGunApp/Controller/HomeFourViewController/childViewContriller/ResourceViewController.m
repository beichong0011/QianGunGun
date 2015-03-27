//
//  ResourceViewController.m
//  QianGunGunApp
//
//  Created by Heaven on 15-3-21.
//  Copyright (c) 2015年 Heaven_sun. All rights reserved.
//

#import "ResourceViewController.h"

@interface ResourceViewController ()

@end

@implementation ResourceViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = NO;
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
