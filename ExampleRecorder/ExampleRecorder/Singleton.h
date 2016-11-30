//
//  Singleton.h
//  Streaming
//
//  Created by admin on 8/25/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "MBProgressHUD.h"
#import "UserInfo.h"
#import "BasicInfo.h"

@interface Singleton : NSObject
{
    NSUInteger _loadingCount;
}

@property (nonatomic, strong) MBProgressHUD *loadingView;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) UserInfo *userInfo;
@property (nonatomic, strong) BasicInfo *basicInfo;

+ (instancetype)shareInstance;
- (void)destory;
- (void)startLoading;
- (void)startLoadingInView:(UIView *)view;
- (void)stopLoading;
@end
