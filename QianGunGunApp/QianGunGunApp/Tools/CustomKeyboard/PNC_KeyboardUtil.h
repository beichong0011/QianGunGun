//
//  PNC_KeyboardView.h
//  BankKeyboardIphone_2
//
//  Created by WangDaLei on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  公共常量

#import <Foundation/Foundation.h>
//位置、大小
#define WDL_KeyboardView_Frame CGRectMake(0, 0, 320, 260)


//字体
#define WDL_Num_FontSize 28
#define WDL_Char_FontSize 26
#define WDL_Small_FontSize 20

//字颜色
#define WDL_But_TextFontColor [UIColor colorWithRed:20./255. green:20./255. blue:20./255. alpha:1.0]
#define WDL_But_TextFontColor_Highlight [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]

//宽高
#define WDL_num_w 100
#define WDL_num_h 55
#define WDL_num_top 44
#define WDL_char_w 45
#define WDL_char_h 53
#define WDL_char_top 44

//图片
#define WDL_Comm_Default @"PNC_Comm_Default.png"
#define WDL_Comm_Highlight @"PNC_Comm_Highlight.png"
#define WDL_DelB_Default @"PNC_DelB_Default.png"
#define WDL_DelB_Highlight @"PNC_DelB_Highlight.png"
#define WDL_DelS_Default @"PNC_DelS_Default.png"
#define WDL_DelS_Highlight @"PNC_DelS_Highlight.png"

typedef enum{
	WDL_KeyboardTypeNumPad = 0,             //字母键盘
	WDL_KeyboardTypeCharPad = 1,            //小写键盘
	WDL_KeyboardTypeUpperCharPad = 2,       //大写键盘
}WDL_KeyboardTypeEnum;                      //键盘类型

@interface PNC_KeyboardUtil : NSObject

@end
