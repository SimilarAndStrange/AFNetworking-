//
//  WLXRequestBase.h
//  WLXNetWorking
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Bangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLXRequestBase : NSObject

typedef NS_ENUM(NSUInteger, RequestMethod) {
    RequestMethodGET,
    RequestMethodPOST
};

typedef NS_ENUM(NSUInteger, RequestType) {
    RequestTypeOrdinary,
    RequestTypeImage
};


@property(nonatomic, copy) NSString * url;    //请求的地址
@property (nonatomic, strong) NSMutableDictionary * baseParams;    //请求的公共参数

//请求
+ (NSURLSessionDataTask *)requestDataWithParams:(NSDictionary *)params
                                        success:(void(^)(NSURLSessionDataTask * task,id responeObject))success
                                        failure:(void(^)(NSURLSessionDataTask * task, NSError * error))failure;

@end
