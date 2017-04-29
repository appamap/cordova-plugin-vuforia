/*===============================================================================
 Copyright (c) 2016 PTC Inc. All Rights Reserved.
 
 Copyright (c) 2012-2015 Qualcomm Connected Experiences, Inc. All Rights Reserved.
 
 Vuforia is a trademark of PTC Inc., registered in the United States and other
 countries.
 ===============================================================================*/

#import "CloudRecoViewController.h"
#import "VuforiaSamplesAppDelegate.h"
#import <Vuforia/Vuforia.h>
#import <Vuforia/TrackerManager.h>
#import <Vuforia/ObjectTracker.h>
#import <Vuforia/Trackable.h>
#import <Vuforia/ImageTarget.h>
#import <Vuforia/TargetFinder.h>
#import <Vuforia/CameraDevice.h>
#import "VuforiaPlugin.h"
#import "UnwindMenuSegue.h"
#import "PresentMenuSegue.h"
#import "SampleAppMenuViewController.h"
#import "ViewController.h"

<<<<<<< HEAD

//liam fix file, UTF ERROR, celened using https://r12a.github.io/apps/conversion/

=======
>>>>>>> cloud_voforia

static const char* const kAccessKey = "efce628c764f89aef73c7b5c0de7925cced8e11f";
static const char* const kSecretKey = "b6bb8b98dff5e78ae88236b6dd6af2d1187a0182";


@interface CloudRecoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *ARViewPlaceholder;

@end

@implementation CloudRecoViewController

@synthesize tapGestureRecognizer, vapp, eaglView;




- (id)initWithOverlayOptions:(NSDictionary *)overlayOptions vuforiaLicenseKey:(NSString *)vuforiaLicenseKey
{
    
    NSLog(@"Vuforia Plugin :: INIT IMAGE TARGETS VIEW CONTROLLER");
    NSLog(@"Vuforia Plugin :: OVERLAY: %@", overlayOptions);
    NSLog(@"Vuforia Plugin :: LICENSE: %@", vuforiaLicenseKey);
    
    self.overlayOptions = overlayOptions;
    self.vuforiaLicenseKey = vuforiaLicenseKey;
    //self = [self initWithNibName:nil bundle:nil];
    
    [self loadOverlay];
    [self scanlineStart];
    
    
    return self;
    
    
}




-(void) buttonClicked:(UIButton*)sender
{
    [self killAll];
    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
}



- (void) killAll
{
    
    bool d = [self doUnloadTrackersData ] ;
    bool s = [self doStopTrackers ] ;
    
    
}

-(void) loadOverlay {
    if(!vapp.cameraIsStarted){
        [self performSelector:@selector(loadOverlay) withObject:nil afterDelay:0.1];
    }else{
        
        // set up the overlay back bar
        
        bool showDevicesIcon = [[self.overlayOptions objectForKey:@"showDevicesIcon"] integerValue];
        
        UIView *vuforiaBarView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 75)];
        vuforiaBarView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        vuforiaBarView.tag = 8;
        [self.view addSubview:vuforiaBarView];
        
        // set up the close button
        UIImage * buttonImage = [UIImage imageNamed:@"close-button.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        button.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 65, (vuforiaBarView.frame.size.height / 2.0) - 30, 60, 60);
        button.tag = 10;
        [vuforiaBarView addSubview:button];
        
        // if the device logo is set by the user
        if(showDevicesIcon) {
            UIImage *image = [UIImage imageNamed:@"iOSDevices.png"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(10, (vuforiaBarView.frame.size.height / 2.0) - 25, 50, 50);
            imageView.tag = 11;
            [vuforiaBarView addSubview:imageView];
        }
        
        // set up the detail label
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, vuforiaBarView.frame.size.width / 2 - button.frame.size.width, 60)];
        [detailLabel setTextColor:[UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.0]];
        [detailLabel setBackgroundColor:[UIColor clearColor]];
        [detailLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 15.0f]];
        
        // get and set the overlay text (if passed by user). if the text is empty, make the back bar transparent
        NSString *overlayText = [self.overlayOptions objectForKey:@"overlayText"];
        
        [detailLabel setText: overlayText];
        detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        detailLabel.numberOfLines = 0;
        detailLabel.tag = 9;
        [detailLabel sizeToFit];
        if([overlayText length] == 0) {
            vuforiaBarView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        }
        
        // if the device icon is to be shown, adapt the text to fit.
        CGRect detailFrame = detailLabel.frame;
        if(showDevicesIcon) {
            detailFrame = CGRectMake(70, 10, [[UIScreen mainScreen] bounds].size.width - 130, detailLabel.frame.size.height);
        }
        else {
            detailFrame = CGRectMake(20, 10, [[UIScreen mainScreen] bounds].size.width - 130, detailLabel.frame.size.height);
        }
        detailLabel.frame = detailFrame;
        [detailLabel sizeToFit];
        [vuforiaBarView addSubview:detailLabel];
        
        if(detailLabel.frame.size.height > button.frame.size.height) {
            CGRect vuforiaFrame = vuforiaBarView.frame;
            vuforiaFrame.size.height = detailLabel.frame.size.height + 25;
            vuforiaBarView.frame = vuforiaFrame;
            
            CGRect buttonFrame = button.frame;
            buttonFrame.origin.y = detailLabel.frame.size.height / 3.0;
            button.frame = buttonFrame;
            
            if(showDevicesIcon) {
                UIImageView *imageView = (UIImageView *)[eaglView viewWithTag:11];
                CGRect imageFrame = imageView.frame;
                imageFrame.origin.y = detailLabel.frame.size.height / 3.0;
                imageView.frame = imageFrame;
            }
        }
    }
}








