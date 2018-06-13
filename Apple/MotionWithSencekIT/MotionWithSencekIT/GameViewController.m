//
//  GameViewController.m
//  MotionWithSencekIT
//
//  Created by Juncheng Han on 2/25/18.
//  Copyright © 2018 Jason H. All rights reserved.
//

#import "GameViewController.h"
#import <CoreMotion/CoreMotion.h>


@interface InitialAttitude: NSObject

@property (nonatomic, assign) double roll;
@property (nonatomic, assign) double pitch;
@property (nonatomic, assign) double yaw;

- (instancetype)initWithRoll:(double)roll andPitch:(double)pitch andYaw:(double)yaw;

@end

@implementation InitialAttitude

- (instancetype)initWithRoll:(double)roll andPitch:(double)pitch andYaw:(double)yaw {
    self = [super init];
    
    if (self) {
        _roll = roll;
        _pitch = pitch;
        _yaw = yaw;
    }
    
    return self;
}

@end



@interface GameViewController()

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) SCNNode *cameraNode;
@property (nonatomic, strong) SCNNode *cameraOrbitNode;
@property (nonatomic, strong) SCNNode *ship;

@property (nonatomic, strong) CMAttitude *initialAttitude;

@end

@implementation GameViewController

#pragma mark - properties

- (CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = 1/10;
        self.initialAttitude = _motionManager.deviceMotion.attitude;
    }
    return _motionManager;
}

#pragma mark - lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // create a new scene
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];

    // create and add a camera to the scene
    self.cameraNode = [SCNNode node];
    self.cameraNode.camera = [SCNCamera camera];
    self.cameraNode.position = SCNVector3Make(0, 0, 15);
    
    // create a orbit node
    self.cameraOrbitNode = [SCNNode node];
    [self.cameraOrbitNode addChildNode:self.cameraNode];
    
    [scene.rootNode addChildNode:self.cameraOrbitNode];
    
    
    NSLog(@"%f %f %f", self.cameraNode.eulerAngles.x, self.cameraNode.eulerAngles.y, self.cameraNode.eulerAngles.z);
    
    // create and add a light to the scene
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.position = SCNVector3Make(0, 10, 10);
    [scene.rootNode addChildNode:lightNode];
    
    // create and add an ambient light to the scene
    SCNNode *ambientLightNode = [SCNNode node];
    ambientLightNode.light = [SCNLight light];
    ambientLightNode.light.type = SCNLightTypeAmbient;
    ambientLightNode.light.color = [UIColor darkGrayColor];
    [scene.rootNode addChildNode:ambientLightNode];
    
    // retrieve the ship node
    self.ship = [scene.rootNode childNodeWithName:@"ship" recursively:YES];
    
    // animate the 3d object
    // [ship runAction:[SCNAction repeatActionForever:[SCNAction rotateByX:0 y:2 z:0 duration:1]]];
    
    // retrieve the SCNView
    SCNView *scnView = (SCNView *)self.view;
    
    // set the scene to the view
    scnView.scene = scene;
    
    // allows the user to manipulate the camera
    scnView.allowsCameraControl = NO;
        
    // show statistics such as fps and timing information
    scnView.showsStatistics = YES;

    // configure the view
    scnView.backgroundColor = [UIColor blackColor];
    
    // add a tap gesture recognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:scnView.gestureRecognizers];
    scnView.gestureRecognizers = gestureRecognizers;
    
    
    // configure motion manager
    if (![self.motionManager isDeviceMotionAvailable]) {
        NSAssert(NO, @"Device motion is not available.");
    }
    
    __weak typeof(self) weakSelf = self;
    [self.motionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSAssert(!error, error.description);
        
        // return;
        if (motion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (strongSelf.initialAttitude == nil)
                {
                    strongSelf.initialAttitude = motion.attitude;
                }
                
                CMAttitude *attitude = motion.attitude;
                [attitude multiplyByInverseOfAttitude:strongSelf.initialAttitude];
                //strongSelf.ship.eulerAngles = SCNVector3Make(attitude.pitch, attitude.yaw, attitude.roll);
                strongSelf.cameraOrbitNode.eulerAngles = SCNVector3Make(attitude.pitch, attitude.yaw, attitude.roll);
            
            });
        }
        
    }];

}


- (void) handleTap:(UIGestureRecognizer*)gestureRecognize
{
    // retrieve the SCNView
    SCNView *scnView = (SCNView *)self.view;
    
    // check what nodes are tapped
    CGPoint p = [gestureRecognize locationInView:scnView];
    NSArray *hitResults = [scnView hitTest:p options:nil];
    
    // check that we clicked on at least one object
    if([hitResults count] > 0){
        // retrieved the first clicked object
        SCNHitTestResult *result = [hitResults objectAtIndex:0];
        
        // get its material
        SCNMaterial *material = result.node.geometry.firstMaterial;
        
        // highlight it
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.5];
        
        // on completion - unhighlight
        [SCNTransaction setCompletionBlock:^{
            [SCNTransaction begin];
            [SCNTransaction setAnimationDuration:0.5];
            
            material.emission.contents = [UIColor blackColor];
            
            [SCNTransaction commit];
        }];
        
        material.emission.contents = [UIColor redColor];
        
        [SCNTransaction commit];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
