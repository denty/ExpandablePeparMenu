//
//  Pepar.m
//  paperDemo
//
//  Created by broy denty on 14-8-18.
//  Copyright (c) 2014年 denty. All rights reserved.
//

#import "Pepar.h"

@implementation Pepar

- (id)initWithFrame:(CGRect)frame WithCount:(NSInteger) count WithCellHeight:(CGFloat) height
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.cellArray = [[NSMutableArray alloc] init];
        self.count = count;
        for (int i =0 ; i<count; i++) {
            UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, height*i, frame.size.width, height)];
            if (i%2 == 0)
            {
                 cell.layer.anchorPoint = CGPointMake(0.5, 0);
                [cell setBackgroundColor:[UIColor grayColor]];
            }
            else
            {
                cell.layer.anchorPoint = CGPointMake(0.5, 1);
                [cell setBackgroundColor:[UIColor lightGrayColor]];
            }
            cell.frame =CGRectMake(0, height*i, frame.size.width, height);
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
        for (int i =0 ; i<self.count; i++) {
            if ((i%2) == 0) {
                CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform"];
                UIView *cell = (UIView *)[self.cellArray objectAtIndex:i];
                CATransform3D rotate = CATransform3DMakeRotation(-M_PI/2, 1, 0, 0);
                CATransform3D combinedTransform = CATransform3DConcat(CATransform3DPerspect(rotate, CGPointMake(0, 0), 800), CATransform3DMakeTranslation(0, -cell.frame.size.height*i, 0));
                [animation setToValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
                [animation setFromValue:[NSValue valueWithCATransform3D:combinedTransform]];
                [animation setDuration:self.animationTiming];
                [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [animation setRemovedOnCompletion:NO];
                [animation setFillMode:kCAFillModeForwards];
                [animation setDelegate:self];
                [cell.layer addAnimation:animation forKey:@"open"];
            }else
            {
                CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform"];
                UIView *cell = (UIView *)[self.cellArray objectAtIndex:i];
                CATransform3D rotate = CATransform3DMakeRotation(M_PI/2, 1, 0, 0);
                CATransform3D combinedTransform = CATransform3DConcat(CATransform3DPerspect(rotate, CGPointMake(0, 0), 800), CATransform3DMakeTranslation(0, -cell.frame.size.height*(i+1), 0));
                [animation setToValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
                [animation setFromValue:[NSValue valueWithCATransform3D:combinedTransform]];
                [animation setDuration:self.animationTiming];
                [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [animation setRemovedOnCompletion:NO];
                [animation setFillMode:kCAFillModeForwards];
                [animation setDelegate:self];
                [cell.layer addAnimation:animation forKey:@"open"];
            }
        }
    }
    else
    {
        for (int i =0 ; i<self.count; i++) {
            if ((i%2) == 0) {
                CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform"];
                UIView *cell = (UIView *)[self.cellArray objectAtIndex:i];
                CATransform3D rotate = CATransform3DMakeRotation(-M_PI/2, 1, 0, 0);
                CATransform3D combinedTransform = CATransform3DConcat(CATransform3DPerspect(rotate, CGPointMake(0, 0), 800), CATransform3DMakeTranslation(0, -cell.frame.size.height*i, 0));
                [animation setToValue:[NSValue valueWithCATransform3D:combinedTransform]];
                [animation setDuration:self.animationTiming];
                [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [animation setRemovedOnCompletion:NO];
                [animation setFillMode:kCAFillModeForwards];
                [animation setDelegate:self];
                [cell.layer addAnimation:animation forKey:@"close"];
            }else
            {
                CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform"];
                UIView *cell = (UIView *)[self.cellArray objectAtIndex:i];
                CATransform3D rotate = CATransform3DMakeRotation(M_PI/2, 1, 0, 0);
                CATransform3D combinedTransform = CATransform3DConcat(CATransform3DPerspect(rotate, CGPointMake(0, 0), 800), CATransform3DMakeTranslation(0, -cell.frame.size.height*(i+1), 0));
                [animation setToValue:[NSValue valueWithCATransform3D:combinedTransform]];
                [animation setDuration:self.animationTiming];
                [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [animation setRemovedOnCompletion:NO];
                [animation setFillMode:kCAFillModeForwards];
                [animation setDelegate:self];
                [cell.layer addAnimation:animation forKey:@"close"];
            }
        }

    }
    [self setHidden:NO];
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
