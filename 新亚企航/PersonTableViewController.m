//
//  PersonTableViewController.m
//  新亚企航
//
//  Created by qingyun on 15/9/24.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "PersonTableViewController.h"
//#import "LoginViewController.h"
//#import "CollectionViewController.h"
#import "AboutMeViewController.h"
#import "PersonTableViewCell.h"

@interface PersonTableViewController ()
@property(nonatomic,strong)NSArray *datas;
@property(nonatomic)int loginNum;
@property(nonatomic,strong)NSString *NoPhoneNum;

@property(nonatomic,strong)NSArray *Ldatas;


@end

@implementation PersonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginNum=0;
    _datas=@[@"登陆/注册",@"我的收藏",@"浏览记录",@"我要卖房",@"关于我们"];
    
    _Ldatas=@[@"用户中心",@"我的收藏",@"浏览记录",@"我要卖房",@"关于我们"];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"123" object:nil];
    
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView .tableFooterView = [[UIView alloc] init];
}

-(void)notice:(id)sender{

    NSDictionary *userInfo=[sender valueForKey:@"userInfo"];
    NSString *Nostr=[userInfo valueForKey:@"1"];
    
    _loginNum=[Nostr intValue];
    
    _NoPhoneNum=[userInfo valueForKey:@"2"];
    [self.tableView reloadData];
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return self.datas.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonSettingCell" forIndexPath:indexPath];
    
    if (_loginNum ==0) {
        cell.textLabel.text=self.datas[indexPath.row];
    }
    else{
        cell.textLabel.text=self.Ldatas[indexPath.row];
      
        
    }
    
         //LoginViewController *Vc=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    UIViewController *vc;
    if (indexPath.row==0 && [cell.textLabel.text isEqualToString:@"登陆/注册"]) {
       
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"登陆";
        self.navigationItem.backBarButtonItem = backItem;
        
         vc=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    }
    else{
        vc=[self.storyboard instantiateViewControllerWithIdentifier:@"logout"];
        [vc setValue:_NoPhoneNum forKey:@"PhoneNum"];
    }
    
    if (indexPath.row==1) {
        
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"收藏";
        self.navigationItem.backBarButtonItem = backItem;
        
        vc=[self.storyboard instantiateViewControllerWithIdentifier:@"Collect"];
    }
   
    if (indexPath.row==2) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"浏览";
        self.navigationItem.backBarButtonItem = backItem;
        vc=[self.storyboard instantiateViewControllerWithIdentifier:@"look"];
    }
    
    if (indexPath.row==3) {
              vc=[self.storyboard instantiateViewControllerWithIdentifier:@"sale"];
    }
    
    if (indexPath.row==4) {
        
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"关于我们";
        self.navigationItem.backBarButtonItem = backItem;
        

        vc=[[AboutMeViewController alloc]init];
    }
    
        [self.navigationController pushViewController:vc animated:YES];
  

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
