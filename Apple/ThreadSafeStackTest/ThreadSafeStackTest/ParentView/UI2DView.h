//
//  UI2DView.h
//  ThreadSafeStackTest
//
//  Created by Juncheng Han on 2/22/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UI2DView : UIView

@property (nonatomic, weak) UI2DView * _Nullable parent;
@property (nonatomic, strong) NSArray<UI2DView *> * _Nullable subViews;

@property (nonatomic, assign) CGVector localPosition;
@property (nonatomic, assign) CGVector worldPosition;


- (void)setNewParent:(UI2DView * _Nullable)parent;
@end
