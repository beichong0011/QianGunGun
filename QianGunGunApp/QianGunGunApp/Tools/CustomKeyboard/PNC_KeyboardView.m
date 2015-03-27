//
//  PNC_KeyboardView.h
//  BankKeyboardIphone_2
//
//  Created by WangDaLei on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  此类用于iphone客户端

#import "PNC_KeyboardView.h"
//是否ios7运行环境
#ifndef isIOS7Later
#define isIOS7Later !([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] ==NSOrderedAscending)
#endif

// yk update mask
@interface PNC_KeyboardView ()

@property(nonatomic,strong) NSTimer *pressTimer;


@end

@implementation PNC_KeyboardView

-(void)dealloc {

}

- (void)setKeyboardValue:(NSString *)aKeyboardValue
{
    
    if (![_keyboardValue isEqualToString:aKeyboardValue]) {
        
        _keyboardValue = [aKeyboardValue copy];
    }
    
    if(_oldLength < _keyboardValue.length)
    {
        self.maskValue = [ProjectUtil  maskStringLast:_keyboardValue];
    }
    else
    {
        self.maskValue = [ProjectUtil maskString:_keyboardValue];
    }
    _oldLength = _keyboardValue.length;
}

#pragma mark -
#pragma mark timer

-(void)stopTimer{
    
    [self.timer invalidate];
	self.timer = nil;
    
	[self.pressTimer invalidate];
	self.pressTimer = nil;
}

#pragma mark -
#pragma mark body method

