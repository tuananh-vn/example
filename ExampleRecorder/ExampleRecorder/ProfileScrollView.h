//
//  ProfileScrollView.h
//  Streaming
//
//  Created by admin on 8/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileScrollView : UIView

@property(nonatomic, strong) IBOutlet UITextView *mChannelNameTxt;
@property(nonatomic, strong) IBOutlet UITextView *mChannelDescriptionTxt;
@property(nonatomic, strong) IBOutlet UITextView *mChannelUrlTxt;
@property(nonatomic, strong) IBOutlet UIView *mDropDownView;
@property(nonatomic, strong) IBOutlet UIButton *mDropDownButton;


@property(nonatomic, strong) IBOutlet UIView *mLine1;
@property(nonatomic, strong) IBOutlet UIView *mLine2;
@property(nonatomic, strong) IBOutlet UIView *mLine3;
@property(nonatomic, strong) IBOutlet UIView *mLine4;

@end
