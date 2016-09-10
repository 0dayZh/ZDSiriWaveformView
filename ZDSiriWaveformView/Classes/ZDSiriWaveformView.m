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
@property (nonatomic, strong) CAGradientLayer   *backgroundLineLayer;
@property (nonatomic, assign) BOOL  needsDraw;

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
    _padding = 5;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    [self setNeedsDraw];
    [self drawIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setNeedsDraw];
    [self drawIfNeeded];
}

#pragma mark - Public

- (void)appearAnimated:(BOOL)animated {}
- (void)disappearAnimated:(BOOL)animated {}

#pragma mark - Draw

- (void)setNeedsDraw {
    self.needsDraw = YES;
}

- (void)drawIfNeeded {
    if (self.needsDraw) {
        [self drawBackgroundLine];
        [self drawWaves];
    }
}

- (void)drawBackgroundLine {
    if (self.backgroundLineLayer) {
        [self.backgroundLineLayer removeFromSuperlayer];
        self.backgroundLineLayer = nil;
    }
    
    CGRect viewBounds = self.bounds;
    CGFloat viewWidth = CGRectGetWidth(viewBounds);
    CGFloat viewHeight = CGRectGetHeight(viewBounds);
    
    // line
    CAGradientLayer *bgLineLayer = [CAGradientLayer layer];
    bgLineLayer.frame = CGRectMake(self.padding, 0, viewWidth - self.padding * 2, viewHeight);
    bgLineLayer.startPoint = CGPointMake(0.0, 0.5);
    bgLineLayer.endPoint = CGPointMake(1.0, 0.5);
    bgLineLayer.locations = @[@(0.0), @(0.1), @(0.9), @(1.0)];
    
    CGColorRef outerColor = [UIColor colorWithWhite:1.0 alpha:0.0].CGColor;
    CGColorRef innerColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
    
    bgLineLayer.colors = @[(__bridge id)outerColor,
                           (__bridge id)innerColor,
                           (__bridge id)innerColor,
                           (__bridge id)outerColor];
    
    // mask
    CGFloat viewMidHeight = CGRectGetMidY(viewBounds);
    CGFloat lineMidHeight = 0.6;
    
    UIBezierPath *shape = [UIBezierPath bezierPath];
    [shape moveToPoint:CGPointMake(0, viewMidHeight)];
    
    // left-top
    [shape addQuadCurveToPoint:CGPointMake(80, viewMidHeight + lineMidHeight)
                  controlPoint:CGPointMake(60, viewMidHeight + lineMidHeight)];
    
    // top
    [shape addLineToPoint:CGPointMake(viewWidth - (self.padding * 2 + 80), viewMidHeight + lineMidHeight)];
    
    // right-top
    [shape addQuadCurveToPoint:CGPointMake(viewWidth - (self.padding * 2), viewMidHeight)
                  controlPoint:CGPointMake(viewWidth - (self.padding * 2 + 60), viewMidHeight + lineMidHeight)];
    
    // right-bottom
    [shape addQuadCurveToPoint:CGPointMake(viewWidth - (self.padding * 2 + 80), viewMidHeight - lineMidHeight)
                  controlPoint:CGPointMake(viewWidth - (self.padding * 2 + 60), viewMidHeight - lineMidHeight)];
    
    // bottom
    [shape addLineToPoint:CGPointMake(80, viewMidHeight - lineMidHeight)];
    
    // left-bottom
    [shape addQuadCurveToPoint:CGPointMake(0, viewMidHeight)
                  controlPoint:CGPointMake(60, viewMidHeight - lineMidHeight)];
    
    [shape closePath];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = viewBounds;
    maskLayer.path = shape.CGPath;
    maskLayer.fillColor = [UIColor redColor].CGColor;
    maskLayer.masksToBounds = YES;
    
    bgLineLayer.mask = maskLayer;
    
    [self.layer addSublayer:bgLineLayer];
    
    self.backgroundLineLayer = bgLineLayer;
}

- (void)drawWaves {}

@end
