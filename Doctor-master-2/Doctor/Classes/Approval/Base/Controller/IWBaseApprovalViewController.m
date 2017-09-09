//
//  IWBaseApprovalViewController.m
//  Conedot
//
//  Created by 范超 on 15/10/17.
//  Copyright © 2015年 范超. All rights reserved.
//

#import "IWBaseApprovalViewController.h"
#import "UzysAssetsPickerController.h"
#import "IWContactTool.h"
#import "IWDepartmentPeopleViewController.h"
#import "IWDepartmentViewController.h"
#import "IWPeopleViewController.h"

@interface IWBaseApprovalViewController () <UzysAssetsPickerControllerDelegate>

@end

@implementation IWBaseApprovalViewController

- (NSMutableArray *)images {
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (NSMutableArray *)ccopyUserName {
    if (_ccopyUserName == nil) {
        _ccopyUserName = [NSMutableArray array];
    }
    return _ccopyUserName;
}

- (NSMutableArray *)ccopyUserId {
    if (_ccopyUserId == nil) {
        _ccopyUserId = [NSMutableArray array];
    }
    return _ccopyUserId;
}

- (void)viewDidLoad {
#ifdef __IPHONE_7_0
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:UserDefaultContactApprovalUserId];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:UserDefaultContactApprovalUserName];
    
    [self setupPhotoView];
    
    // 监听
    [self addNotice];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultContactApprovalUserId];
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultContactApprovalUserName];
    if (![@"" isEqualToString:userId] && ![@"" isEqualToString:userName]) {
        if (self.currentView == self.textFieldReview) {
            self.reviewUserId = userId;
            [self.textFieldReview setTitle:userName forState:UIControlStateNormal];
        } else {
            if ([self.ccopyUserId indexOfObject:userId] == NSNotFound) {
                [self.ccopyUserName addObject:userName];
                [self.textFieldCopy setTitle:[self.ccopyUserName componentsJoinedByString:@","] forState:UIControlStateNormal];
                [self.ccopyUserId addObject:userId];
            }
            
        }
    }
}

- (void)setBottom:(UIView *)bottom {
    _bottom = bottom;
    self.scrollView.contentSize = CGSizeMake(self.view.width, CGRectGetMaxY(self.bottom.frame));
    self.scrollView.showsVerticalScrollIndicator = NO;
}

- (void)setButton:(UIButton *)button {
    _button = button;
    [self.button setBackgroundImage:[UIImage resizedImageWithName:@"btn_green"] forState:UIControlStateNormal];
    [self.button setBackgroundImage:[UIImage resizedImageWithName:@"btn_green_highlighted"] forState:UIControlStateHighlighted];
}

- (void)setupPhotoView {
    // photosView
    IWPhotosView *photosView = [[IWPhotosView alloc] init];
    photosView.noClick = true;
    self.photosView = photosView;
}

- (UIDatePicker *)setupDatePicker {
    // Add the picker
    UIDatePicker *pickerView = [[UIDatePicker alloc] init];
    pickerView.datePickerMode = UIDatePickerModeDateAndTime;
    pickerView.date = [NSDate date]; // 设置初始时间
    pickerView.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"]; // 设置时区，中国在东八区
//    pickerView.minimumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60 * -1]; // 设置最小时间
//    pickerView.maximumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60]; // 设置最大时间
    
    return pickerView;
}

- (void)addNotice {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(deleteImage:) name:IWImagesDeleteNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addImage {
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    picker.maximumNumberOfSelectionVideo = 0;
    picker.maximumNumberOfSelectionPhoto = 6 - self.images.count;
    [self presentViewController:picker animated:YES completion:^{
    }];
}

- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    IWLog(@"assets %@",assets);
    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) {
        // Photo
        NSInteger count = assets.count;
        NSMutableArray *array = [NSMutableArray array];
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *representation = obj;
            IWPhoto *photo = [[IWPhoto alloc] init];
            photo.pic = representation.defaultRepresentation.url.absoluteString;
            photo.asset = representation;
            photo.showDelete = YES;
            [array addObject:photo];
            [self.images addObject:photo];
        }];
        
        [self setupImage];
    }
}

- (void)setupImage {
    NSInteger count = self.images.count;
    // 判断
    if (count == 1) {
        self.photosView.hidden = NO;
    } else if (count == 0) {
        self.photosView.hidden = YES;
    }
    
    self.photosView.pic_urls = self.images;
    
    CGFloat photosX = IWApprovalAddMargin;
    CGFloat photosY = CGRectGetMaxY(self.addFile.frame) + IWApprovalAddMargin;
    CGSize photosSize = [IWPhotosView sizeWithPhotosCount:_photosView.pic_urls.count];
    self.photosView.frame = (CGRect){{photosX, photosY}, photosSize};
    IWLog(@"%@", NSStringFromCGRect(self.photosView.frame));
    // 设置尺寸
    [self resizeSize];
}

- (void)resizeSize{
}

- (void)deleteImage:(NSNotification *)notification {
    NSString *url = notification.userInfo[IWImagesDeleteNotificationPic];
    IWLog(@"url:%@", url);
    [self.images removeAllObjects];
    
    // 设置数据
    [self setupImage];
}

- (BOOL)checkValideWithName:(NSString *)name error:(NSString *)error {
    if (name == nil || [name isEqualToString:@""]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(error, nil)];
        return YES;
    }
    return NO;
}

- (BOOL)validatePhone:(NSString *)phone {
    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

- (BOOL)checkMustName:(NSString *)name error:(NSString *)error {
    if ([name isKindOfClass:[NSNumber class]]) {
        name = [NSString stringWithFormat:@"%@", name];
    }
    if (name == nil || [name isEqualToString:NSLocalizedString(@"approval_qingjia_input_hint", nil)]) {
        if (error != nil) {
            [IWToast toastWithView:self.view title:NSLocalizedString(error, nil)];
        }
        return YES;
    }
    return NO;
}

/**
 *  加载部门数据
 */
- (void)loadDepartmentData:(IWFanCompany *)company {
    IWContactLevelParam *param = [[IWContactLevelParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(company.companyId);
    
}

@end
