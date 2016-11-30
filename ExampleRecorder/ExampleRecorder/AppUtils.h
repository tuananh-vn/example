//
//  AppUtils.h
//  Streaming
//
//  Created by admin on 8/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface AppUtils : NSObject

+ (BOOL) isiPadDevice;
+ (void) saveValue: (NSString*) value ForKey: (NSString *) key;

+ (NSString *) getValueForKey: (NSString *) key;

+ (void)setImageView:(UIImageView *)imageView path:(NSString *)path;

@end
