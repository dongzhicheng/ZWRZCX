
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
    self.view.backgroundColor = [UIColor blueColor];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.YanZhengMaTextField resignFirstResponder];
    [self.iphoneEMSNumberTexfield resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
