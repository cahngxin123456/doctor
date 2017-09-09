//
//  IWProfileSFTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/22.
//
//

#import <UIKit/UIKit.h>
#import "IWprofileCommunityModel.h"
#import "IWprofileProvinceModel.h"
#import "IWProfileCityModel.h"
@interface IWProfileSFTableViewCell : UITableViewCell



@property (nonatomic, strong) IWprofileCommunityModel *communitymodel;
@property (nonatomic, strong) IWprofileProvinceModel *provinceModel;
@property (nonatomic, strong) IWProfileCityModel *cityModel;


@property (nonatomic, weak) UIImageView *rightimageView;
@property (nonatomic, weak) UILabel *titleLabel;
+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