- (CGRect)getCurrentARViewFrame
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect viewFrame = screenBounds;
    
    // If this device has a retina display, scale the view bounds
    // for the AR (OpenGL) view
    if (YES == vapp.isRetinaDisplay) {
        viewFrame.size.width *= [UIScreen mainScreen].nativeScale;
        viewFrame.size.height *= [UIScreen mainScreen].nativeScale;
    }
    return viewFrame;
}

- (BOOL) isVisualSearchOn {
    return isVisualSearchOn;
}

- (void) setVisualSearchOn:(BOOL) isOn {
    isVisualSearchOn = isOn;
}

- (void)loadView
{
    // Custom initialization
    self.title = @"Cloud Reco";
    
    if (self.ARViewPlaceholder != nil) {
        [self.ARViewPlaceholder removeFromSuperview];
        self.ARViewPlaceholder = nil;
    }
    
    scanningMode = YES;
    isVisualSearchOn = NO;
    
    extendedTrackingEnabled = NO;
    continuousAutofocusEnabled = YES;
    flashEnabled = NO;
    frontCameraEnabled = NO;
    
    vapp = [[SampleApplicationSession alloc] initWithDelegate:self];
    
    CGRect viewFrame = [self getCurrentARViewFrame];
    
    eaglView = [[CloudRecoEAGLView alloc] initWithFrame:viewFrame appSession:vapp viewController:self];
    
    
    [self setView:eaglView];
    
    
    //VuforiaSamplesAppDelegate *appDelegate = (VuforiaSamplesAppDelegate*)[[UIApplication sharedApplication] delegate];
    //appDelegate.glResourceHandler = eaglView;
    
    
    [self scanlineCreate];
    
    // double tap used to also trigger the menu
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(doubleTapGestureAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    // a single tap will trigger a single autofocus operation
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(autofocus:)];
    if (doubleTap != NULL) {
        [tapGestureRecognizer requireGestureRecognizerToFail:doubleTap];
    }
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissARViewController)
                                                 name:@"kDismissARViewController"
                                               object:nil];
    
    // we use the iOS notification to pause/resume the AR when the application goes (or come back from) background
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(pauseAR)
     name:UIApplicationWillResignActiveNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(resumeAR)
     name:UIApplicationDidBecomeActiveNotification
     object:nil];
    
    // initialize AR
    [vapp initAR:Vuforia::GL_20 orientation:self.interfaceOrientation];
    
    // show loading animation while AR is being initialized
    [self showLoadingAnimation];
}

- (void) pauseAR {
    NSError * error = nil;
    if (![vapp pauseAR:&error]) {
        NSLog(@"Error pausing AR:%@", [error description]);
    }
}

- (void) resumeAR {
    NSError * error = nil;
    if(! [vapp resumeAR:&error]) {
        NSLog(@"Error resuming AR:%@", [error description]);
    }
    [eaglView updateRenderingPrimitives];
    // on resume, we reset the flash
    Vuforia::CameraDevice::getInstance().setFlashTorchMode(false);
    flashEnabled = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.showingMenu = NO;
    
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    NSLog(@"self.navigationController.navigationBarHidden: %s", self.navigationController.navigationBarHidden ? "Yes" : "No");
    
    // last error seen - used to avoid seeing twice the same error in the error dialog box
    lastErrorCode = 99;
}

