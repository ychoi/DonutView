//
//  YCViewController.m
//  DonutViewDemo
//
//  Created by Young Choi on 5/6/15.
//  Copyright (c) 2015 Young Choi. All rights reserved.
//

#import "YCViewController.h"
#import "YCDonutView.h"

@interface YCViewController ()

@end

@implementation YCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Put a background with some tiles with random colors.
    [self addBackgroundTiles];
    
    // Add a donut view to see through it. (the parent view's backgroud tiles)
    YCDonutView *donutView = [[YCDonutView alloc] initWithFrame:CGRectInset(self.view.frame, 60.0f, 180.0f)];
    [self.view addSubview:donutView];
    
    // Add gestures for Move and Resize
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.delegate = self;
    [donutView addGestureRecognizer:panGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    pinchGesture.delegate = self;
    [donutView addGestureRecognizer:pinchGesture];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    CGPoint translation = [panGesture translationInView:panGesture.view.superview];
    
    if (UIGestureRecognizerStateBegan == panGesture.state ||UIGestureRecognizerStateChanged == panGesture.state)
    {
        panGesture.view.center = CGPointMake(panGesture.view.center.x + translation.x, panGesture.view.center.y + translation.y);
        [panGesture setTranslation:CGPointZero inView:self.view];
    }
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)pinchGesture
{
    if (UIGestureRecognizerStateBegan == pinchGesture.state || UIGestureRecognizerStateChanged == pinchGesture.state)
    {
        pinchGesture.view.transform = CGAffineTransformScale(pinchGesture.view.transform, pinchGesture.scale, pinchGesture.scale);
        pinchGesture.scale = 1; // Reset to 1
        [pinchGesture.view setNeedsDisplay]; // call drawRect for redrawing at current scale level
    }
}

- (void)addBackgroundTiles
{
    NSInteger tileCount = 100;
    CGFloat w = self.view.frame.size.width / tileCount;
    CGFloat h = self.view.frame.size.height / tileCount;
    for(int i=0; i<tileCount; i++)
    {
        for (int j=0; j<tileCount; j++)
        {
            CGFloat x = i*w;
            CGFloat y = j*h;
            UIView *tile = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
            
            CGFloat r = (CGFloat)(arc4random() % 255);
            CGFloat g = (CGFloat)(arc4random() % 255);
            CGFloat b = (CGFloat)(arc4random() % 255);
            
            tile.backgroundColor = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:0.5];
            
            [self.view addSubview:tile];
        }
    }
}

@end
