//
//  ViewController.m
//  PopupView
//
//  Created by Zhao Fei on 2016/10/12.
//  Copyright © 2016年 ZhaoFei. All rights reserved.
//

#import "ViewController.h"
#import "PopupView.h"
@interface ViewController ()
@property (nonatomic, assign) BOOL rightItemSelected;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightItemSelected = NO;
    self.navigationItem.title = @"PopupView";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickAdd)];
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)clickAdd {
    
    [PopupView addCellWithIcon:[UIImage imageNamed:@"diannao"] text:@"diannao" action:^{
        NSLog(@"diannao");
    }];
    
    [PopupView addCellWithIcon:[UIImage imageNamed:@"jiahaoyou"] text:@"jiahaoyou" action:^{
        NSLog(@"jiahaoyou");
    }];
    
    [PopupView addCellWithIcon:[UIImage imageNamed:@"saoyisao"] text:@"saoyisao" action:^{
        NSLog(@"saoyisao");
    }];
    
    [PopupView popupView];
}

@end
