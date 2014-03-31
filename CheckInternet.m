//
//  CheckInternet.m
//  CheckNetworkStatus
//
//  Created by Xchobo on 2014/3/31.
//  Copyright (c) 2014年 Xchobo. All rights reserved.
//

#import "CheckInternet.h"

@implementation CheckInternet

// 監測網路狀態改變時
- (void) reachabilityChanged:(NSNotification *)notification
{
	Reachability* curReach = [notification object];
	NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
	[self updateInterfaceWithReachability:curReach];
}

- (int)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString* statusString = @"";
    int statusValue = 0;
    
    switch (netStatus)
    {
        case NotReachable:        {
            statusString = NSLocalizedString(@"目前沒有網路", @"Text field text for access is not available");
            /*
             Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
             */
            connectionRequired = NO;
            statusValue = 0;
            break;
        }
            
        case ReachableViaWWAN:        {
            statusString = NSLocalizedString(@"偵測到 WWAN 行動網路", @"");
            statusValue = 1;
            break;
        }
        case ReachableViaWiFi:        {
            statusString= NSLocalizedString(@"偵測到 WiFi", @"");
            statusValue = 2;
            break;
        }
    }
    
    if (connectionRequired)
    {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, 轉換網路中", @"Concatenation of status string with connection requirement");
        statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    
    //
    NSLog(@"目前狀態 %@", statusString);
    return statusValue;
}

- (int) networkCheck{
    // 登錄通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    // 登錄網路元件
    _internetReachability = [Reachability reachabilityForInternetConnection];
	[_internetReachability startNotifier];
	int checkvalue = [self updateInterfaceWithReachability:_internetReachability];
    return checkvalue;
}


@end
