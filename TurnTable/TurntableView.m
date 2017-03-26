//
//  TurntableView.m
//  TurnTable
//
//  Created by 李晓飞 on 2017/3/23.
//  Copyright © 2017年 xiaofei. All rights reserved.
//

#import "TurntableView.h"

#define kSideForArrow       130 * kScreenWidth / 375.0


@interface TurntableView ()<CAAnimationDelegate>

@property (nonatomic, strong)UIViewController *superVC;

@property (nonatomic, strong)UIImageView *bgImgView;
@property (nonatomic, strong)UIImageView *arrowImgView;

@property (nonatomic, assign)float random;          //随机角度
@property (nonatomic, assign)float orign;           //初始角度

@end

@implementation TurntableView

- (instancetype)initWithFrame:(CGRect)frame ViewController:(UIViewController *)vc {
    self = [super initWithFrame:frame];
    if (self) {
        self.superVC = vc;
        CGFloat sideLen = frame.size.width;
        
        self.bgImgView = [[UIImageView alloc] init];
        self.bgImgView.frame = self.bounds;
        self.bgImgView.image = [UIImage imageNamed:@"bg"];
        [self addSubview:self.bgImgView];
        
        self.arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake((sideLen - kSideForArrow)/2, (sideLen - kSideForArrow)/2, kSideForArrow, kSideForArrow)];
        self.arrowImgView.image = [UIImage imageNamed:@"choujiang"];
        [self addSubview:self.arrowImgView];
        self.arrowImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lucky:)];
        [self.arrowImgView addGestureRecognizer:tapGesture];
    }
    return self;
}

//点击手势
- (void)lucky:(UITapGestureRecognizer *)tapGesture {
    //产生随机角度
    srand((unsigned)time(0));  //不加这句每次产生的随机数不变
    _random = (rand() % 20) / 10.0;
    //设置动画
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [spin setFromValue:[NSNumber numberWithFloat:M_PI * (0.0 + _orign)]];   //开始角度
    [spin setToValue:[NSNumber numberWithFloat:M_PI * (10.0 + _random + _orign)]];      //结束角度
    [spin setDuration:2.5];      //动画时间
    [spin setDelegate:self];     //设置代理
    [spin setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];      //速度控制器
    //添加动画
    [[self.bgImgView layer] addAnimation:spin forKey:nil];
    //锁定结束位置
    self.bgImgView.transform = CGAffineTransformMakeRotation(M_PI * (10.0 + _random + _orign));
    //锁定fromValue的位置
    _orign = 10.0 + _random + _orign;
    _orign = fmodf(_orign, 2.0);
}

#pragma mark    ----CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"开始动画");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"结束动画 %@", anim);
    NSInteger num;
    //1 6 3 2 4 5
    if (_orign >= 0.0 && _orign < (1/3.0)) {
        //抽到1个积分
        NSLog(@"1");
        num = 1;
    }else if (_orign >= (1/3.0) && _orign < (2/3.0)) {
        //抽到6个积分
        NSLog(@"6");
        num = 6;
    }else if (_orign >= (2/3.0) && _orign < (3/3.0)) {
        //抽到3个积分
        NSLog(@"3");
        num = 3;
    }else if (_orign >= (3/3.0) && _orign < (4/3.0)) {
        //抽到2个积分
        NSLog(@"2");
        num = 2;
    }else if (_orign >= (4/3.0) && _orign < (5/3.0)) {
        //抽到4个积分
        NSLog(@"4");
        num = 4;
    }else if (_orign >= (5/3.0) && _orign < (6/3.0)) {
        //抽到5个积分
        NSLog(@"5");
        num = 5;
    }
    
    NSString *warnStr = [NSString stringWithFormat:@"您抽到了%li个积分", num];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:warnStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self.superVC presentViewController:alert animated:YES completion:^{
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
