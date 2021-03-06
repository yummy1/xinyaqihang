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


@interface RentalViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong)NSArray *datas;
@property(nonatomic,strong)NSMutableArray *AreaDatas;
@property(nonatomic,strong)NSArray *ListDatas;

@property(nonatomic,strong)NSString *NoNameString;
@property(nonatomic,strong)NSString *NoNamePrice;
@property(nonatomic,strong)NSString *NoNameTitle;
@property(nonatomic,strong)UIButton *cityBtn;
@property(nonatomic,strong)UITableView *streetTabView;
@property(nonatomic,strong)UITableView *AreaTabView;
@property(nonatomic,strong)UITableView *PriceTabView;
@property(nonatomic,strong)UITableView *MoreTabView;
@property(nonatomic)BOOL switchArea;
@property(nonatomic)BOOL switchPrice;
@property(nonatomic)BOOL switchMore;

@property(nonatomic,strong)NSArray *PriceDatas;
@property(nonatomic,strong)NSDictionary *MoreDict;
@property(nonatomic,strong)UIView *Blueview;
@property(nonatomic)int ALLIndexpath;
@property(nonatomic,strong)NSString *compareArea;
@property(nonatomic,strong)NSString *compareArea22;
@property(nonatomic,strong)NSString *compareStreetString;
@property(nonatomic,strong)NSString *comparePrice;
@property(nonatomic,strong)UIRefreshControl *Recontrol;

@end

@implementation RentalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   // [self.segemC addTarget:self action:@selector(OnSelect:) forControlEvents:UIControlEventValueChanged];
    [self loadDataFromSerVer];
    
    _MyTabView.delegate=self;
    _MyTabView.dataSource=self;
    
    _PriceDatas=@[@"不限",@"0-500",@"500-800",@"800-1000",@"1000-1500",@"1500-2500",@"2500-5000"];
    
    
    _switchArea=NO;
    _switchMore=NO;
    _switchPrice=NO;
    
//下拉刷新
    
  //  [self setupRefresh];
   }

-(void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(loadDataFromSerVer) forControlEvents:UIControlEventValueChanged];
    [self.MyTabView addSubview:control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [control beginRefreshing];
    
    // 3.加载数据
    [self loadDataFromSerVer];
    _Recontrol=control;
}



-(void)OnSelect:(UISegmentedControl*)sender
{
 
    if ( sender.selectedSegmentIndex==0) {
     UITableView *AreaTabView=[[UITableView alloc]init];
        [self.view addSubview:AreaTabView];
        
    }
    
    
}


- (IBAction)AreaBtnWithCreateTabView:(id)sender {
    
    
    
    if ((_switchArea = !_switchArea)) {
        _AreaTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, 375, 350)];
        self.AreaTabView .separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview: _AreaTabView];
        [self GetStreetAndArea];
        _AreaTabView.delegate=self;
        _AreaTabView.dataSource=self;
        _AreaTabView.tag=101;
        
            }else {
                
    
        [_AreaTabView removeFromSuperview];
        [_Blueview removeFromSuperview];
       [_streetTabView removeFromSuperview];
                
    }
}
- (IBAction)PriceBtnWithCreateTabview:(id)sender {
    
    if ((_switchPrice = !_switchPrice)) {
        _PriceTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, 375, 350)];
        [self.view addSubview: _PriceTabView];
        _PriceTabView.delegate=self;
        _PriceTabView.dataSource=self;
        _PriceTabView.tag=201;
}
    else {
        
        [_PriceTabView removeFromSuperview];
    }
}


