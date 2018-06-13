//
//  UI2DView.m
//  ThreadSafeStackTest
//
//  Created by Juncheng Han on 2/22/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import "UI2DView.h"

@implementation UI2DView


- (void)setNewParent:(UI2DView *)parent {
    if (parent == self.parent) {
        return;
    }
    
    // checking
    UI2DView *tempNewP = parent;
    while(tempNewP != nil) {
        NSAssert(tempNewP != self, @"Error: New parent view is subview in current view's view hierachy.");
        tempNewP = tempNewP.parent;
    }
    
    // change parent view
    if (self.parent != nil) {
        UI2DView *oldParentView = self.parent;
        NSMutableArray *oldPvSubviews = [NSMutableArray arrayWithArray:oldParentView.subViews];
        [oldPvSubviews removeObject:self];
        oldParentView.subViews = [oldPvSubviews copy];
    }
    
    if (parent != nil) {
        NSMutableArray *newPvSubviews = [NSMutableArray arrayWithArray:self.parent.subViews];
        [newPvSubviews addObject:self];
        parent.subViews = [newPvSubviews copy];
    }
    
    [self setParent:parent];
}

@end
