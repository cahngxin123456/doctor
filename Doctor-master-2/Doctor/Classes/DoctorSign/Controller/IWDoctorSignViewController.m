//
//  IWDoctorSignViewController.m
//  Doctor
//
//  Created by 范超 on 2016/12/24.
//
//

#import "IWDoctorSignViewController.h"
#import "IWWebViewController.h"

@interface IWDoctorSignViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonInfo;
@property (weak, nonatomic) IBOutlet UIButton *buttonDoctorInfo;
@property (weak, nonatomic) IBOutlet UIButton *buttonAgreement;
- (IBAction)loadInfo;
- (IBAction)loadDoctorInfo;
- (IBAction)loadAgreement;

@end

@implementation IWDoctorSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置基本
    [self setupBase];
}

-(void)setupBase {
    self.title = NSLocalizedString(@"doctor_sign_title", nil);
    
    [self.buttonInfo setBackgroundImage:[UIImage resizedImageWithName:@"sm_bg"] forState:UIControlStateNormal];
    [self.buttonInfo setBackgroundImage:[UIImage resizedImageWithName:@"sm_bg_highlighted"] forState:UIControlStateHighlighted];
    
    [self.buttonDoctorInfo setBackgroundImage:[UIImage resizedImageWithName:@"mp_bg"] forState:UIControlStateNormal];
    [self.buttonDoctorInfo setBackgroundImage:[UIImage resizedImageWithName:@"mp_bg_highlighted"] forState:UIControlStateHighlighted];
    
    [self.buttonAgreement setBackgroundImage:[UIImage resizedImageWithName:@"xieyi_bg"] forState:UIControlStateNormal];
    [self.buttonAgreement setBackgroundImage:[UIImage resizedImageWithName:@"xieyi_bg_highlighted"] forState:UIControlStateHighlighted];
}

- (IBAction)loadInfo {
    NSString *url = SERVER_GET_AGREE_ILLUSTRATION_URL;
    
    IWWebViewController *vc = [[IWWebViewController alloc] init];
    vc.navTitle = NSLocalizedString(@"doctor_sign_info", nil);
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loadDoctorInfo {
    NSString *url = [NSString stringWithFormat:SERVER_GET_VIEW_DOCTORINFO_URL, [IWUserTool user].loginId];
    
    IWWebViewController *vc = [[IWWebViewController alloc] init];
    vc.navTitle = NSLocalizedString(@"doctor_sign_doctorinfo", nil);
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loadAgreement {
    NSString *url = [NSString stringWithFormat:SERVER_GET_VIEW_AGREEMENT_URL, [IWUserTool user].loginId];
    
    IWWebViewController *vc = [[IWWebViewController alloc] init];
    vc.navTitle = NSLocalizedString(@"doctor_sign_title", nil);
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
