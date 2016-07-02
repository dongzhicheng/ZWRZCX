
//
//  LoginViewController.m
//  ZWRZCX
//
//  Created by 董志成 on 16/6/4.
//  Copyright © 2016年 董志成. All rights reserved.
//

#import "LoginViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "MainDiTuViewController.h"


@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *iphoneEMSNumberTexfield;
@property (strong, nonatomic) IBOutlet UITextField *YanZhengMaTextField;


@end

@implementation LoginViewController
- (IBAction)QueRen:(id)sender {
    [SMSSDK commitVerificationCode:self.YanZhengMaTextField.text phoneNumber:self.iphoneEMSNumberTexfield.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            NSLog(@"短信验证成功");
            UIStoryboard * mainDiTuStor =  [UIStoryboard storyboardWithName:@"MainMapSto" bundle:nil];
            
            MainDiTuViewController * mainDiTuVC  = [mainDiTuStor instantiateInitialViewController];

            [self.navigationController pushViewController:mainDiTuVC animated:YES];
        }else{
            NSLog(@"短信错误信息:%@",error);
        }
    }];
}
- (IBAction)Login:(id)sender {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"18363345960"
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         NSLog(@"获取验证码成功");
                                     } else {
                                         NSLog(@"错误信息：%@",error);
                                     }
                                     }];
}
- (IBAction)phoneNumberRegister:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor purpleColor];

    //    [self animationAutoProductStarAndPoint]; // 产生粒子
    
#pragma mark http://m.blog.csdn.net/blog/u012890196/21246751
    
    //    [self animation]; // 网页教程
    
#pragma mark http://blog.csdn.net/chaoyuan899/article/details/42174647
    //    [self animation_1];
    
    [self animation_2];  // 礼花弹
    

    
}

- (void)animationAutoProductStarAndPoint
{
    
    // 发射器
    
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    // 发射器位置
    emitterLayer.emitterPosition = CGPointMake(200,150);
    // 发射器大小
    emitterLayer.emitterSize = CGSizeMake(self.view.bounds.size.width - 100, 20);
    // 递增渲染模式
    emitterLayer.renderMode = kCAEmitterLayerOldestLast;
    // 粒子发射模式（面发射）
    emitterLayer.emitterMode = kCAEmitterLayerSurface;
    // 粒子发射源形状（球状）控制粒子形状
    emitterLayer.emitterShape = kCAEmitterLayerLine;
    // 用于初始化随机数产生的种子
    //    emitterLayer.seed = (arc4random()%100)+1;
    
    // 粒子边缘颜色
    emitterLayer.shadowOpacity = 0.8; // 透明度
    emitterLayer.shadowRadius = 0.0;  // 圆角半径
    emitterLayer.shadowOffset = CGSizeMake(0.0, 0.0); // 偏移量
    emitterLayer.shadowColor = [[UIColor yellowColor] CGColor];
    
    // 粒子原型(粒子容器)
    
    // 星星粒子原型
    CAEmitterCell *cellStar = [CAEmitterCell emitterCell];
    // 名字
    cellStar.name = @"star";
    // 速度乘数因子(粒子产生速度)
    cellStar.birthRate = 1.0;
    // 粒子生命周期
    cellStar.lifetime = 50.0;
    // 速度
    cellStar.velocity = 10.0;
    // 粒子速度范围
    cellStar.velocityRange = 10.0;
    // 粒子x,y,z方向加速分量
    //    cellStar.xAcceleration = 2;
    cellStar.yAcceleration = 5;
    //    cellStar.zAcceleration = 12;
    // 粒子发射角度
    cellStar.emissionRange = 0.5*M_PI;
    // 粒子旋转角度范围
    cellStar.spinRange = 0.25*M_PI;
    // 粒子内容
    cellStar.contents = (id)[[UIImage imageNamed:@"bgAnimationStar1"] CGImage];
    // 粒子颜色
    cellStar.color = [[UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:1.0] CGColor];
    // 粒子透明
    cellStar.alphaRange = 0.5;
    cellStar.alphaSpeed = 2;
    // 粒子缩放
    cellStar.scale = 0.7;
    cellStar.scaleRange = 0.7;
    
    
    CAEmitterCell *starCell0 = [CAEmitterCell emitterCell];
    starCell0.birthRate = 2.0;
    starCell0.lifetime = 2;
    starCell0.velocity = 10;
    starCell0.yAcceleration = 5;
    starCell0.emissionRange = 2*M_PI;    // 发射角度范围
    starCell0.contents = (id)[[UIImage imageNamed:@"bgAnimationPoint1"] CGImage];
    starCell0.color = [[UIColor colorWithRed:1 green:1 blue:1 alpha:0] CGColor];
    starCell0.alphaSpeed = 0.6;
    starCell0.scale = 0.6;
    [starCell0 setName:@"starcell"];
    
    // 粒子容器_1 添加 另一中粒子_2
    starCell0.emitterCells = @[cellStar];
    
    emitterLayer.emitterCells = [NSArray arrayWithObjects:cellStar, starCell0, nil];
    [self.view.layer insertSublayer:emitterLayer atIndex:0];
    
}

