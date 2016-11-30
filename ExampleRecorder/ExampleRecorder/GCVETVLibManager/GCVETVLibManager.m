//
//  GCVETVLibManager.m
//  ExampleRecorder
//
//  Created by admin on 11/28/16.
//  Copyright © 2016 Alan Skipp. All rights reserved.
//

#import "GCVETVLibManager.h"
#import "ASScreenRecorder.h"
#import "APIConfigure.h"
#import "Singleton.h"
#import "StreamAPIConnection.h"
#import "AppUtils.h"

@interface GCVETVLibManager()
@property(nonatomic, strong) GCVETVStartController *startController;
@property(nonatomic, strong) GCVETVButtonController *controlController;
@property(nonatomic, strong) UINavigationController *webviewNavigation;
@property(nonatomic, strong) UINavigationController *homeNavigation;
//@property (nonatomic, strong) VEDRTMPSession * rtmpSession;
//// start window layer
//@property(nonatomic, strong) UIWindow *openWindow;
//@property(nonatomic, strong) UIWindow *controlWindow;
//
//
////@property(nonatomic, assign) CGSize screenSize;

@end

@implementation GCVETVLibManager

static GCVETVLibManager *sharedMyManager = nil;
- (BOOL)isLogin {
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"_needEnableAds"];
    return isLogin;
}

- (void)setNeedEnableAds:(BOOL)isLogin {
    BOOL _isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"_needEnableAds"];
    if (_isLogin == isLogin) {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:@"_needEnableAds"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)sharedManager {
    static dispatch_once_t onceToken;
    if(!sharedMyManager) {
        dispatch_once(&onceToken, ^{
            sharedMyManager = [[self alloc] init];
        });
    }
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        self.rtmpSession;
        CGRect mainFrame = [[UIScreen mainScreen] bounds];
        _buttonFrame = CGRectMake(10, 10, 50, 50);
        _controlFrame = mainFrame;
        _controlFrame.size.height = 50;
        _controlFrame.origin.y = mainFrame.size.height - 50;
        return self;
    }
    
    return nil;
}

#pragma RTMP Session control

-(VEDRTMPSession *) rtmpSession{
    // Override point for customization after application launch.
    if(!_rtmpSession) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        NSLog(@"Screen rect:%@", NSStringFromCGRect(rect));
    
        _rtmpSession = [[VEDRTMPSession alloc] initWithVideoSize:rect.size frameRate:30 bitrate:1000000 useInterfaceOrientation:YES];
    }
    return _rtmpSession;
}

-(void) toogleSession {
    switch(self.rtmpSession.rtmpSessionState) {
        case VCSessionStateNone:
        case VCSessionStatePreviewStarted:
        case VCSessionStateEnded:
        case VCSessionStateError:
            [self.rtmpSession startRtmpSessionWithURL:@"rtmp://113.171.255.130/stream/" andStreamKey:@"36e2f46e585b603e90fed28a3c8f65ec"];
            
            //            [_session startRtmpSessionWithURL:@"rtmp://125.212.194.16/stream/" andStreamKey:@"abc123"];
            break;
        default:
            [self.rtmpSession endRtmpSession];
            break;
    }
}

-(void) pushBuffer: (CVPixelBufferRef) pixelBufferRef {
    [self.rtmpSession pushBuffer:pixelBufferRef];
}

#pragma ASScreenRecorder control

-(void) toogleRecording {
    ASScreenRecorder *recorder = [ASScreenRecorder sharedInstance];
    
    if (recorder.isRecording) {
        [recorder stopRecordingWithCompletion:^{
            NSLog(@"Finished recording");
            [self playEndSound];
        }];
    } else {
        [recorder startRecording];
        NSLog(@"Start recording");
        [self playStartSound];
    }
}



