//
//  LargerHitView.m
//  hitTest
//
//  Created by Juncheng Han on 2/15/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import "LargerHitView.h"

@implementation LargerHitView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.userInteractionEnabled == NO || self.isHidden || self.alpha < 0.01) {
        return nil;
    }
    
    /* Inset `rect' by `(dx, dy)' -- i.e., offset its origin by `(dx, dy)', and
     decrease its size by `(2*dx, 2*dy)'. */
    CGRect touchRect = CGRectInset(self.bounds, -50, -50);
    NSLog(@"%@", NSStringFromCGRect(touchRect));
    
    if (CGRectContainsPoint(touchRect, point)) {
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                return hitTestView;
            }
        }
        return self;
    }
    return nil;
}

@end
