//
//  AppDelegate.m
//  Ching
//
//  Created by Nate Armstrong on 7/31/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "AppDelegate.h"
#import "EnvelopesViewController.h"

@interface AppDelegate ()

@property (strong, readwrite) CHPersistenceController *persistenceController;

- (void)completeUserInterface;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.persistenceController = [[CHPersistenceController alloc] initWithCallback:^{
		[self completeUserInterface];
	}];
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	[self.persistenceController save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	[self.persistenceController save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[self.persistenceController save];
}

- (void)completeUserInterface
{
	UISplitViewController *splitVC = (UISplitViewController *)self.window.rootViewController;
	UINavigationController *nav = [[splitVC viewControllers] firstObject];
	EnvelopesViewController *vc = (EnvelopesViewController *)[nav topViewController];
	vc.context = self.persistenceController.managedObjectContext;
}

@end
