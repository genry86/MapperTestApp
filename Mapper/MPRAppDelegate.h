//
//  MPRAppDelegate.h
//  Mapper
//
//  Created by Genry on 7/4/13.
//  Copyright (c) 2013 Genry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPRStreetsListViewController.h"
@interface MPRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MPRStreetsListViewController *streetsController;
@property (nonatomic, strong) UINavigationController *navigationController;

@end
