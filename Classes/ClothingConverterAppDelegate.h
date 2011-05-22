//
//  ClothingConverterAppDelegate.h
//  ClothingConverter
//
//  Created by Jason Lagaac on 13/05/10.
//  Copyright Jason Lagaac 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClothingConverterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UITabBarController *rootController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;

@end

