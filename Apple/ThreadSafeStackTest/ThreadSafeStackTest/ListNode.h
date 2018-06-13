//
//  ListNode.h
//  ThreadSafeStack
//
//  Created by Juncheng Han on 2/12/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListNode : NSObject <NSSecureCoding>

@property (nonatomic, strong, nullable) id value;
@property (nonatomic, strong, nullable) ListNode *next;

- (nullable instancetype)initWithValue:(nullable id)value andNext:(nullable ListNode *)next;

@end
