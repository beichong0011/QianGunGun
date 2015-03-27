//
//  PNC_KeyboardView.h
//  BankKeyboardIphone_2
//
//  Created by WangDaLei on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  此类用于iphone客户端

#import <UIKit/UIKit.h>
#import "ProjectUtil.h"

@protocol PNC_KeyboardViewDelegate;

@interface PNC_KeyboardView : UIView <UIActionSheetDelegate> {
    
//    id<PNC_KeyboardViewDelegate>delegate;   //代理
//    NSInteger maxLength;                    //最大长度
//    WDL_KeyboardTypeEnum keyboardType;      //键盘类型
//    NSMutableArray *numArray;               //数字数字
//    NSMutableArray *charArray;              //小写字母数字
//    NSMutableArray *upperCharArray;         //大写字母数字
//    UIToolbar *topToolBar;                  //控件
//    NSTimer *_timer;                        //定时器
//    // yk update mask
////@private
//    NSString *_maskValue;                    //密码键盘显示值
//    BOOL _secure;                            //是否为密码键盘
}


@property (nonatomic, retain) id<PNC_KeyboardViewDelegate> delegate;
@property (nonatomic, assign) NSInteger maxLength;
@property (nonatomic, assign) WDL_KeyboardTypeEnum keyboardType;
@property (nonatomic, strong) NSMutableArray *numArray;
@property (nonatomic, strong) NSMutableArray *charArray;
@property (nonatomic, strong) NSMutableArray *upperCharArray;
@property (nonatomic, strong) UIToolbar *topToolBar;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *keyboardValue;
@property (nonatomic, strong) UITextField *defaultTextField;
@property(nonatomic,strong) NSTimer *clickTimer;
@property(nonatomic)         BOOL isDoubleClick;
@property(nonatomic)         BOOL toolBarHidden;
@property(nonatomic,assign) BOOL secure;
@property(nonatomic,assign) NSInteger oldLength;
// yk update mask
@property (nonatomic, copy) NSString *maskValue;
@property(nonatomic) CGFloat topHeight;
@property(nonatomic,getter = isShow) BOOL show;
@property(nonatomic,strong) UIViewController *showViewController;
@property(nonatomic,strong) UIActionSheet *actionSheet;
@property(nonatomic) BOOL isUseActionSheet;



//初始化当前键盘，参数说明：
//frame：初始化大小，传CGRectZero，
//boolNumKeyboardOnly：是数字键盘还是全键盘，YES（数字键盘），NO（全键盘）
//boolRandom：键盘是否随机显示，YES（随机显示），NO（按正常显示）
//boolSecure：文本是否以密码形式显示，YES（密码文本），NO（普通文本）
- (id)initWithFrame:(CGRect)frame isNumKeyboardOnly:(BOOL)boolNumKeyboardOnly isRandom:(BOOL)boolRandom isSecure:(BOOL)boolSecure showToolBar:(BOOL)showToolBar;

//- (void)showKeyboardType:(WDL_KeyboardTypeEnum)type;
- (void)showInViewController:(UIViewController *)viewController;
- (void)hiddenMyself;

//一般键盘
-(IBAction)keyPress:(id)sender;

//更改键盘类型
-(void)changeKeyboardType;

//开始执行删除
-(IBAction)delKeyPressBegin:(id)sender;

//结束执行删除
-(IBAction)delKeyPressEnd:(id)sender;

//删除文本值
-(void)delTextValue;

//调换数组的顺序
-(void)exchangeValueKeyboardType:(WDL_KeyboardTypeEnum)kType indexA:(int)a indexB:(int)b;

@end

@protocol PNC_KeyboardViewDelegate <NSObject>

@optional
-(void)pncKeyboardViewCanceled:(PNC_KeyboardView*)keyboardView;
-(void)pncKeyboardViewDone:(PNC_KeyboardView*)keyboardView value:(NSString *)value;

@required
// yk update
-(void)pncKeyboardView:(PNC_KeyboardView*)keyboardView keyClickWithValue:(NSString *)value;
@end
