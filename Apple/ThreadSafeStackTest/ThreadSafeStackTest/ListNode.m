//
//  ListNode.m
//  ThreadSafeStack
//
//  Created by Juncheng Han on 2/12/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import "ListNode.h"

@implementation ListNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.next = NULL;
        self.value = NULL;
    }
    return self;
}

- (instancetype)initWithValue:(id)value andNext:(ListNode *)next {
    self = [super init];
    if (self) {
        self.next = next;
        self.value = value;
    }
    return self;
}

#pragma mark - NSCoding

#define kValueKey @"valueKey"
#define kNextKey @"nextKey"

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:_value forKey:kValueKey];
    [aCoder encodeObject:_next forKey:kNextKey];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    id value = [aDecoder decodeObjectForKey:kValueKey];
    id next = [aDecoder decodeObjectOfClass:[ListNode class] forKey:kNextKey];
    
    self = [super init];
    
    if (self) {
        self.value = value;
        self.next = next;
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