- (void)animation
{
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //例子发射位置
    snowEmitter.emitterPosition = CGPointMake(240,200);
    //发射源的尺寸大小
    snowEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width * 20, 20);
    //发射模式
    snowEmitter.emitterMode = kCAEmitterLayerSurface;
    //发射源的形状
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    
    //创建雪花类型的粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    //粒子的名字
    snowflake.name = @"snow";
    //粒子参数的速度乘数因子
    snowflake.birthRate = 1.0;
    snowflake.lifetime = 120.0;
    //粒子速度
    snowflake.velocity = 10.0;
    //粒子的速度范围
    snowflake.velocityRange = 10;
    //粒子y方向的加速度分量
    snowflake.yAcceleration = 2;
    //周围发射角度
    snowflake.emissionRange = 0.5 * M_PI;
    //子旋转角度范围
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents = (id)[[UIImage imageNamed:@"bgAnimationStar1"] CGImage];
    //设置雪花形状的粒子的颜色
    snowflake.color = [[UIColor colorWithRed:0.200 green:0.258 blue:0.543 alpha:1.000] CGColor];
    
    //创建星星形状的粒子
    CAEmitterCell *snowflake1 = [CAEmitterCell emitterCell];
    //粒子的名字
    snowflake1.name = @"snow";
    //粒子参数的速度乘数因子
    snowflake1.birthRate = 10.0;
    snowflake1.lifetime = 120.0;
    //粒子速度
    snowflake1.velocity =10.0;
    //粒子的速度范围
    snowflake1.velocityRange = 10;
    //粒子y方向的加速度分量
    snowflake1.yAcceleration = 2;
    //周围发射角度
    snowflake1.emissionRange = 0.5 * M_PI;
    //子旋转角度范围
    snowflake1.spinRange = 0.25 * M_PI;
    //粒子的内容和内容的颜色
    snowflake1.contents = (id)[[UIImage imageNamed:@"bgAnimationStar"] CGImage];
    snowflake1.color = [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius = 0.0;
    snowEmitter.shadowOffset = CGSizeMake(0.0, 1.0);
    //粒子边缘的颜色
    snowEmitter.shadowColor = [[UIColor redColor] CGColor];
    
    snowEmitter.emitterCells = [NSArray arrayWithObjects:snowflake,snowflake1,nil];
    [self.view.layer insertSublayer:snowEmitter atIndex:0];
    
}

// CAEMitterCell的属性基本上可以分为三种：

//这种粒子的某一属性的初始值。比如，color属性指定了一个可以混合图片内容颜色的混合色。在示例中，我们将它设置为桔色。
//例子某一属性的变化范围。比如emissionRange属性的值是2π，这意味着例子可以从360度任意位置反射出来。如果指定一个小一些的值，就可以创造出一个圆锥形
//指定值在时间线上的变化。比如，在示例中，我们将alphaSpeed设置为-0.4，就是说例子的透明度每过一秒就是减少0.4，这样就有发射出去之后逐渐小时的效果。

- (void)animation_1
{
    //create particle emitter layer
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.view.bounds;
    [self.view.layer addSublayer:emitter];
    
    //configure emitter
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
    
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"bgAnimationStar1"].CGImage;
    cell.birthRate = 50;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
    //add particle template to emitter
    emitter.emitterCells = @[cell];
}

- (void)animation_2
{
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:emitterLayer];
    
    emitterLayer.emitterPosition = CGPointMake(160, 500);    // 坐标
    emitterLayer.emitterSize = CGSizeMake(self.view.bounds.size.width/2, 0);               // 粒子大小
    emitterLayer.renderMode = kCAEmitterLayerAdditive;      // 递增渲染模式
    emitterLayer.emitterMode = kCAEmitterLayerOutline;      // 粒子发射模式（向线外发射）
    emitterLayer.emitterShape = kCAEmitterLayerLine;        // 粒子形状（线）
    
    emitterLayer.seed = (arc4random()%100) + 1;
    
    // 爆炸前的移动星星圆粒子
    CAEmitterCell *cycleCell = [CAEmitterCell emitterCell];
    cycleCell.birthRate = 1.0;
    cycleCell.lifetime = 1.02;
    cycleCell.emissionLatitude = 0;
    cycleCell.emissionLongitude = 0;
    cycleCell.emissionRange = M_PI_4/2;    // 发射角度范围
    cycleCell.velocity = 200;
    cycleCell.contents = (id)[[UIImage imageNamed:@"cycle1.png"] CGImage];
    cycleCell.scale = 0.06;
    
    // 爆炸时的粒子
    CAEmitterCell *burstCell = [CAEmitterCell emitterCell];
    burstCell.birthRate	= cycleCell.birthRate;
    burstCell.scale = 2.5;
    burstCell.lifetime = 0.2;
    
    // 爆炸后的散射星星粒子
    CAEmitterCell *starCell = [CAEmitterCell emitterCell];
    starCell.birthRate = 500;
    starCell.velocity = 100;
    starCell.lifetime = 1;
    starCell.lifetimeRange = 0.5;
    starCell.emissionRange = 2*M_PI;    // 发射角度范围
    starCell.yAcceleration = 75;
    starCell.contents = (id)[[UIImage imageNamed:@"star1.png"] CGImage];
    starCell.color = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor;
    starCell.alphaSpeed = -0.8;
    starCell.scale = 2;
    starCell.scaleRange = 0.1;
    starCell.spin = 2*M_PI;;
    starCell.redRange = 0.5;
    starCell.greenRange = 0.5;
    starCell.blueRange = 0.5;
    
    
    emitterLayer.emitterCells = @[cycleCell]; // layer层添加移动粒子
    cycleCell.emitterCells = @[burstCell]; // 移动粒子产生后才产生爆炸粒子
    burstCell.emitterCells = @[starCell]; // 爆炸粒子产生后才有星星粒子
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.YanZhengMaTextField resignFirstResponder];
    [self.iphoneEMSNumberTexfield resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
