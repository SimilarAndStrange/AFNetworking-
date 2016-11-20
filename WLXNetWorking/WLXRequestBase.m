//
//  WLXRequestBase.m
//  WLXNetWorking
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Bangyang. All rights reserved.
//

#import "WLXRequestBase.h"
#import "WLXSessionManager.h"

#define BaseUrl @""                   

@implementation WLXRequestBase

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.url = @"";
        //用来设置请求需要的公共的参数 例如：version devtoken session_id udid ...
        self.baseParams = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

#pragma mark - 拼接完整的url
- (NSString *)getcCompleteUrl
{
    //获取一个baseUrl 拼接之后成一个完整的返回 我随便宏定义一个url
    NSString * url = [NSString stringWithFormat:@"%@%@",BaseUrl,_url];
    return url;
}

#pragma mark - 基本设置  
//继承之后，这两个方法需要覆写
//请求的方式
- (RequestMethod)getRequestMethod
{
    return RequestMethodPOST;
}

//是否包含图片上传
- (RequestType)getRequestType
{
    return RequestTypeOrdinary;
}


#pragma mark - 组合参数
- (NSDictionary *)CombinationParams:(NSDictionary *)params
{
    [self.baseParams addEntriesFromDictionary:params];
    return self.baseParams;
}

#pragma mark - 发起请求
+ (NSURLSessionDataTask *)requestDataWithParams:(NSDictionary *)params
                                        success:(void(^)(NSURLSessionDataTask * task,id responeObject))success
                                        failure:(void(^)(NSURLSessionDataTask * task, NSError * error))failure
{
    WLXRequestBase * requestBase = [[self alloc] init];
    if (requestBase)
    {
        NSDictionary * allParams = [requestBase CombinationParams:params];
        if ([requestBase getRequestType] == RequestTypeOrdinary)
        {
            return [requestBase RequestParams:allParams success:success failure:failure];
        }
        else
        {
            return [requestBase RequestImageParams:allParams success:success failure:failure];
        }
    }
    return nil;
}


#pragma mark - Request no Image
- (NSURLSessionDataTask *)RequestParams:(NSDictionary *)params
                                success:(void(^)(NSURLSessionDataTask * task,id responeObject))success
                                failure:(void(^)(NSURLSessionDataTask * task, NSError * error))failure
{
    WLXSessionManager * manager = [WLXSessionManager shareInstance];
    if ([self getRequestMethod] == RequestMethodGET)
    {
        NSURLSessionDataTask * task = [manager GET:[self getcCompleteUrl] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(task,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //在这里可以对请求出错做统一的处理
            failure(task,error);
        }];
        return task;
    }
    else
    {
        NSURLSessionDataTask * task = [manager POST:[self getcCompleteUrl] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(task,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //在这里可以对请求出错做统一的处理
            failure(task,error);
        }];
        
        return task;
    }
}


#pragma mark - Request Image
- (NSURLSessionDataTask *)RequestImageParams:(NSDictionary *)params
                                     success:(void(^)(NSURLSessionDataTask * task,id responeObject))success
                                     failure:(void(^)(NSURLSessionDataTask * task,NSError * error))failure
{
    WLXSessionManager * manager = [WLXSessionManager shareInstance];
    NSURLSessionDataTask * task = [manager POST:[self getcCompleteUrl] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 构造body,告诉AF是什么类型文件
        for (NSString *key in params)
        {
            id value = params[key];
            if ([value isKindOfClass:[NSData class]])
            {
                [formData appendPartWithFileData:value name:key fileName:[NSString stringWithFormat:@"%@.jpg",key] mimeType:@"image/jpeg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //在这里可以对请求出错做统一的处理
        failure(task,error);
    }];
    return task;
}

@end
