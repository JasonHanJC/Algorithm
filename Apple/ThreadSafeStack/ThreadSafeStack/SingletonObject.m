//
//  SingletonObject.m
//  ThreadSafeStack
//
//  Created by Juncheng Han on 2/12/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import "SingletonObject.h"

@interface SingletonObject ()

@property (nonatomic, strong) NSString *test;

@end

@implementation SingletonObject

+ (instancetype)shared {
    static SingletonObject *singletonObject = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonObject = [[SingletonObject alloc] init];
    });
    return singletonObject;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
        _test = @"Hello world";
        
    }
    return self;
}

@end
