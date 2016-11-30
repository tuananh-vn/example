//
//  AppDelegate.m
//  ExampleRecorder
//
//  Created by Alan Skipp on 23/04/2014.
//  Copyright (c) 2014 Alan Skipp. All rights reserved.
//

#import "AppDelegate.h"
#import <ReplayKit/ReplayKit.h>
#import "GCVETVLibManager.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    NSLog(@"Screen rect:%@", NSStringFromCGRect(rect));
//
//    _session = [[VEDRTMPSession alloc] initWithVideoSize:rect.size frameRate:30 bitrate:1000000 useInterfaceOrientation:YES];
    [GCVETVLibManagerShare showOpenWindow];
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) toogleSession {
    switch(_session.rtmpSessionState) {
        case VCSessionStateNone:
        case VCSessionStatePreviewStarted:
        case VCSessionStateEnded:
        case VCSessionStateError:
            [_session startRtmpSessionWithURL:@"rtmp://113.171.255.130/stream/" andStreamKey:@"36e2f46e585b603e90fed28a3c8f65ec"];
            
            //            [_session startRtmpSessionWithURL:@"rtmp://125.212.194.16/stream/" andStreamKey:@"abc123"];
            break;
        default:
            [_session endRtmpSession];
            break;
    }
}

-(void) pushBuffer: (CVPixelBufferRef) pixelBufferRef {
    [_session pushBuffer:pixelBufferRef];
}
-(void) pushContext: (CGContextRef*) contextRef {
    [_session pushImageContext: contextRef];
}

-(void) pushImage: (UIImage*) image {
    [_session addPixelBufferSource:image withRect:[[UIScreen mainScreen] bounds]];
}
-(void) pushRefSource: (CGImageRef) ref{
    [_session addPixelBufferRefSource:ref withRect:[[UIScreen mainScreen] bounds]];
}
@end
