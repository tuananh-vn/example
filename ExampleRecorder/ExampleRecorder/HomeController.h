//
//  HomeController.h
//  Streaming
//
//  Created by admin on 8/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@class HomeController;

@protocol GCVETVHomeDelegate <NSObject>

-(void) didStartClick;
-(void) didCancel;

@end

@interface UINavigationController(HomeController)

// Returns rootViewController casted as KINWebBrowserViewController
- (HomeController *)rootHomeController;

@end
@interface HomeController : UIViewController<NIDropDownDelegate, UITextViewDelegate>
{
    NIDropDown *dropDown;
}


@property(nonatomic, assign) id<GCVETVHomeDelegate> delegate;


@property(nonatomic, strong) IBOutlet UIScrollView *mScrollView;
@property(nonatomic, strong) IBOutlet UIView *mImageView;
@property(nonatomic, strong) IBOutlet UIView *mInfoView;
@property(nonatomic, strong) IBOutlet UIView *mButtonView;
@property(nonatomic, strong) IBOutlet UIView *mSContentView;


@property(nonatomic, strong) IBOutlet UIView *mEditToolView;
@property(nonatomic, strong) IBOutlet UIView *mNormalToolView;
@property(nonatomic, strong) IBOutlet UIView *mCancelToolView;
@property(nonatomic, strong) IBOutlet UIImageView *mOwnerAva;


@property(nonatomic, strong) IBOutlet UIButton *mSaveButton;
@property(nonatomic, strong) IBOutlet UIButton *mCancelButton;
@property(nonatomic, strong) IBOutlet UILabel *mStreamButton;

//@property(nonatomic, strong) IBOutlet UITextField *mChannelNameTxt;
//@property(nonatomic, strong) IBOutlet UITextField *mChannelDescriptionTxt;
//@property(nonatomic, strong) IBOutlet UITextField *mChannelUrlTxt;
//@property(nonatomic, strong) IBOutlet UIView *mDropDownView;

+ (UINavigationController *)navigationControllerWithHomeController;

+ (UINavigationController *)navigationControllerWithHome:(HomeController *)homeController;



- (IBAction)showEdit:(id)sender;
- (IBAction)cancelEdit:(id)sender;
- (IBAction)saveEdit:(id)sender;
- (IBAction)logout:(id)sender;

- (IBAction)startStream:(id)sender;
- (IBAction)stopStream:(id)sender;
@end
