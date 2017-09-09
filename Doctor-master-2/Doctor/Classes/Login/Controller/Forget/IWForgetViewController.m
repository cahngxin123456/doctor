//
//  IWForgetViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-9.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWForgetViewController.h"
#import "IWFindCellPhoneViewController.h"
#import "IWFindEmailViewController.h"
#import "IWFindAnswerViewController.h"

@interface IWForgetViewController ()
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation IWForgetViewController

- (NSMutableArray *)datas {
    if (_datas == nil) {
        _datas = [NSMutableArray array];
        [_datas addObject:NSLocalizedString(@"find_password_cellphone", nil)];
//        [_datas addObject:NSLocalizedString(@"find_password_email", nil)];
    }
    return _datas;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置tableView属性
    [self setupTableView];
}

/**
 *  设置tableView属性
 */
- (void)setupTableView {
    self.title = NSLocalizedString(@"find_password", nil);
    self.tableView.backgroundColor = IWTableViewBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithName:@"btn_closeItem"] style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
}

/**
 *  关闭
 */
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"forget";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.datas[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = nil;
    if (indexPath.row == 0) { // 手机找回
        vc = [[IWFindCellPhoneViewController alloc] init];
    } else if (indexPath.row == 1) { // 邮箱找回
        vc = [[IWFindEmailViewController alloc] init];
    } else { // 安全问题找回
        vc = [[IWFindAnswerViewController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
