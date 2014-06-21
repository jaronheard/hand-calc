//
//  ModelController.h
//  hand-calc
//
//  Created by Jaron Heard on 6/21/14.
//  Copyright (c) 2014 Jaron Heard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end

