//
//  iPhoneMainViewController.m
//  CafeCreatium
//
//  Created by Matthew on 7/22/13.
//  Copyright (c) 2013 Matthew. All rights reserved.
//

#import "iPhoneMainViewController.h"
#import "AmbienceViewController.h"

@implementation iPhoneMainViewController
@synthesize initialViewController, floInfo;

-(id) init
{
    self = [super init];
    
    if (self) {
        self.view.backgroundColor = [UIColor blackColor];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor brownColor];
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:2.0f] forKey:UIPageViewControllerOptionInterPageSpacingKey]];
    
    self.pageController.dataSource = self;
    
    [[self.pageController view] setFrame:[[self view] bounds]];
    self.pageController.delegate = self;
    
    self.initialViewController = [[AmbienceViewController alloc] init];
    self.initialViewController.index = 0;
    [self.initialViewController setCustomImages];
    
    self.floInfo = [[AmbienceViewController alloc] init];
    self.floInfo.index = 2;
    [self.floInfo specialViewDidLoad];
    
    NSArray *viewControllers = [NSArray arrayWithObject:self.initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    //CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, screenHeight - 65, self.view.bounds.size.width, 15)];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    self.pageControl.backgroundColor = [UIColor clearColor];
    [[self view] addSubview:self.pageControl];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(AmbienceViewController *)viewController index];
    self.pageControl.hidden = NO;
    if (index == 0) {
        self.pageControl.currentPage = index;
        return nil;
    }
    self.pageControl.currentPage = index;
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(AmbienceViewController *)viewController index];
    self.pageControl.currentPage = index;
    index++;
    
    if (index == 3) {
        self.pageControl.hidden = YES;
        return nil;
    }
    self.pageControl.hidden = NO;
    
    return [self viewControllerAtIndex:index];
    
}

- (AmbienceViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (index == 0) {
        return self.initialViewController;
    }
    
    if (index == 2) {
        return self.floInfo;
    }
    
    AmbienceViewController *childViewController = [[AmbienceViewController alloc] init];
    childViewController.index = index;
    [childViewController setCustomImages];
    
    return childViewController;
    
}



@end
