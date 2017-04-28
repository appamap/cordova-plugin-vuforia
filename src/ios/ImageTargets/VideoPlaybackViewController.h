/*===============================================================================
Copyright (c) 2016 PTC Inc. All Rights Reserved.

Copyright (c) 2012-2015 Qualcomm Connected Experiences, Inc. All Rights Reserved.

Vuforia is a trademark of PTC Inc., registered in the United States and other 
countries.
===============================================================================*/

#import <UIKit/UIKit.h>
#import "VideoPlaybackEAGLView.h"
#import "ApplicationSession.h"
#import <Vuforia/DataSet.h>

@interface VideoPlaybackViewController : UIViewController <ApplicationControl> {
    
    Vuforia::DataSet*  dataSet;
    BOOL fullScreenPlayerPlaying;
    CGRect viewFrame;
    Vuforia::DataSet*  dataSetCurrent;
    Vuforia::DataSet*  dataSetTargets;
    
    // menu options
    BOOL extendedTrackingEnabled;
    BOOL continuousAutofocusEnabled;
    BOOL flashEnabled;
    BOOL playFullscreenEnabled;
    BOOL frontCameraEnabled;
    
    BOOL switchToTarmac;
    BOOL switchToStonesAndChips;
    BOOL extendedTrackingIsOn;
    
    
    ApplicationSession *vapp;
}

- (void)rootViewControllerPresentViewController:(UIViewController*)viewController inContext:(BOOL)currentContext;
- (void)rootViewControllerDismissPresentedViewController;
- (id)initWithOverlayOptions:(NSDictionary *)overlayOptions vuforiaLicenseKey:(NSString *)vuforiaLicenseKey;
- (void) killAll;

@property (nonatomic, strong) VideoPlaybackEAGLView* eaglView;
@property (nonatomic, strong) UITapGestureRecognizer * tapGestureRecognizer;


@property (retain) NSString *imageTargetFile;
@property (retain) NSArray *imageTargetNames;
@property (retain) NSString *overlayText;
@property (retain) NSDictionary *overlayOptions;
@property (retain) NSString *vuforiaLicenseKey;

@property (nonatomic) bool delaying;



@property (nonatomic, readwrite) BOOL showingMenu;

@end
