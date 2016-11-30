//
//  BasicInfo.h
//  Streaming
//
//  Created by admin on 8/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameType.h"
#import "ChannelInfo.h"


@interface BasicInfo : NSObject

@property(nonatomic) GameType * gameType;
@property(nonatomic) ChannelInfo * channelInfo;


@end
