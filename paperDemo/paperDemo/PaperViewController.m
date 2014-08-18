//
//  PaperViewController.m
//  paperDemo
//
//  Created by broy denty on 14-8-18.
//  Copyright (c) 2014年 denty. All rights reserved.
//

#import "PaperViewController.h"
#import "Pepar.h"
@interface PaperViewController ()

@end

@implementation PaperViewController
{
    Pepar * aPepar;
    UIView *buttonHolder;
    BOOL open;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    open = YES;
    aPepar = [[Pepar alloc] initWithFrame:CGRectMake(0, 0, 320, 0) WithCount:6 WithCellHeight:60];
    [aPepar setDelegate:self];
    aPepar.animationTiming = 1.0;
    [self.view addSubview:aPepar];
    buttonHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:CGRectMake(0, 25, 60, 30)];
    [button setBackgroundColor:[UIColor orangeColor]];
    [buttonHolder setBackgroundColor:[UIColor cyanColor]];
    [button addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"open" forState:UIControlStateNormal];
    [buttonHolder addSubview:button];
    [self.view addSubview:buttonHolder];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)open
{
    [aPepar startAnimationWithOpen:open];
    if (open) {
        [UIView animateWithDuration:aPepar.animationTiming animations:^{
            [buttonHolder setFrame:CGRectMake(0, aPepar.count*60, 320, 60)];
            [aPepar setFrame:CGRectMake(0, 0, 320, aPepar.count*60)];
        }];
    }else
    {
        [UIView animateWithDuration:aPepar.animationTiming animations:^{
            [buttonHolder setFrame:CGRectMake(0, 0, 320, 60)];
            [aPepar setFrame:CGRectMake(0, 0, 320, 0)];
        }];
    }

}

- (void)openSuccess
{
    open = NO;
}

- (void)closeSuccess
{
    open = YES;
}
@end
