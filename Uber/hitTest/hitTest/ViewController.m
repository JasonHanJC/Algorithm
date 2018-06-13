//
//  ViewController.m
//  hitTest
//
//  Created by Juncheng Han on 2/15/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import "ViewController.h"
#import "LargerHitView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end

@implementation ViewController
- (IBAction)segmentTapped:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"0");
    } else {
        NSLog(@"%ld", sender.selectedSegmentIndex);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LargerHitView *testView = [[LargerHitView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    testView.backgroundColor = [UIColor redColor];
    testView.center = self.view.center;
    testView.userInteractionEnabled = true;
    
    [self.view addSubview:testView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [testView addGestureRecognizer:tap];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // <#code to be executed after a specified delay#>
    });
}

- (void)tap:(UITapGestureRecognizer *)sender {
    
    NSLog(@"taped");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
