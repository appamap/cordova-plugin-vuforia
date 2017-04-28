#import "ViewController.h"
#import "CloudRecoViewController.h"
#import "VuforiaPlugin.h"

//VideoPlaybackViewController

#import <Vuforia/TrackerManager.h>
#import <Vuforia/ObjectTracker.h>

@interface ViewController ()

@property BOOL launchedCamera;
@property CloudRecoViewController *imageTargetsViewController;


@end

@implementation ViewController
NSString *vuforia_key=@"";
NSString *vuforia_access_key=@"";
NSString *vuforia_secret_key=@"";
NSString *vuforia_command_id=@"";
VuforiaPlugin *vplug;
CDVPluginResult *presult;

-(id)initWithFileName:(NSString *)fileName targetNames:(NSArray *)imageTargetNames overlayOptions:( NSDictionary *)overlayOptions vuforiaLicenseKey:(NSString *)vuforiaLicenseKey {

    self = [super init];
    self.imageTargets = [[NSDictionary alloc] initWithObjectsAndKeys: fileName, @"imageTargetFile", imageTargetNames, @"imageTargetNames", nil];
    self.overlayOptions = overlayOptions;
    self.vuforiaLicenseKey = vuforiaLicenseKey;
    NSLog(@"Vuforia Plugin :: initWithFileName: %@", fileName);
    NSLog(@"Vuforia Plugin :: overlayOptions: %@", self.overlayOptions);
    NSLog(@"Vuforia Plugin :: License key: %@", self.vuforiaLicenseKey);
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];

    NSLog(@"Vuforia Plugin :: viewController did load");
    self.launchedCamera = false;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (self.launchedCamera == false) {
        
        
        self.imageTargetsViewController = [[CloudRecoViewController alloc] initWithOverlayOptions:self.overlayOptions vuforiaLicenseKey:vuforia_key];
        self.launchedCamera = true;

       // self.VideoPlaybackViewController.imageTargetFile = [self.imageTargets objectForKey:@"imageTargetFile"];
        //self.VideoPlaybackViewController.imageTargetNames = [self.imageTargets objectForKey:@"imageTargetNames"];

        [self presentViewController:self.imageTargetsViewController animated:NO completion:nil];
    }
    else
    {
         [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (bool) stopTrackers {
    return [self.imageTargetsViewController doStopTrackers];
}

- (bool) startTrackers {
    return [self.imageTargetsViewController doStartTrackers];
}

- (bool) updateTargets:(NSArray *)targets {
   // return [self.imageTargetsViewController doUpdateTargets:targets];
}

- (void) close{
    [self.imageTargetsViewController dismissViewControllerAnimated:NO completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissMe {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CameraHasFound" object:self];
}

- (BOOL)shouldAutorotate {
    return [[self presentingViewController] shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [[self presentingViewController] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self presentingViewController] preferredInterfaceOrientationForPresentation];
}

@end
