#import <UIKit/UIKit.h>
#import "VuforiaPlugin.h"
@interface ViewController : UIViewController

@property (retain, nonatomic) NSDictionary *imageTargets;
@property (retain, nonatomic) NSDictionary *overlayOptions;
@property (retain, nonatomic) NSString *overlayText;
@property (retain, nonatomic) NSString *vuforiaLicenseKey;
@property (retain, nonatomic) UIViewController *vc;


extern NSString *vuforia_key;
extern NSString *vuforia_access_key;
extern NSString *vuforia_secret_key;
extern NSString *vuforia_command_id;
extern VuforiaPlugin *vplug;
extern CDVPluginResult *presult;

-(id)initWithFileName:(NSString *)fileName targetNames:(NSArray *)imageTargetNames overlayOptions:(NSDictionary*)overlayOptions vuforiaLicenseKey:(NSString *)vuforiaLicenseKey;
- (bool) stopTrackers;
- (bool) startTrackers;
- (bool) updateTargets:(NSArray *)targets;
- (void) close;
@end
