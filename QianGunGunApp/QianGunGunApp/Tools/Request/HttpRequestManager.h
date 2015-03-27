//
//  HttpRequestManager.h
//  Genvana
//
//  Created by adinnet on 14-5-14.
//  Copyright (c) 2014年 Panda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//#define TestUrl    @"http://test.api.ppdai.com/lend"//线下
#define ServerUrl  @"http://saas.pydzm.com" //线上

#define BaseHostAddress                        ServerUrl
// 用户
#define LoginMethod                            @"login"//用户登录
#define CultureMainMethod                      @"api/article/getType"//
#define CultureInfoDetailMethod                @"api/article/getListByType"
#define WebViewMethod                           @"api/article/show"
#define ProductMainMethod                       @"api/product/getType"
#define SeachKeyMethod                          @"api/product/getTypeByKey"
#define SearchInfoListMethod                    @"api/product/getListByKey"
#define GetProductInoFromKetSearch              @"api/product/getListByKey"
#define GetProductInfoFromClassifyID            @"api/product/getListByType"
#define GetProductInfoFromProductID             @"api/product/show"
#define MemberLogin                             @"api/member/login"
#define AddSuggestion                           @"api/feedback/add"
#define Remindbook                              @"api/notepad/getNotepad"
#define deleteBook                              @"api/notepad/delNotepad"
#define addNoteBook                             @"api/notepad/addNotepad"
#define addAddressBook                          @"api/member/addMail"
#define addressbookList                         @"api/member/maillist"
#define BussinessCard                           @"api/member/mailOne"
#define FollowRemindBookList                    @"api/notepad/getFollowpad"
#define AddFollowNoteBook                       @"api/notepad/addFollowpad"
#define DeleteFollowBussinessBook               @"api/notepad/delFollowpad"
#define IndentListV                             @"api/order/memberOrderList"
#define IndentListMemberS                        @"api/order/orderlist"
#define HandleIndentss                          @"api/order/settingOrder"
#define PurchaseOrder                           @"api/order/add"
#define TaskFromVList                              @"api/task/getvTask"
#define MarkTaskFromV                           @"api/task/subvTask"
#define IndentDetailsss                         @"api/order/detail"
#define AddTaskFromVList                        @"api/task/getTask"
#define MemberTask                              @"api/task/subTask"
#define EditNoteBook                            @"api/notepad/editNotepad"
#define EdifFollowNoteBook                      @"api/notepad/editFollowpad"
#define PrePage                                 @"api/guide/getPic"
//#define GetCultureInfoListFromIndentID          @"api/article/getListByType"


@protocol HttpRequestDelegate <NSObject>
-(void)httpRequestSucessed:(NSString *)result;
-(void)httpRequestFailed:(NSError *)error;
@end


@interface HttpRequestManager : NSObject{
    AFHTTPRequestOperationManager *manager;

}
@property(strong,nonatomic)NSString *str;
@property(strong, nonatomic)id<HttpRequestDelegate>delegate;

+(HttpRequestManager *)shareInstance;

-(void)cancelOperation;

- (void)addPOSTRequestParameters:(NSDictionary *)parameters
                         success:(void(^)(id successobject))success
                            fail:(void(^)(id failobject))fail;

- (void)addGETRequestParameters:(NSDictionary *)parameters
                        success:(void(^)(id successobject))success
                           fail:(void(^)(id failobject))fail;

- (void)addGETRequestURLString:(NSString *)URLString
                    Parameters:(NSDictionary *)parameters
                       success:(void (^)(id))success
                          fail:(void (^)(id))fail;

- (void)addGETRequestURLString:(NSString *)baseUrlString
                  methodString:(NSString *)methodUrlString
                    Parameters:(NSDictionary *)parameters
                       success:(void (^)(id))success
                          fail:(void (^)(id))fail;
- (void)addPOSTRequestURLString:(NSString *)baseUrlString
                   methodString:(NSString *)methodUrlString
                     Parameters:(NSDictionary *)parameters
                        success:(void (^)(id))success
                           fail:(void (^)(id))fail;
- (void)addPOSTRequestURLString:(NSString *)baseUrlString
                   methodString:(NSString *)methodUrlString
                     Parameters:(NSDictionary *)parameters
                      imageData:(NSData *)fileData
                       fileName:(NSString *)fileName
                        success:(void (^)(id))success
                           fail:(void (^)(id))fail;

@end
