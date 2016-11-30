//
//  ButtonControllerViewController.h
//  ExampleRecorder
//
//  Created by admin on 11/29/16.
//  Copyright © 2016 Alan Skipp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GCVETVControlDelegate <NSObject>

-(void) didToogleClick;
-(void) didCloseClick;

@end


@interface GCVETVButtonController : UIViewController<UIGestureRecognizerDelegate>

@property(nonatomic, assign) id<GCVETVControlDelegate> delegate;
@property(nonatomic, strong) UIImageView* toogleIcon;
@property(nonatomic, strong) UIImageView* closeIcon;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil frame: (CGRect) frame;
@end
