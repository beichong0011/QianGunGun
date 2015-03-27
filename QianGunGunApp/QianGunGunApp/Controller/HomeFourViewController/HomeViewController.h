//
//  HomeViewController.h
//  QianGunGun
//
//  Created by Heaven on 15-3-17.
//  Copyright (c) 2015年 Heaven_sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnHome;
@property (weak, nonatomic) IBOutlet UILabel *number;
- (IBAction)btnBuy:(UIButton *)sender;

@end
