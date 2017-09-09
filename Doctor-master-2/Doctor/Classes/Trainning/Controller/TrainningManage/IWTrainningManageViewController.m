//
//  IWTrainningManageViewController.m
//  Conedot
//
//  Created by 范超 on 15/1/20.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWTrainningManageViewController.h"
#import "IWFanCompany.h"
#import "IWPopMenu.h"
#import "IWManagerItem.h"
#import "IWBookCell.h"
#import "IWTranningManagerSystemViewController.h"

@interface IWTrainningManageViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) IWFanCompany *company;
@property (nonatomic, weak) IWPopMenu *menu;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, strong) NSMutableArray *books;
@property (nonatomic, weak) UIImageView *imageBg;
@end

@implementation IWTrainningManageViewController

- (void)setUnRead:(IWUnRead *)unRead {
    if (unRead == nil) {
        unRead = [[IWUnRead alloc] init];
    }
    _unRead = unRead;
    [self books];
}

- (NSMutableArray *)books {
    _books = [NSMutableArray array];
    IWManagerItem *item1 = [[IWManagerItem alloc] init];
    item1.name = NSLocalizedString(@"learntask", nil);
    item1.type = IWTrainningManagerTypeLearnTask;
    item1.controllerVc = @"IWTranningManagerSystemViewController";
    item1.unReadnum = self.unRead.learnTaskNumber;
    item1.enable = YES;
    [_books addObject:item1];
    
    IWManagerItem *item2 = [[IWManagerItem alloc] init];
    item2.name = NSLocalizedString(@"training_courses", nil);
    item2.type = IWTrainningManagerTypeTrainningCourses;
    item2.controllerVc = @"IWTrainningManagerCourseViewController";
    item2.enable = YES;
    [_books addObject:item2];
    
    return _books;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置基本
    [self setupBase];
    
    // 设置背景
    [self setupBg];
    
    // 监听
    [self addNotice];
}

/**
 *  设置基本
 */
- (void)setupBase {
    self.title = NSLocalizedString(@"trainning_manage", nil);
    self.view.backgroundColor = IWGlobalBg;
}

/**
 *  设置背景
 */
- (void)setupBg {
    UIImageView *imageBg = [[UIImageView alloc] init];
    [imageBg setImage:[UIImage imageNamed:@"trainnig_book_manage"]];
    [self.view addSubview:imageBg];
    self.imageBg = imageBg;
}

- (void)addNotice {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(tabBarClick:) name:@"manage" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.imageBg.frame = self.view.bounds;
}


- (void)tabBarClick:(NSNotification *)notification {
    long companyId = (long)notification.userInfo[@"company"];
    IWFanCompany *company = [[IWFanCompany alloc] init];
    company.companyId = companyId;
    self.company = company;
    
    // 第一次进入
//    if (!self.show) {
//        self.show = YES;
//        return;
//    }
    
    // 弹出相应pop
    UITableView *tableView = [[UITableView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    tableView.backgroundView = nil;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.rowHeight = 34;
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    
    IWPopMenu *menu = [[IWPopMenu alloc] initWithContentView:self.tableView];
    menu.arrowPosition = IWPopMenuArrowPositionCenter;
    self.menu = menu;
    
    
    
    CGFloat menuW = 95;
    CGFloat menuX = (self.view.frame.size.width / 3) + 13;
    CGFloat menuH = tableView.rowHeight * 2 + 16;
    CGFloat menuY = self.view.frame.size.height - menuH + 10;
    
    // IOS7 的bug 7.1 7.1.1
    NSString *currentVersion = [UIDevice currentDevice].systemVersion;
    IWLog(@"currentVersion-%@", currentVersion);
    NSComparisonResult result1 = [currentVersion compare:@"7.0" options:NSNumericSearch];
    NSComparisonResult result2 = [currentVersion compare:@"7.0.9" options:NSNumericSearch];
    if (result1 != NSOrderedAscending && result2 == NSOrderedAscending) {  // if (version >= 7.0 && version < 7.0.9) {
        menuY = menuY - 64;
    }
    
    [menu showInRect:CGRectMake(menuX, menuY, menuW, menuH)];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IWBookCell *cell = [IWBookCell cellWithTableView:tableView];
    
    cell.bookItem = self.books[indexPath.row];
    cell.lastRowInSection =  (self.books.count - 1 == indexPath.row);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.menu dismiss];
    
    // 取出数据
    IWManagerItem *item = self.books[indexPath.row];
    if ([item.controllerVc isEqualToString:@""]) {
        return;
    }
    Class class = NSClassFromString(item.controllerVc);
    IWTranningManagerSystemViewController *vc = (IWTranningManagerSystemViewController *)[[class alloc] init];
    vc.manualType = item.type;
    
    // 跳转到控制器
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
