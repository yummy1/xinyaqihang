//
//  SignViewController.m
//  新亚企航
//
//  Created by qingyun on 15/9/29.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SignViewController.h"
#import "AFNetworking.h"
#import "NSJSONSerialization+NSString.h"

@interface SignViewController ()
@property (weak, nonatomic) IBOutlet UITextField *PhoneNum;
@property (weak, nonatomic) IBOutlet UITextField *IdCode;
@property (weak, nonatomic) IBOutlet UITextField *RIdCode;

@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property(nonatomic,strong)NSArray *datas;
@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
}
- (IBAction)GetNumCode:(id)sender {

    if (![self isValidatePhone:self.PhoneNum.text]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"您输入的手机号有误，请重新输入!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [self.view addSubview:alert];
        [alert show];
        return ;
    }
    [self GetNumCode];
    
}

- (IBAction)sign:(id)sender {
    
    
    [self signup];
    
    
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

-(void)GetNumCode{

    NSDictionary *paras = @{@"commandcode": @"125", @"REQUEST_BODY":@{@"username":_PhoneNum.text,@"code":@"2"}};
    //序列化为字符串
    NSString *parsString = [NSJSONSerialization stringWithJSONObjct:paras];
    
    
    //完整地提交的参数
    NSDictionary *parameters = @{@"HEAD_INFO":parsString};
    
    NSString *urlString = @"http://www.fungpu.com/houseapp/apprq.do";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlString parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObject) {
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
    }];

}


-(void)signup
{

    NSDictionary *paras = @{@"commandcode": @"110", @"REQUEST_BODY":@{@"username":_PhoneNum.text,@"code":_IdCode.text,@"password":_passWord.text}};
    //序列化为字符串
    NSString *parsString = [NSJSONSerialization stringWithJSONObjct:paras];
    
    
    //完整地提交的参数
    NSDictionary *parameters = @{@"HEAD_INFO":parsString};
    
    NSString *urlString = @"http://www.fungpu.com/houseapp/apprq.do";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlString parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObject) {
        
        
        NSDictionary *responseBody=[responseObject valueForKey:@"RESPONSE_BODY"];
         NSArray *Sdatas=[responseBody valueForKey:@"list"];
        NSLog(@"LLLLLLLLLLLLLLLLLL%@",Sdatas);
        int state=[Sdatas[0][@"state"] intValue];
       if (state ==0) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"注册成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [self.view addSubview:alert];
            [alert show];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            
        }else if(state==1)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"注册失败，请重新尝试!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [self.view addSubview:alert];
            [alert show];
        }
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
    }];
}

@end
