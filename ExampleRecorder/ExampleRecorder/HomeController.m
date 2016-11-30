//
//  HomeController.m
//  Streaming
//
//  Created by admin on 8/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "HomeController.h"
#import "AppUtils.h"
#import "ProfileScrollView.h"
#import "StreamAPIConnection.h"
#import "Singleton.h"
#import "Constant.h"

@interface HomeController ()

@end

@implementation HomeController

int textBttSize;
int textSize;
int textHeight;
int verticalSpace;
int horizontalSpace;

int dropdownHeight;

int profileHeight;

int gameIndex;
int gameTempIndex;


BOOL isEdit;
BOOL isStream;

NSMutableArray *listGame;

ProfileScrollView *mContentView;


//UITextView *mChannelNameTxt;
//UITextView *mChannelDescriptionTxt;
//UITextView *mChannelUrlTxt;

+ (UINavigationController *)navigationControllerWithHomeController {
    HomeController *homeController = [[self alloc] init];
    return [HomeController navigationControllerWithHome:homeController];
}

+ (UINavigationController *)navigationControllerWithHome:(HomeController *)homeController {
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:homeController action:@selector(doneButtonPressed:)];
    [homeController.navigationItem setRightBarButtonItem:doneButton];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeController];
    return navigationController;
}

- (void)doneButtonPressed:(id)sender {
    [self dismissAnimated:YES];
}

