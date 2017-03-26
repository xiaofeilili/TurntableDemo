//
//  ViewController.m
//  TurnTable
//
//  Created by 李晓飞 on 2017/3/23.
//  Copyright © 2017年 xiaofei. All rights reserved.
//

#import "ViewController.h"
#import "TurntableView.h"

#define kSideForBG          328 * kScreenWidth / 375.0

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    TurntableView *turnView = [[TurntableView alloc] initWithFrame:CGRectMake((kScreenWidth - kSideForBG)/2, 100, kSideForBG, kSideForBG) ViewController:self];
    [self.view addSubview:turnView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
