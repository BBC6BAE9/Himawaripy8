//
//  NSImage+Combined.h
//  Demo
//
//  Created by henry on 2021/5/22.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSImage (Combined)

+ (NSImage *)imageCombinedByImages:(NSArray *)arrImages width:(float)width;


@end

NS_ASSUME_NONNULL_END
