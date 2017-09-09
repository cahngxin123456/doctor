//
//  IWTrainningBookViewController.m
//  Conedot
//
//  Created by 范超 on 15/1/20.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWTrainningBookViewController.h"
#import "IWTranningSystemViewController.h"
#import "IWBookCell.h"
#import "IWTabBarButton.h"
#import "IWPopMenu.h"
#import "IWBookItem.h"
#import "IWFanCompany.h"
#import "IWTrainningParam.h"

@interface IWTrainningBookViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UIImageView *imageBg;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) IWPopMenu *menu;

@property (nonatomic, assign) BOOL show;

@property (nonatomic, strong) NSMutableArray *books;

@property (nonatomic, strong) IWFanCompany *company;
@end

@implementation IWTrainningBookViewController

- (void)setUnRead:(IWUnRead *)unRead {
    if (unRead == nil) {
        unRead = [[IWUnRead alloc] init];
    }
    _unRead = unRead;
    [self books];
}

- (NSMutableArray *)books {
    _books = [NSMutableArray array];
    
    IWBookItem *item2 = [[IWBookItem alloc] init];
    item2.name = NSLocalizedString(@"trainning_intro", nil);
    item2.type = IWTrainningBookTypeIntro;
    item2.controllerVc = @"IWTranningSystemViewController";
    item2.enable = YES;
    item2.unReadnum = self.unRead.manualClassUnReadNumber;
    [_books addObject:item2];
    
    IWBookItem *item3 = [[IWBookItem alloc] init];
    item3.name = NSLocalizedString(@"teacher_intro", nil);
    item3.type = IWTrainningBookTypeTeacher;
    item3.controllerVc = @"IWTranningSystemViewController";
    item3.enable = YES;
    item3.unReadnum = self.unRead.manualTeacherUnReadNumber;
    [_books addObject:item3];
    
    IWBookItem *item4 = [[IWBookItem alloc] init];
    item4.name = NSLocalizedString(@"special_project", nil);
    item4.type = IWTrainningBookTypeSpecial;
    item4.controllerVc = @"IWTranningSystemViewController";
    item4.enable = YES;
    item4.unReadnum = self.unRead.manualProjectUnReadNumber;
    [_books addObject:item4];
    
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

- (void)addNotice {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(tabBarClick:) name:@"book" object:nil];
}

- (void)tabBarClick:(NSNotification *)notification {
    long companyId = (long)notification.userInfo[@"company"];
    IWFanCompany *company = [[IWFanCompany alloc] init];
    company.companyId = companyId;
    self.company = company;
    
    // 第一次进入
    if (!self.show) {
        self.show = YES;
        return;
    }
    
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
    
    CGFloat menuX = 5;
    CGFloat menuW = 95;
    CGFloat menuH = tableView.rowHeight * 3 + 16;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.imageBg.frame = self.view.bounds;
}

/**
 *  设置基本
 */
- (void)setupBase {
    self.title = NSLocalizedString(@"trainning_book", nil);
    self.show = NO;
}

/**
 *  设置背景
 */
- (void)setupBg {
    UIImageView *imageBg = [[UIImageView alloc] init];
    [imageBg setImage:[UIImage imageNamed:@"tranning"]];
    [self.view addSubview:imageBg];
    self.imageBg = imageBg;
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
    IWBookItem *item = self.books[indexPath.row];
    Class class = NSClassFromString(item.controllerVc);
    IWTranningSystemViewController *vc = (IWTranningSystemViewController *)[[class alloc] init];
    vc.manualType = item.type;
    
    // 跳转到控制器
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