- (void)viewWillDisappear:(BOOL)animated
{
    // on iOS 7, viewWillDisappear may be called when the menu is shown
    // but we don't want to stop the AR view in that case
    if (self.showingMenu) {
        return;
    }
    
    [vapp stopAR:nil];
    
    // Be a good OpenGL ES citizen: now that Vuforia is paused and the render
    // thread is not executing, inform the root view controller that the
    // EAGLView should finish any OpenGL ES commands
    [self finishOpenGLESCommands];
    
    //VuforiaSamplesAppDelegate *appDelegate = (VuforiaSamplesAppDelegate*)[[UIApplication sharedApplication] delegate];
    //appDelegate.glResourceHandler = nil;
    
    [super viewWillDisappear:animated];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)finishOpenGLESCommands
{
    // Called in response to applicationWillResignActive.  Inform the EAGLView
    [eaglView finishOpenGLESCommands];
}

- (void)freeOpenGLESResources
{
    // Called in response to applicationDidEnterBackground.  Inform the EAGLView
    [eaglView freeOpenGLESResources];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showUIAlertFromErrorCode:(int)code
{
    if (lastErrorCode == code)
    {
        // we don't want to show twice the same error
        return;
    }
    lastErrorCode = code;
    
    NSString *title = nil;
    NSString *message = nil;
    
    if (code == Vuforia::TargetFinder::UPDATE_ERROR_NO_NETWORK_CONNECTION)
    {
        title = @"Network Unavailable";
        message = @"Please check your internet connection and try again.";
    }
    else if (code == Vuforia::TargetFinder::UPDATE_ERROR_REQUEST_TIMEOUT)
    {
        title = @"Request Timeout";
        message = @"The network request has timed out, please check your internet connection and try again.";
    }
    else if (code == Vuforia::TargetFinder::UPDATE_ERROR_SERVICE_NOT_AVAILABLE)
    {
        title = @"Service Unavailable";
        message = @"The cloud recognition service is unavailable, please try again later.";
    }
    else if (code == Vuforia::TargetFinder::UPDATE_ERROR_UPDATE_SDK)
    {
        title = @"Unsupported Version";
        message = @"The application is using an unsupported version of Vuforia.";
    }
    else if (code == Vuforia::TargetFinder::UPDATE_ERROR_TIMESTAMP_OUT_OF_RANGE)
    {
        title = @"Clock Sync Error";
        message = @"Please update the date and time and try again.";
    }
    else if (code == Vuforia::TargetFinder::UPDATE_ERROR_AUTHORIZATION_FAILED)
    {
        title = @"Authorization Error";
        message = @"The cloud recognition service access keys are incorrect or have expired.";
    }
    else if (code == Vuforia::TargetFinder::UPDATE_ERROR_PROJECT_SUSPENDED)
    {
        title = @"Authorization Error";
        message = @"The cloud recognition service has been suspended.";
    }
    else if (code == Vuforia::TargetFinder::UPDATE_ERROR_BAD_FRAME_QUALITY)
    {
        title = @"Poor Camera Image";
        message = @"The camera does not have enough detail, please try again later";
    }
    else
    {
        title = @"Unknown error";
        message = [NSString stringWithFormat:@"An unknown error has occurred (Code %d)", code];
    }
    
    //  Call the UIAlert on the main thread to avoid undesired behaviors
    dispatch_async( dispatch_get_main_queue(), ^{
        if (title && message)
        {
            UIAlertView *anAlertView = [[UIAlertView alloc] initWithTitle:title
                                                                  message:message
                                                                 delegate:self
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
            [anAlertView show];
        }
    });
}


#pragma mark - loading animation

- (void) showLoadingAnimation {
    CGRect indicatorBounds;
    CGRect mainBounds = [[UIScreen mainScreen] bounds];
    int smallerBoundsSize = MIN(mainBounds.size.width, mainBounds.size.height);
    int largerBoundsSize = MAX(mainBounds.size.width, mainBounds.size.height);
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown ) {
        indicatorBounds = CGRectMake(smallerBoundsSize / 2 - 12,
                                     largerBoundsSize / 2 - 12, 24, 24);
    }
    else {
        indicatorBounds = CGRectMake(largerBoundsSize / 2 - 12,
                                     smallerBoundsSize / 2 - 12, 24, 24);
    }
    
    UIActivityIndicatorView *loadingIndicator = [[UIActivityIndicatorView alloc]
                                                 initWithFrame:indicatorBounds];
    
    loadingIndicator.tag  = 1;
    loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [eaglView addSubview:loadingIndicator];
    [loadingIndicator startAnimating];
}

- (void) hideLoadingAnimation {
    UIActivityIndicatorView *loadingIndicator = (UIActivityIndicatorView *)[eaglView viewWithTag:1];
    [loadingIndicator removeFromSuperview];
}


#pragma mark - SampleApplicationControl

- (bool) doInitTrackers {
    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
    Vuforia::Tracker* trackerBase = trackerManager.initTracker(Vuforia::ObjectTracker::getClassType());
    // Set the visual search credentials:
    Vuforia::TargetFinder* targetFinder = static_cast<Vuforia::ObjectTracker*>(trackerBase)->getTargetFinder();
    if (targetFinder == NULL)
    {
        NSLog(@"Failed to get target finder.");
        return NO;
    }
    
    NSLog(@"Successfully initialized ObjectTracker.");
    return YES;
}

- (bool) doLoadTrackersData {
    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
    Vuforia::ObjectTracker* objectTracker = static_cast<Vuforia::ObjectTracker*>(trackerManager.getTracker(Vuforia::ObjectTracker::getClassType()));
    if (objectTracker == NULL)
    {
        NSLog(@">doLoadTrackersData>Failed to load tracking data set because the ImageTracker has not been initialized.");
        return NO;
        
    }
    
    // Initialize visual search:
    Vuforia::TargetFinder* targetFinder = objectTracker->getTargetFinder();
    if (targetFinder == NULL)
    {
        NSLog(@">doLoadTrackersData>Failed to get target finder.");
        return NO;
    }
    
    NSDate *start = [NSDate date];
    const char *c_access=[vuforia_access_key UTF8String];
    const char *c_secret=[vuforia_secret_key UTF8String];
    // Start initialization:
    if (targetFinder->startInit(c_access, c_secret))
    {
        targetFinder->waitUntilInitFinished();
        
        NSDate *methodFinish = [NSDate date];
        NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:start];
        
        NSLog(@"waitUntilInitFinished Execution Time: %lf", executionTime);
    }
    
    int resultCode = targetFinder->getInitState();
    if ( resultCode != Vuforia::TargetFinder::INIT_SUCCESS)
    {
        NSLog(@">doLoadTrackersData>Failed to initialize target finder.");
        if (resultCode == Vuforia::TargetFinder::INIT_ERROR_NO_NETWORK_CONNECTION) {
            NSLog(@"CloudReco error:Vuforia::TargetFinder::INIT_ERROR_NO_NETWORK_CONNECTION");
        } else if (resultCode == Vuforia::TargetFinder::INIT_ERROR_SERVICE_NOT_AVAILABLE) {
            NSLog(@"CloudReco error:Vuforia::TargetFinder::INIT_ERROR_SERVICE_NOT_AVAILABLE");
        } else {
            NSLog(@"CloudReco error:%d", resultCode);
        }
        
        int initErrorCode;
        if(resultCode == Vuforia::TargetFinder::INIT_ERROR_NO_NETWORK_CONNECTION)
        {
            initErrorCode = Vuforia::TargetFinder::UPDATE_ERROR_NO_NETWORK_CONNECTION;
        }
        else
        {
            initErrorCode = Vuforia::TargetFinder::UPDATE_ERROR_SERVICE_NOT_AVAILABLE;
        }
        [self showUIAlertFromErrorCode: initErrorCode];
        return NO;
    } else {
        NSLog(@">doLoadTrackersData>target finder initialized");
    }
    
    return YES;
}

