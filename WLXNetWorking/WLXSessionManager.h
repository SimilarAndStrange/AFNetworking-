//
//  WLXSessionManager.h
//  WLXNetWorking
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Bangyang. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface WLXSessionManager : AFHTTPSessionManager

+ (WLXSessionManager *)shareInstance;

@end
