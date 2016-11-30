//
//  Constant.h
//  BusyBody
//
//  Created by Mac on 7/24/15.
//  Copyright (c) 2015 GiangNguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
extern const CGFloat IPADW;
extern const CGFloat IP6W;
extern const CGFloat IP4W;
extern const CGFloat IP4H;
extern const CGFloat IP6PW;
extern CGFloat HEADER_HEIGHT;
extern CGFloat DEFAULT_ROW_HEIGHT;
extern CGFloat ALERT_ITEM_HEIGHT;
extern const NSString *KEY_LOGGEDIN;
extern const NSString *KEY_USER;
extern const NSString *KEY_PASS;
extern const NSString *KEY_NEWEST;
extern const NSString *KEY_MERCHANT;
extern const CGFloat kCustomIOSAlertViewCornerRadius;
extern CGFloat DIALOG_HEIGHT1;
extern CGFloat DIALOG_HEIGHT2;
extern CGFloat DIALOG_HEIGHT3;
extern CGFloat kios7;
extern CGFloat DIALOG_WIDTH;

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define Rgb2UIColor(r, g, b)  [[UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0] CGColor]
#define yellowgreenColor Rgb2UIColor(156, 208, 13);
#define graylineColor Rgb2UIColor(52, 52, 52);
#define placeholderColor Rgb2UIColor(166, 166, 166);
#define SETSCREEN() ((IS_IPAD()) ? @"ipad" : (SCREEN_WIDTH_PORTRAIT==IP6PW)? @"ip6plus":(SCREEN_WIDTH_PORTRAIT==IP6W)? @"ip6": @"ip4")

#define IS_IP6PLUS() (SCREEN_WIDTH_PORTRAIT==IP6PW)
#define IS_IP6() (SCREEN_WIDTH_PORTRAIT==IP6W)

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SETPADDING() ((IS_IPAD()) ? 30 : (SCREEN_WIDTH_PORTRAIT==IP6PW)? 14:(SCREEN_WIDTH_PORTRAIT==IP6W)? 11: 11)
#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#pragma mark - SCREEN INFORMATION

/** Float: Portrait Screen Height **/
#define SCREEN_HEIGHT_PORTRAIT ( [[UIScreen mainScreen ] bounds ].size.height )

/** Float: Portrait Screen Width **/
#define SCREEN_WIDTH_PORTRAIT ( [[UIScreen mainScreen ] bounds ].size.width )

/** Float: Landscape Screen Height **/
#define SCREEN_HEIGHT_LANDSCAPE ( [[UIScreen mainScreen ] bounds ].size.width )

/** Float: Landscape Screen Width **/
#define SCREEN_WIDTH_LANDSCAPE ( [[UIScreen mainScreen ] bounds ].size.height )

#define getNameVIew(simpleTableIdentifier) simpleTableIdentifier= [simpleTableIdentifier stringByAppendingString:SETSCREEN()]




