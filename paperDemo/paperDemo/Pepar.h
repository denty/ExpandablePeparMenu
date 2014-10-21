//
//  Pepar.h
//  paperDemo
//
//  Created by broy denty on 14-8-18.
//  Copyright (c) 2014年 denty. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PeparActionDelegate <NSObject>

- (void)openSuccess;
- (void)closeSuccess;
- (UIView *)factoryCellWithView:(UIView *)view WithIndex:(NSInteger) index;
- (void)clickButtonWithIndex:(NSInteger) index;
@end
@interface Pepar : UIView
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSMutableArray *cellArray;
@property (nonatomic,assign) CGFloat animationTiming;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,weak) id<PeparActionDelegate> delegate;
- (id)initWithFrame:(CGRect)frame WithCount:(NSInteger) count WithCellHeight:(CGFloat) height WithDelegate: (id<PeparActionDelegate>) delegate;
- (void)startAnimationWithOpen:(BOOL) openAction;
- (void)touchActionWithPoint:(CGPoint) point;
@end
