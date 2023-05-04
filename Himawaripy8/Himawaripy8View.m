//
//  Himawaripy8View.m
//  Himawaripy8
//
//  Created by henry on 2021/5/22.
//

#import "Himawaripy8View.h"
#import "GISatelliteDownloader.h"
#import "Font.h"

@interface Himawaripy8View()<SatelliteDownloaderDelegate>

@property(nonatomic, strong)NSImageView *imageView;
@property(nonatomic, strong)GISatelliteDownloader *satDownloader;
@property(nonatomic, strong)NSTextField *lab;
@property(nonatomic, assign)int seconds;

@end

@implementation Himawaripy8View

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)startAnimation
{
    CALayer *viewLayer = [CALayer layer];
    [self setWantsLayer:YES];
    [self setLayer:viewLayer];
    self.layer.backgroundColor = [NSColor blackColor].CGColor;
    [self setNeedsDisplay:YES];
    
    CGFloat imageViewH = self.bounds.size.height * 0.8;
    
    NSImageView *imageView = [[NSImageView alloc]init];
    self.imageView = imageView;
    [self addSubview:imageView];
    self.imageView.image = [NSImage imageNamed:@"default.png"];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *trailingConstraint = [imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant: -68];
    NSLayoutConstraint *topConstraint = [imageView.topAnchor constraintEqualToAnchor:self.topAnchor constant: 68];
    NSLayoutConstraint *bottomConstraint = [imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant: -68];
    NSLayoutConstraint *widthConstraint = [imageView.widthAnchor constraintEqualToAnchor:imageView.heightAnchor];
    [NSLayoutConstraint activateConstraints:@[trailingConstraint, topConstraint, bottomConstraint, widthConstraint]];
    
    NSView *leftContainerView = [[NSView alloc] init];
    [leftContainerView setWantsLayer:YES];
    //    leftContainerView.layer.backgroundColor = [NSColor greenColor].CGColor;
    [self addSubview:leftContainerView];
    
    leftContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    {
        NSLayoutConstraint *trailingConstraint = [leftContainerView.trailingAnchor constraintEqualToAnchor:imageView.leadingAnchor];
        NSLayoutConstraint *leadingConstraint = [leftContainerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:68];
        NSLayoutConstraint *topConstraint = [leftContainerView.topAnchor constraintEqualToAnchor:self.topAnchor];
        NSLayoutConstraint *bottomConstraint = [leftContainerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
        [NSLayoutConstraint activateConstraints:@[trailingConstraint, leadingConstraint, topConstraint, bottomConstraint]];
    }
    
    GISatelliteDownloader *satDownloader = [[GISatelliteDownloader alloc] init];
    self.satDownloader = satDownloader;
    satDownloader.delegate = self;
    
    [satDownloader downloadEarthImage:imageViewH];
    [[Font shareInstance] fontOfSize:180 name:@"Montserrat-ExtraBold"];
    NSFont *font = [NSFont fontWithName:@"Montserrat-ExtraBold" size:180];
    NSTextField *lab=[[NSTextField alloc]init];
    self.lab = lab;
    lab.bordered=NO;
    lab.textColor = [NSColor whiteColor];
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dataFormatter stringFromDate:currentDate];
    lab.stringValue = dateString;
    lab.wantsLayer=YES;
    lab.backgroundColor = [NSColor clearColor];
    lab.font = font;
    lab.layer.backgroundColor = [NSColor blackColor].CGColor;
    lab.alignment=NSTextAlignmentLeft;
    lab.editable=NO;//不可编辑
    [lab setNeedsDisplay:YES];
    [leftContainerView addSubview:lab];
    
    lab.translatesAutoresizingMaskIntoConstraints = NO;

    // 激活约束
    [NSLayoutConstraint activateConstraints:@[
        [lab.centerYAnchor constraintEqualToAnchor:leftContainerView.centerYAnchor],
        [lab.centerXAnchor constraintEqualToAnchor:leftContainerView.centerXAnchor],
    ]];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

- (void)updateTime{
    if (self.seconds == 0) {
        [self.satDownloader downloadEarthImage:self.imageView.frame.size.width];
    }
    self.seconds+= 1;
    if (self.seconds > 600) {
        self.seconds = 0;
    }
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [dataFormatter stringFromDate:currentDate];
    self.lab.stringValue = dateString;
}

- (void)satelliteImageLoaded:(NSImage *)image withError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (image == nil) {
            self.imageView.image = [NSImage imageNamed:@"default"];
        }else{
            self.imageView.image = image;
        }
    });
}

- (void)satelliteImageDownloadProgress:(float)progress {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"下载进度 %f", progress);
    });
}

@end
