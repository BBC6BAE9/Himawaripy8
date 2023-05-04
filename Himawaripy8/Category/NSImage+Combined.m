//
//  NSImage+Combined.m
//  Demo
//
//  Created by henry on 2021/5/22.
//

#import "NSImage+Combined.h"
#import "NSImage+Color.h"

@implementation NSImage (Combined)

+ (NSImage *)imageCombinedByImages:(NSArray *)arrImages width:(float)width{
    
    
    float imageW = width;
    float imageH = width;
    
    NSImage *sourceImg = [NSImage swatchWithColor:[NSColor whiteColor] size:NSMakeSize(imageW * 4, imageH * 4)];
    
    for (int i = 0; i<arrImages.count ; i++) {
        sourceImg = [self mergeImages:sourceImg withImage:arrImages[i] index: i width:width];
    }
    
    return sourceImg;
}


+(NSImage *)mergeImages:(NSImage *)theTarget withImage:(NSImage *)theSource index:(NSInteger)index width:(float)width{

    //Get the source image from file
    NSImage *source = theSource;
    
    //Init target image
    NSImage *target = theTarget;
    //start drawing on target
    [target lockFocus];
    
    //draw the portion of the source image on target image
    if (index == 0 || index == 1|| index == 2|| index == 3) {
        [source drawInRect:NSMakeRect(index % 4* width, 3 * width, width,width) fromRect:NSZeroRect operation: NSCompositeCopy fraction:1.0];
            }
    
    if (index == 4 || index == 5|| index == 6|| index == 7) {
        [source drawInRect:NSMakeRect(index % 4* width, 2 * width, width,width) fromRect:NSZeroRect operation: NSCompositeCopy fraction:1.0];
    }

    if (index == 8 || index == 9|| index == 10|| index == 11) {
        [source drawInRect:NSMakeRect(index % 4* width, width, width,width) fromRect:NSZeroRect operation: NSCompositeCopy fraction:1.0];

    }

    if (index == 12 || index == 13|| index == 14|| index == 15) {
        [source drawInRect:NSMakeRect(index % 4* width, 0, width,width) fromRect:NSZeroRect operation: NSCompositeCopy fraction:1.0];

    }

    
    //end drawing
    [target unlockFocus];
    
    //create a NSBitmapImageRep
    NSBitmapImageRep *bmpImageRep = [[NSBitmapImageRep alloc]initWithData:[target TIFFRepresentation]];
    //add the NSBitmapImage to the representation list of the target
    [target addRepresentation:bmpImageRep];


    return target;
}

@end
