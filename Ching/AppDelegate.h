//
//  AppDelegate.h
//  Ching
//
//  Created by Nate Armstrong on 7/31/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import UIKit;
@import ChingKit;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly) CHPersistenceController *persistenceController;

@end