- (bool) doStartTrackers {
    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
    
    Vuforia::ObjectTracker* objectTracker = static_cast<Vuforia::ObjectTracker*>(
                                                                                 trackerManager.getTracker(Vuforia::ObjectTracker::getClassType()));
    if (objectTracker == 0) {
        NSLog(@"Failed to start Object Tracker, as it is null.");
        return NO;
    }
    objectTracker->start();
    
    // Start cloud based recognition if we are in scanning mode:
    if (scanningMode)
    {
        Vuforia::TargetFinder* targetFinder = objectTracker->getTargetFinder();
        if (targetFinder != 0) {
            isVisualSearchOn = targetFinder->startRecognition();
        }
    }
    return YES;
}

- (void) onInitARDone:(NSError *)initError {
    // remove loading animation
    UIActivityIndicatorView *loadingIndicator = (UIActivityIndicatorView *)[eaglView viewWithTag:1];
    [loadingIndicator removeFromSuperview];
    
    if (initError == nil) {
        NSError * error = nil;
        [vapp startAR:Vuforia::CameraDevice::CAMERA_DIRECTION_BACK error:&error];
        
        [eaglView updateRenderingPrimitives];
        
        // by default, we try to set the continuous auto focus mode
        // and we update menu to reflect the state of continuous auto-focus
        continuousAutofocusEnabled = Vuforia::CameraDevice::getInstance().setFocusMode(Vuforia::CameraDevice::FOCUS_MODE_CONTINUOUSAUTO);
        
        [self scanlineStart];
        
    } else {
        NSLog(@"Error initializing AR:%@", [initError description]);
        
        dispatch_async( dispatch_get_main_queue(), ^{
            [self killAll];
            [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
            
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
            //                                                            message:[initError localizedDescription]
            //                                                           delegate:self
            //                                                  cancelButtonTitle:@"OK"
            //                                                  otherButtonTitles:nil];
            //            [alert show];
        });
    }
}

- (bool) doStopTrackers {
    // Stop the tracker
    // Stop the tracker:
    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
    Vuforia::ObjectTracker* objectTracker = static_cast<Vuforia::ObjectTracker*>(
                                                                                 trackerManager.getTracker(Vuforia::ObjectTracker::getClassType()));
    if(objectTracker != 0) {
        objectTracker->stop();
        
        // Stop cloud based recognition:
        Vuforia::TargetFinder* targetFinder = objectTracker->getTargetFinder();
        if (targetFinder != 0) {
            isVisualSearchOn = !targetFinder->stop();
        }
    }
    return YES;
}

- (bool) doUnloadTrackersData {
    // Get the image tracker:
    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
    Vuforia::ObjectTracker* objectTracker = static_cast<Vuforia::ObjectTracker*>(trackerManager.getTracker(Vuforia::ObjectTracker::getClassType()));
    
    if (objectTracker == NULL)
    {
        NSLog(@"Failed to unload tracking data set because the ObjectTracker has not been initialized.");
        return NO;
    }
    
    // Deinitialize visual search:
    Vuforia::TargetFinder* finder = objectTracker->getTargetFinder();
    finder->deinit();
    return YES;
}

- (bool) doDeinitTrackers {
    return YES;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kDismissARViewController" object:nil];
}

- (void)dismissARViewController
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)configureVideoBackgroundWithViewWidth:(float)viewWidth andHeight:(float)viewHeight
{
    [eaglView configureVideoBackgroundWithViewWidth:(float)viewWidth andHeight:(float)viewHeight];
}

