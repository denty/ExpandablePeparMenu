//
//  PaperViewController.m
//  paperDemo
//
//  Created by broy denty on 14-8-18.
//  Copyright (c) 2014年 denty. All rights reserved.
//

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#import "PaperViewController.h"
#import "Pepar.h"
@interface PaperViewController ()

@end

@implementation PaperViewController
{
    Pepar * aPepar;
    UIView *buttonHolder;
    BOOL open;
    NSArray *buttonArray;
    UIButton * button;
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
    buttonArray= @[@"button1",@"button2",@"button3",@"button4",@"button5",@"button6"];
    open = YES;
    aPepar = [[Pepar alloc] initWithFrame:CGRectMake(0, 0, 320, 70*buttonArray.count) WithCount:buttonArray.count WithCellHeight:70 WithDelegate:self];
    aPepar.animationTiming = 0.5;
    [self.view addSubview:aPepar];
    buttonHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:CGRectMake(0, 25, 60, 30)];
    [button setBackgroundColor:[UIColor orangeColor]];
    [buttonHolder setBackgroundColor:[UIColor colorWithRed:104.0f/255.0f green:104.0f/255.0f blue:104.0f/255.0f alpha:1]];
    [button addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"open" forState:UIControlStateNormal];
    [buttonHolder addSubview:button];
    [self.view addSubview:buttonHolder];
    
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nagetiveAction:)];
    [buttonHolder addGestureRecognizer:gesture];
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

            CAKeyframeAnimation *aCAKeyframeAnimationButton = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            NSMutableArray *keyAnimationButtonArray = [[NSMutableArray alloc] init];
            for (int j = 100; j>=0; j--) {
                [keyAnimationButtonArray addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 70*(aPepar.count)*sin(M_PI/200*(100-j)), 0)]];
            }
            [aCAKeyframeAnimationButton setValues:keyAnimationButtonArray];
            [aCAKeyframeAnimationButton setDuration:aPepar.animationTiming];
            [aCAKeyframeAnimationButton setRemovedOnCompletion:NO];
            [aCAKeyframeAnimationButton setFillMode:kCAFillModeForwards];
            [aCAKeyframeAnimationButton setDelegate:self];
            [buttonHolder.layer addAnimation:aCAKeyframeAnimationButton forKey:@"openMove"];
        }];
    }else
    {
        [UIView animateWithDuration:aPepar.animationTiming animations:^{
            CAKeyframeAnimation *aCAKeyframeAnimationButton = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            NSMutableArray *keyAnimationButtonArray = [[NSMutableArray alloc] init];
            for (int j = 100; j>=0; j--) {
                [keyAnimationButtonArray addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 70*(aPepar.count)*sin(M_PI/200*(j)), 0)]];
            }
            [aCAKeyframeAnimationButton setValues:keyAnimationButtonArray];
            [aCAKeyframeAnimationButton setDuration:aPepar.animationTiming];
            [aCAKeyframeAnimationButton setRemovedOnCompletion:NO];
            [aCAKeyframeAnimationButton setFillMode:kCAFillModeForwards];
            [aCAKeyframeAnimationButton setDelegate:self];
            [buttonHolder.layer addAnimation:aCAKeyframeAnimationButton forKey:@"openMove"];
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

- (UIColor *)CellColorWith:(NSInteger)index
{
    if (index%2 == 0) {
        return [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:231.0f/255.0f alpha:1];
    }else
    {
        return [UIColor colorWithRed:254.0f/255.0f green:254.0f/255.0f blue:254.0f/255.0f alpha:1];
    }
}

- (UIView *)factoryCellWithView:(UIView *)view WithIndex:(NSInteger)index
{
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width/2, view.frame.size.height)];
    [textLabel setText:[buttonArray objectAtIndex:index]];
    [view addSubview:textLabel];
    [view setBackgroundColor:[self CellColorWith:index]];
    return view;
}


- (void)nagetiveAction:(UIGestureRecognizer*) gesture
{
    CGPoint touchPoint = [gesture locationInView:buttonHolder];
    touchPoint.y = touchPoint.y-aPepar.count*70;
    if ([button.layer.presentationLayer hitTest:touchPoint])
    {
        [self open];
    }
}
@end
