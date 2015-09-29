//
//  DetailTableViewCell.h
//  新亚企航
//
//  Created by qingyun on 15/9/26.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollview;
@property (weak, nonatomic) IBOutlet UIImageView *iconTop;
@property (weak, nonatomic) IBOutlet UILabel *Dtitle;
@property (weak, nonatomic) IBOutlet UILabel *Dprice;
@property (weak, nonatomic) IBOutlet UILabel *Dhousetype;
@property (weak, nonatomic) IBOutlet UILabel *Dfitment;
@property (weak, nonatomic) IBOutlet UILabel *Darea;

@property (weak, nonatomic) IBOutlet UILabel *Dtoward;
@property (weak, nonatomic) IBOutlet UILabel *Dfloor;

@property (weak, nonatomic) IBOutlet UILabel *Dstate;
@property (weak, nonatomic) IBOutlet UILabel *DPhone;
@property (weak, nonatomic) IBOutlet UILabel *Dcom;

@property (weak, nonatomic) IBOutlet UILabel *Daddress;
@property (weak, nonatomic) IBOutlet UILabel *Dconfig;

@property (weak, nonatomic) IBOutlet UILabel *Ddesc;

@property (weak, nonatomic) IBOutlet UILabel *Denvironment;

@property (weak, nonatomic) IBOutlet UILabel *Dfacility;
@property (weak, nonatomic) IBOutlet UILabel *Dname;
@property (weak, nonatomic) IBOutlet UILabel *Dmob;

@property (weak, nonatomic) IBOutlet UIImageView *DiconDown;

@end
