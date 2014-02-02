//
//  RPViewController.m
//  Demo
//
//  Created by Rui Peres on 02/02/2014.
//  Copyright (c) 2014 Demo. All rights reserved.
//

#import "RPViewController.h"
#import "RPDynamicWarningView.h"

@implementation RPViewController

- (void)removeDynamicLocationView:(RPDynamicWarningView *)dynamic
{
    //[dynamic stopDynamicLocationWithCompletionBlock:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    RPDynamicWarningView *locationView = [[RPDynamicWarningView alloc] initWithText:@"We can't find you kind sir..." imageName:@"marker_icn.png"];
    
    [self.view addSubview:locationView];
    locationView.center = self.view.center;
    
    [self performSelector:@selector(removeDynamicLocationView:) withObject:locationView afterDelay:5.0f];
}

@end
