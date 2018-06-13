//
//  main.m
//  ThreadSafeStackTest
//
//  Created by Juncheng Han on 2/12/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import <simd/simd.h>


int main(int argc, char * argv[]) {

//    int (^myBlock)(int);
//
//    myBlock = ^(int a) {
//        return a + 1;
//    };
//
//
//
//    NSArray *array = @[@1, @2, @3];
//    NSLog(@"%p", array.self);
//    printf("%p", array);
//
//
//    NSMutableArray *mArray = [NSMutableArray arrayWithArray:array];
//
//    [mArray removeLastObject];
//
//    array = [mArray copy];
//
//    CGRect frame = CGRectMake(0, 0, 0, 0);
//
//
//
//    NSLog(@"%@", array);
//    printf("%p", array);

//    int *a = malloc(1);
//
//    char *b = malloc(2);
//
//    *a = 26214400;
//    b = "aasdf";
//
//    printf("%d", *a);
    
    
    int a[2] = {1, 2};
    
    free(a);
    
}



