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

@interface DetailTableViewController ()
@property(nonatomic,strong)NSArray *Ddatas;
@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=NO;
    [self loadDataFromServer];
    
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
 cell.Dfloor.text=[self.Ddatas[0][@"floor"]stringValue ];
    cell.Daddress.text=self.Ddatas[0][@"address"];
    cell.Dfitment.text=self.Ddatas[0][@"fitment"];
    cell.Dhousetype.text=self.Ddatas[0][@"type"];
    cell.Dstate.text=self.Ddatas[0][@"state"];
    cell.Darea.text=[self.Ddatas[0][@"area"] stringValue] ;
    cell.Dtoward.text=self.Ddatas[0][@"toward"];
    cell.Dname.text=self.Ddatas[0][@"name"];
    cell.Dmob.text=self.Ddatas[0][@"mob"];
    cell.DPhone.text=self.Ddatas[0][@"mob"];
    cell.Dtitle.text=self.GetTitle;
    cell.Dprice.text=self.Getprice; 
    
    
   // cell.DiconDown.image=self.Ddatas[0][@"fitment"];
    cell.Dconfig.text=self.Ddatas[0][@"config"];
    cell.Ddesc.text=self.Ddatas[0][@"desc"];
    cell.Dcom.text=self.Ddatas[0][@"com"];
    cell.Denvironment.text=self.Ddatas[0][@"environmental"];
    cell.Dfacility.text=self.Ddatas[0][@"facility"];
    NSString *urlStr = @"http://www.fungpu.com/houseapp/";
    NSString *iconUrl=self.Ddatas[0][@"iconurl"];
    
    NSString *urlString=[urlStr stringByAppendingPathComponent:iconUrl];
    NSURL *url=[NSURL URLWithString:urlString];
    [cell.DiconDown sd_setImageWithURL:url];









    
    
    
    
    
    
    
    
    
    
    return cell;
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
