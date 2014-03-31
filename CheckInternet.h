//
//  CheckInternet.h
//  CheckNetworkStatus
//
//  Created by Xchobo on 2014/3/31.
//  Copyright (c) 2014年 Xchobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface CheckInternet : NSObject

// 檢查狀態：無網路、3G、Wifi
@property (nonatomic) Reachability *internetReachability;

- (int) networkCheck;
@end
