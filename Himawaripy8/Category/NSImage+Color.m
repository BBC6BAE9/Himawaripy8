//
//  NSImage+Color.m
//  Demo
//
//  Created by henry on 2021/5/22.
//

#import "NSImage+Color.h"

@implementation NSImage (Color)
+(NSImage *)swatchWithColor:(NSColor *)color size:(NSSize)size
{
    NSImage *image = [[NSImage alloc] initWithSize:size];
    [image lockFocus];
    [color drawSwatchInRect:NSMakeRect(0, 0, size.width, size.height)];
    [image unlockFocus];
   return image;
}
@end
