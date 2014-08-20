//
//  Pepar.m
//  paperDemo
//
//  Created by broy denty on 14-8-18.
//  Copyright (c) 2014年 denty. All rights reserved.
//

#import "Pepar.h"

@implementation Pepar

- (id)initWithFrame:(CGRect)frame WithCount:(NSInteger) count WithCellHeight:(CGFloat) height WithDelegate: (id<PeparActionDelegate>) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.cellArray = [[NSMutableArray alloc] init];
        self.count = count;
        self.height = height;
        self.delegate = delegate;
        for (int i =0 ; i<self.count; i++) {
            UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.height)];
            UIView *cell = [self.delegate factoryCellWithView:baseView WithIndex:i];
            if (i%2 == 0)
            {
                cell.layer.anchorPoint = CGPointMake(0.5, 0);
                cell.frame =CGRectMake(0, 0, self.frame.size.width, self.height);
            }
            else
            {
                cell.layer.anchorPoint = CGPointMake(0.5, 1);
                cell.frame =CGRectMake(0,-self.height, self.frame.size.width, self.height);
            }
            [cell setTag:i];
            [self.cellArray addObject:cell];
            [self addSubview:cell];
        }
            [self.layer setMasksToBounds:YES];
        [self setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}

- (void)startAnimationWithOpen:(BOOL) openAction
{
    if (openAction) {
        for (int i =0 ; i<self.count; i++)
        {
            if ((i%2) == 0)
            {
                CAKeyframeAnimation *aCAKeyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                UIView *cell = (UIView *)[self.cellArray objectAtIndex:i];
                NSMutableArray *keyAnimationArray = [[NSMutableArray alloc] init];
                for (int j = 100; j>=0; j--) {
                    CATransform3D rotate = CATransform3DMakeRotation(-M_PI/200*j, 1, 0, 0);
                    CATransform3D combinedTransform = CATransform3DConcat(CATransform3DPerspect(rotate, CGPointMake(0, cell.frame.size.height), 600), CATransform3DMakeTranslation(0, cell.frame.size.height*i*sin(M_PI/200*(100-j)), 0));
                    [keyAnimationArray addObject:[NSValue valueWithCATransform3D:combinedTransform]];
                }
                [aCAKeyframeAnimation setValues:keyAnimationArray];
                [aCAKeyframeAnimation setDuration:self.animationTiming];
                [aCAKeyframeAnimation setRemovedOnCompletion:NO];
                [aCAKeyframeAnimation setFillMode:kCAFillModeForwards];
                [aCAKeyframeAnimation setDelegate:self];
                [cell.layer addAnimation:aCAKeyframeAnimation forKey:@"open"];
            }
            else
            {
                CAKeyframeAnimation *aCAKeyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                UIView *cell = (UIView *)[self.cellArray objectAtIndex:i];
                NSMutableArray *keyAnimationArray = [[NSMutableArray alloc] init];
                for (int j = 100; j>=0; j--) {
                    CATransform3D rotate = CATransform3DMakeRotation(M_PI/200*j, 1, 0, 0);
                    CATransform3D combinedTransform = CATransform3DConcat(CATransform3DPerspect(rotate, CGPointMake(0, -cell.frame.size.height), 600), CATransform3DMakeTranslation(0,cell.frame.size.height*(1+i)*sin(M_PI/200*(100-j)), 0));
                    [keyAnimationArray addObject:[NSValue valueWithCATransform3D:combinedTransform]];
                }
                [aCAKeyframeAnimation setValues:keyAnimationArray];
                [aCAKeyframeAnimation setDuration:self.animationTiming];
                [aCAKeyframeAnimation setRemovedOnCompletion:NO];
                [aCAKeyframeAnimation setFillMode:kCAFillModeForwards];
                [aCAKeyframeAnimation setDelegate:self];
                [cell.layer addAnimation:aCAKeyframeAnimation forKey:@"open"];
            }
        }
    }
    else
    {
        for (int i =0 ; i<self.count; i++) {
            if ((i%2) == 0)
            {
                CAKeyframeAnimation *aCAKeyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                UIView *cell = (UIView *)[self.cellArray objectAtIndex:i];
                NSMutableArray *keyAnimationArray = [[NSMutableArray alloc] init];
                for (int j = 10; j>=0; j--) {
                    CATransform3D rotate = CATransform3DMakeRotation(-M_PI/20*(10-j), 1, 0, 0);
                    CATransform3D combinedTransform = CATransform3DConcat(CATransform3DPerspect(rotate, CGPointMake(0, cell.frame.size.height), 600), CATransform3DMakeTranslation(0, cell.frame.size.height*i*sin(M_PI/20*j), 0));
                    [keyAnimationArray addObject:[NSValue valueWithCATransform3D:combinedTransform]];
                }
                [aCAKeyframeAnimation setValues:keyAnimationArray];
                [aCAKeyframeAnimation setDuration:self.animationTiming];
                [aCAKeyframeAnimation setRemovedOnCompletion:NO];
                [aCAKeyframeAnimation setFillMode:kCAFillModeForwards];
                [aCAKeyframeAnimation setDelegate:self];
                [cell.layer addAnimation:aCAKeyframeAnimation forKey:@"close"];
            }
            else
            {
                CAKeyframeAnimation *aCAKeyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                UIView *cell = (UIView *)[self.cellArray objectAtIndex:i];
                NSMutableArray *keyAnimationArray = [[NSMutableArray alloc] init];
                for (int j = 10; j>=0; j--) {
                    CATransform3D rotate = CATransform3DMakeRotation(M_PI/20*(10-j), 1, 0, 0);
                    CATransform3D combinedTransform = CATransform3DConcat(CATransform3DPerspect(rotate, CGPointMake(0, -cell.frame.size.height), 600), CATransform3DMakeTranslation(0, cell.frame.size.height*(i+1)*sin(M_PI/20*j), 0));
                    [keyAnimationArray addObject:[NSValue valueWithCATransform3D:combinedTransform]];
                }
                [aCAKeyframeAnimation setValues:keyAnimationArray];
                [aCAKeyframeAnimation setDuration:self.animationTiming];
                [aCAKeyframeAnimation setRemovedOnCompletion:NO];
                [aCAKeyframeAnimation setFillMode:kCAFillModeForwards];
                [aCAKeyframeAnimation setDelegate:self];
                [cell.layer addAnimation:aCAKeyframeAnimation forKey:@"close"];
            }
        }

    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isEqual:[[(UIView*)[self.cellArray lastObject] layer] animationForKey:@"open"]])
    {
        [self.delegate openSuccess];
    }
    else if([anim isEqual:[[(UIView *)[self.cellArray lastObject] layer] animationForKey:@"close"]])
    {
        [self.delegate closeSuccess];
    }
    else
    {
    }
}

CA_EXTERN CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CA_EXTERN CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}
@end
