//
//  AppDelegate.h
//  CafeCreatium
//
//  Created by Matthew on 7/22/13.
//  Copyright (c) 2013 Matthew. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPhoneMainViewController, iPadMainViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    BOOL isPlaying;
}

@property (strong, nonatomic) UIWindow *window;

@end
