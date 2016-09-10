//
//  ZDSiriWaveformView.m
//  Pods
//
//  Created by 0dayZh on 16/9/10.
//
//

#import "ZDSiriWaveformView.h"

@interface ZDSiriWaveformView ()

@property (nonatomic, strong) NSMutableArray    *height;

@end

@implementation ZDSiriWaveformView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self innerInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self innerInit];
    }
    
    return self;
}

- (void)innerInit {
    self.backgroundColor = [UIColor blackColor];
}

@end
