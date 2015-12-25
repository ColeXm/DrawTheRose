//
//  ViewController.m
//  MerryChristmas
//
//  Created by ColeXm on 15/12/24.
//  Copyright © 2015年 ColeXm. All rights reserved.
//

#import "ViewController.h"
#import "DrawBoard.h"

@interface ViewController ()<finishDelegate>{

    DrawBoard *db;
    __weak IBOutlet UISlider *r;
    __weak IBOutlet UISlider *g;
    __weak IBOutlet UISlider *b;
}
- (IBAction)changeSS:(UISlider *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    db = [DrawBoard new];
    db.delegate = self;
    [db showTheFlowerOnView:self.view];
    [db showTheWordOnView:self.view];
    
    r.enabled = NO;
    g.enabled = NO;
    b.enabled = NO;
    
}

-(void)finishAA{

    r.enabled = YES;
    g.enabled = YES;
    b.enabled = YES;
}


- (IBAction)changeSS:(UISlider *)sender {
    
    
    
    
    [db changeTheFlower:[UIColor colorWithRed:r.value/255. green:g.value/255. blue:b.value/255. alpha:1.]];
    
    
}
@end