- (void)dismissAnimated:(BOOL)animated {
    if([self.delegate respondsToSelector:@selector(didCancel)]) {
        [self.delegate didCancel];
    }
    [self.navigationController dismissViewControllerAnimated:animated completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVariables];
    [self initButtonView];
    [self initScrollView];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [self getStreamInfo];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initVariables{
    if(IS_IPAD()){
        textBttSize = 30;
        textSize = 25;
        textHeight = 70;
        verticalSpace = 30;
        horizontalSpace = 80;
        return;
    }
    if(IS_IP6PLUS()){
        textBttSize = 13;
        textSize = 14;
        textHeight = 55;
        verticalSpace = 20;
        horizontalSpace = 30;
        return;
    }
    if(IS_IP6()){
        textBttSize = 13;
        textSize = 13;
        textHeight = 50;
        verticalSpace = 15;
        horizontalSpace = 20;
        return;
    }
    textBttSize = 11;
    textSize = 11;
    textHeight = 35;
    verticalSpace = 10;
    horizontalSpace = 15;
    return;

}

- (void) initView {
    self.mOwnerAva.layer.cornerRadius = self.mOwnerAva.frame.size.height / 2;
    self.mOwnerAva.layer.masksToBounds = YES;
    
}
- (void) initButtonView {
    [self.mSaveButton.titleLabel setFont:[UIFont systemFontOfSize:textBttSize]];
    [self.mCancelButton.titleLabel setFont:[UIFont systemFontOfSize:textBttSize]];
    [self.mStreamButton setFont:[UIFont systemFontOfSize:textBttSize]];
}
- (void) initScrollView {
    mContentView = (ProfileScrollView*)[[[NSBundle mainBundle] loadNibNamed:@"ProfileScrollView" owner:self options:nil] objectAtIndex:0];
    [mContentView.mChannelNameTxt setFont:[UIFont boldSystemFontOfSize: textSize]];
    [mContentView.mChannelDescriptionTxt setFont:[UIFont boldSystemFontOfSize: textSize]];
    [mContentView.mChannelUrlTxt setFont:[UIFont boldSystemFontOfSize: textSize]];
    [mContentView.mDropDownButton.titleLabel setFont:[UIFont boldSystemFontOfSize: textSize]];
    mContentView.mChannelNameTxt.textContainer.maximumNumberOfLines = 1;
    mContentView.mChannelDescriptionTxt.textContainer.maximumNumberOfLines = 1;
    mContentView.mChannelNameTxt.delegate = self;
    mContentView.mChannelDescriptionTxt.delegate = self;
    [self initFrameSize];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    int currentPoint = 0;
    int elementWidth = screenWidth - 2 * horizontalSpace;
    CGRect frame;
    CGRect frameLine;
    frame = mContentView.mChannelNameTxt.frame;
    frame.size.height = textHeight;
    frame.size.width = elementWidth;
    frame.origin.x = horizontalSpace;
    frame.origin.y = currentPoint + verticalSpace;
    frameLine.origin.x = horizontalSpace;
    frameLine.origin.y = frame.origin.y + textHeight;
    frameLine.size.width = frame.size.width;
    frameLine.size.height = 1;
    currentPoint = frame.origin.y + textHeight;
    mContentView.mChannelNameTxt.frame = frame;
    mContentView.mLine1.frame = frameLine;
    
    
    frame = mContentView.mChannelDescriptionTxt.frame;
    frame.size.height = textHeight;
    frame.size.width = elementWidth;
    frame.origin.x = horizontalSpace;
    frame.origin.y = currentPoint + verticalSpace;
    frameLine.origin.x = horizontalSpace;
    frameLine.origin.y = frame.origin.y + textHeight;
    frameLine.size.width = frame.size.width;
    currentPoint = frame.origin.y + textHeight;
    mContentView.mChannelDescriptionTxt.frame = frame;
    mContentView.mLine2.frame = frameLine;
    
    frame = mContentView.mDropDownView.frame;
    frame.size.height = textHeight;
    frame.size.width = elementWidth;
    frame.origin.x = horizontalSpace;
    frame.origin.y = currentPoint + verticalSpace;
    frameLine.origin.x = horizontalSpace;
    frameLine.origin.y = frame.origin.y + textHeight;
    frameLine.size.width = frame.size.width;
    currentPoint = frame.origin.y + textHeight;
    mContentView.mDropDownView.frame = frame;
    mContentView.mLine3.frame = frameLine;
    
    frame = mContentView.mChannelUrlTxt.frame;
    frame.size.height = textHeight;
    frame.size.width = elementWidth;
    frame.origin.x = horizontalSpace;
    frame.origin.y = currentPoint + verticalSpace;
    frameLine.origin.x = horizontalSpace;
    frameLine.origin.y = frame.origin.y + textHeight;
    frameLine.size.width = frame.size.width;
    currentPoint = frame.origin.y + textHeight;
    mContentView.mChannelUrlTxt.frame = frame;
    mContentView.mLine4.frame = frameLine;
    
    frame = mContentView.frame;
    frame.size.width = screenWidth;
    frame.size.height = currentPoint + verticalSpace;
    frameLine.origin.x = horizontalSpace;
    frameLine.origin.y = frame.origin.y;
    frameLine.size.width = frame.size.width;
    frame.origin.x = 0;
    frame.origin.y = 0;
    int childHeight = frame.size.height;
    if(childHeight < profileHeight) {
        childHeight = profileHeight;
    }
    frame.size.height = childHeight;
    mContentView.frame = frame;
    
    [mContentView.mDropDownButton addTarget:self action:@selector(showDropDown:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.mSContentView.frame = frame;
    [self.mSContentView addSubview:mContentView];
    self.mScrollView.contentSize = mContentView.frame.size;
    [self showEditView:NO];
    
}

-(void) initFrameSize {
    int ratioHeight = self.mSContentView.frame.size.height * 100 / self.view.frame.size.height;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    profileHeight = screenHeight * ratioHeight / 100;
}

-(void) getStreamInfo {
    NSString *token = [AppUtils getValueForKey:@"apitoken"];
    [self getInfoWithToken:token];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
 Login to server
 */
-(void) getInfoWithToken: (NSString *) token {
    [[Singleton shareInstance] startLoadingInView:self.view];
    StreamAPIConnection *connection = [[StreamAPIConnection alloc] init];
    [connection getInfoWithToken:token completed:^(NSString *msgError, id result) {
        [[Singleton shareInstance] stopLoading];
        if(!msgError) {
            if(result) {
                int error = [[result objectForKey:@"error"] intValue];
                NSDictionary* value = [result objectForKey:@"value"];
                if(error == 0){
//                    [AppUtils saveValue:value ForKey:@"apitoken"];
//                    [self goHome];
                    listGame = [StreamAPIConnection getListGameFromJSON:value];
                    ChannelInfo *channelInfo = [StreamAPIConnection getChannelInfoFromJSON:value];
                    if(![Singleton shareInstance].basicInfo)
                        [Singleton shareInstance].basicInfo = [[BasicInfo alloc] init];
                    [Singleton shareInstance].basicInfo.channelInfo = channelInfo;
                    for(int i = 0; i < [listGame count]; i++) {
                        GameType *item = [listGame objectAtIndex:i];
                        if(item.gameID == channelInfo.channelGameID) {
                            [Singleton shareInstance].basicInfo.gameType = item;
                            gameIndex = i;
                            break;
                        }
                    }
                    [self displayImage];
                    [self displayInfo];
                    return;
                    
                }
            }
        }
    }];
}

-(void) displayImage {
    [self initView];
    [AppUtils setImageView:self.mOwnerAva path:[Singleton shareInstance].basicInfo.channelInfo.channelOwnerAva];
    
}

-(void) displayInfo {
    
    mContentView.mChannelNameTxt.text = [Singleton shareInstance].basicInfo.channelInfo.channelTitle;
    mContentView.mChannelDescriptionTxt.text = [Singleton shareInstance].basicInfo.channelInfo.channelDescription;
    [mContentView.mDropDownButton setTitle:[Singleton shareInstance].basicInfo.gameType.gameName forState:UIControlStateNormal];
    mContentView.mChannelUrlTxt.text = [Singleton shareInstance].basicInfo.channelInfo.streamUrl;
    mContentView.mChannelUrlTxt.editable = FALSE;
}

-(void) saveInfo {
    gameIndex = gameTempIndex;
    [Singleton shareInstance].basicInfo.channelInfo.channelTitle = mContentView.mChannelNameTxt.text;
    [Singleton shareInstance].basicInfo.channelInfo.channelDescription = mContentView.mChannelDescriptionTxt.text;
    [Singleton shareInstance].basicInfo.gameType = (GameType *)[listGame objectAtIndex:gameTempIndex];
}

-(NSArray *) getListGameDropDown: (NSMutableArray *) listGame {
    NSMutableArray *listLabel = [[NSMutableArray alloc] init];
    for(int i = 0; i < [listGame count]; i++){
        GameType *item = [listGame objectAtIndex:i];
        [listLabel addObject: item.gameName];
    }
    return [NSArray arrayWithArray:listLabel];
}



-(void) showDropDown: (id)sender{
//    [alertView close];
    if(!isEdit) return;
    NSArray * arr = [self getListGameDropDown:listGame];
    
    if(dropDown == nil) {
        int underHeight = mContentView.frame.size.height - mContentView.mDropDownView.frame.origin.y - mContentView.mDropDownView.frame.size.height;
        int overHeight = mContentView.mDropDownView.frame.origin.y;
        int avaiableHeight = underHeight;
        NSString *direction = @"down";
        if(overHeight > avaiableHeight) {
            avaiableHeight = overHeight;
            direction = @"up";
        }
        CGFloat f = 4 * textHeight;
        if(avaiableHeight < f) {
            f = avaiableHeight;
        }
        dropDown = [[NIDropDown alloc]showDropDownView:mContentView.mDropDownView :&f :arr :nil :@"down" : textHeight : textSize];
        dropDown.isLocation = NO;
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDownView:mContentView.mDropDownView];
        dropDown.isLocation = NO;
        [self rel];
    }
}

-(void) setEditMode: (BOOL) _isEdit {
    isEdit = _isEdit;
    mContentView.mChannelNameTxt.editable = _isEdit;
    mContentView.mChannelDescriptionTxt.editable = _isEdit;
}

-(void) showEditView: (BOOL) isShow {
    
    self.mEditToolView.hidden = !isShow;
    self.mNormalToolView.hidden = isShow;
    [self setEditMode:isShow];
}

-(void) setStreamMode: (BOOL) _isStream {
    isStream = _isStream;
    self.mEditToolView.hidden = YES;
    self.mNormalToolView.hidden = _isStream;
    self.mCancelToolView.hidden = !_isStream;
    [self setEditing:NO];
}

#pragma mark - NIDropDown Delegate

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender withIndex: (int) index {
    gameTempIndex = index;
    GameType *item = [listGame objectAtIndex:index];
    [mContentView.mDropDownButton setTitle:item.gameName forState:UIControlStateNormal];
    [self rel];
}
-(void)rel{
    dropDown = nil;
}

- (void) goLogin {
    if([self.delegate respondsToSelector:@selector(didCancel)]) {
        [self.delegate didCancel];
    }
}

- (IBAction)showEdit:(id)sender {
    [self showEditView:YES];
}

- (IBAction)cancelEdit:(id)sender {
    [self showEditView:NO];
    [self displayInfo];
}

- (IBAction)saveEdit:(id)sender {
    [self showEditView:NO];
    [self saveInfo];
}

- (IBAction)logout:(id)sender {
    [AppUtils saveValue:@"" ForKey:@"apitoken"];
    [self dismissAnimated:YES];
    [self goLogin];
}



- (IBAction)startStream:(id)sender {
    [self gotoStream];
}

- (IBAction)stopStream:(id)sender {
    [self setStreamMode:NO];
//    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    [appDelegate stopVETVServer];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


-(void) gotoStream {
    [self dismissAnimated:YES];
    if([self.delegate respondsToSelector:@selector(didStartClick)]) {
        [self.delegate didStartClick];
    }

}

@end
@implementation UINavigationController(HomeController)

- (HomeController *)rootHomeController {
    UIViewController *rootViewController = [self.viewControllers objectAtIndex:0];
    return (HomeController *)rootViewController;
}

@end
