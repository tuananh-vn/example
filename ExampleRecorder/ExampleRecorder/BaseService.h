//
//  BaseService.h
//  MakeTodayGreat
//
//  Created by tunglinhvu on 7/8/16.
//  Copyright © 2016 tieudiep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface BaseService : NSObject

typedef void (^requestServerHandler) (NSString * msgError, id result);
- (void) httpGetWithService: (NSString *)service parameters: (id)param completed: (requestServerHandler)completion;
- (void) httpPostWithService: (NSString *)service parameters: (id)param completed: (requestServerHandler)completion;

@end
