//
//  ViewController.m
//  HYHActivityIndicatorView
//
//  Created by harry on 2020/6/28.
//  Copyright © 2020 DangDang. All rights reserved.
//

#import "ViewController.h"

#import "HYHActivityIndicator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    activityIndicator.frame = CGRectMake(100, 100, 40, 40);
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    HYHActivityIndicator *indicator = [[HYHActivityIndicator alloc] initWithFrame:CGRectMake(100, 200, 40, 40)];
    [self.view addSubview:indicator];
    [indicator startAnimation];
    
}


@end