- (IBAction)moreBtnWithTAbView:(id)sender {
    
//    
//    if ((_switchMore = !_switchMore)) {
//        _MoreTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, 375, 350)];
//        [self.view addSubview: _MoreTabView];
//        _MoreTabView.tag=301;
//    }else {
//        
//        [_MoreTabView removeFromSuperview];
//      
//        
//    }

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
        NSLog(@"***************%@",_datas);
        
        
        [_MyTabView reloadData];
        
        [_Recontrol endRefreshing];
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
        [_Recontrol endRefreshing];
    }];
    


}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag==101) {
        return self.AreaDatas.count;
    }
    else if(tableView.tag==102)
    {
        NSArray *arr=self.ListDatas[_ALLIndexpath-1];
        return arr.count;
        
    }else if(tableView.tag==201)
    {
    
        return self.PriceDatas.count;
    }
    else
    {
        return self.datas.count;}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify=@"AreaCell";
    static NSString *streeId=@"steetCell";
    static NSString *priceId=@"priceCell";
    if (tableView.tag==101) {
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
       // cell.textLabel.text=self.AreaDatas[indexPath.row];
        [cell.textLabel setText:self.AreaDatas[indexPath.row]];
        return cell;
        
       
        
    }else if
         (tableView.tag==102) {
            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:streeId];
            
           [cell.textLabel setText:self.ListDatas[_ALLIndexpath-1][indexPath.row]];
            // [cell.textLabel setText: @"ssss"];
             return cell;
         }else if (tableView.tag==201){
             
             
             UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:priceId];
             [cell.textLabel setText:self.PriceDatas[indexPath.row]];
             return cell;

         
         }
    
    
    else{
    
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
   
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    DetailTableViewController *controller=(DetailTableViewController*)sender;
   UITableViewController *dstvc=segue.destinationViewController;
    
    
    
    [_AreaTabView removeFromSuperview];
    [_Blueview removeFromSuperview];
    [_streetTabView removeFromSuperview];

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
    
    self.navigationController.navigationBarHidden = YES;
    _cityBtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 30, 50, 20)];
    [self.view addSubview:_cityBtn];
    _cityBtn.backgroundColor=[UIColor grayColor];
    [_cityBtn setTitle:@"昆明" forState:UIControlStateNormal];
    [_cityBtn addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UISearchBar *searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(60, 30, 220, 20)];
    [self.view addSubview:searchBar];
    searchBar.delegate=self;
    
    UIButton *MapBtn=[[UIButton alloc]initWithFrame:CGRectMake(320, 30, 50, 20)];
    [self.view addSubview:MapBtn];
    
    [MapBtn setTitle:@"地图" forState:UIControlStateNormal];
    MapBtn.backgroundColor=[UIColor grayColor];
    UIView *LineView=[[UIView alloc]initWithFrame:CGRectMake(0, 53, 375, 1)];
    LineView.backgroundColor=[UIColor blueColor];
    [self.view addSubview:LineView];
 
}

-(void)selectCity
{UITableViewController *CityVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CityTabViewController"];
    [CityVC setValue:_cityBtn.titleLabel.text forKey:@"CityName"];
    
    [self.navigationController pushViewController:CityVC animated:YES];

}



- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    UIViewController *searchVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    [searchVC setValue:_cityBtn.titleLabel.text forKey:@"city"];
    [self.navigationController pushViewController:searchVC animated:YES];
    
    [searchBar resignFirstResponder];
}


