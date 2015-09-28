//
//  DetailTableViewController.m
//  新亚企航
//
//  Created by qingyun on 15/9/26.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "DetailTableViewController.h"
#import "DetailTableViewCell.h"
#import "AFNetworking.h"
#import "NSJSONSerialization+NSString.h"
#import "UIImageView+WebCache.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface DetailTableViewController ()
@property(nonatomic,strong)NSArray *Ddatas;
@property(nonatomic,strong)NSArray *Cdatas;
@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=NO;
    
//    UIBarButtonItem *Shareiterm=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
//                                                                        target:self action:@selector(sharedToThird)];
//    
    
    UIBarButtonItem *Shareiterm=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"分享未点击"] style: UIBarButtonItemStyleDone target:self action:@selector(sharedToThird)];
    
 

    
    UIBarButtonItem *Collectiterm=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"收藏未点击"] style:UIBarButtonItemStyleDone target:self action:@selector(collectionFromSever)];
    
    Shareiterm.image=[UIImage imageNamed:@"收藏未点击"];
    Collectiterm.image=[UIImage imageNamed:@"分享未点击"];
    NSArray *iterms=@[Shareiterm,Collectiterm];
    
    
    self.navigationItem.rightBarButtonItems=iterms;
    
    
    [self loadDataFromServer];
    
    
    
    
}

-(void)sharedToThird
{
    [self showShareActionSheet:self.view];

}

-(void)collectionFromSever
{

    [self collecttoSever];
}

-(void)loadDataFromServer
{
    
    NSDictionary *paras = @{@"commandcode": @"109", @"REQUEST_BODY":@{@"nid":self.searchString}};
    //序列化为字符串
    NSString *parsString = [NSJSONSerialization stringWithJSONObjct:paras];
    
    
    //完整地提交的参数
    NSDictionary *parameters = @{@"HEAD_INFO":parsString};
    
    NSString *urlString = @"http://www.fungpu.com/houseapp/apprq.do";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlString parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObject) {
        
        
        NSDictionary *responseBody=[responseObject valueForKey:@"RESPONSE_BODY"];
        
        _Ddatas=[responseBody valueForKey:@"list"];
       // NSLog(@"=====================%@",_Ddatas);
        
        [self.tableView reloadData];
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 820;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    if (![self.Ddatas[0][@"floor"] isKindOfClass:[NSNull class]]) {
         cell.Dfloor.text=[self.Ddatas[0][@"floor"]stringValue ];
    }
    
  
    if (![self.Ddatas [0][@"address"] isKindOfClass:[NSNull class]]) {
       cell.Daddress.text=self.Ddatas[0][@"address"];
    }
    
    
    
    if (![self.Ddatas [0][@"fitment"] isKindOfClass:[NSNull class]]) {
         cell.Dfitment.text=self.Ddatas[0][@"fitment"];
    }
  
    
    if (![self.Ddatas [0][@"type"] isKindOfClass:[NSNull class]]) {
       cell.Dhousetype.text=self.Ddatas[0][@"type"];
    }
    if (![self.Ddatas [0][@"state"] isKindOfClass:[NSNull class]]) {
        cell.Dstate.text=self.Ddatas[0][@"state"];
    }
   
    if (![self.Ddatas [0][@"area"] isKindOfClass:[NSNull class]]) {
        cell.Darea.text=[self.Ddatas[0][@"area"] stringValue] ;

    }
    if (![self.Ddatas [0][@"toward"] isKindOfClass:[NSNull class]]) {
        cell.Dtoward.text=self.Ddatas[0][@"toward"];
    }
    
    
    if (![self.Ddatas [0][@"name"] isKindOfClass:[NSNull class]]) {
        cell.Dname.text=self.Ddatas[0][@"name"];
    }
    
    if (![self.Ddatas [0][@"mob"] isKindOfClass:[NSNull class]]) {
        cell.Dmob.text=self.Ddatas[0][@"mob"];
        cell.DPhone.text=self.Ddatas[0][@"mob"];
    }

    cell.Dtitle.text=self.GetTitle;
    cell.Dprice.text=self.Getprice; 
  
    if (![self.Ddatas [0][@"fitment"] isKindOfClass:[NSNull class]]) {
        cell.Dfitment.text=self.Ddatas[0][@"fitment"];
    }
    if (![self.Ddatas [0][@"config"] isKindOfClass:[NSNull class]]) {
        cell.Dconfig.text=self.Ddatas[0][@"config"];
    }
    if (![self.Ddatas [0][@"desc"] isKindOfClass:[NSNull class]]) {
        cell.Ddesc.text=self.Ddatas[0][@"desc"];
    }
    

    if (![self.Ddatas [0][@"com"] isKindOfClass:[NSNull class]]) {
        cell.Dcom.text=self.Ddatas[0][@"com"];
    }
    if (![self.Ddatas [0][@"environmental"] isKindOfClass:[NSNull class]]) {
        cell.Denvironment.text=self.Ddatas[0][@"environmental"];
    }
    

    if (![self.Ddatas [0][@"facility"] isKindOfClass:[NSNull class]]) {
        cell.Dfacility.text=self.Ddatas[0][@"facility"];
    }

     NSString *urlStr = @"http://www.fungpu.com/houseapp/";
    NSString *iconUrl=self.Ddatas[0][@"iconurl"];
    if ([iconUrl isEqual:@""]|[iconUrl isEqual:nil]) {
        NSString *urlString=[urlStr stringByAppendingPathComponent:iconUrl];
        NSURL *url=[NSURL URLWithString:urlString];
        [cell.DiconDown sd_setImageWithURL:url];
    }
    
    
    
    return cell;
}



- (void)showShareActionSheet:(UIView *)view
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
   // __weak DetailTableViewController *theController = self;
    
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    //    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:nil
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    
    
    
    //2、分享
    [ShareSDK showShareActionSheet:view
                             items:@[@(SSDKPlatformTypeSinaWeibo),  @(SSDKPlatformTypeWechat), @(SSDKPlatformTypeQQ)]
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                           //                           [theController showLoadingView:YES];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
                   
                   if (state != SSDKResponseStateBegin)
                   {
                       //                       [theController showLoadingView:NO];
                       //                       [theController.tableView reloadData];
                   }
                   
               }];
}

-(void)collecttoSever
{NSDictionary *paras = @{@"commandcode": @"123", @"REQUEST_BODY":@{@"xid":self.searchString}};
    //序列化为字符串
    NSString *parsString = [NSJSONSerialization stringWithJSONObjct:paras];
    
    
    //完整地提交的参数
    NSDictionary *parameters = @{@"HEAD_INFO":parsString};
    
    NSString *urlString = @"http://www.fungpu.com/houseapp/apprq.do";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlString parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObject) {
        NSLog(@"%@", responseObject);
        
        NSDictionary *responseBody=[responseObject valueForKey:@"RESPONSE_BODY"];
//        
//        NSString *srt=[responseBody valueForKey:@"RESPONSE_CODE_INFO"];
//        NSLog(@"LLLLLLLLLLLLLLLLLL%@",srt);
//        int state=[_Ldatas[0][@"state"] intValue];
//        if (state ==0) {
//            NSNotification * notice = [NSNotification notificationWithName:@"123" object:nil userInfo:@{@"1":@"1",@"2":_UserName.text}];
//            //发送消息
//            [[NSNotificationCenter defaultCenter]postNotification:notice];
//            [self alertShow];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        
//        }else if(state==1)
//        {
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"登录失败，请重新登录!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [self.view addSubview:alert];
//            [alert show];
//        }
//        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
    }];



}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
