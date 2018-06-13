//
//  ViewController.m
//  PlaySensors
//
//  Created by Juncheng Han on 2/24/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet UILabel *xLabel;
@property (weak, nonatomic) IBOutlet UILabel *yLabel;
@property (weak, nonatomic) IBOutlet UILabel *zLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // configure core motion manager
    [self configureCoreMotion];
}

- (void)configureCoreMotion {
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = 1;
    
    if ([self.motionManager isAccelerometerAvailable]) {
        NSLog(@"accelerometer is available");
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        __weak typeof(self) weakSelf = self;
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (error) {
                NSLog(@"Error: %@", error.description);
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (accelerometerData) {
                        strongSelf.xLabel.text = [NSString stringWithFormat:@"%f", accelerometerData.acceleration.x];
                        strongSelf.yLabel.text = [NSString stringWithFormat:@"%f", accelerometerData.acceleration.y];
                        strongSelf.zLabel.text = [NSString stringWithFormat:@"%f", accelerometerData.acceleration.z];
                    }
                });
            }
        }];
        
    } else {
        NSLog(@"accelerometer is not available");
    }
    
}


@end
