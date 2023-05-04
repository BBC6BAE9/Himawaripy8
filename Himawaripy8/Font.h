//
//  Font.h
//  DigitClock
//
//  Created by wenyou on 2017/7/10.
//  Copyright © 2017年 wenyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface Font : NSObject
+ (instancetype)shareInstance;
- (NSFont *)fontOfSize:(CGFloat)fontSize name:(NSString *)fontName;
@end
