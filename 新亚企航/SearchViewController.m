//
//  SearchViewController.m
//  新亚企航
//
//  Created by qingyun on 15/9/27.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SearchViewController.h"
#import "AFNetworking.h"
#import "NSJSONSerialization+NSString.h"
#

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *mysearchbar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property(nonatomic,strong)NSArray *datas;
@property(nonatomic,strong)NSString *Xid;
@property(nonatomic,strong)NSArray *Xdatas;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.mysearchbar.delegate=self;
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchBar=self.mysearchbar;
    if (self.mysearchbar.text.length!=0) {
        [self resetSearch];
    }

}


-(void)resetSearch
{
//    
//     [NSString stringWithCString:[self.mysearchbar.text UTF8String] encoding:NSUnicodeStringEncoding]
    NSDictionary *paras = @{@"commandcode": @"114", @"REQUEST_BODY":@{@"keyword":  [NSString stringWithCString:[self.mysearchbar.text UTF8String] encoding:NSUnicodeStringEncoding] ,   @"city":self.city}};
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
       _datas=[responseBody valueForKey:@"list"];
        if (self.datas.count>0) {
            _Xid=self.datas[0][@"xid"];
            [self loadDataWithxid];
            
        }
            else if(self.datas.count==0)
        {
            
            
            _Xdatas=@[@""];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"没有搜索的小区!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [self.view addSubview:alert];
            [alert show];

                    }
        
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
    }];
}



-(void)loadDataWithxid
{

    
    
    NSDictionary *paras = @{@"commandcode": @"115", @"REQUEST_BODY":@{@"xid":_Xid}};
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
        _Xdatas=[responseBody valueForKey:@"list"];

        
        [self.myTableView reloadData];
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.Xdatas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];

    cell.textLabel.text=self.Xdatas[indexPath.row][@"community"];
    
    return cell;
}


@end
