//
//  IWUserInfoViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWUserInfoViewController.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWPeople.h"

@interface IWUserInfoViewController ()


@end

@implementation IWUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航
    [self setupNavBar];
    
    // 加载数据
    if (self.companyId) {
        [self loadData];
    }
}

- (void)setPeople:(IWPeople *)people {
    _people = people;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}


/**
 *  加载数据
 */
- (void)loadData {
//    IWUserInfoParam *param = [[IWUserInfoParam alloc] init];
//    param.loginName = [IWUserTool user].loginName;
//    param.pwd = [IWUserTool user].pwd;
//    param.companyId = @(self.companyId);
//    
//    [IWUserTool userInfoWithParam:param success:^(IWUserInfoResult *result) {
//        // 设置数据
//        [self setupData:result];
//    } failure:^(NSError *error) {
//        
//    }];
}

- (void)setupData:(IWUserInfoResult *)result {
    
}

/**
 *  设置导航
 */
- (void)setupNavBar {
    self.title = NSLocalizedString(@"person_info", nil);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithName:@"btn_closeItem"] style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
}

/**
 *  关闭
 */
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
