//
//  SaleViewController.m
//  新亚企航
//
//  Created by qingyun on 15/9/24.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SaleViewController.h"

@interface SaleViewController ()

@end

@implementation SaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addsale=[[UIBarButtonItem alloc]init];
    addsale.title=@"添加房源";
    self.navigationItem.rightBarButtonItem=addsale;
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
