//
//  foodlingAppDelegate.h
//  foodling
//
//  Created by Apirom Na Nakorn on 12/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class foodlingViewController;

@interface foodlingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainController *viewController;

@end

