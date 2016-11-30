//
//  GCVETVLibManager.h
//  ExampleRecorder
//
//  Created by admin on 11/28/16.
//  Copyright © 2016 Alan Skipp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VEDRTMPSession.h"
#import "KINWebBrowserViewController.h"
#import "GCVETVStartController.h"
#import "HomeController.h"
#import "GCVETVButtonController.h"

#define GCVETVLibManagerShare ((GCVETVLibManager *)[GCVETVLibManager sharedManager])



@protocol GCVETVLibDelegate

-(void) openStream;
-(void) toogleStream;
-(void) logoutStream;

@end


@interface GCVETVLibManager : NSObject<GCVETVLibDelegate, KINWebBrowserDelegate, GCVETVStartDelegate, GCVETVHomeDelegate, GCVETVControlDelegate>
+ (id)sharedManager;
@property (nonatomic, retain) VEDRTMPSession * rtmpSession;
// start window layer
@property(nonatomic, strong) UIWindow *openWindow;
@property(nonatomic, strong) UIWindow *controlWindow;

@property(nonatomic, assign) CGRect buttonFrame;
@property(nonatomic, assign) CGRect controlFrame;

//@property(nonatomic, assign) CGSize screenSize;


-(void) toogleSession;

-(void) pushBuffer: (CVPixelBufferRef) pixelBufferRef ;

- (void) showOpenWindow;

- (void) showControlWindow ;

- (void) hideAllWindow ;

@end
