//
//  DrawBoard.h
//  MerryChristmas
//
//  Created by ColeXm on 15/12/24.
//  Copyright © 2015年 ColeXm. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


@protocol finishDelegate <NSObject>

-(void)finishAA;

@end


@interface DrawBoard : NSObject



@property (nonatomic, assign)id <finishDelegate>delegate;



//玫瑰花
- (void)showTheFlowerOnView:(UIView *)view;

//字
- (void)showTheWordOnView:(UIView *)view;


- (void)changeTheFlower:(UIColor *)color;

@end
