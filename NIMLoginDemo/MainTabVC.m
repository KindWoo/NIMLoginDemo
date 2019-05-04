//
//  MainTabVC.m
//  NIMLoginDemo
//
//  Created by KindWoo on 2019/5/4.
//  Copyright © 2019 wukaida. All rights reserved.
//

#import "MainTabVC.h"
#import "LoginVC.h"
#import <NIMSDK/NIMSDK.h>



@interface MainTabVC ()
@property (weak, nonatomic) IBOutlet UILabel *loginResult;
@property (strong,nonatomic) LoginVC *loginVC;
@end

@implementation MainTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *result = [NSString stringWithFormat:@"Hello,%@",[[NIMSDK sharedSDK].loginManager currentAccount]];
    _loginResult.text = result;
}


- (IBAction)doLogout:(id)sender {
    //IM-SDK登出
    [[NIMSDK sharedSDK].loginManager logout:^(NSError * _Nullable error) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nil forKey:@"account"];
        [defaults setObject:nil forKey:@"token"];
        [defaults synchronize];
        
        if(!error){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"云信" message:@"您已登出" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
                [UIApplication sharedApplication].keyWindow.rootViewController = self.loginVC;
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else{
            NSLog(@"登出失败");
        }
    }];

}



@end
