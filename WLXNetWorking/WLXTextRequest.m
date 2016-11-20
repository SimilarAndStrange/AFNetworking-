//
//  WLXTextRequest.m
//  WLXNetWorking
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Bangyang. All rights reserved.
//

#import "WLXTextRequest.h"

@implementation WLXTextRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.url = @"/rent/goods/list";
    }
    return self;
}

#pragma mark - 基本设置
- (RequestMethod)getRequestMethod
{
    return RequestMethodPOST;
}

- (RequestType)getRequestType
{
    return RequestTypeOrdinary;
}

@end
