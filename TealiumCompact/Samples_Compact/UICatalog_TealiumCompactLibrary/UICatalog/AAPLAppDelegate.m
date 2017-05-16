/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The application-specific delegate class.
*/

#import "AAPLAppDelegate.h"
#import <TealiumLibrary/Tealium.h>

@interface AAPLAppDelegate() <UISplitViewControllerDelegate>
@end

@implementation AAPLAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    
    splitViewController.delegate = self;
    splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;

    [Tealium initSharedInstance:@"hyatt" profile:@"mobileappios" target:@"dev"];
    
    [Tealium addRemoteCommandId:@"testCommand"
                    description:@"Remote code trigger test"
                    targetQueue:dispatch_get_main_queue()
                          block:^(TealiumRemoteCommandResponse *response) {
                              
                              NSLog(@"Tag Bridge testCommand triggered! Testing123");
                              
                          }];
    
    return YES;
}

#pragma mark - UISplitViewControllerDelegate

- (UISplitViewControllerDisplayMode)targetDisplayModeForActionInSplitViewController:(UISplitViewController *)splitViewController {
    return UISplitViewControllerDisplayModeAllVisible;
}

@end
