//
//  LocalOutlineViewController.m
//  Preference Creator
//
//  Created by Yoann Gini on 16/07/2017.
//  Copyright © 2017 Yoann Gini. All rights reserved.
//

#import "LocalOutlineViewController.h"

#import "ManifestBrowserViewController.h"

@interface LocalOutlineViewController ()

@end

@implementation LocalOutlineViewController

- (void)triggerActionPannelToSelectPreferenceManifest {
    [self performSegueWithIdentifier:@"PresentManifestBrowser"
                              sender:self];
}

-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PresentManifestBrowser"]) {
        ManifestBrowserViewController *targetBrowserViewController = segue.destinationController;
        targetBrowserViewController.originalOutlineViewController = self;
    }
}

@end
