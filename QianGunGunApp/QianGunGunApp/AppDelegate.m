//
//  AppDelegate.m
//  QianGunGunApp
//
//  Created by Heaven on 15-3-19.
//  Copyright (c) 2015年 Heaven_sun. All rights reserved.
//

#import "AppDelegate.h"
#import "AssetsViewController.h"
#import "MyAccountViewController.h"
#import "SortViewController.h"
#import "TabBarViewController.h"
#import "HttpRequestManager.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "UMSocial.h"
#import "APService.h"
@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //umeng分享
    [self UmengShera];
    //JPSH推送
    [self JPush];
    //版本检查更新
    [self CheckUpdate];
    _tabbar= [[TabBarViewController alloc] init];
    self.window.rootViewController = _tabbar;
    return YES;
}

- (void)CheckUpdate
{
    NSInteger num = 1;
    NSString *strID = @"";
    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/search?term=%@",strID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"返回关注信息:%@",responseObject);
//        NSDictionary *dic = (NSDictionary *)responseObject;
//        NSString *latestVersion = [dic objectForKey:@"version"];
        if (num == 1) {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"检查更新" message:@"有新的版本更新" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
            [aler show];
        }else
        {
            return ;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)UmengShera
{
    [UMSocialData setAppKey:QIANGUNGUN_APPID];
}
- (void)JPush
{
    [self jPushSetupWithOptions:nil];
}
- (void)jPushSetupWithOptions:(NSDictionary *)launchOptions
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com"];
        [[UIApplication sharedApplication]openURL:url];
    };
}
#pragma mark - Token获取
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [APService registerDeviceToken:deviceToken];
}
#pragma mark - 接受到消息推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
