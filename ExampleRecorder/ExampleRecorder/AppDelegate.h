//
//  AppDelegate.h
//  ExampleRecorder
//
//  Created by Alan Skipp on 23/04/2014.
//  Copyright (c) 2014 Alan Skipp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ReplayKit/ReplayKit.h>
#import "VEDRTMPSession.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, RPPreviewViewControllerDelegate, RPScreenRecorderDelegate>

@property (nonatomic, retain) VEDRTMPSession * session;
@property (strong, nonatomic) UIWindow *window;

-(void) toogleSession;
-(void) pushBuffer: (CVPixelBufferRef) pixelBufferRef;
-(void) pushContext: (CGContextRef*) contextRef;
-(void) pushImage: (UIImage*) image;
-(void) pushRefSource: (CGImageRef) ref;
@end
