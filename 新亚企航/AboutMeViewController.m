//
//  AboutMeViewController.m
//  新亚企航
//
//  Created by qingyun on 15/9/24.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake(138, 50, 100, 100)];
    [self.view addSubview:icon];
    
    icon.image=[UIImage imageNamed:@"detailInfoDefault"];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 180, 330, 20)];
    [self.view addSubview:label];
    label.text=@"新亚竭诚为您服务 服务热线0871-64564997";
    
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
