//
//  iPhoneMainViewController.h
//  CafeCreatium
//
//  Created by Matthew on 7/22/13.
//  Copyright (c) 2013 Matthew. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AmbienceViewController;
@interface iPhoneMainViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageController;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) AmbienceViewController *initialViewController;
@property (nonatomic, retain) AmbienceViewController *floInfo;
@end
