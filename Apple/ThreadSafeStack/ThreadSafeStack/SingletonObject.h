//
//  SingletonObject.h
//  ThreadSafeStack
//
//  Created by Juncheng Han on 2/12/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonObject : NSObject

+ (instancetype)shared;

@end
