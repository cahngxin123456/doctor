//
//  IWTrainningKnowledgeViewController.m
//  Conedot
//
//  Created by 范超 on 15/1/20.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWTrainningKnowledgeViewController.h"

@interface IWTrainningKnowledgeViewController ()

@end

@implementation IWTrainningKnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置基本
    [self setupBase];
}

/**
 *  设置基本
 */
- (void)setupBase {
    self.title = NSLocalizedString(@"trainning_knowledge", nil);
    self.view.backgroundColor = IWGlobalBg;
}

@end
