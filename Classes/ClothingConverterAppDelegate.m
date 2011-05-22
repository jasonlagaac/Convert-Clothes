//
//  ClothingConverterAppDelegate.m
//  ClothingConverter
//
//  Created by Jason Lagaac on 13/05/10.
//  Copyright Jason Lagaac 2010. All rights reserved.
//

#import "ClothingConverterAppDelegate.h"


@implementation ClothingConverterAppDelegate

@synthesize window;
@synthesize rootController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    sleep(2.0);
    // Override point for customization after app launch    
    [window addSubview:rootController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [rootController release];
    [window release];
    [super dealloc];
}


@end
