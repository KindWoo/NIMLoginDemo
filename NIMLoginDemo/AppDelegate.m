//
//  AppDelegate.m
//  NIMLoginDemo
//
//  Created by KindWoo on 2019/5/4.
//  Copyright © 2019 wukaida. All rights reserved.
//

#import "AppDelegate.h"
#import <NIMSDK/NIMSDK.h>
#import "LoginVC.h"
#import "MainTabVC.h"


@interface AppDelegate ()<NIMLoginManagerDelegate>

@property (strong,nonatomic) LoginVC *loginVC;
@property (strong,nonatomic) MainTabVC *mainTabVC;



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *appKey        = @"45c6af3c98409b18a84451215d0bdd6e";
    NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:appKey];
    [[NIMSDK sharedSDK] registerWithOption:option];
    [[NIMSDK sharedSDK].loginManager addDelegate:self];
    
    [self setupMainViewController];
    
    return YES;
}

-(void) setupMainViewController{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *account = [user objectForKey:@"account"];
    NSString *token = [user objectForKey:@"token"];

    if ([account length] && [token length]){
        NIMAutoLoginData *logindata = [[NIMAutoLoginData alloc] init];
        logindata.account = account;
        logindata.token = token;
        [[NIMSDK sharedSDK].loginManager autoLogin:logindata];  //自动登录
    } else {
        [self setupLoginViewController];
    }
}

-(void) setupLoginViewController{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.loginVC = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
    self.window.rootViewController = self.loginVC;
    [self.window makeKeyAndVisible];
}


-(void) onLogin:(NIMLoginStep)step{
    NSLog(@"当前的状态 ：%ld",(long)step);
    if (step == NIMLoginStepLoginOK) {
        //进入mainTabVC
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.mainTabVC = [storyboard instantiateViewControllerWithIdentifier:@"mainTabVC"];
        self.window.rootViewController = self.mainTabVC;
        [self.window makeKeyAndVisible];
        
    }
}


-(void) onAutoLoginFailed:(NSError *)error{
    if (!error) {
        NSLog(@"自动登录成功");
    } else{
        NSLog(@"自动登录失败，原因:%@",error);
        [self setupLoginViewController];
    }
}



@end
