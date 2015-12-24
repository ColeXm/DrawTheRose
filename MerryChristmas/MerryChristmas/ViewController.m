//
//  ViewController.m
//  MerryChristmas
//
//  Created by ColeXm on 15/12/24.
//  Copyright © 2015年 ColeXm. All rights reserved.
//

#import "ViewController.h"
#import "DrawBoard.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DrawBoard *db = [DrawBoard new];
    [db showTheFlowerOnView:self.view];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [db showTheWordOnView:self.view];
    });
    
}



@end
