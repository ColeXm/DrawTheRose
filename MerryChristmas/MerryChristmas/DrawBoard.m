//
//  DrawBoard.m
//  MerryChristmas
//
//  Created by ColeXm on 15/12/24.
//  Copyright © 2015年 ColeXm. All rights reserved.
//

#import "DrawBoard.h"
#import <CoreText/CoreText.h>


const float  kRadius = 100.;
#define kSqrt sqrtf(5000.)
#define COLOR(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1.0]
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation DrawBoard{
    CAShapeLayer *pathLayer;
    CAShapeLayer *layer2;
}

- (void)showTheFlowerOnView:(UIView *)view{

    //path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path appendPath:[DrawBoard p:CGPointMake(kSqrt, -kSqrt)    s:M_PI - M_PI_4]];
    [path appendPath:[DrawBoard p:CGPointMake(-kSqrt, -kSqrt)   s:-M_PI_4]];
    [path appendPath:[DrawBoard p:CGPointMake(kRadius, 0)       s:M_PI]];
    [path appendPath:[DrawBoard p:CGPointMake(0, -kRadius)      s:0]];
    [path appendPath:[DrawBoard p:CGPointMake(kSqrt, kSqrt)     s:M_PI + M_PI_4]];
    [path appendPath:[DrawBoard p:CGPointMake(kSqrt, -kSqrt)    s:M_PI_4]];
    [path appendPath:[DrawBoard p:CGPointMake(0, kRadius)       s:-M_PI_2]];
    [path appendPath:[DrawBoard p:CGPointMake(kRadius, 0)       s:M_PI_2 ]];
    [path appendPath:[DrawBoard p:CGPointMake(-kSqrt, kSqrt)    s:-M_PI_4]];
    [path appendPath:[DrawBoard p:CGPointMake(kSqrt, kSqrt)     s:-M_PI_4 - M_PI]];
    [path appendPath:[DrawBoard p:CGPointMake(-kRadius, 0)      s:0]];
    [path appendPath:[DrawBoard p:CGPointMake(0, kRadius)       s:-M_PI]];
    [path appendPath:[DrawBoard p:CGPointMake(-kSqrt, -kSqrt)   s:M_PI_4]];
    [path appendPath:[DrawBoard p:CGPointMake(-kSqrt, kSqrt)    s:M_PI_4- M_PI]];
    [path appendPath:[DrawBoard p:CGPointMake(0, -kRadius)      s:M_PI_2]];
    [path appendPath:[DrawBoard p:CGPointMake(-kRadius, 0)      s:M_PI_2- M_PI]];
    
    
    //layer
    pathLayer = [CAShapeLayer layer];
    pathLayer.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2);
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.strokeColor = [[UIColor yellowColor] CGColor];
    pathLayer.fillColor = [[UIColor clearColor] CGColor];
    pathLayer.lineWidth = 1.0f;
    pathLayer.path = path.CGPath;
    [view.layer addSublayer:pathLayer];
    
    
    //animation
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.delegate = self;
    pathAnimation.duration = 4.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [pathLayer addAnimation:pathAnimation forKey:nil];
    
}


- (void)showTheWordOnView:(UIView *)view{
    
    CGMutablePathRef letters = CGPathCreateMutable();

    //这里设置画线的字体和大小
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id _Nonnull)((__bridge CTFontRef)[UIFont systemFontOfSize:50.]), kCTFontAttributeName,
                           nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"圣诞快乐！" attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    // for each RUN
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        // Get FONT for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        // for each GLYPH in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    CGPathRelease(letters);
    
    
    //layer
    layer2 = [CAShapeLayer layer];
    layer2.frame = CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2);
    layer2.geometryFlipped = YES;
    layer2.bounds = CGPathGetBoundingBox(path.CGPath);
    layer2.strokeColor = [[UIColor yellowColor] CGColor];
    layer2.fillColor = [[UIColor clearColor] CGColor];
    layer2.lineWidth = 1.0f;
    layer2.path = path.CGPath;
    [view.layer addSublayer:layer2];
    
    
    //animation
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 4.0;
    pathAnimation.delegate = self;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [layer2 addAnimation:pathAnimation forKey:nil];
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    pathLayer.fillColor = [COLOR(254, 67, 101) CGColor];
    layer2.fillColor = [COLOR(254, 67, 101) CGColor];
}


+(UIBezierPath *)p:(CGPoint )p s:(CGFloat)s
{
    return [UIBezierPath bezierPathWithArcCenter:p
                                          radius:kRadius
                                      startAngle:s
                                        endAngle:s + M_PI_2
                                       clockwise:YES];
}

@end
