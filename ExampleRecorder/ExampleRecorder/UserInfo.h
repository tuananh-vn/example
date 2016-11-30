//
//  UserInfo.h
//  Streaming
//
//  Created by admin on 8/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject


@property(nonatomic) NSString* apiToken;
@property(nonatomic) NSString* gToken;
@property(nonatomic) BOOL hasJustLogin;

@end
