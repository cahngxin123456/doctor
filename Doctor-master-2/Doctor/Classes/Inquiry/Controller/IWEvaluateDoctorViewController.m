//
//  IWEvaluateDoctorViewController.m
//  Doctor
//
//  Created by 深水区 on 17/1/9.
//
//

#import "IWEvaluateDoctorViewController.h"
#import "IWTextView.h"
#import "IWInquiryTool.h"


@interface IWEvaluateDoctorViewController ()<UITextViewDelegate>


@property (nonatomic, weak) IWTextView *textView;
@property (nonatomic, weak) UIButton *saveButton;

@property (nonatomic, copy) NSString *judgement;




@end

@implementation IWEvaluateDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self textView];
    [self saveButton];

}

- (void)setInquiryId:(NSString *)inquiryId{
    _inquiryId = inquiryId;
}

- (void)setMemberID:(NSString *)memberID{
    _memberID = memberID;
}

- (IWTextView *)textView{
    if (_textView == nil) {
        IWTextView *textView = [[IWTextView alloc] init];
        textView.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
        textView.delegate = self;
        textView.frame = CGRectMake(10, 20, IWWIDTH - 20, 80);
        textView.font = [UIFont systemFontOfSize:12];
        textView.placeholder = NSLocalizedString(@"inquiry_doctor_hint", nil);
        textView.delegate =self;
        [self.view addSubview:textView];
        _textView = textView;
        
    }
    return _textView;
}

- (UIButton *)saveButton{
    if (_saveButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, CGRectGetMaxY(self.textView.frame) + 30, IWWIDTH - 20, 40);
        [button addTarget:self action:@selector(savebuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"保存" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 10;
        NSArray *imageNameArray = @[@"t_btn_normal",@"t_btn_press"];
        for (int i = 0; i<2; i++) {
            // 加载图片
            UIImage *image = [UIImage imageNamed:imageNameArray[i]];
            // 设置端盖的值
            CGFloat top = image.size.height * 0.5;
            CGFloat left = image.size.width * 0.5;
            CGFloat bottom = image.size.height * 0.5;
            CGFloat right = image.size.width * 0.5;
            UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
            // 拉伸图片
            UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
            if (i == 0) {
                [button setBackgroundImage:newImage forState:UIControlStateNormal];
            }else
            {
                [button setBackgroundImage:newImage forState:UIControlStateHighlighted];
            }
        }
        [self.view addSubview:button];
        _saveButton = button;
    }
    return _saveButton;
}

- (void)savebuttonClicked:(UIButton *)btn{
    
    if (self.judgement.length == 0) {
        [MBProgressHUD showSuccess:@"请输入留言内容"];
        
    }else{
        IWAddDoctorMessageParam *param = [[IWAddDoctorMessageParam alloc] init];
        param.loginId = self.memberID;
        param.companyId = @(IWCompanyId);
        param.inquiryId = self.inquiryId;
        param.judgement = [self.judgement  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [MBProgressHUD showMessage:@"正在提交留言"];
        [IWInquiryTool submitDoctorMessageWithParams:param datas:nil success:^(IWBaseResult *result) {
            
            [MBProgressHUD hideHUD];
            if (result.code == 0) {
                [MBProgressHUD showSuccess:@"留言提交成功"];
                [self.navigationController popViewControllerAnimated:YES];
                
                
            }else{
                [MBProgressHUD showSuccess:result.info];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
        }];

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.markedTextRange == nil) {
        NSLog(@"text:%@", textView.text);
        self.judgement = textView.text;
    }
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
