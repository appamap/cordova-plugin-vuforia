/*===============================================================================
Copyright (c) 2016 PTC Inc. All Rights Reserved.

Copyright (c) 2012-2015 Qualcomm Connected Experiences, Inc. All Rights Reserved.

Vuforia is a trademark of PTC Inc., registered in the United States and other 
countries.
===============================================================================*/

#import <UIKit/UIKit.h>
#import "VuforiaPlugin.h"
#import "CloudRecoEAGLView.h"
#import "SampleApplicationSession.h"
#import "SampleAppMenuViewController.h"
#import <Vuforia/DataSet.h>
#import <Cordova/CDV.h>

@interface CloudRecoViewController : UIViewController <SampleApplicationControl, SampleAppMenuDelegate, UIAlertViewDelegate> {
    
    
    
    BOOL scanningMode;
    BOOL isVisualSearchOn;
    
    int lastErrorCode;
    
    // menu options
    BOOL extendedTrackingEnabled;
    BOOL continuousAutofocusEnabled;
    BOOL flashEnabled;
    BOOL frontCameraEnabled;
}

@property (nonatomic, strong) CloudRecoEAGLView* eaglView;
@property (nonatomic, strong) UITapGestureRecognizer * tapGestureRecognizer;
@property (nonatomic, strong) SampleApplicationSession * vapp;

@property (nonatomic, readwrite) BOOL showingMenu;

@property (retain) NSString *imageTargetFile;
@property (retain) NSArray *imageTargetNames;
@property (retain) NSString *overlayText;
@property (retain) NSDictionary *overlayOptions;
@property (retain) NSString *vuforiaLicenseKey;



- (BOOL) isVisualSearchOn;
- (void) toggleVisualSearch;
- (id)initWithOverlayOptions:(NSDictionary *)overlayOptions vuforiaLicenseKey:(NSString *)vuforiaLicenseKey;
-(void) buttonClicked:(UIButton*)sender;

@end
