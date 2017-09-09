//
//  IWPicAndTextMessageDiagnoseController.m
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import "IWPicAndTextMessageDiagnoseController.h"

// 视图
#import "IWPicAndTextMessageDiagnoseHeaderView.h"
// 控制器
#import "IWMessageDiagnoseController.h"


#import "IWFirstChildViewController.h"
#import "IWSecondChildViewController.h"
#import "IWMedicalReportViewCell.h"
#import "IWAddMessageViewController.h"

@interface IWPicAndTextMessageDiagnoseController ()

{
    UIViewController *currentVC;
}

@property (nonatomic,weak) IWPicAndTextMessageDiagnoseHeaderView *headerView;
@property (nonatomic, strong) IWFirstChildViewController *firstVC;
@property (nonatomic, strong) IWSecondChildViewController *secondVC;
@property (nonatomic, strong) UIView *showArea;
@property (nonatomic, strong) IWPicAndTextMessageDiagnoseSelectPickedView *pickView;
@property (nonatomic, weak) UIButton *bottomButton;


@end

@implementation IWPicAndTextMessageDiagnoseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"图文留言问诊";

    [self configUI];//配置UI
    
    //添加底部按钮
    [self bottomButton];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark - 控件安装，初始化

-(void)configUI{
    [self headerView];

    //添加button
    UIView *lineview = [[UIView alloc] init];
    lineview.backgroundColor = [UIColor lightGrayColor];
    lineview.alpha = 0.2;
    lineview.frame = CGRectMake(10, 0, IWWIDTH - 20, 0.5);
    
    self.pickView = [IWPicAndTextMessageDiagnoseSelectPickedView IWPicAndTextMessageDiagnoseSelectPickedViewWithFrame:CGRectMake(0, 150, IWWIDTH, 38)];
    self.pickView.titleOne = @"已提交";
    self.pickView.titleTwo = @"已回复";
    
    __weak typeof(self)ws = self;
    [self.pickView setButtonTapBlock:^(NSInteger tag) {
        if (tag == 0)
        {
            if (currentVC == _firstVC)
            {
                return;
            }
            
            [ws transitionFromViewController:currentVC toViewController:_firstVC duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
                
            } completion:^(BOOL finished) {
                currentVC = _firstVC;
            }];
        }
        
        if (tag == 1)
        {
            if (currentVC == _secondVC)
            {
                return;
            }
            
            [self transitionFromViewController:currentVC toViewController:_secondVC duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
                
            } completion:^(BOOL finished) {
                currentVC = _secondVC;
            }];
        }
        
    }];
    
    
    [self.view addSubview:self.pickView];
    [self.pickView addSubview:lineview];
    
    // 初始化两个控制器并作为root控制器的subController
    _firstVC   = [IWFirstChildViewController new];
    _firstVC.inquiryType = 3;
    [self addChildViewController:_firstVC];
    [_firstVC didMoveToParentViewController:self];
    
    _secondVC  = [IWSecondChildViewController new];
    _secondVC.inquiryType = 3;
    [self addChildViewController:_secondVC];
    [_secondVC didMoveToParentViewController:self];



    // 初始化要展示的区域
    self.showArea = [UIView new];
    self.showArea.frame = CGRectMake(0, 190, IWWIDTH,IWHEIGHT - 190);
    self.showArea.layer.masksToBounds = YES;
    [self.view addSubview:_showArea];
    
    // 将第一个控制器的view添加进来展示
    [self.showArea addSubview:_firstVC.view];
    
    currentVC = _firstVC;
    
}
-(UIButton *)bottomButton{
    if (_bottomButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(IWWIDTH - 70, IWHEIGHT - 70 - 64, 60, 60);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 25;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(bottombuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.numberOfLines = 2;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"liuyan_btn"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"liuyan_btn_highlighted"] forState:UIControlStateHighlighted];
        
        [button setTitle:@"留言" forState:UIControlStateNormal];
        
        [self.view addSubview:button];
        
        _bottomButton=button;
    }
    return _bottomButton;
}
//点击事件
-(void)bottombuttonClicked:(UIButton *)button{
    IWAddMessageViewController *vc = [[IWAddMessageViewController alloc] init] ;
    vc.navigationItem.title = @"留言问诊";
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}
#pragma mark - 控件
-(IWPicAndTextMessageDiagnoseHeaderView *)headerView{
    if (_headerView == nil) {
        IWPicAndTextMessageDiagnoseHeaderView *headerView = [IWPicAndTextMessageDiagnoseHeaderView IWPicAndTextMessageDiagnoseHeaderViewWithFrame:CGRectMake(0, 0, IWWIDTH, 120)];
        
        __weak typeof(self) ws = self;
        [headerView setButtonTapBlock:^(NSInteger index) {
            switch (index) {
                case 0://我的
                {
                    IWMessageDiagnoseController *dbc = [[IWMessageDiagnoseController alloc] init];
                    dbc.title = @"我的问诊";
                    dbc.type = 0;
                    [ws.navigationController pushViewController:dbc animated:YES];
                }
                    break;
                case 1://家人的
                {
                    IWMessageDiagnoseController *dbc = [[IWMessageDiagnoseController alloc] init];
                    dbc.title = @"家人的问诊";
                    dbc.type = 1;

                    [ws.navigationController pushViewController:dbc animated:YES];
                }
                    break;
                case 2://其他人的
                {
                    IWMessageDiagnoseController *dbc = [[IWMessageDiagnoseController alloc] init];
                    dbc.title = @"其他人的问诊";
                    dbc.type = 2;

                    [ws.navigationController pushViewController:dbc animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }];
        [self.view addSubview:headerView];
        _headerView = headerView;
    }
    return _headerView;
}




@end
