//
//  StreamAPIConnection.h
//  Streaming
//
//  Created by admin on 8/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"
#import "ChannelInfo.h"
#import "GameType.h"
#import "UserInfo.h"
#import "BasicInfo.h"



@interface StreamAPIConnection : BaseService

-(void) loginWithGToken: (NSString*) gtoken completed: (requestServerHandler) completion;

-(void) getInfoWithToken: (NSString*) apiToken completed: (requestServerHandler) completion;

//String apiToken, int gameId, String title, String description, int isArchiving, int isMakeArchieve, int isLiveChat, int restriction

-(void) callStartStream: (NSString *) apiToken andGameID: (int) gameID andTitle: (NSString *) title andDescription: (NSString *) description completed: (requestServerHandler) completion;

-(void) callStopStream: (NSString *) apiToken completed: (requestServerHandler) completion;

+(ChannelInfo *) getChannelInfoFromJSON: (NSDictionary *) data ;

+(NSMutableArray *) getListGameFromJSON: (NSDictionary *) data ;

+(GameType *) getGameFromJSON: (NSDictionary *) data ;

+(UserInfo *) getUserInfoFromJSON: (NSDictionary *) data;


@end
