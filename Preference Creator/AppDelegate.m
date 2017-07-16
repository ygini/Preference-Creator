//
//  AppDelegate.m
//  Preference Creator
//
//  Created by Yoann Gini on 16/07/2017.
//  Copyright © 2017 Yoann Gini. All rights reserved.
//

#import "AppDelegate.h"
#import <PFM/PFM.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{
                                                              kPFMManifestsSources: @[
                                                                      @{
                                                                          kPFMManifestsSourceName: @"Apple Configurator 2",
                                                                          kPFMManifestsSourcePath: @"/Applications/Apple Configurator 2.app/Contents/Frameworks/ConfigurationProfile.framework/Versions/A/Resources",
                                                                          }
                                                                      ]
                                                              }];
    

}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