- (void)playStartSound
{
    NSURL *url = [NSURL URLWithString:@"/System/Library/Audio/UISounds/begin_record.caf"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

- (void)playEndSound
{
    NSURL *url = [NSURL URLWithString:@"/System/Library/Audio/UISounds/end_record.caf"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

#pragma show window control 

- (UIWindow *) openWindow {
    if(!_openWindow) {
        _openWindow = [[UIWindow alloc] initWithFrame: _buttonFrame];
        _openWindow.backgroundColor = [UIColor clearColor];
        _openWindow.windowLevel = UIWindowLevelAlert;
        _startController = [[GCVETVStartController alloc] initWithNibName:nil bundle:nil frame:_openWindow.frame];
        _startController.view.backgroundColor = [UIColor clearColor];
        _startController.delegate = self;
        _openWindow.rootViewController = _startController;
    }
    return _openWindow;
}

- (UIWindow *) controlWindow {
    if(!_controlWindow) {
        _controlWindow = [[UIWindow alloc] initWithFrame: _controlFrame];
        _controlWindow.backgroundColor = [UIColor clearColor];
        _controlWindow.windowLevel = UIWindowLevelAlert;
        _controlController = [[GCVETVButtonController alloc] initWithNibName:nil bundle:nil frame:_controlWindow.frame];
        _controlController.view.backgroundColor = [UIColor clearColor];
//        _controlController.view.alpha = 0.5;
        _controlController.delegate = self;
        _controlWindow.rootViewController = _controlController;
    }
    return _controlWindow;
}

- (void) showOpenWindow {
    self.openWindow.hidden = NO;
    self.controlWindow.hidden = YES;
}

- (void) showControlWindow {
    self.openWindow.hidden = YES;
    self.controlWindow.hidden = NO;
}

- (void) hideAllWindow {
    self.openWindow.hidden = YES;
    self.controlWindow.hidden = YES;
}

#pragma StartController Delegate 
-(void) didOpenClick {
    
    [self hideAllWindow];
    if([AppUtils getValueForKey:@"apitoken"] && ![[AppUtils getValueForKey:@"apitoken"] isEqualToString:@""]) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        _homeNavigation = [HomeController navigationControllerWithHomeController];
        [mainWindow.rootViewController presentViewController:_homeNavigation animated:YES completion:nil];
        HomeController *homeController = [_homeNavigation rootHomeController];
        homeController.delegate = self;
    } else {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        _webviewNavigation = [KINWebBrowserViewController navigationControllerWithWebBrowser];
        [mainWindow.rootViewController presentViewController:_webviewNavigation animated:YES completion:nil];
        KINWebBrowserViewController *webBrowser = [_webviewNavigation rootWebBrowser];
        webBrowser.delegate = self;
        [webBrowser loadRequest:[self createHelpRequest]];
    }
}

#pragma KINWebbrowser Delegate
- (void)webBrowser:(KINWebBrowserViewController *)webBrowser didStartLoadingURL:(NSURL *)url {
    NSString *urlString = url.absoluteString;
    NSLog(@"The Redirected URL is: %@", urlString);
    if([urlString rangeOfString:GCVETVRedirectURL].location != NSNotFound &&
       [urlString rangeOfString:@"?access_token="].location != NSNotFound) {
        NSString *token = [[urlString stringByReplacingOccurrencesOfString:GCVETVRedirectURL
                                                                withString:@""] stringByReplacingOccurrencesOfString:@"?access_token=" withString:@""];
        NSLog(@"The accesstoken is: %@", token);
        if(![Singleton shareInstance].userInfo) {
            [Singleton shareInstance].userInfo = [[UserInfo alloc] init];
        }
        [Singleton shareInstance].userInfo.gToken = token;
        [self loginToServerWithToken:token];
    }
}
- (void)webBrowser:(KINWebBrowserViewController *)webBrowser didFinishLoadingURL:(NSURL *)URL {
    NSLog(@"finish loading %@", URL.absoluteString);
    
}
- (void)webBrowser:(KINWebBrowserViewController *)webBrowser didFailToLoadURL:(NSURL *)URL error:(NSError *)error {
    NSLog(@"failed loading %@", error.description);
    
}
- (void)webBrowserViewControllerWillDismiss:(KINWebBrowserViewController*)viewController {
    [self showOpenWindow];
}

-(NSMutableURLRequest *) createHelpRequest {
//    NSString *defaultURL = DEFAULT_URL;
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:(self.serverURL ? _serverURL : defaultURL) ]];
    
    NSString *loginURL = @"https://auth.garena.com/oauth/login?";
    NSString *loginAPI = @"10035";
    NSString *loginLocation = @"vi-VN";
    NSString *loginRedirect = GCVETVRedirectURL;
    NSString *loginFullUrl = [NSString stringWithFormat:@"%@client_id=%@&redirect_uri=%@&response_type=token&locale=%@", loginURL, loginAPI, loginRedirect, loginLocation ];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginFullUrl]];
    [request setHTTPMethod:@"GET"];
    return request;
}
-(void) clearCookies {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
}

-(void) loginToServerWithToken: (NSString *) token {
    [[Singleton shareInstance] startLoadingInView:[_webviewNavigation rootWebBrowser].view];
    StreamAPIConnection *connection = [[StreamAPIConnection alloc] init];
    [connection loginWithGToken:token completed:^(NSString *msgError, id result) {
        [[Singleton shareInstance] stopLoading];
        if(!msgError) {
            if(result) {
                int error = [[result objectForKey:@"error"] intValue];
                NSString* value = [result objectForKey:@"value"];
                if(error == 0){
                    [Singleton shareInstance].userInfo.apiToken = value;
                    [AppUtils saveValue:value ForKey:@"apitoken"];
                    [_webviewNavigation dismissViewControllerAnimated:YES completion:nil];
                       [self clearCookies];
                    [self openHomeController];
                }
            }
        }
    }];
}

#pragma Home controller
-(void) openHomeController {
    [self hideAllWindow];
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    _homeNavigation = [HomeController navigationControllerWithHomeController];
    [mainWindow.rootViewController presentViewController:_homeNavigation animated:YES completion:nil];
    
    HomeController *homeController = [_homeNavigation rootHomeController];
    homeController.delegate = self;
}

-(void) didStartClick {

    [self showControlWindow];
}
-(void) didCancel {
    [self showOpenWindow];
}


#pragma Controller Delegate
-(void) didToogleClick {
    [self toogleSession];
    [self toogleRecording];
}

-(void) didCloseClick {
    ASScreenRecorder *recorder = [ASScreenRecorder sharedInstance];
    if(recorder.isRecording) {
        [self toogleSession];
        [self toogleRecording];
    }
    [self showOpenWindow];
}
@end

