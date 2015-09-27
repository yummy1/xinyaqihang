//
//  RentalViewController.m
//  新亚企航
//
//  Created by qingyun on 15/9/24.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "RentalViewController.h"
#import "RentalTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "NSJSONSerialization+NSString.h"
#import "DetailTableViewController.h"


@interface RentalViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *datas;
@property(nonatomic,strong)NSString *NoNameString;
@property(nonatomic,strong)NSString *NoNamePrice;
@property(nonatomic,strong)NSString *NoNameTitle;

@end

@implementation RentalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self.segemC addTarget:self action:@selector(OnSelect:) forControlEvents:UIControlEventValueChanged];
    [self loadDataFromSerVer];
    
    _MyTabView.delegate=self;
    _MyTabView.dataSource=self;
   }

-(void)OnSelect:(UISegmentedControl*)sender
{
 
    if ( sender.selectedSegmentIndex==0) {
     UITableView *AreaTabView=[[UITableView alloc]init];
        [self.view addSubview:AreaTabView];
        
    }
    
    
}




-(void)loadDataFromSerVer
{

    NSDictionary *paras = @{@"commandcode": @"108", @"REQUEST_BODY":@{@"city":@"昆明",@"desc":@"0",@"p":@"1",@"lat":@"24.97307931636",@"lng":@"102.69840055824"}};
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
        
        
        [_MyTabView reloadData];
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
    }];
    


}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   RentalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    
       cell.title.text=self.datas[indexPath.row][@"title"];
    cell.huxing.text=self.datas[indexPath.row][@"housetype"];
    cell.price.text=[self.datas[indexPath.row][@"price"] stringValue];
    cell.community.text=self.datas[indexPath.row][@"community"];
    cell.idNum.text=self.datas[indexPath.row][@"nid"];
    cell.shequ.text=self.datas[indexPath.row][@"simpleadd"];
    NSString *urlStr = @"http://www.fungpu.com/houseapp/";
    NSString *urlString=[urlStr stringByAppendingString:_datas[indexPath.row][@"iconurl"]];
    NSURL *url=[NSURL URLWithString:urlString];
    [cell.icon sd_setImageWithURL:url];
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    DetailTableViewController *controller=(DetailTableViewController*)sender;
   UITableViewController *dstvc=segue.destinationViewController;
    
   
    [dstvc setValue:_NoNameString  forKey:@"searchString"];
    [dstvc setValue:_NoNameTitle  forKey:@"GetTitle"];
     [dstvc setValue:_NoNamePrice  forKey:@"Getprice"];
}



- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    RentalTableViewCell *cell=(RentalTableViewCell*)[self.MyTabView cellForRowAtIndexPath:indexPath];
    
    _NoNameString=cell.idNum.text;
    _NoNamePrice=cell.price.text;
    _NoNameTitle=cell.title.text;
    return indexPath;

}




-(void)viewWillAppear:(BOOL)animated
{
//
//    [self.navigationController.tabBarController.tabBar setHidden:YES];
    
    self.navigationController.navigationBarHidden = YES;
    UIButton *CityBtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 30, 50, 20)];
    [self.view addSubview:CityBtn];
    CityBtn.backgroundColor=[UIColor grayColor];
    [CityBtn setTitle:@"昆明" forState:UIControlStateNormal];
    
    UISearchBar *searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(60, 30, 220, 20)];
    [self.view addSubview:searchBar];
    
    
    UIButton *MapBtn=[[UIButton alloc]initWithFrame:CGRectMake(320, 30, 50, 20)];
    [self.view addSubview:MapBtn];
    [MapBtn setTitle:@"地图" forState:UIControlStateNormal];
    MapBtn.backgroundColor=[UIColor grayColor];
    UIView *LineView=[[UIView alloc]initWithFrame:CGRectMake(0, 53, 375, 1)];
    LineView.backgroundColor=[UIColor blueColor];
    [self.view addSubview:LineView];
 
}





@end
