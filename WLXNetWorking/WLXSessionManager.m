//
//  WLXSessionManager.m
//  WLXNetWorking
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Bangyang. All rights reserved.
//

#import "WLXSessionManager.h"
//超时时间
static int const DEFAULT_REQUEST_TIME_OUT = 20;
@implementation WLXSessionManager

static WLXSessionManager * shareInstance = nil;
+ (WLXSessionManager *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    if(shareInstance == nil){
        shareInstance = [super allocWithZone:zone];
    }
    return shareInstance;
}

//拷贝方法
- (id)copyWithZone:(NSZone *)zone{
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化一些必须参数,根据实际情况去设置
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [[self requestSerializer] setTimeoutInterval:DEFAULT_REQUEST_TIME_OUT];
    }
    return self;
}




@end