// update from the Vuforia loop
- (void) onVuforiaUpdate: (Vuforia::State *) state {
    // Get the tracker manager:
    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
    
    ;
    
    // Get the image tracker:
    Vuforia::ObjectTracker* objectTracker = static_cast<Vuforia::ObjectTracker*>(trackerManager.getTracker(Vuforia::ObjectTracker::getClassType()));
    
    // Get the target finder:
    Vuforia::TargetFinder* finder = objectTracker->getTargetFinder();
    
    // Check if there are new results available:
    const int statusCode = finder->updateSearchResults();
    if (statusCode < 0)
    {
        // Show a message if we encountered an error:
        NSLog(@"update search result failed:%d", statusCode);
        if (statusCode == Vuforia::TargetFinder::UPDATE_ERROR_NO_NETWORK_CONNECTION) {
            [self showUIAlertFromErrorCode:statusCode];
        }
    }
    else if (statusCode == Vuforia::TargetFinder::UPDATE_RESULTS_AVAILABLE)
    {
        
        // Iterate through the new results:
        for (int i = 0; i < finder->getResultCount(); ++i)
        {
            const Vuforia::TargetSearchResult* result = finder->getResult(i);
            
            
            //liams change, this is the meta data object
            
            /*
             
             
             {
             "array": [
             1,
             2,
             3
             ],
             "boolean": true,
             "null": null,
             "number": 123,
             "object": {
<<<<<<< HEAD
             \u0102\u0084\u00C2\u0082\u0102\u008B\u00C2\u0098\u00C4\u0082\u00C2\u0082\u0102\u0082\u00C2\u0080\u00C4\u0082\u00C2\u0082\u0102\u0082\u00C2\u009Curl\u0102\u0084\u00C2\u0082\u0102\u008B\u00C2\u0098\u00C4\u0082\u00C2\u0082\u0102\u0082\u00C2\u0080\u00C4\u0082\u00C2\u0082\u0102\u0082\u00C2\u009D: "https://s3-eu-west-1.amazonaws.com/eventrotrails/-KXj_7o6Ds-VCKx0C1CC-locationvr",
=======
             Ă˘ÂÂurlĂ˘ÂÂ: "https://s3-eu-west-1.amazonaws.com/eventrotrails/-KXj_7o6Ds-VCKx0C1CC-locationvr",
>>>>>>> cloud_voforia
             "c": "d",
             "e": "f"
             },
             "string": "Hello World"
             }
             
             
             */
            
            
            
            NSString *meta = [NSString stringWithUTF8String:result->getMetaData()];
            NSData *data = [meta dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            id jso=[json objectForKey:@"object"];
            NSString *url=[NSString stringWithFormat:@"%@",[jso objectForKey:@"url"]];
            //            NSString *url=@"https://s3-eu-west-1.amazonaws.com/eventrotrails/-KXj_7o6Ds-VCKx0C1CC-locationvr";
            //            vuforia_cs_key=@"a";
            
            //            CDVPluginResult* pluginResult = nil;
            if ([url isEqual:[NSNull null]]){
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    CDVPluginResult *pluginResult = [ CDVPluginResult
                                                     resultWithStatus    : CDVCommandStatus_OK
                                                     messageAsString: url
                                                     ];
                    [vplug.commandDelegate sendPluginResult:pluginResult callbackId:vuforia_command_id];
                });
            }
            
            // Check if this target is suitable for tracking:
            // if (result->getTrackingRating() > 0)
            // {
            //     // Create a new Trackable from the result:
            //     Vuforia::Trackable* newTrackable = finder->enableTracking(*result);
            //     if (newTrackable != 0)
            //     {
            //         //  Avoid entering on ContentMode when a bad target is found
            //         //  (Bad Targets are targets that are exists on the CloudReco database but not on our
            //         //  own book database)
            //         NSLog(@"Successfully created new trackable '%s' with rating '%d'.",
            //               newTrackable->getName(), result->getTrackingRating());
            //         if (extendedTrackingEnabled) {
            //             newTrackable->startExtendedTracking();
            //         }
            //     }
            //     else
            //     {
            //         NSLog(@"Failed to create new trackable.");
            //     }
            // }
            
            
        }
    }
    
}

