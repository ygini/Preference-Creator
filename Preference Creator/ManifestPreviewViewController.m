//
//  ManifestPreviewViewController.m
//  Preference Creator
//
//  Created by Yoann Gini on 16/07/2017.
//  Copyright © 2017 Yoann Gini. All rights reserved.
//

#import "ManifestPreviewViewController.h"

@interface ManifestPreviewViewController ()
@property (strong) IBOutlet NSTextField *domainLabel;
@property (strong) IBOutlet NSTextField *nameLabel;
@property (strong) IBOutlet NSTextField *descriptionLabel;

@end

@implementation ManifestPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (void)viewWillAppear {
    self.domainLabel.stringValue = self.manifest.pfm_domain;
    self.nameLabel.stringValue = self.manifest.pfm_title;
    self.descriptionLabel.stringValue = self.manifest.pfm_description;
}

@end
