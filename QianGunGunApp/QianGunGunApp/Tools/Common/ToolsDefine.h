//
//  ToolsDefine.h
//  QianGunGunApp
//
//  Created by Heaven on 15-3-25.
//  Copyright (c) 2015年 Heaven_sun. All rights reserved.
//

//umeng分享钱滚滚APPID
#define QIANGUNGUN_APPID @"551221e4fd98c56fc6000089"
//JPshAPPKEY
#define JPhshAPPKEY @"a93e67ccd679eb8bed7d0e44"
//版本
#define iOS8                                ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define iOS7                                ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) //&& ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0))
//常用宏定义
#define D_Color_Secondary                   RGBA(102,102,102,1)
#define D_Color_Yellow                      RGBA(255,200,20,1)
#define D_Font_Info                       [UIFont systemFontOfSize:14.f]
#define D_Font_Hint                       [UIFont systemFontOfSize:12.f]
//颜色自定义
#define RGBA(r,g,b,a)						[UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
//版本检测
#define APP_URL    @"http://itunes.apple.com/lookup?id=662004496"
//获取系统窗口宽高
#define SCREEN_WIDTH                        [[UIScreen mainScreen] applicationFrame].size.width
#define SCREEN_HEIGHT                       [[UIScreen mainScreen] applicationFrame].size.height