-(void)GetStreetAndArea
{

    NSDictionary *paras = @{@"commandcode": @"101", @"REQUEST_BODY":@{@"city":_cityBtn.titleLabel.text}};
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
        //_AreaDatas=[NSMutableArray array];
      _AreaDatas=[[responseBody valueForKey:@"list"]valueForKey:@"area"];
        _AreaDatas=[NSMutableArray arrayWithArray:_AreaDatas];
        [_AreaDatas insertObject:@"不限" atIndex:0];
        _ListDatas=[[responseBody valueForKey:@"list"]valueForKey:@"listarea"];
        [_AreaTabView reloadData];
        [_streetTabView reloadData];
            } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView.tag==101) {
        if (indexPath.row==0) {
           
            //_switchArea=YES;
            [self.AreaTabView removeFromSuperview];
            [_Blueview removeFromSuperview];
            [_streetTabView removeFromSuperview];
          
            //_switchArea=NO;
            [self loadDataFromSerVer];
             }else if (indexPath.row<self.AreaDatas.count+1)
             {
                
                 
                 UITableViewCell *cell =[ _AreaTabView cellForRowAtIndexPath:indexPath];
                 _compareArea=  cell.textLabel.text;
                 
               
                 
                 
                _Blueview =[[UIView alloc]initWithFrame:CGRectMake(129, 100, 1, 350)];
                 _Blueview.backgroundColor=[UIColor blueColor];
                 [self.view addSubview:_Blueview];
                 
                 _streetTabView=[[UITableView alloc]initWithFrame:CGRectMake(130, 100, 273, 350)];
        
                 [self.view addSubview:_streetTabView];
                 
               
                
                 _streetTabView.tag=102;
                 _streetTabView.delegate=self;
                 _streetTabView.dataSource=self;
                 
                 
                 _ALLIndexpath=(int)indexPath.row;
                 
                 }
    }else if(tableView.tag==102 )
       
        
    
    {
        
        NSArray *Arr=self.ListDatas[_ALLIndexpath-1];
        if (indexPath.row<Arr.count+1) {
            UITableViewCell *cell =[_streetTabView cellForRowAtIndexPath:indexPath];
            _compareStreetString= cell.textLabel.text;
            
            
            [self loadDataWithAreaAndBusiness];
        
        }
   }else if (tableView.tag==201)
   {
   UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
       _comparePrice=cell.textLabel.text;
       
       if (indexPath.row==0) {
           _switchPrice=YES;
           [_PriceTabView removeFromSuperview];
          
       }else if(indexPath.row<7)
       {

              // NSString *PriceWorld=[self.datas[indexPath.row]valueForKey:@"price"];
               NSDictionary *paras = @{@"commandcode": @"108", @"REQUEST_BODY":@{@"city":@"昆明",@"desc":@"0",@"p":@"1",@"lat":@"24.97307931636",@"lng":@"102.69840055824",@"price":_comparePrice}};
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
            //       NSArray *SelectPriceResult=[responseBody valueForKey:@"list"];
                   _datas=[responseBody valueForKey:@"list"];;
                  // NSLog(@"price%@",_datas);
                   
                   if (_datas.count==0) {
                       
                       UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"没有搜索结果!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                       [self.view addSubview:alert];
                       [alert show];
                   }
                   
                   [_MyTabView reloadData];
                   _switchPrice=NO;
                   [_PriceTabView removeFromSuperview];
               } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
                   NSLog(@"%@", error);
               }];
               
               

               
              
       }
   
       

   }
}
-(void)loadDataWithAreaAndBusiness
{
    NSDictionary *paras = @{@"commandcode": @"108", @"REQUEST_BODY":@{@"city":@"昆明",@"area":_compareArea,@"businesscCircle":_compareStreetString}};
    
    
    
    
    //序列化为字符串
    NSString *parsString = [NSJSONSerialization stringWithJSONObjct:paras];
    
    
    //完整地提交的参数
    NSDictionary *parameters = @{@"HEAD_INFO":parsString};
    
    NSString *urlString = @"http://www.fungpu.com/houseapp/apprq.do";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlString parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObject) {
        
        
        NSDictionary *responseBody=[responseObject valueForKey:@"RESPONSE_BODY"];
        
        _datas=[responseBody valueForKey:@"list"];;
        NSLog(@"SteetSteetSteetSteetSteetSteet%@",_datas);
        
                        if (_datas.count==0) {
        
                            [_AreaTabView removeFromSuperview];
                            [_Blueview removeFromSuperview];
                            [_streetTabView removeFromSuperview];
        
        
        
                            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"没有搜索结果!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [self.view addSubview:alert];
                            [alert show];
                        }
        
        [self.MyTabView reloadData];
        // _switchArea=NO;
        [_AreaTabView removeFromSuperview];
        [_Blueview removeFromSuperview];
        [_streetTabView removeFromSuperview];
        
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error);
    }];
    


}

@end
