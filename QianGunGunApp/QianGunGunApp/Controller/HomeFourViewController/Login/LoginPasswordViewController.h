//
//  LoginPasswordViewController.h
//  QianGunGunApp
//
//  Created by Heaven on 15-3-23.
//  Copyright (c) 2015年 Heaven_sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNC_KeyboardView.h"

@interface LoginPasswordViewController : UIViewController<PNC_KeyboardViewDelegate>
@property (strong, nonatomic) PNC_KeyboardView *keyBoardView;
//密码预存
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) IBOutlet UIButton *returnBtn;
@property (weak, nonatomic) IBOutlet UITextField *paswordTextFlid;
-(NSString *)password;
@end
