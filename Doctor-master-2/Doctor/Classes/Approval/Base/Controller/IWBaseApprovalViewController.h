//
//  IWBaseApprovalViewController.h
//  Conedot
//
//  Created by 范超 on 15/10/17.
//  Copyright © 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWPhoto.h"
#import "IWPhotosView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "IWToast.h"
#import "MBProgressHUD+MJ.h"
#import "IWFanCompany.h"

@class IWPhotosView;

#define IWApprovalAddMargin 10

@interface IWBaseApprovalViewController : UIViewController

@property (nonatomic, weak) TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, weak) UIButton *addFile;
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, weak) UIView *bottom;
@property (nonatomic, weak) UIButton *currentView;
@property (nonatomic, weak) UIButton *textFieldReview;
@property (nonatomic, weak) UIButton *textFieldCopy;

@property (nonatomic, strong) IWPhotosView *photosView;
@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, strong) IWFanCompany *company;

@property (nonatomic, copy) NSString *reviewUserId;
@property (nonatomic, copy) NSMutableArray *ccopyUserName;
@property (nonatomic, copy) NSMutableArray *ccopyUserId;

- (void)addImage;
- (void)resizeSize;
- (BOOL)checkValideWithName:(NSString *)name error:(NSString *)error;
- (BOOL)validatePhone:(NSString *)phone;
- (BOOL)checkMustName:(NSString *)name error:(NSString *)error;
- (void)loadDepartmentData:(IWFanCompany *)company;
- (UIDatePicker *)setupDatePicker;
@end
