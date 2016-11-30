//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIDropDown;
@protocol NIDropDownDelegate
- (void) niDropDownDelegateMethod: (NIDropDown *) sender;
- (void) niDropDownDelegateMethod: (NIDropDown *) sender withIndex: (int) index;
@end

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSString *animationDirection;
    UIImageView *imgView;
}
@property (nonatomic, retain) id <NIDropDownDelegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;
@property (nonatomic, assign) BOOL isLocation;

@property (nonatomic) int cellHeight;
@property (nonatomic) int textSize;

-(void)hideDropDownView:(UIView *)b;
- (id)showDropDownView:(UIView *)b:(CGFloat *)height:(NSArray *)arr:(NSArray *)imgArr:(NSString *)direction :(int) cellH : (int) textS ;

-(void)hideDropDown:(UIButton *)b;
- (id)showDropDown:(UIButton *)b:(CGFloat *)height:(NSArray *)arr:(NSArray *)imgArr:(NSString *)direction;

-(void)hideTextDropDown:(UITextField *)b;
- (id)showTextDropDown:(UITextField *)b:(CGFloat *)height:(NSArray *)arr:(NSArray *)imgArr:(NSString *)direction;

@end
