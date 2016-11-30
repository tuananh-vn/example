//
//  ChannelInfo.h
//  Streaming
//
//  Created by admin on 8/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelInfo : NSObject

//private String description = "description";
//private int isArchiving = 0;
//private int isMakeArhieve = 0;
//private int isLiveChat = 0;
//private int restriction = 0;
//
//private String ownerName;
//private String ownerAva;
//private String streamServer;
//private String streamKey;
//private String streamApp

@property(nonatomic) NSString* channelOwnerName;
@property(nonatomic) NSString* channelOwnerAva;

@property(nonatomic) NSString* channelTitle;
@property(nonatomic) NSString* channelDescription;
@property(nonatomic) int channelGameID;


@property(nonatomic) NSString* streamUrl;
@property(nonatomic) NSString* streamServer;
@property(nonatomic) NSString* streamKey;
@property(nonatomic) NSString* streamApp;
@property(nonatomic) int streamPort;

@property(nonatomic) int channelArchiving;
@property(nonatomic) int channelLiveChat;
@property(nonatomic) int channelRestriction;

@end
