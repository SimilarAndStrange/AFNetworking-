//
//  NSObject+WLXError.m
//  WLXNetWorking
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 Bangyang. All rights reserved.
//

#import "NSObject+WLXError.h"
#define APP_ERROR_HANDLE_NOTIFICATION @"app_error_handle_notification"

@implementation NSObject (WLXError)

+ (instancetype)serverErrorWithCode:(NSInteger)code andMsg:(NSString *)msg {
    NSDictionary *userInfo = [NSDictionary dictionary];
    if (!msg) {
        msg = @"服务器请求出错，请稍后再试！";
    }
    userInfo = @{@"error_msg" : msg};
    
    return [NSError errorWithDomain:@"" code:code userInfo:userInfo];
}

//在appdelegate注册通知，然后接收错误消息就好了。
- (void)toHandle {
    [[NSNotificationCenter defaultCenter] postNotificationName:APP_ERROR_HANDLE_NOTIFICATION object:self];
}

@end
