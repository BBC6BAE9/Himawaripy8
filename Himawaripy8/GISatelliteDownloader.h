//
//  GISatelliteDownloader.h
//  SatelliteEarthImage
//
//  Created by huang on 25.04.16.
//  Copyright © 2023 huang. All rights reserved.
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
