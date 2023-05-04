//
//  NSImage+Color.h
//  Demo
//
//  Created by henry on 2021/5/22.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSImage (Color)
+(NSImage *)swatchWithColor:(NSColor *)color size:(NSSize)size;
@end

NS_ASSUME_NONNULL_END
