//
//  ZDSiriWaveformView.h
//  Pods
//
//  Created by 0dayZh on 16/9/10.
//
//

#import <UIKit/UIKit.h>

@interface ZDSiriWaveformView : UIView

@property (nonatomic, assign) CGFloat   padding;    // default as 5

- (void)appearAnimated:(BOOL)animated;
- (void)disappearAnimated:(BOOL)animated;

@end
