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

@interface PersonTableViewController ()
@property(nonatomic,strong)NSArray *datas;



@end

@implementation PersonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datas=@[@"登陆/注册",@"我的收藏",@"浏览记录",@"我要卖房",@"关于我们"];
    
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
    
       cell.textLabel.text=self.datas[indexPath.row];
    
         //LoginViewController *Vc=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    UIViewController *vc;
    if (indexPath.row==0) {
         vc=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    }
    if (indexPath.row==1) {
        vc=[self.storyboard instantiateViewControllerWithIdentifier:@"Collect"];
    }
   
    if (indexPath.row==2) {
        vc=[self.storyboard instantiateViewControllerWithIdentifier:@"Collect"];
    }
    
    if (indexPath.row==3) {
        vc=[self.storyboard instantiateViewControllerWithIdentifier:@"sale"];
    }
    
    if (indexPath.row==4) {
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
