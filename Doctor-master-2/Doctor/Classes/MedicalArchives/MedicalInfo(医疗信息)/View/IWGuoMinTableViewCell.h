//
//  IWGuoMinTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import <UIKit/UIKit.h>
#import "IMJIETagView.h"
#import "IMJIETagFrame.h"

@interface IWGuoMinTableViewCell : UITableViewCell<IMJIETagViewDelegate>

@property (nonatomic, weak) IMJIETagView *tagView;
@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) NSString *resultStr;
//
@property (nonatomic, copy) NSString *textFieldStr;
//
@property (nonatomic, copy) void(^guominCellBlock)(NSString *s1);
//
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSArray *selectArray;

@property (nonatomic, copy) NSString *othername;



+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;
@end
