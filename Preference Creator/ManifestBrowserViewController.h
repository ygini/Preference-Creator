//
//  ManifestBrowserViewController.h
//  Preference Creator
//
//  Created by Yoann Gini on 16/07/2017.
//  Copyright © 2017 Yoann Gini. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "LocalOutlineViewController.h"

@interface ManifestBrowserViewController : NSViewController

@property BOOL useGlobalySharedManifests;
@property (weak) LocalOutlineViewController *originalOutlineViewController;

@end
