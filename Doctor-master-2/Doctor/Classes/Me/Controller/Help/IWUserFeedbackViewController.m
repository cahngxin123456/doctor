//
//  IWUserFeedbackViewController.m
//  Conedot
//
//  Created by 范超 on 15/3/31.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWUserFeedbackViewController.h"
#import "IWTextView.h"
#import "IWToast.h"
#import "NSString+IW.h"
#import "MBProgressHUD+MJ.h"
#import "IWMeTool.h"
#include "IWUser.h"
#import "IWUserTool.h"
#import "IWPictureDetailViewController.h"

@interface IWUserFeedbackViewController () <UITextViewDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, IWPictureDetailViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UILabel *subNameView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic, strong) NSString *path;
@property (nonatomic, weak) UIImage *image;

- (IBAction)buttonAdd:(id)sender;
- (IBAction)submit:(id)sender;
@property (nonatomic, weak) IWTextView *textView;
@end

@implementation IWUserFeedbackViewController

- (void)viewDidLoad {
#ifdef __IPHONE_7_0
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    [super viewDidLoad];
    
    // 设置基本
    [self setupBase];
    
    // 添加输入控件
    [self setupTextView];
}

/**
 *  设置基本
 */
- (void)setupBase {
    self.title = NSLocalizedString(@"user_feedback", nil);
    
    self.nameView.placeholder = NSLocalizedString(@"user_feedback_name_hint", nil);
    self.subNameView.text = NSLocalizedString(@"user_feedback_spec_hint", nil);
    [self.submitButton setTitle:NSLocalizedString(@"user_feedback_submit", nil) forState:UIControlStateNormal];
    [self.submitButton setBackgroundImage:[UIImage resizedImageWithName:@"feedback_submit_button"] forState:UIControlStateNormal];
    [self.submitButton setBackgroundImage:[UIImage resizedImageWithName:@"feedback_submit_press"] forState:UIControlStateHighlighted];
}

// 添加输入控件
- (void)setupTextView {
    IWTextView *textView = [[IWTextView alloc] init];
    textView.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
    textView.delegate = self;
    textView.frame = self.contentView.frame;
    textView.placeholder = NSLocalizedString(@"user_feedback_content_hint", nil);
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismissKeyBoard];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)resignAllFirstResponder {
    [self.textView resignFirstResponder];
    [self.nameView resignFirstResponder];
}

- (void)dismissKeyBoard {
    [self resignAllFirstResponder];
}


- (IBAction)buttonAdd:(id)sender {
    if (self.path != nil) {
        // 跳到新页面
        IWPictureDetailViewController *picVc = [[IWPictureDetailViewController alloc] init];
        picVc.delegate = self;
        picVc.path = self.path;
        [self.navigationController pushViewController:picVc animated:YES];
    } else {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:NSLocalizedString(@"take_picture_cancel", nil) otherButtonTitles:NSLocalizedString(@"choose_picture", nil), nil];
        sheet.tag = 255;
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}

- (IBAction)submit:(id)sender {
    [self dismissKeyBoard];
    NSString *content = self.textView.text;
    NSString *contact = self.nameView.text;
    
    // 判断内容
    if ([self checkValideWithName:content error:@"user_feedback_submit_content_null"]) return;
    
    // 判断姓名
    if ([self checkValideWithName:contact error:@"user_feedback_submit_name_null"]) return;
    
    // 检测姓名是否合法QQ/电话/邮箱
    NSString *regexQQ = @"^[1-9][0-9]{4,9}$";
    NSString *regexPhone = @"^(13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$";
    NSString *regexMail = @"^\\s*\\w+(?:\\.{0,1}[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$";
    NSPredicate *predQQ = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexQQ];
    NSPredicate *predPhone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPhone];
    NSPredicate *predMail = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexMail];
    if (![predQQ evaluateWithObject:contact] && ![predPhone evaluateWithObject:contact] && ![predMail evaluateWithObject:contact]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"user_feedback_name_error", nil)];
        return;
    }
    
    // 提交
    [self sendFeedbackWithPath:self.path content:content contact:contact];
}

/**
 *  上传文件
 *
 *  @param path    图片路径
 *  @param title   标题
 *  @param keys    关键字
 *  @param content 内容
 */
- (void)sendFeedbackWithPath:(NSString *)path content:(NSString *)content contact:(NSString *)contact {
    IWUserFeedbackParam *param = [[IWUserFeedbackParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.content = [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    param.contact = [contact stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (path == nil || [path isEqualToString:@""]) {
        [IWMeTool userFeedbackSubmitWithParam:param success:^(IWUserFeedbackResult *result) {
            if (result.code == 0) {
                [MBProgressHUD showSuccess:NSLocalizedString(@"send_success", nil)];
                
                // 跳转到公司主页
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [MBProgressHUD showSuccess:result.info];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showError:NSLocalizedString(@"send_fail", nil)];
        }];
    } else {
        // 封装文件参数
        [IWMeTool userFeedbackSubmitWithParam:param path:self.path success:^(IWBaseResult *result) {
            if (result.code == 0) {
                [MBProgressHUD showSuccess:NSLocalizedString(@"send_success", nil)];
                
                // 跳转到公司主页
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [MBProgressHUD showSuccess:result.info];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showError:NSLocalizedString(@"send_fail", nil)];
        }];
    }
}

/**
 *  检查输入字符的合法性
 *
 *  @param name  输入字符
 *  @param error 错误显示
 *
 *  @return true：非法
 */
- (BOOL)checkValideWithName:(NSString *)name error:(NSString *)error{
    if (name == nil || [name isEqualToString:@""]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(error, nil)];
        return YES;
    }
    return NO;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        if (buttonIndex == 0) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.image = image;
    
    [self saveImage:image withName:@"currentImage.png"];
    [self.addButton setImage:image forState:UIControlStateNormal];
    self.addButton.tag = 100;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName {
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    self.path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:_path atomically:NO];
}

- (void)deleteImageWithController:(IWPictureDetailViewController *)vc {
    self.path = nil;
    [self.addButton setImage:[UIImage imageWithName:@"feedback_add_button"] forState:UIControlStateNormal];
}
@end