- (void) toggleVisualSearch {
    [self toggleVisualSearch:isVisualSearchOn];
}






- (void) toggleVisualSearch:(BOOL)visualSearchOn
{
    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
    Vuforia::ObjectTracker* objectTracker = static_cast<Vuforia::ObjectTracker*>(trackerManager.getTracker(Vuforia::ObjectTracker::getClassType()));
    
    if (objectTracker == 0) {
        NSLog(@"Failed to toggle Visual Search, as Object Tracker is null.");
        return;
    }
    
    
    //Vuforia::TrackableResult* tr = state.getTrackableResult(0);
    
    Vuforia::TargetFinder* targetFinder = objectTracker->getTargetFinder();
    
    
    
    if (visualSearchOn == NO)
    {
        NSLog(@"Starting target finder");
        [self scanlineStart];
        targetFinder->startRecognition();
        isVisualSearchOn = YES;
    }
    else
    {
        NSLog(@"Stopping target finder");
        [self scanlineStop];
        targetFinder->stop();
        isVisualSearchOn = NO;
    }
}


- (void)autofocus:(UITapGestureRecognizer *)sender
{
    [self performSelector:@selector(cameraPerformAutoFocus) withObject:nil afterDelay:.4];
}

- (void)cameraPerformAutoFocus
{
    Vuforia::CameraDevice::getInstance().setFocusMode(Vuforia::CameraDevice::FOCUS_MODE_TRIGGERAUTO);
    
    // After triggering an autofocus event,
    // we must restore the previous focus mode
    if (continuousAutofocusEnabled)
    {
        [self performSelector:@selector(restoreContinuousAutoFocus) withObject:nil afterDelay:2.0];
    }
}

