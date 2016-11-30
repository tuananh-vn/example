//
//  BaseService.m
//  MakeTodayGreat
//
//  Created by tunglinhvu on 7/8/16.
//  Copyright © 2016 tieudiep. All rights reserved.
//

#import "APIConfigure.h"
#import "BaseService.h"

@implementation BaseService
- (void)httpGetWithService:(NSString*)service parameters:(id)param completed:(requestServerHandler)completion
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@", BaseUrl, service] parameters:param
        progress:^(NSProgress* _Nonnull downloadProgress) {

        }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            NSLog(@"Request:%@", task.currentRequest);

            if (completion) {
                completion(nil, responseObject);
            }
        }
        failure:^(NSURLSessionDataTask* _Nonnull task, NSError* _Nonnull error) {
            NSLog(@"Request:%@", task.currentRequest);
            NSLog(@"Error:%@", error);

            if (completion) {
                completion(error.localizedDescription, nil);
            }

        }];
}

- (void)httpPostWithService:(NSString*)service parameters:(id)param completed:(requestServerHandler)completion
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:[NSString stringWithFormat:@"%@%@", BaseUrl, service] parameters:param progress:^(NSProgress* _Nonnull uploadProgress) {

    }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            NSLog(@"Request:%@", task.currentRequest);
            if (completion) {
                completion(nil, responseObject);
            }

        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
            NSLog(@"Request:%@", task.currentRequest);
            NSLog(@"Error:%@", error);
            if (completion) {
                completion(error.localizedDescription, nil);
            }
        }];
}
@end
