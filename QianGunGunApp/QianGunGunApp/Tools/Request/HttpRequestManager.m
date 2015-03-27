//
//  HttpRequestManager.m
//  Genvana
//
//  Created by adinnet on 14-5-14.
//  Copyright (c) 2014年 Panda. All rights reserved.
//

#import "HttpRequestManager.h"
//#import "Reachability.h"
@implementation HttpRequestManager
@synthesize str;
@synthesize delegate;
static HttpRequestManager *shareHttpRequestManagerFunction = nil;
+ (HttpRequestManager *)shareInstance
{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        shareHttpRequestManagerFunction = [[HttpRequestManager alloc] init];
    });
    return shareHttpRequestManagerFunction;
}
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)cancelOperation{
    [manager.operationQueue cancelAllOperations];
}

-(NSString *)processParsedObject:(NSDictionary *)dict
{
    NSString *returnStr = [[NSString alloc] init];
    for (NSString *keyStr in dict) {
       
        id value = [dict objectForKey:keyStr];
        if ([value isKindOfClass:[NSString class]]) {
            returnStr = [returnStr stringByAppendingString:[NSString stringWithFormat:@"<%@>%@</%@>",keyStr,[dict objectForKey:keyStr],keyStr]];
        }else if([value isKindOfClass:[NSDictionary class]]){
            returnStr = [returnStr stringByAppendingString:[NSString stringWithFormat:@"<%@>",keyStr]];
            NSDictionary* newDict = (NSDictionary*)value;
            NSString * resultstr = [self processParsedObject:newDict];
            returnStr = [returnStr stringByAppendingString:[NSString stringWithFormat:@"%@",resultstr]];
            returnStr = [returnStr stringByAppendingString:[NSString stringWithFormat:@"</%@>",keyStr]];
        }
    }
    
    return returnStr;
}

- (void)addPOSTRequestParameters:(NSDictionary *)parameters
                         success:(void (^)(id))success
                            fail:(void (^)(id))fail{
    NSLog(BaseHostAddress,nil);
    [manager POST:BaseHostAddress parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog([[NSThread currentThread] description],nil);
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

- (void)addGETRequestParameters:(NSDictionary *)parameters
                        success:(void (^)(id))success
                           fail:(void (^)(id))fail{
    [manager GET:BaseHostAddress parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

- (void)addGETRequestURLString:(NSString *)URLString
                    Parameters:(NSDictionary *)parameters
                       success:(void (^)(id))success
                          fail:(void (^)(id))fail{
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}
- (void)addGETRequestURLString:(NSString *)baseUrlString
                  methodString:(NSString *)methodUrlString
                    Parameters:(NSDictionary *)parameters
                       success:(void (^)(id))success
                          fail:(void (^)(id))fail{
    baseUrlString = [baseUrlString stringByAppendingString:@"/"];
    if (manager == nil) {
        manager = [AFHTTPRequestOperationManager manager];
    }
    NSString *absolutelyStr = [baseUrlString stringByAppendingString:methodUrlString];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
//    manager.responseSerializer=[AFJSONResponseSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
 manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg",@"image/png",@"text/plain",@"application/json",nil];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:absolutelyStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}
- (void)addPOSTRequestURLString:(NSString *)baseUrlString
                   methodString:(NSString *)methodUrlString
                     Parameters:(NSDictionary *)parameters
                        success:(void (^)(id))success
                           fail:(void (^)(id))fail{
//    baseUrlString = [baseUrlString stringByAppendingString:@"/"];
//    NSString *absolutelyStr = [baseUrlString stringByAppendingString:methodUrlString];
//     manager.requestSerializer=[AFJSONRequestSerializer serializer];
//    if (manager == nil) {
//        manager = [AFHTTPRequestOperationManager manager];
//    }
//    manager.requestSerializer.timeoutInterval = 10;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg",@"image/png",@"text/plain",@"application/json",nil];
    
    
    baseUrlString = [baseUrlString stringByAppendingString:@"/"];
    if (manager == nil) {
        manager = [AFHTTPRequestOperationManager manager];
    }
    NSString *absolutelyStr = [baseUrlString stringByAppendingString:methodUrlString];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
     manager.requestSerializer.timeoutInterval = 10;
    //    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    //    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg",@"image/png",@"text/plain",@"application/json",nil];

    
    
    [manager POST:absolutelyStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        

        if (fail) {
            fail(error);
        }
    }];
}

@end
