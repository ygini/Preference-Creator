//
//  ManifestBrowserViewController.m
//  Preference Creator
//
//  Created by Yoann Gini on 16/07/2017.
//  Copyright © 2017 Yoann Gini. All rights reserved.
//

#import "ManifestBrowserViewController.h"
#import <PFM/PFM.h>
#import "ManifestPreviewViewController.h"

@interface ManifestBrowserViewController () <NSBrowserDelegate>
@property (strong) IBOutlet NSButton *okButton;
@property (strong) IBOutlet NSBrowser *manifestsBrowser;
@property ManifestPreviewViewController *previewViewController;
@end

@implementation ManifestBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[PFMManifestProvider sharedInstance] reloadManifests];
}

#pragma mark - Actions

- (IBAction)acceptCurrentSelection:(id)sender {
    id selectedItem = [self.manifestsBrowser itemAtIndexPath:self.manifestsBrowser.selectionIndexPath];
    
    if ([selectedItem isKindOfClass:[PFMPreferenceManifest class]]) {
        [self dismissController:self];
        self.originalOutlineViewController.preferenceManifest = selectedItem;
        [self.originalOutlineViewController manifestSelectionIsDone];
    }
}

- (IBAction)cancelSelection:(id)sender {
    [self dismissController:self];
    [self.originalOutlineViewController manifestSelectionCancelled];
}


#pragma mark - Toolbox

- (NSArray*)sortedArray:(NSArray*)arrayToSort {
    return [arrayToSort sortedArrayUsingSelector:@selector(compare:)];
}

- (NSDictionary*)manifestSource {
    if (self.useGlobalySharedManifests) {
        return [PFMManifestProvider sharedInstance].globalManifestsPerSourceAndName;
    } else {
        return [PFMManifestProvider sharedInstance].manifestsPerSourceAndDomain;
    }
}

- (NSString*)displayLabelForPreferenceManifest:(PFMPreferenceManifest*)preferenceManifest {
    if (self.useGlobalySharedManifests) {
        return preferenceManifest.pfm_title;
    } else {
        return preferenceManifest.pfm_title;
    }
}

#pragma mark - NSBrowserDelegate

-(id)rootItemForBrowser:(NSBrowser *)browser {
    return [self manifestSource];
}

- (NSInteger)browser:(NSBrowser *)browser numberOfChildrenOfItem:(NSDictionary*)item {
    return [[item allKeys] count];
}

- (id)browser:(NSBrowser *)browser child:(NSInteger)index ofItem:(NSDictionary*)item {
    return [item objectForKey:[[self sortedArray:[item allKeys]] objectAtIndex:index]];
}

- (BOOL)browser:(NSBrowser *)browser isLeafItem:(id)item {
    return [item isKindOfClass:[PFMPreferenceManifest class]];
}

- (id)browser:(NSBrowser *)browser objectValueForItem:(id)item {
    if ([item isKindOfClass:[PFMPreferenceManifest class]]) {
        return [self displayLabelForPreferenceManifest:(PFMPreferenceManifest*)item];
    } else {
        return [[[self manifestSource] allKeysForObject:item] lastObject];
    }
}

-(NSViewController *)browser:(NSBrowser *)browser previewViewControllerForLeafItem:(PFMPreferenceManifest*)item {
    if (!self.previewViewController) {
        self.previewViewController = [[ManifestPreviewViewController alloc] initWithNibName:@"ManifestPreviewViewController" bundle:[NSBundle bundleForClass:[self class]]];
    }
    self.previewViewController.manifest = item;
    return self.previewViewController;
}

- (CGFloat)browser:(NSBrowser *)browser shouldSizeColumn:(NSInteger)columnIndex forUserResize:(BOOL)forUserResize toWidth:(CGFloat)suggestedWidth  {
    if (!forUserResize) {
        id item = [browser parentForItemsInColumn:columnIndex];
        if ([self browser:browser isLeafItem:item]) {
            suggestedWidth = 250;
        }
    }
    return suggestedWidth;
}

- (NSIndexSet *)browser:(NSBrowser *)browser selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes inColumn:(NSInteger)column {
    NSIndexPath *indexPath = [browser indexPathForColumn:column];
    
    if ([proposedSelectionIndexes count] > 0) {
        indexPath = [indexPath indexPathByAddingIndex:[proposedSelectionIndexes lastIndex]];
    }
    
    id selectedItem = [browser itemAtIndexPath:indexPath];
    
    self.okButton.enabled = [selectedItem isKindOfClass:[PFMPreferenceManifest class]];
    return proposedSelectionIndexes;
}

@end
