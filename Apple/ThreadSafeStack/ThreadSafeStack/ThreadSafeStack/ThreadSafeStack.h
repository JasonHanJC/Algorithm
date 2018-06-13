//
//  ThreadSafeStack.h
//  ThreadSafeStack
//
//  Created by Juncheng Han on 2/12/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ThreadSafeStackProtocol

- (void)test;

@end

@interface ThreadSafeStack<__covariant ObjectType> : NSObject <NSSecureCoding, NSMutableCopying, NSCopying>

// MARK: initializer
- (instancetype)init;

// MARK: public motheds
- (void)push:(ObjectType)object;
- (ObjectType)pop;
- (ObjectType)peek;


@property (nonatomic, weak) id<ThreadSafeStackProtocol> delegate;
@property (nonatomic, strong) NSArray<id<ThreadSafeStackProtocol>> * array;

@property (readonly) NSUInteger count;

@end
