//
//  RootForPageViewController.m
//  VITacademics
//
//  Created by Siddharth on 03/03/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import "RootForPageViewController.h"

@interface RootForPageViewController () <UIPageViewControllerDataSource>

@end

@implementation RootForPageViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    self.detailsView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsView"];
    self.detailsView.subject = self.subject;
    
    //Details
    if([_subject.subjectDetails count] > 0){
        self.subjectDetailsView = [[SubjectDetailsViewController alloc] init];
        self.subjectDetailsView.detailsArray = _subject.subjectDetails;
        
    }
    else{
        [CSNotificationView showInViewController:self style:CSNotificationViewStyleError message:@"Not Uploaded Yet"];
        
    }
    
    //Marks
    if([self.subjectMarks count] < 16){
        
        //[CSNotificationView showInViewController:self style:CSNotificationViewStyleError message:@"PBL/Lab not supported (yet)"];
        
    }
    else{
        self.marksView = [[MarksViewController alloc] init];
        [self.marksView setMarksArray:self.subjectMarks];
    }
    
    if(self.subject.subjectCode){
        self.title = self.subject.subjectCode;
    }
    else{
        self.title = @"Subject Details";
    }
    
    NSArray *viewControllers = @[self.detailsView];
    
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    //self.index = 0;
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height - 120);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if([viewController isKindOfClass:[SubjectDetailsViewController class]])
    {
        return self.detailsView;
    }
    if([viewController isKindOfClass:[MarksViewController class]]){
        return self.subjectDetailsView;
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    //After
    if([viewController isKindOfClass:[DetailViewController class]])
    {
        return self.subjectDetailsView;
    }
    if([viewController isKindOfClass:[SubjectDetailsViewController class]]){
        return self.marksView;
    }
    return nil;
    
}


@end
