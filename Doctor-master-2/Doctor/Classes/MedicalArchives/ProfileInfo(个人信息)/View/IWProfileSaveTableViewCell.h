//
//  IWProfileSaveTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import <UIKit/UIKit.h>

@interface IWProfileSaveTableViewCell : UITableViewCell

//@property (nonatomic, strong) <#ModelClass#> *model;
@property (nonatomic, weak) UILabel *saveLabel;
+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
