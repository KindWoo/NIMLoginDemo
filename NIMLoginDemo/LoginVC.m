//
//  LoginVC.m
//  NIMLoginDemo
//
//  Created by KindWoo on 2019/5/4.
//  Copyright © 2019 wukaida. All rights reserved.
//

#import "LoginVC.h"
#import <NIMSDK/NIMSDK.h>
#import "MainTabVC.h"


@interface LoginVC ()


@property (strong,nonatomic) MainTabVC *mainTabVC;
@property (weak, nonatomic) IBOutlet UITextField *textAccount;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}





- (IBAction)doLogin:(id)sender {
    
    [_textAccount resignFirstResponder];
    [_textPassword resignFirstResponder];
    
    NSString *account = [_textAccount.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *token = _textPassword.text;
    //云信IM-SDK登录
    [[NIMSDK sharedSDK].loginManager login:account token:token completion:^(NSError * _Nullable error) {
        if(!error){
            NSLog(@"登录成功");
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:account forKey:@"account"];
            [defaults setObject:token forKey:@"token"];
            [defaults synchronize];
            self.mainTabVC = [self.storyboard instantiateViewControllerWithIdentifier:@"mainTabVC"];
            [UIApplication sharedApplication].keyWindow.rootViewController = self.mainTabVC;
        } else {
            NSString *msg = [NSString stringWithFormat:@"登录失败，错误原因：%@",error];
            NSLog(@"account====%@,token====%@",account,token);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Failed" message:msg preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}



@end
