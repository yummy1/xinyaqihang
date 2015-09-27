//
//  logoutViewController.m
//  新亚企航
//
//  Created by qingyun on 15/9/26.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "logoutViewController.h"
#import "NSJSONSerialization+NSString.h"
#import "AFNetworking.h"

@interface logoutViewController ()
@property(nonatomic,strong)NSArray *Ldatas;
@end

@implementation logoutViewController



-(void)viewWillAppear:(BOOL)animated
{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.PhoneLabel.text=self.PhoneNum;
}




- (IBAction)logout:(id)sender {
    
    [self logOut];
    
}
-(void)logOut
{
    NSDictionary *paras = @{@"commandcode": @"128", @"REQUEST_BODY":@{@"username":_PhoneNum}};
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
            
            
            
            NSNotification * notice = [NSNotification notificationWithName:@"123" object:nil userInfo:@{@"1":@"0"}];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            
            
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
            
        }
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
    }];

}

@end
