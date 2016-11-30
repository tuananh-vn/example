//
//  GameType.h
//  Streaming
//
//  Created by admin on 8/24/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameType : NSObject

//private int gameID;
//private String gameName;
//private String gameThumb;
//private String gameType;
//private String gameSlug;

@property(nonatomic) int gameID;
@property(nonatomic) NSString* gameName;
@property(nonatomic) NSString* gameThumb;
@property(nonatomic) NSString* gameType;
@property(nonatomic) NSString* gameSlug;

@end