- (void)restoreContinuousAutoFocus
{
    Vuforia::CameraDevice::getInstance().setFocusMode(Vuforia::CameraDevice::FOCUS_MODE_CONTINUOUSAUTO);
}

- (void)doubleTapGestureAction:(UITapGestureRecognizer*)theGesture
{
    if (!self.showingMenu) {
        [self performSegueWithIdentifier: @"PresentMenu" sender: self];
    }
}

- (void)swipeGestureAction:(UISwipeGestureRecognizer*)gesture
{
    if (!self.showingMenu) {
        [self performSegueWithIdentifier:@"PresentMenu" sender:self];
    }
}


- (void) setOffTargetTracking:(BOOL) isActive {
    Vuforia::TrackerManager& trackerManager = Vuforia::TrackerManager::getInstance();
    Vuforia::ObjectTracker* objectTracker = static_cast<Vuforia::ObjectTracker*>(trackerManager.getTracker(Vuforia::ObjectTracker::getClassType()));
    
    if (objectTracker == 0) {
        NSLog(@"Failed to enable Extended Tracking, as the Object Tracker is null.");
        return;
    }
    
    Vuforia::TargetFinder* targetFinder = objectTracker->getTargetFinder();
    int nbTargets = targetFinder->getNumImageTargets();
    for(int idx = 0; idx < nbTargets ; idx++) {
        Vuforia::ImageTarget * it = targetFinder->getImageTarget(idx);
        if (it != NULL) {
            if (isActive) {
                it->startExtendedTracking();
            } else {
                it->stopExtendedTracking();
            }
        }
    }
}


#pragma mark - menu delegate protocol implementation

- (BOOL) menuProcess:(NSString *)itemName value:(BOOL)value
{
    if ([@"Extended Tracking" isEqualToString:itemName]) {
        extendedTrackingEnabled = value;
        [self setOffTargetTracking:extendedTrackingEnabled];
        return YES;
    }
    return NO;
}

- (void) menuDidExit
{
    self.showingMenu = NO;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue isKindOfClass:[PresentMenuSegue class]]) {
        UIViewController *dest = [segue destinationViewController];
        if ([dest isKindOfClass:[SampleAppMenuViewController class]]) {
            self.showingMenu = YES;
            
            SampleAppMenuViewController *menuVC = (SampleAppMenuViewController *)dest;
            menuVC.menuDelegate = self;
            menuVC.sampleAppFeatureName = @"Cloud Reco";
            menuVC.dismissItemName = @"Vuforia Samples";
            menuVC.backSegueId = @"BackToCloudReco";
            
            // initialize menu item values (ON / OFF)
            [menuVC setValue:extendedTrackingEnabled forMenuItem:@"Extended Tracking"];
        }
    }
}



#pragma mark - scan line
const int VIEW_SCAN_LINE_TAG = 1111;

- (void) scanlineCreate {
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    UIImageView *scanLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
    scanLineView.tag = VIEW_SCAN_LINE_TAG;
    scanLineView.contentMode = UIViewContentModeScaleToFill;
    [scanLineView setImage:[UIImage imageNamed:@"scanline.png"]];
    [scanLineView setHidden:YES];
    [self.view addSubview:scanLineView];
}

- (void) scanlineStart {
    UIView * scanLineView = [self.view viewWithTag:VIEW_SCAN_LINE_TAG];
    if (scanLineView) {
        [scanLineView setHidden:NO];
        CGRect frame = [[UIScreen mainScreen] bounds];
        
        CABasicAnimation *animation = [CABasicAnimation
                                       animationWithKeyPath:@"position"];
        
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(scanLineView.center.x, frame.size.height)];
        animation.autoreverses = YES;
        animation.duration = 4.0;
        animation.repeatCount = HUGE_VAL;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [scanLineView.layer addAnimation:animation forKey:@"position"];
    }
}

- (void) scanlineStop {
    UIView * scanLineView = [self.view viewWithTag:VIEW_SCAN_LINE_TAG];
    if (scanLineView) {
        [scanLineView setHidden:YES];
        [scanLineView.layer removeAllAnimations];
    }
}


@end
