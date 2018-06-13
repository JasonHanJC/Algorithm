//
//  ThreadSafeStack.m
//  ThreadSafeStack
//
//  Created by Juncheng Han on 2/12/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import "ThreadSafeStack.h"
#import "ListNode.h"

struct ListNodeC {
    struct ListNodeC * __nullable next;
    __unsafe_unretained id __nullable value;
};

@interface ThreadSafeStack()
{
    // struct ListNodeC * head;
}

@property (nonatomic, strong) ListNode *head;
@property (nonatomic, strong) dispatch_queue_t isolationQueue;

@end

@implementation ThreadSafeStack

- (instancetype)init {
    self = [super init];
    if (self) {
//        head = (ListNodeC *)malloc(sizeof(ListNodeC));
        _head = NULL;
        NSString *name = [NSString stringWithFormat:@"com.ThreadSafeStack.dispatchQueue.%@", [[NSUUID UUID] UUIDString]];
        _isolationQueue = dispatch_queue_create([name cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

#pragma mark - setter and getter

- (NSUInteger)count {
    __block NSInteger res = 0;
    dispatch_sync(self.isolationQueue, ^{
        ListNode *temp = self.head;
        while (temp != NULL) {
            res += 1;
            temp = temp.next;
        }
        
#if DEBUG
        NSLog(@"count %ld", (long)res);
#endif
    });
    return res;
}

#pragma mark - public methods

- (id)peek {
    __block id res;
    dispatch_sync(self.isolationQueue, ^{
//        res = head->value;
        res = self.head.value;
        
#if DEBUG
        NSLog(@"peek %@", res);
#endif
    });
    return res;
}

- (id)pop {
    __block id res = NULL;
    dispatch_sync(self.isolationQueue, ^{
        if (self.head == NULL) {
        } else {
            res = self.head.value;
            self.head = self.head.next;
        }
//
//#if DEBUG
//        NSLog(@"pop %@", res == NULL ? @"Null" : res);
//#endif
    });
    
#if DEBUG
    NSLog(@"pop %@", res == NULL ? @"Null" : res);
#endif
    return res;
}

- (void)push:(id)object {
    dispatch_async(self.isolationQueue, ^{
//        ListNodeC * newNode = (ListNodeC *)malloc(sizeof(ListNodeC));;
//        newNode->value = object;
//        newNode->next = head;
//
//        head = newNode;
        
        self.head = [[ListNode alloc] initWithValue:object andNext:self.head];
#if DEBUG
        NSLog(@"push %@", object);
#endif
    });
}

#pragma mark - override methods

- (NSString *)description {
    NSMutableString *des = [NSMutableString stringWithFormat:@"%@: ", [super description]];
    dispatch_sync(self.isolationQueue, ^{
//    struct ListNodeC * temp = head;
        ListNode *temp = self.head;
        while (temp != NULL) {
            [des appendString:[NSString stringWithFormat:@"%@ ", [temp.value description]]];
            temp = temp.next;
        }
    });
    return [des copy];
}

#pragma mark - NSCopy and NSMutableCopy

- (id<NSCopying, NSSecureCoding>)copyWithZone:(NSZone *)zone {
    
    ThreadSafeStack *copy = [[[self class] allocWithZone:zone] init];
    
    copy.head = self.head;
    
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [self copyWithZone:zone];
}

#pragma mark - NSCoding

#define kHeadKey @"headKey"

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:_head forKey:kHeadKey];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    id head = [aDecoder decodeObjectOfClass:[ListNode class] forKey:kHeadKey];
    
    self = [super init];
    if (self) {
        _head = head;
        NSString *name = [NSString stringWithFormat:@"com.ThreadSafeStack.dispatchQueue.%@", [[NSUUID UUID] UUIDString]];
        _isolationQueue = dispatch_queue_create([name cStringUsingEncoding:NSASCIIStringEncoding], DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

/*
 state: Context information that is used in the enumeration
 buffer: A C array of objects over which the sender is to iterate
 len: The maximum number of objects to return in buffer
 */
//- (NSUInteger)countByEnumeratingWithState:(nonnull NSFastEnumerationState *)state
//                                  objects:(id  _Nullable __unsafe_unretained * _Nonnull)buffer
//                                    count:(NSUInteger)len {
//
//    NSUInteger rCount = 0;
//
//    unsigned long countOfItemsAlreadyEnumerated = state->state;
//
//    if (countOfItemsAlreadyEnumerated == 0) {
//        // set the starting point
//        state->mutationsPtr = state->mutationsPtr;
//        state->extra[0] = (unsigned long)_head.value;
//        state->state = 1;
//    }
//
//
//
//
//    id currentValue = (id)state->extra[0];
//    ListNode *currentNode = self.head;
//    state->itemsPtr = buffer;
//
//    while(currentNode && rCount < len)
//    {
//        // Add the item for the next index to stackbuf.
//        //
//        // If you choose not to use ARC, you do not need to retain+autorelease the
//        // objects placed into stackbuf.  It is the caller's responsibility to ensure we
//        // are not deallocated during enumeration.
//
//        *buffer++ = currentNode.value;
//        currentNode = currentNode.next;
//        countOfItemsAlreadyEnumerated++;
//
//        // We must return how many items are in state->itemsPtr.
//        rCount++;
//    }
//
//    if (currentNode) {
//        state->extra[0] = (unsigned long)currentNode.next.value; // 4
//    }
//
//    return rCount;
//}

@end
