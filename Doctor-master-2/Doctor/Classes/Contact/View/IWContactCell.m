//
//  IWContactCell.m
//  Conedot
//
//  Created by 范超 on 14-10-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWContactCell.h"
#import "IWContact.h"

@interface IWContactCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


@end

@implementation IWContactCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"contact";
    IWContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IWContactCell" owner:nil options:nil][0];
    }
    
    return cell;
}

- (void)setContact:(IWContact *)contact {
    _contact = contact;
    
    self.nameLabel.text = contact.value;
    self.phoneLabel.text = contact.showCellphone;
}

@end
