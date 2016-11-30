//
//  AppUtils.m
//  Streaming
//
//  Created by admin on 8/23/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "AppUtils.h"

@implementation AppUtils

+ (BOOL) isiPadDevice{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

+ (void) saveValue: (NSString*) value ForKey: (NSString *) key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:value
                     forKey:key];
    // – setBool:forKey:
    // – setFloat:forKey:
    // in your case
    [userDefaults synchronize];
}

+ (NSString *) getValueForKey: (NSString *) key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)setImageView:(UIImageView *)imageView path:(NSString *)path
{
    NSString *url = path;
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

@end