- (id)initWithFrame:(CGRect)frame isNumKeyboardOnly:(BOOL)boolNumKeyboardOnly isRandom:(BOOL)boolRandom isSecure:(BOOL)boolSecure showToolBar:(BOOL)showToolBar {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        
        NSString *actionTitle = isIOS7Later ? @"\n\n\n\n\n\n\n\n\n\n\n\n\n\n" : @"\n\n\n\n\n\n\n\n\n\n\n\n\n";
        
		self.actionSheet = [[UIActionSheet alloc] initWithTitle:actionTitle delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        
		CGFloat topHeight = showToolBar ? WDL_num_top : 5;
		CGFloat changeHeight = topHeight + 216;
		
		// 背景图片
		UIImage *bgImage = [UIImage imageNamed:@"num_bg.png"];
		UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height / 2)];
		bgImageView.image = bgImage;
		[self addSubview:bgImageView];
		
        //数字数字
        self.numArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",nil];
		
		//小写字母数组
        self.charArray = [[NSMutableArray alloc]initWithObjects:@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m",nil];
        
        //大写字母数组
        self.upperCharArray = [[NSMutableArray alloc]initWithObjects:@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",nil];
		if (boolRandom) {
			for (int i = 9; i >= 0; i --) {
				NSDate *date =  [[NSDate alloc] init];
				double randTime = [date timeIntervalSince1970];
				NSString *timeStr = [NSString stringWithFormat:@"%f",randTime];
				timeStr = [timeStr pathExtension];
				[self exchangeValueKeyboardType:WDL_KeyboardTypeNumPad indexA:i indexB:([timeStr intValue] % 10 )];
			}
		}
        
        _keyboardValue =@"";
		
		if (showToolBar) {
			CGRect topToolBarFrame = CGRectMake( 0, 0, self.frame.size.width, 44);

				UIView *toolView = [[UIView alloc] initWithFrame:topToolBarFrame];
				
				// 左边的取消按钮
				UIImage *cancelImage = [UIImage imageNamed:@"cancel.png"];
				UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(5, (topToolBarFrame.size.height - cancelImage.size.height / 2) / 2, cancelImage.size.width / 2, cancelImage.size.height / 2)];
				[cancelButton setBackgroundImage:cancelImage forState:UIControlStateNormal];
				[cancelButton setBackgroundImage:[UIImage imageNamed:@"cancel_s.png"] forState:UIControlStateHighlighted];
				[cancelButton addTarget:self action:@selector(CustomKeyboardViewDismiss) forControlEvents:UIControlEventTouchUpInside];
				[toolView addSubview:cancelButton];
				
				// 完成按钮
				UIImage *doneImage = [UIImage imageNamed:@"done.png"];
				UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(toolView.frame.size.width - doneImage.size.width / 2 - 5, (topToolBarFrame.size.height - doneImage.size.height / 2) / 2, doneImage.size.width / 2, doneImage.size.height / 2)];
				[doneButton setBackgroundImage:doneImage forState:UIControlStateNormal];
				[doneButton setBackgroundImage:[UIImage imageNamed:@"done_s.png"] forState:UIControlStateHighlighted];
				[doneButton addTarget:self action:@selector(CustomKeyboardViewSubmit) forControlEvents:UIControlEventTouchUpInside];
				[toolView addSubview:doneButton];
				
				[self addSubview:toolView];
		}
		
		UIImage *num_key = [[UIImage imageNamed:@"num_key.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
		UIImage *num_key_s = [[UIImage imageNamed:@"num_key_s.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        
        //数字键
        for (int i=0; i<12; i++) {
            float kx;
            float ky;
			int row = 3;
			int line = 4;
			float width = (num_key.size.width / 2) * self.frame.size.width / 320;
			float height = (num_key.size.height / 2) * self.frame.size.height / changeHeight;
			height = self.frame.size.height - topHeight < height * line ? (self.frame.size.height - topHeight) / line : height;
			float hSpace = (self.frame.size.width - width * row) / (row + 1);
			float vSpace = (self.frame.size.height - topHeight - height * line) / (line + 1);
            kx = hSpace + (i % row) * (width + hSpace);
            ky = topHeight + vSpace + (i / row) * (height + vSpace);
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            [bt setTag:(1000+i)];
            [bt setFrame:CGRectMake(kx, ky, width, height)];
            if (i == 9) {
                if (!boolNumKeyboardOnly) {
                    [bt setTitle:@"abc" forState:UIControlStateNormal];
                    [bt addTarget:self action:@selector(keyPress:) forControlEvents:UIControlEventTouchUpInside];
                    [bt.titleLabel setFont:[UIFont systemFontOfSize:WDL_Num_FontSize]];
                    [bt setTitleColor:WDL_But_TextFontColor forState:UIControlStateNormal];
                    [bt setTitleColor:WDL_But_TextFontColor_Highlight forState:UIControlStateHighlighted];
                }
				[bt setBackgroundImage:num_key forState:UIControlStateNormal];
				[bt setBackgroundImage:num_key_s forState:UIControlStateHighlighted];
                
            } else if (i == 11){
                
                [bt setTitle:@" " forState:UIControlStateNormal];
                [bt addTarget:self action:@selector(delKeyPressBegin:) forControlEvents:UIControlEventTouchDown];
                [bt addTarget:self action:@selector(delKeyPressEnd:) forControlEvents:UIControlEventTouchUpInside];
                [bt addTarget:self action:@selector(delKeyPressEnd:) forControlEvents:UIControlEventTouchUpOutside];
                [bt.titleLabel setFont:[UIFont systemFontOfSize:WDL_Num_FontSize]];
				[bt setTitleColor:WDL_But_TextFontColor forState:UIControlStateNormal];
				[bt setTitleColor:WDL_But_TextFontColor_Highlight forState:UIControlStateHighlighted];
				[bt setBackgroundImage:[UIImage imageNamed:@"num_delete.png"] forState:UIControlStateNormal];
				[bt setBackgroundImage:[UIImage imageNamed:@"num_delete_s.png"] forState:UIControlStateHighlighted];
                
            } else {
                
                if (i < 9) {
                    [bt setTitle:[self.numArray objectAtIndex:i] forState:UIControlStateNormal];
                } else {
                    [bt setTitle:[self.numArray objectAtIndex:(i-1)] forState:UIControlStateNormal];
                }
                [bt addTarget:self action:@selector(keyPress:) forControlEvents:UIControlEventTouchUpInside];
                [bt.titleLabel setFont:[UIFont systemFontOfSize:WDL_Num_FontSize]];
                [bt setTitleColor:WDL_But_TextFontColor forState:UIControlStateNormal];
                [bt setTitleColor:WDL_But_TextFontColor_Highlight forState:UIControlStateHighlighted];
				[bt setBackgroundImage:num_key forState:UIControlStateNormal];
				[bt setBackgroundImage:num_key_s forState:UIControlStateHighlighted];
                
            }
            [bt setHidden:NO];
            [self addSubview:bt];
        }
        UIImage *charKeyImage = [UIImage imageNamed:@"char_key.png"];
        UIImage *charKey_sImage = [UIImage imageNamed:@"char_key_s.png"];
        UIImage *char_capImage = [UIImage imageNamed:@"char_cap.png"];
        UIImage *char_cap_sImage = [UIImage imageNamed:@"char_cap_s.png"];
        UIImage *char_abcImage = [UIImage imageNamed:@"char_abc.png"];
        UIImage *char_abc_sImage = [UIImage imageNamed:@"char_abc_s.png"];
        UIImage *char_deleteImage = [UIImage imageNamed:@"char_delete.png"];
        UIImage *char_delete_sImage = [UIImage imageNamed:@"char_delete_s.png"];
		CGFloat lastX = (self.frame.size.width - char_capImage.size.width / 2 - char_abcImage.size.width / 2 - char_deleteImage.size.width/2) / 4;
        if (!boolNumKeyboardOnly) {
            //小写字母键
			int row = 10;
			int line = 4;
			float width = (charKeyImage.size.width / 2) * self.frame.size.width / 320;
			float height = (charKeyImage.size.height / 2) * self.frame.size.height / changeHeight;
			float hSpace = (self.frame.size.width - row * width) / (row + 1); // 水平上的空格
			float vSpace = (self.frame.size.height - topHeight - height * line) / (line + 1); // 竖直方向的空格
            for (int i=0; i<=28; i++) {
                UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
                [bt setTag:(2000+i)];
				if (i < 26) {
					float kx;
					int nowLine;
					if (i < 10) {
						row = 10;
						nowLine = 0;
						kx = hSpace + i * (width + hSpace);
					}
					else if (i >= 10 && i < 19) {
						row = 9;
						nowLine = 1;
						kx = hSpace + width / 2 + (i-10) * (width + hSpace);
					}
					else {
						row = 7;
						nowLine = 2;
						kx = hSpace + 3 * width / 2 + (i-19) * (width + hSpace);
					}
					float ky = topHeight + vSpace + nowLine * (height + vSpace);
					[bt setFrame:CGRectMake(kx, ky, width, height)];
					
					if (self.charArray.count > i) {
						[bt setTitle:[self.charArray objectAtIndex:i] forState:UIControlStateNormal];
					}
                    [bt addTarget:self action:@selector(keyPress:) forControlEvents:UIControlEventTouchUpInside];
                    [bt.titleLabel setFont:[UIFont systemFontOfSize:WDL_Small_FontSize]];
                    [bt setBackgroundImage:charKeyImage forState:UIControlStateNormal];
                    [bt setBackgroundImage:charKey_sImage forState:UIControlStateHighlighted];
                    [bt setTitleColor:WDL_But_TextFontColor forState:UIControlStateNormal];
                    [bt setTitleColor:WDL_But_TextFontColor_Highlight forState:UIControlStateHighlighted];
				}
                else if (i == 26) {
					float kx = lastX;
					float ky = topHeight + vSpace + 3 * (height + vSpace);
					[bt setFrame:CGRectMake(kx, ky, char_capImage.size.width / 2, height)];
                    [bt addTarget:self action:@selector(shiftTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
                    [bt.titleLabel setFont:[UIFont systemFontOfSize:WDL_Small_FontSize]];
                    [bt setBackgroundImage:char_capImage forState:UIControlStateNormal];
                    [bt setBackgroundImage:char_cap_sImage forState:UIControlStateHighlighted];
                    [bt setBackgroundImage:char_cap_sImage forState:UIControlStateSelected];
                }
				else if (i == 27){
					float kx = lastX + char_capImage.size.width / 2 + lastX;
					float ky = topHeight + vSpace + 3 * (height + vSpace);
					[bt setFrame:CGRectMake(kx, ky, char_abcImage.size.width/2, height)];
                    [bt setTitle:@"123" forState:UIControlStateNormal];
                    [bt addTarget:self action:@selector(keyPress:) forControlEvents:UIControlEventTouchUpInside];
                    [bt.titleLabel setFont:[UIFont systemFontOfSize:WDL_Small_FontSize]];
                    [bt setBackgroundImage:char_abcImage forState:UIControlStateNormal];
                    [bt setBackgroundImage:char_abc_sImage forState:UIControlStateHighlighted];
                    [bt setTitleColor:WDL_But_TextFontColor forState:UIControlStateNormal];
                    [bt setTitleColor:WDL_But_TextFontColor_Highlight forState:UIControlStateHighlighted];
                    
                }
				else if (i == 28){
					float kx = lastX + char_capImage.size.width / 2 + lastX + char_abcImage.size.width / 2 + lastX;
					float ky = topHeight + vSpace + 3 * (height + vSpace);
					[bt setFrame:CGRectMake(kx, ky, char_deleteImage.size.width/2, height)];
                    [bt addTarget:self action:@selector(delKeyPressBegin:) forControlEvents:UIControlEventTouchDown];
                    [bt addTarget:self action:@selector(delKeyPressEnd:) forControlEvents:UIControlEventTouchUpInside];
                    [bt addTarget:self action:@selector(delKeyPressEnd:) forControlEvents:UIControlEventTouchUpOutside];
                    [bt.titleLabel setFont:[UIFont systemFontOfSize:WDL_Small_FontSize]];
                    [bt setBackgroundImage:char_deleteImage forState:UIControlStateNormal];
                    [bt setBackgroundImage:char_delete_sImage forState:UIControlStateHighlighted];
                }
                [bt setHidden:YES];
                [self addSubview:bt];
            }
            
            //大写字母键
            for (int i=0; i<28; i++) {
                float kx ;
                float ky ;
                kx = 1 + i%7 * WDL_char_w + i%7;
                ky = topHeight + i/7 * WDL_char_h + i/7;
                UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
                [bt setTag:(3000+i)];
                [bt setFrame:CGRectMake(kx, ky, WDL_char_w, WDL_char_h)];
                if (i ==21) {
                    
                    [bt setTitle:@"123" forState:UIControlStateNormal];
                    [bt addTarget:self action:@selector(keyPress:) forControlEvents:UIControlEventTouchUpInside];
                    [bt.titleLabel setFont:[UIFont systemFontOfSize:WDL_Small_FontSize]];
                    [bt setBackgroundImage:[UIImage imageNamed:WDL_Comm_Highlight] forState:UIControlStateNormal];
                    [bt setBackgroundImage:[UIImage imageNamed:WDL_Comm_Default] forState:UIControlStateHighlighted];
                    [bt setTitleColor:WDL_But_TextFontColor_Highlight forState:UIControlStateNormal];
                    [bt setTitleColor:WDL_But_TextFontColor forState:UIControlStateHighlighted];
                    
                } else if (i == 27) {
                    
                    [bt setTitle:@" " forState:UIControlStateNormal];
                    [bt addTarget:self action:@selector(delKeyPressBegin:) forControlEvents:UIControlEventTouchDown];
                    [bt addTarget:self action:@selector(delKeyPressEnd:) forControlEvents:UIControlEventTouchUpInside];
                    [bt addTarget:self action:@selector(delKeyPressEnd:) forControlEvents:UIControlEventTouchUpOutside];
                    [bt.titleLabel setFont:[UIFont systemFontOfSize:WDL_Small_FontSize]];
                    [bt setBackgroundImage:[UIImage imageNamed:WDL_DelS_Default] forState:UIControlStateNormal];
                    [bt setBackgroundImage:[UIImage imageNamed:WDL_DelS_Highlight] forState:UIControlStateHighlighted];
                    [bt setTitleColor:WDL_But_TextFontColor_Highlight forState:UIControlStateNormal];
                    [bt setTitleColor:WDL_But_TextFontColor forState:UIControlStateHighlighted];
                    
                } else {
                    
                    if (i < 21) {
                        [bt setTitle:[self.upperCharArray objectAtIndex:i] forState:UIControlStateNormal];
                    } else {
                        [bt setTitle:[self.upperCharArray objectAtIndex:(i-1)] forState:UIControlStateNormal];
                    }
                    [bt addTarget:self action:@selector(keyPress:) forControlEvents:UIControlEventTouchUpInside];
                    [bt.titleLabel setFont:[UIFont systemFontOfSize:WDL_Char_FontSize]];
                    [bt setBackgroundImage:[UIImage imageNamed:WDL_Comm_Default] forState:UIControlStateNormal];
                    [bt setBackgroundImage:[UIImage imageNamed:WDL_Comm_Highlight] forState:UIControlStateHighlighted];
                    [bt setTitleColor:WDL_But_TextFontColor forState:UIControlStateNormal];
                    [bt setTitleColor:WDL_But_TextFontColor_Highlight forState:UIControlStateHighlighted];
                    
                }
                [bt setHidden:YES];
                [self addSubview:bt];
            }
        }
        
        _keyboardType = WDL_KeyboardTypeNumPad;
		self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.actionSheet addSubview:self];
        // yk update mask
        _maskValue = @"";
        _secure = boolSecure;
    }
    return self;
    
}

- (void)setKeyboardCapital:(BOOL)isCapital
{
	for (int i=0; i<=28; i++) {
		int oldButTag = (2000+i);
		UIButton *oldBut = (UIButton *)[self viewWithTag:oldButTag];
		
		if (oldButTag != (2000 + 26) && oldButTag != (2000 + 27) && oldButTag != (2000 + 28)) {
			NSString *title = [oldBut titleForState:UIControlStateNormal];
			if (title) {
				unichar asicc = [title characterAtIndex:0];
				if(asicc>='a'&&asicc<='z') {
					asicc=asicc-32;
				}
				else if(asicc>='A'&&asicc<='Z') {
					asicc=asicc+32;
				}
				NSString *changeTitle = [NSString stringWithCharacters:&asicc length:1];
				[oldBut setTitle:changeTitle forState:UIControlStateNormal];
			}
		}
	}
}

// 取消按钮
- (void)CustomKeyboardViewDismiss
{
	if (self.delegate && [self.delegate respondsToSelector:@selector(pncKeyboardViewCanceled:)]) {
		[self.delegate pncKeyboardViewCanceled:self];
	}
	[self hiddenMyself];
}

//确认按钮
-(void)CustomKeyboardViewSubmit{
	if (self.delegate && [self.delegate respondsToSelector:@selector(pncKeyboardViewDone:value:)]) {
		[self.delegate pncKeyboardViewDone:self value:self.keyboardValue];
	}
	[self hiddenMyself];
}

- (void)showInViewController:(UIViewController *)viewController
{
	if (self.isUseActionSheet) {
//		if (viewController.tabBarController) {
//			[self.actionSheet showFromTabBar:viewController.tabBarController.tabBar];
//		}
//		else {
			[self.actionSheet showInView:viewController.view.window];
//		}
	}
	else {
		if (!self.isShow) {
            int sub = 20;
            if(isIOS7Later)
            {//如果是ipad或iphone5以下的机型是ios7系统会少20像素，所以此处需要做一个判断。
//                CGRect tempcgrect = [UIScreen mainScreen].bounds;
//                if(tempcgrect.size.height == 480.f)
//                {
//                    sub = -50;
//                }
//                else
//                {
                sub = 0;
//                }
            }
            int inY=0;
            if(!isIOS7Later){
                inY=20;
            }
			[viewController.view.window addSubview:self];
			self.frame = CGRectMake(0, viewController.view.bounds.size.height-inY, self.frame.size.width, self.frame.size.height);
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:.3];
			
            self.frame = CGRectMake(0, viewController.view.bounds.size.height - self.frame.size.height + sub-inY, self.frame.size.width, self.frame.size.height);
			[UIView commitAnimations];
			self.show = YES;
			self.showViewController = viewController;
		}
	}
}

- (void)hiddenMyself
{
	if (self.isUseActionSheet) {
		[self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
	}
	else {
		if (self.isShow) {
			UIViewController *viewController = self.showViewController;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:.3];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(hiddenAnimationDidStop)];
			self.frame = CGRectMake(0, viewController.view.bounds.size.height, self.frame.size.width, self.frame.size.height);
			[UIView commitAnimations];
		}
		if (self.defaultTextField) {
			[self.defaultTextField resignFirstResponder];
		}
	}
}

- (void)hiddenAnimationDidStop
{
	[self removeFromSuperview];
	self.show = NO;
}

- (IBAction)shiftTouchUpInside:(id)sender
{
	[self setKeyboardCapital:YES]; // 设定为大写
	UIButton *button = (UIButton *)sender;
	[button setSelected:!button.selected];
}

//一般键盘
-(IBAction)keyPress:(id)sender{
    UIButton *butItem = (UIButton*)sender;
    NSString *butTitle = butItem.titleLabel.text;
    if ([butTitle isEqualToString:@"abc"] || [butTitle isEqualToString:@"ABC"] || [butTitle isEqualToString:@"123"]) {
        //更换当前键盘类型
        [self changeKeyboardType];
    } else {
        //更改当前文本值
		if (!_keyboardValue) {
			self.keyboardValue = @"";
		}
        if (_maxLength > 0) {
			if ([_keyboardValue isKindOfClass:[NSString class]]) {
				if ([_keyboardValue length] < _maxLength) {
					self.keyboardValue = [NSString stringWithFormat:@"%@%@",_keyboardValue,butTitle];
				}
			}
        }
		else {
            self.keyboardValue = [NSString stringWithFormat:@"%@%@",_keyboardValue,butTitle];
        }
		
        if (_secure) {
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(pncKeyboardView:keyClickWithValue:)]) {
                    [self.delegate pncKeyboardView:self keyClickWithValue:self.maskValue];
                }
            }
        }
        else{
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(pncKeyboardView:keyClickWithValue:)]) {
                    [self.delegate pncKeyboardView:self keyClickWithValue:_keyboardValue];
                }
            }
        }
    }
	//	if (!self.isDoubleClick) {
	//		[self setKeyboardCapital:NO];
	//	}
}

