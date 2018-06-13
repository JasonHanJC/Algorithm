//
//  main.m
//  ThreadSafeStack
//
//  Created by Juncheng Han on 2/4/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThreadSafeStack.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        ThreadSafeStack *stack = [[ThreadSafeStack alloc] init];
        
        NSArray *testStrings = @[@"first", @"second", @"third", @"forth", @"fifth", @"sixth", @"seventh"];
        
        for (NSString *s in testStrings) {
            [stack push:s];
        }
        
        
        dispatch_queue_t concurrentQueue = dispatch_queue_create("test.concurrent.queue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
        
        dispatch_group_t group = dispatch_group_create();
        
        dispatch_group_async(group, concurrentQueue, ^{
            NSLog(@"peek: %@", [stack peek]);
        });
        
        dispatch_group_async(group, concurrentQueue, ^{
            NSLog(@"peek: %@", [stack peek]);
        });

        dispatch_group_async(group, concurrentQueue, ^{
            [stack pop];
            NSLog(@"pop: %@", stack);
        });


        dispatch_group_async(group, concurrentQueue, ^{
            NSLog(@"peek: %@", [stack peek]);
        });

        dispatch_group_async(group, concurrentQueue, ^{
            [stack pop];
            NSLog(@"pop: %@", stack);
        });

        dispatch_group_async(group, concurrentQueue, ^{
            [stack push:@"aaa"];
            NSLog(@"push: %@", stack);
        });

        dispatch_group_async(group, concurrentQueue, ^{
            [stack push:@"sss"];
            NSLog(@"push: %@", stack);
        });

        dispatch_group_async(group, concurrentQueue, ^{
            
            NSLog(@"peek: %@", [stack peek]);
        });

        dispatch_group_async(group, concurrentQueue, ^{
            [stack push:@"ddd"];
            NSLog(@"push: %@", stack);
        });

        dispatch_group_async(group, concurrentQueue, ^{
            NSLog(@"peek: %@", [stack peek]);
        });
        
        dispatch_group_async(group, concurrentQueue, ^{
            NSLog(@"peek: %@", [stack peek]);
        });
        
        dispatch_group_async(group, concurrentQueue, ^{
            NSLog(@"peek: %@", [stack peek]);
        });
        
        dispatch_group_async(group, concurrentQueue, ^{
            [stack pop];
            NSLog(@"pop: %@", stack);
        });
        
        
        dispatch_group_async(group, concurrentQueue, ^{
            NSLog(@"peek: %@", [stack peek]);
        });
        
        dispatch_group_async(group, concurrentQueue, ^{
            [stack pop];
            NSLog(@"pop: %@", stack);
        });
        
        dispatch_group_async(group, concurrentQueue, ^{
            [stack push:@"fff"];
            NSLog(@"push: %@", stack);
        });
        
        dispatch_group_async(group, concurrentQueue, ^{
            [stack push:@"ggg"];
            NSLog(@"push: %@", stack);
        });
        
        dispatch_group_async(group, concurrentQueue, ^{
            NSLog(@"peek: %@", [stack peek]);
        });
        
        dispatch_group_async(group, concurrentQueue, ^{
            [stack push:@"hhh"];
            NSLog(@"push: %@", stack);
        });
        
        dispatch_group_async(group, concurrentQueue, ^{
            NSLog(@"peek: %@", [stack peek]);
        });
    
        // NSLog(@"%@", stack);
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        return 0;
    }
}
