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

@end
@interface Pepar : UIView
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSMutableArray *cellArray;
@property (nonatomic,assign) CGFloat animationTiming;
@property (nonatomic,weak) id<PeparActionDelegate> delegate;
- (id)initWithFrame:(CGRect)frame WithCount:(NSInteger) count WithCellHeight:(CGFloat) height;
- (void)startAnimationWithOpen:(BOOL) openAction;
@end