//开始执行删除
-(IBAction)delKeyPressBegin:(id)sender{
    //执行删除
    [self delTextValue];
    //开启Timer
	self.pressTimer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(startDelText) userInfo:nil repeats:NO];
}

- (void)startDelText
{
    //开启Timer
	self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(delTextValue) userInfo:nil repeats:YES];
}

//结束执行删除
-(IBAction)delKeyPressEnd:(id)sender{
    //停止Timer
    [self stopTimer];
}

//删除文本值
-(void)delTextValue{
	if (_keyboardValue.length > 0) {
		self.keyboardValue = [_keyboardValue substringToIndex:(_keyboardValue.length-1)];
        if (_secure) {
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(pncKeyboardView:keyClickWithValue:)]) {
                    [self.delegate pncKeyboardView:self keyClickWithValue:self.maskValue];
                }
            }
        }
        else{
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(pncKeyboardView:keyClickWithValue:)]) {
                    [self.delegate pncKeyboardView:self keyClickWithValue:_keyboardValue];
                }
            }
        }
	}
}

- (void)showKeyboardType:(WDL_KeyboardTypeEnum)type
{
	if (type == WDL_KeyboardTypeNumPad) {
		if (_keyboardType != WDL_KeyboardTypeNumPad) {
			[self changeKeyboardType];
		}
	}
}

