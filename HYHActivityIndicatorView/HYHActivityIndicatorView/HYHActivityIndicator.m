//
//  HYHActivityIndicator.m
//  HYHActivityIndicatorView
//
//  Created by harry on 2020/6/28.
//  Copyright © 2020 DangDang. All rights reserved.
//

#import "HYHActivityIndicator.h"

static NSInteger const kMax = 12;
static CGFloat const kOutRadius = 18.f;
static CGFloat const kInnerRadius = 10.f;

@interface HYHActivityIndicator ()
{
    NSInteger _start;
    NSArray *_capacity;
}
@end

@implementation HYHActivityIndicator

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        NSMutableArray *array = [NSMutableArray array];
        CGFloat radioAlpha = 1.0 / kMax;
        for (int i = kMax; i >= 1; i--) {
            CGFloat alpha = radioAlpha * i;
            [array addObject:@(alpha)];
        }
        _capacity = [array copy];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat originX = self.bounds.size.width * 0.5;
    CGFloat originY = self.bounds.size.height * 0.5;
    
    CGFloat maxAngle = M_PI * 2;
    CGFloat angle = maxAngle / kMax;
    for (int i = 0; i < kMax; i++) {
        CGFloat cosin = cos(-angle * i);
        CGFloat sin = sinf(-angle * i);
        
        CGFloat minX = originX + kInnerRadius * cosin;
        CGFloat minY = originY + kInnerRadius * sin;
        CGFloat maxX = originX + kOutRadius * cosin;
        CGFloat maxY = originY + kOutRadius * sin;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(minX, minY)];
        [path addLineToPoint:CGPointMake(maxX, maxY)];
        path.lineWidth = 3;
        path.lineCapStyle = kCGLineCapRound;
        
        NSInteger index = (i + _start) % kMax;
        UIColor *color = [UIColor colorWithRed:255/255.0 green:0 blue:0 alpha:[_capacity[index] floatValue]];
        [color setStroke];
        
        [path stroke];
    }
    
    // 0..11
    _start = ++_start % kMax;
}

- (void)startAnimation {
    
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(draw) userInfo:nil repeats:YES];
}

- (void)draw {
    [self setNeedsDisplay];
}

@end
