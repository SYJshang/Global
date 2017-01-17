//
//  WBHttpTool.m
//  weibo
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 qingyun.com. All rights reserved.
//

#import "WBHttpTool.h"

@implementation WBHttpTool


+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //AFN请求成功的时候调用
                //先把请求成功之后要做的事情保存到这个代码块
                if (success) {
                    success(responseObject);
                }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (failure) {
                failure(error);
            }
        }
    }];
    
}




+ (void)Post:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    [mgr POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                if (success) {
                    success(responseObject);
                }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
                failure(error);
        }
        
    }];
    
}

@end
