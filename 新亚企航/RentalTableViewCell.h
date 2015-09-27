//
//  RentalTableViewCell.h
//  新亚企航
//
//  Created by qingyun on 15/9/25.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *shequ;
@property (weak, nonatomic) IBOutlet UILabel *community;
@property (weak, nonatomic) IBOutlet UILabel *huxing;
@property (weak, nonatomic) IBOutlet UILabel *idNum;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
