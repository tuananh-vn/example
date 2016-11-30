//
//  GCVETVStartController.h
//  ExampleRecorder
//
//  Created by admin on 11/28/16.
//  Copyright © 2016 Alan Skipp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GCVETVStartDelegate <NSObject>

-(void) didOpenClick;

@end


@interface GCVETVStartController : UIViewController <UIGestureRecognizerDelegate>
@property(nonatomic, assign) id<GCVETVStartDelegate> delegate;
@property(nonatomic, strong) UIImageView* helpIcon;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil frame: (CGRect) frame;
@end
