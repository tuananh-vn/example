//
//  StreamAPIConnection.m
//  Streaming
//
//  Created by admin on 8/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "StreamAPIConnection.h"

@implementation StreamAPIConnection


-(void) loginWithGToken: (NSString*) gtoken completed: (requestServerHandler) completion{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:gtoken forKey:@"access_token"];
    [self httpPostWithService:@"glogin" parameters:params completed:^(NSString *msgError, id result) {
        NSLog(@"%@", msgError);
        if (completion) {
            completion(msgError, result);
        }
    }];
    
}

-(void) getInfoWithToken: (NSString*) apiToken completed: (requestServerHandler) completion{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:apiToken forKey:@"api_token"];
    [self httpPostWithService:@"get" parameters:params completed:^(NSString *msgError, id result) {
        NSLog(@"%@", msgError);
        if (completion) {
            completion(msgError, result);
        }
    }];
}

//String apiToken, int gameId, String title, String description, int isArchiving, int isMakeArchieve, int isLiveChat, int restriction

-(void) callStartStream: (NSString *) apiToken andGameID: (int) gameID andTitle: (NSString *) title andDescription: (NSString *) description completed: (requestServerHandler) completion{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:apiToken forKey:@"api_token"];
    [self httpPostWithService:@"get" parameters:params completed:^(NSString *msgError, id result) {
        NSLog(@"%@", msgError);
        if (completion) {
            completion(msgError, result);
        }
    }];
}

-(void) callStopStream: (NSString *) apiToken completed: (requestServerHandler) completion{
    
}

/*
 parse data
 */

+(ChannelInfo *) getChannelInfoFromJSON: (NSDictionary *) data {
    ChannelInfo *item = [[ChannelInfo alloc] init];
    item.channelTitle = [data objectForKey:@"channel_name"];
    item.channelDescription = [data objectForKey:@"channel_description"];
    item.streamApp = [data objectForKey:@"stream_app"];
    item.streamKey = [data objectForKey:@"stream_key"];
    item.streamServer = [data objectForKey:@"stream_server"];
    item.streamUrl = [data objectForKey:@"public_url"];
    item.streamPort = 1935;
    item.channelGameID = 1;
    item.channelOwnerAva = [data objectForKey:@"icon"];
    
    item.channelOwnerName = [data objectForKey:@"name"];
    return item;
}

+(NSMutableArray *) getListGameFromJSON: (NSDictionary *) data {
    NSMutableArray * result = [[NSMutableArray alloc] init];
    NSArray * gameArray = [data objectForKey:@"game_list"];
    for(int i = 0; i < [gameArray count]; i++){
        NSDictionary *itemData = [gameArray objectAtIndex:i];
        GameType *item = [StreamAPIConnection getGameFromJSON:itemData];
        [result addObject:item];
    }
    return result;
}

+(GameType *) getGameFromJSON: (NSDictionary *) data {
    GameType * item = [[GameType alloc] init];
    item.gameID = [[data objectForKey:@"id"] intValue];
    item.gameName = [data objectForKey:@"name"];
    item.gameThumb = [data objectForKey:@"thumbnail"];
    item.gameSlug = [data objectForKey:@"slug"];
    item.gameType = [data objectForKey:@"type"];
    return item;
}

+(UserInfo *) getUserInfoFromJSON: (NSDictionary *) data {
    UserInfo *userInfo = [[UserInfo alloc] init];
    userInfo.apiToken = [data objectForKey:@"value"];
    return userInfo;
}

@end
