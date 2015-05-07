//
//  YCDonutView.m
//  DonutViewDemo
//
//  Created by Young Choi on 5/6/15.
//  Copyright (c) 2015 Young Choi. All rights reserved.
//

#import "YCDonutView.h"

CGMutablePathRef createRoundedCornerPath(CGRect rect, CGFloat cornerRadius)
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    // get the 4 corners of the rect
    CGPoint topLeft = CGPointMake(rect.origin.x, rect.origin.y);
    CGPoint topRight = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    CGPoint bottomRight = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGPoint bottomLeft = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
    
    // move to top left
    CGPathMoveToPoint(path, NULL, topLeft.x + cornerRadius, topLeft.y);
    
    // add top line
    CGPathAddLineToPoint(path, NULL, topRight.x - cornerRadius, topRight.y);
    
    // add top right curve
    CGPathAddQuadCurveToPoint(path, NULL, topRight.x, topRight.y, topRight.x, topRight.y + cornerRadius);
    
    // add right line
    CGPathAddLineToPoint(path, NULL, bottomRight.x, bottomRight.y - cornerRadius);
    
    // add bottom right curve
    CGPathAddQuadCurveToPoint(path, NULL, bottomRight.x, bottomRight.y, bottomRight.x - cornerRadius, bottomRight.y);
    
    // add bottom line
    CGPathAddLineToPoint(path, NULL, bottomLeft.x + cornerRadius, bottomLeft.y);
    
    // add bottom left curve
    CGPathAddQuadCurveToPoint(path, NULL, bottomLeft.x, bottomLeft.y, bottomLeft.x, bottomLeft.y - cornerRadius);
    
    // add left line
    CGPathAddLineToPoint(path, NULL, topLeft.x, topLeft.y + cornerRadius);
    
    // add top left curve
    CGPathAddQuadCurveToPoint(path, NULL, topLeft.x, topLeft.y, topLeft.x + cornerRadius, topLeft.y);
    
    return path;
}


@implementation YCDonutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [super setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextAddRect(context, rect);
    CGRect roundedRect = CGRectInset(rect, 20.0f, 20.0f);
    CGMutablePathRef roundedRectPath = createRoundedCornerPath(roundedRect, 15.0f);
    CGContextAddPath(context, roundedRectPath);
    CGPathRelease(roundedRectPath);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextEOFillPath(context); // clip, cut off the hole
    
    CGContextRestoreGState(context);
}

@end