//更改键盘类型
-(void)changeKeyboardType{
    if (_keyboardType == WDL_KeyboardTypeNumPad) {
        for (int i=0; i<12; i++) {
            int oldButTag = (1000+i);
            UIButton *oldBut = (UIButton *)[self viewWithTag:oldButTag];
            [oldBut setHidden:YES];
        }
        for (int i=0; i<=28; i++) {
            int oldButTag = (2000+i);
            UIButton *oldBut = (UIButton *)[self viewWithTag:oldButTag];
            [oldBut setHidden:NO];
        }
        _keyboardType = WDL_KeyboardTypeCharPad;
    }
	else if (_keyboardType == WDL_KeyboardTypeCharPad) {
        for (int i=0; i<=28; i++) {
            int oldButTag = (2000+i);
            UIButton *oldBut = (UIButton *)[self viewWithTag:oldButTag];
            [oldBut setHidden:YES];
        }
        for (int i=0; i<12; i++) {
            int oldButTag = (1000+i);
            UIButton *oldBut = (UIButton *)[self viewWithTag:oldButTag];
            [oldBut setHidden:NO];
        }
        _keyboardType = WDL_KeyboardTypeNumPad;
    }
	//	else if (keyboardType == WDL_KeyboardTypeUpperCharPad) {
	//        for (int i=0; i<=28; i++) {
	//            int oldButTag = (3000+i);
	//            UIButton *oldBut = (UIButton *)[self viewWithTag:oldButTag];
	//            [oldBut setHidden:YES];
	//        }
	//        for (int i=0; i<12; i++) {
	//            int oldButTag = (1000+i);
	//            UIButton *oldBut = (UIButton *)[self viewWithTag:oldButTag];
	//            [oldBut setHidden:NO];
	//        }
	//        keyboardType = WDL_KeyboardTypeNumPad;
	//    }
}

//调换数组的顺序
- (void)exchangeValueKeyboardType:(WDL_KeyboardTypeEnum)kType indexA:(int)a indexB:(int)b{
    if (kType == WDL_KeyboardTypeNumPad) {
        NSString *tempA = [_numArray objectAtIndex:a];
        NSString *tempB = [_numArray objectAtIndex:b];
        [_numArray replaceObjectAtIndex:a withObject:tempB];
        [_numArray replaceObjectAtIndex:b withObject:tempA];
    } else if (kType == WDL_KeyboardTypeCharPad) {
        NSString *tempA = [_charArray objectAtIndex:a];
        NSString *tempB = [_charArray objectAtIndex:b];
        [_charArray replaceObjectAtIndex:a withObject:tempB];
        [_charArray replaceObjectAtIndex:b withObject:tempA];
    } else if (kType == WDL_KeyboardTypeUpperCharPad) {
        NSString *tempA = [_upperCharArray objectAtIndex:a];
        NSString *tempB = [_upperCharArray objectAtIndex:b];
        [_upperCharArray replaceObjectAtIndex:a withObject:tempB];
        [_upperCharArray replaceObjectAtIndex:b withObject:tempA];
    }
}

@end
