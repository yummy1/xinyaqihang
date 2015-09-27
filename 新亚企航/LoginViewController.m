//
//  LoginViewController.m
//  新亚企航
//
//  Created by qingyun on 15/9/24.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "LoginViewController.h"
#import "NSJSONSerialization+NSString.h"
#import "AFNetworking.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *UserName;
@property (weak, nonatomic) IBOutlet UITextField *passWorld;


@property(nonatomic,strong)NSArray *Ldatas;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
- (IBAction)LoginTosever:(id)sender {
    if (![self isValidatePhone:_UserName.text]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"您输入的手机号有误，请重新输入!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [self.view addSubview:alert];
        [alert show];
        return ;
    }
    
    
    [self login];
    
    
    
}

-(void)login
{ NSDictionary *paras = @{@"commandcode": @"111", @"REQUEST_BODY":@{@"username":_UserName.text,@"password":_passWorld.text}};
    //序列化为字符串
    NSString *parsString = [NSJSONSerialization stringWithJSONObjct:paras];
    
    
    //完整地提交的参数
    NSDictionary *parameters = @{@"HEAD_INFO":parsString};
    
    NSString *urlString = @"http://www.fungpu.com/houseapp/apprq.do";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlString parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObject) {
        //NSLog(@"%@", responseObject);
        
        NSDictionary *responseBody=[responseObject valueForKey:@"RESPONSE_BODY"];
        _Ldatas=[responseBody valueForKey:@"list"];
        NSLog(@"LLLLLLLLLLLLLLLLLL%@",_Ldatas);
       int state=[_Ldatas[0][@"state"] intValue];
        if (state ==0) {
            NSNotification * notice = [NSNotification notificationWithName:@"123" object:nil userInfo:@{@"1":@"1",@"2":_UserName.text}];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            [self alertShow];
            [self.navigationController popToRootViewControllerAnimated:YES];
    
        }else if(state==1)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"登录失败，请重新登录!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                   [self.view addSubview:alert];
                   [alert show];
        }

    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
    }];
}

-(void)alertShow
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:_UserName.text forKey:@"currentTelNum"];
    [userDefault setObject:_passWorld.text forKey:@"currentPassWord"];
    [userDefault setObject:@"成功" forKey:@"lid"];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"恭喜您，登录成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.delegate=self;
    [self.view addSubview:alert];
    [alert show];

    }

-(BOOL) isValidatePhone:(NSString *)phoneNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|[3-9][0-9][0-9])\\d{7,8}$";
    //NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    if (([regextestmobile evaluateWithObject:phoneNum] == YES)
        || ([regextestcm evaluateWithObject:phoneNum] == YES)
        || ([regextestct evaluateWithObject:phoneNum] == YES)
        || ([regextestcu evaluateWithObject:phoneNum] == YES)
        || ([regextestphs evaluateWithObject:phoneNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}




@end
