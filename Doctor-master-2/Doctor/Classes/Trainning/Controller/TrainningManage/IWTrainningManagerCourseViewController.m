//
//  IWTrainningManagerCourseViewController.m
//  Conedot
//
//  Created by 范超 on 16/7/2.
//  Copyright © 2016年 范超. All rights reserved.
//

#import "IWTrainningManagerCourseViewController.h"
#import "SMPagerTabView.h"
#import "IWTrainningCourseViewController.h"
#import "IWTrainningCourseParam.h"
#import "ScanViewController.h"

@interface IWTrainningManagerCourseViewController () <SMPagerTabViewDelegate>
@property (nonatomic, strong) SMPagerTabView *segmentView;
@property (nonatomic, strong) NSMutableArray *allVC;
@end

@implementation IWTrainningManagerCourseViewController

- (void)viewDidLoad {
#ifdef __IPHONE_7_0
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    [super viewDidLoad];

    // 设置基本
    [self setupBase];
    
    [self setupRightIcon];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupRightIcon {
    UIBarButtonItem *scan = [[UIBarButtonItem alloc] initWithImage:[UIImage resizedImageWithName:@"scan"] style:UIBarButtonItemStyleDone target:self action:@selector(scan:)];
    
    self.navigationItem.rightBarButtonItems = @[scan];
}

- (void)scan:(UIBarButtonItem *)item {
    ScanViewController *vc = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupBase {
    self.title = NSLocalizedString(@"trainning_course_title", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    _allVC = [NSMutableArray array];
    IWTrainningCourseViewController *one = [[IWTrainningCourseViewController alloc] init];
    one.listType = IWTrainningCourseTypeAll;
    one.nav = (UINavigationController *)self.navigationController;
    one.title = NSLocalizedString(@"trainning_course_page_1", nil);
    [_allVC addObject:one];
    
    IWTrainningCourseViewController *two = [[IWTrainningCourseViewController alloc] init];
    two.listType = IWTrainningCourseTypeMine;
    two.nav = (UINavigationController *)self.navigationController;
    two.title = NSLocalizedString(@"trainning_course_page_2", nil);
    [_allVC addObject:two];
    
    IWTrainningCourseViewController *three = [[IWTrainningCourseViewController alloc] init];
    three.listType = IWTrainningCourseTypeLast;
    three.nav = (UINavigationController *)self.navigationController;
    three.title = NSLocalizedString(@"trainning_course_page_3", nil);
    [_allVC addObject:three];
    
    self.segmentView.delegate = self;
    //可自定义背景色和tab button的文字颜色等
    _segmentView.tabButtonFontSize = 13;
    _segmentView.backgroundColor = [UIColor redColor];
    _segmentView.tabButtonTitleColorForSelected = IWGlobalColor;
    _segmentView.tabMargin = 0;
    _segmentView.selectedLineWidth = 80;
    //开始构建UI
    [_segmentView buildUI];
    //起始选择一个tab
    [_segmentView selectTabWithIndex:0 animate:NO];
}

- (NSUInteger)numberOfPagers:(SMPagerTabView *)view {
    return self.allVC.count;
}

- (UIViewController *)pagerViewOfPagers:(SMPagerTabView *)view indexOfPagers:(NSUInteger)number {
    return self.allVC[number];
}

- (SMPagerTabView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[SMPagerTabView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        [self.view addSubview:_segmentView];
    }
    return _segmentView;
}



@end
