//
//  ViewController.m
//  ThreadSafeself.stackTest
//
//  Created by Juncheng Han on 2/12/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import "ViewController.h"
#import "ThreadSafeStack.h"

@interface ViewController ()

@property (nonatomic, strong) ThreadSafeStack *stack;
@property (nonatomic, strong) ThreadSafeStack *testStack;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    __block int count = 0;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        for (int i = 0; i < 10000; i ++) {
//            count ++;
//        }
//    });
//    for (int i = 0; i < 10000; i ++) {
//        count ++;
//    }

    
    self.stack = [[ThreadSafeStack alloc] init];

    NSArray *testStrings = @[@"first", @"second", @"third", @"forth", @"fifth", @"sixth", @"seventh"];

    for (NSString *s in testStrings) {
        [self.stack push:s];
    }
    
//    for (NSString *s in self.stack) {
//
//        NSLog(@"%@", s);
//    }

      NSLog(@"%@", self.stack);
//
//    self.testStack = [self.stack copy];
//
//
//    NSLog(@"%@", self.testStack);
    

    dispatch_queue_t concurrentQueue = dispatch_queue_create("test.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group, concurrentQueue, ^{
        [self.stack pop];
    });
    
    dispatch_group_async(group, concurrentQueue, ^{
        [self.stack pop];
    });
    
    dispatch_group_async(group, concurrentQueue, ^{
        [self.stack pop];
    });
    
    dispatch_group_async(group, concurrentQueue, ^{
        [self.stack pop];
    });
    
    dispatch_group_async(group, concurrentQueue, ^{
        [self.stack pop];
    });
    
    dispatch_group_async(group, concurrentQueue, ^{
        [self.stack pop];
    });
    
    dispatch_group_async(group, concurrentQueue, ^{
        [self.stack pop];
    });
    
    dispatch_group_async(group, concurrentQueue, ^{
        [self.stack pop];
    });
    
    dispatch_group_async(group, concurrentQueue, ^{
        [self.stack pop];
    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack pop];
//    });
//
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack pop];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        // NSLog(@"push: %@", @"aaa");
//        [self.stack push:@"aaa"];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        // NSLog(@"push: %@", @"sss");
//        [self.stack push:@"sss"];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        // NSLog(@"push: %@", @"ddd");
//        [self.stack push:@"ddd"];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack pop];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack pop];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        // NSLog(@"push: %@", @"fff");
//        [self.stack push:@"fff"];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        // NSLog(@"push: %@", @"ggg");
//        [self.stack push:@"ggg"];
//
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        // NSLog(@"push: %@", @"hhh");
//        [self.stack push:@"hhh"];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack pop];
//    });
//
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack pop];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        // NSLog(@"push: %@", @"aaa");
//        [self.stack push:@"aaa"];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        // NSLog(@"push: %@", @"sss");
//        [self.stack push:@"sss"];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        // NSLog(@"push: %@", @"ddd");
//        [self.stack push:@"ddd"];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack pop];
//    });
//
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack pop];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        // NSLog(@"push: %@", @"fff");
//        [self.stack push:@"fff"];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        // NSLog(@"push: %@", @"ggg");
//        [self.stack push:@"ggg"];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        // NSLog(@"push: %@", @"hhh");
//        [self.stack push:@"hhh"];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack count];
//    });
//
//    dispatch_group_async(group, concurrentQueue, ^{
//        [self.stack peek];
//    });
//
//    // NSLog(@"%@", self.stack);
//
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
