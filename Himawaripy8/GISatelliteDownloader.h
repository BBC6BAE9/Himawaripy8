//
//  GISatelliteDownloader.h
//  SatelliteEarthImage
//
//  Created by Gnatyuk Ivan on 25.04.16.
//  Copyright © 2016 Gnatyuk Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark Delegate
@protocol SatelliteDownloaderDelegate <NSObject>

@required
- (void)satelliteImageLoaded:(NSImage *)image
                   withError:(NSError *)error;

@optional
- (void)satelliteImageDownloadProgress:(float)progress;

@end
@interface GISatelliteDownloader : NSObject

- (void)downloadEarthImage:(float)width;
- (NSImage *)combineImage;

@property (nonatomic, weak) id<SatelliteDownloaderDelegate> delegate;

@end
