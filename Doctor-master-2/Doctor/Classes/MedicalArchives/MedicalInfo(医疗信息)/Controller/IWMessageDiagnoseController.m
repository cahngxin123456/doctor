//
//  IWMessageDiagnoseController.m
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import "IWMessageDiagnoseController.h"
#import "IWPicAndTextMessageDiagnoseSelectPickedView.h"
#import "IWFirstChildViewController.h"
#import "IWSecondChildViewController.h"
#import "IWAddMessageViewController.h"

@interface IWMessageDiagnoseController ()

{
    UIViewController *currentVC;
}

@property (nonatomic, strong) IWFirstChildViewController *firstVC;
@property (nonatomic, strong) IWSecondChildViewController *secondVC;
@property (nonatomic, strong) UIView *showArea;
@property (nonatomic, strong) IWPicAndTextMessageDiagnoseSelectPickedView *pickView;
@property (nonatomic, weak) UIButton *bottomButton;


@end

@implementation IWMessageDiagnoseController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];//配置UI
    [self bottomButton];
}

#pragma mark - 控件安装，初始化

-(void)configUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self pickView];
    
    
    // 初始化两个控制器并作为root控制器的subController
    _firstVC   = [IWFirstChildViewController new];
    _firstVC.inquiryType = self.type;
    [self addChildViewController:_firstVC];
    [_firstVC didMoveToParentViewController:self];
    
    _secondVC  = [IWSecondChildViewController new];
    _secondVC.inquiryType = self.type;
    [self addChildViewController:_secondVC];
    [_secondVC didMoveToParentViewController:self];
    
    
    
    // 初始化要展示的区域
    self.showArea = [UIView new];
    self.showArea.frame = CGRectMake(0, 40, IWWIDTH,IWHEIGHT -40);
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
    vc.inquiryType = self.type;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 控件
-(IWPicAndTextMessageDiagnoseSelectPickedView *)pickView{
    if (_pickView == nil) {
        IWPicAndTextMessageDiagnoseSelectPickedView *pickedView = [IWPicAndTextMessageDiagnoseSelectPickedView IWPicAndTextMessageDiagnoseSelectPickedViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        pickedView.titleOne = @"已提交";
        pickedView.titleTwo = @"已回复";
        
        __weak typeof(self)ws = self;
        [pickedView setButtonTapBlock:^(NSInteger tag) {
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

        
        [self.view addSubview:pickedView];
        _pickView = pickedView;
    }
    return _pickView;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
