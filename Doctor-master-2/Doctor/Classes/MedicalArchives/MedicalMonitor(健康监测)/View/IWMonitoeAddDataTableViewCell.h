//
//  IWMonitoeAddDataTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import <UIKit/UIKit.h>

@interface IWMonitoeAddDataTableViewCell : UITableViewCell

//@property (nonatomic, strong) <#ModelClass#> *model;
@property (nonatomic, copy) NSString *nameTitle;


@property (nonatomic, weak) UIImageView *rightimageView;
@property (nonatomic, weak) UILabel *titleLabel;
+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
