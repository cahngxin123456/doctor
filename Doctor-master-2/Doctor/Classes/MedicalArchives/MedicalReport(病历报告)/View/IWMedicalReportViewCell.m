//
//  IWMedicalReportViewCell.m
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import "IWMedicalReportViewCell.h"
#import "SDWeiXinPhotoContainerView.h"
#import "UIView+SDAutoLayout.h"

@interface IWMedicalReportViewCell()

@property (nonatomic, weak) UILabel *labelTitle;
@property (nonatomic, weak) UILabel *labelHospital;
@property (nonatomic, weak) UILabel *labelDisease;
@property (nonatomic, weak) UILabel *labelOverview;
@property (nonatomic, weak) UIImageView *imageArrow;
@property (nonatomic, weak) UIButton *checkBox;
@property (nonatomic, weak) UIButton *buttonDelete;
@property (nonatomic, weak) SDWeiXinPhotoContainerView *picContainerView;
@property (nonatomic, weak) UIView *divider;


@end

@implementation IWMedicalReportViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"medicalReport";
    IWMedicalReportViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWMedicalReportViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setup {
    // 标题
    UILabel *labelTitle = [[UILabel alloc] init];
    labelTitle.font = [UIFont boldSystemFontOfSize:14];
    labelTitle.textColor = [UIColor blackColor];
    self.labelTitle = labelTitle;
    
    // 箭头
    UIImageView *imageArrow = [[UIImageView alloc] init];
    [imageArrow setImage:[UIImage imageNamed:@"common_icon_arrow"]];
    self.imageArrow = imageArrow;
    
    // checkbox
    UIButton *checkBox = [[UIButton alloc] init];
    [checkBox setImage:[UIImage imageWithName:@"xz_btn_normal"] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageWithName:@"xz_btn_press"] forState:UIControlStateSelected];
    [checkBox addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    checkBox.hidden = YES;
    self.checkBox = checkBox;
    
    // 医院
    UILabel *labelHospital = [[UILabel alloc] init];
    labelHospital.font = [UIFont systemFontOfSize:12];
    labelHospital.textColor = [UIColor lightGrayColor];
    self.labelHospital = labelHospital;
    
    // 疾病
    UILabel *labelDisease = [[UILabel alloc] init];
    labelDisease.font = [UIFont systemFontOfSize:14];
    labelDisease.textColor = IWGlobalColor;
    self.labelDisease = labelDisease;
    
    // 备注
    UILabel *labelOverview = [[UILabel alloc] init];
    labelOverview.font = [UIFont systemFontOfSize:12];
    labelOverview.textColor = [UIColor grayColor];
    self.labelOverview = labelOverview;
    
    // 图片
    SDWeiXinPhotoContainerView *picContainerView = [[SDWeiXinPhotoContainerView alloc] init];
    self.picContainerView = picContainerView;
    
    // 删除
    UIButton *buttonDelete = [[UIButton alloc] init];
    [buttonDelete setBackgroundImage:[UIImage resizedImageWithName:@"de_normal"] forState:UIControlStateNormal];
    [buttonDelete setBackgroundImage:[UIImage resizedImageWithName:@"de_press"] forState:UIControlStateHighlighted];
    [buttonDelete setTitle:NSLocalizedString(@"inquiry_family_delete", nil) forState:UIControlStateNormal];
    [buttonDelete setTitleColor:IWGlobalColor forState:UIControlStateNormal];
    buttonDelete.titleLabel.font = [UIFont systemFontOfSize:12];
    [buttonDelete addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    self.buttonDelete = buttonDelete;
    
    // line
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor lightGrayColor];
    divider.alpha = 0.2;
    self.divider = divider;
    
    NSArray *views = @[self.labelTitle, self.imageArrow, self.checkBox, self.labelHospital, self.labelDisease, self.labelOverview, self.picContainerView, self.buttonDelete, self.divider];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    self.labelTitle.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(200)
    .heightIs(18);
    
    self.imageArrow.sd_layout
    .rightSpaceToView(contentView, margin)
    .topEqualToView(self.labelTitle)
    .widthIs(12)
    .heightIs(12);
    
    self.checkBox.sd_layout
    .rightSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(15)
    .heightIs(15);
    
    self.labelHospital.sd_layout
    .leftEqualToView(self.labelTitle)
    .topSpaceToView(self.labelTitle, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    self.labelDisease.sd_layout
    .leftEqualToView(self.labelTitle)
    .topSpaceToView(self.labelHospital, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    self.labelOverview.sd_layout
    .leftEqualToView(self.labelTitle)
    .topSpaceToView(self.labelDisease, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    self.picContainerView.sd_layout
    .leftEqualToView(self.labelTitle);
    
    self.buttonDelete.sd_layout
    .rightSpaceToView(contentView, margin)
    .widthIs(70)
    .heightIs(24);
    
    self.divider.sd_layout
    .leftEqualToView(self.labelTitle)
    .rightEqualToView(self.buttonDelete)
    .heightIs(0.5);
}

- (void)delete {
    if ([self.delegate respondsToSelector:@selector(didClickDeleteButton:)]) {
        [self.delegate didClickDeleteButton:self.medicalReport];
    }
}

- (void)add {
    self.checkBox.selected = !self.checkBox.selected;
    self.medicalReport.isChecked = self.checkBox.selected;
}

- (void)setMedicalReport:(IWMedicalReport *)medicalReport {
    if (medicalReport != nil) {
        _medicalReport = medicalReport;
        
        if (self.isFromInquiry) {
            self.checkBox.hidden = NO;
            self.imageArrow.hidden = YES;
            [self.buttonDelete setTitle:NSLocalizedString(@"trainning_course_detail_title", nil) forState:UIControlStateNormal];
            medicalReport.isShowDetail = YES;
        } else {
            self.checkBox.hidden = YES;
            self.imageArrow.hidden = NO;
            [self.buttonDelete setTitle:NSLocalizedString(@"inquiry_family_delete", nil) forState:UIControlStateNormal];
            medicalReport.isShowDetail = NO;
        }
        
        
        self.checkBox.selected = medicalReport.isChecked;
        self.labelTitle.text = [NSString stringWithFormat:@"%@ %@", medicalReport.reportDate, medicalReport.reportType2show];
        self.labelHospital.text = medicalReport.hospital;
        self.labelDisease.text = medicalReport.disease;
        self.labelOverview.text = medicalReport.overview;
        self.picContainerView.picPathStringsArray = medicalReport.pictures;
        
        CGFloat picContainerTopMargin = 0;
        if (medicalReport.pictures.count > 0) {
            picContainerTopMargin = 10;
        }
        self.picContainerView.sd_layout.topSpaceToView(self.labelOverview, picContainerTopMargin);
        
        if (medicalReport.pictures.count > 0) {
            self.buttonDelete.sd_layout.topSpaceToView(self.picContainerView, 10);
        } else {
            self.buttonDelete.sd_layout.topSpaceToView(self.labelOverview, 0);
        }
        
        UIView *bottomView = self.buttonDelete;
        
        [self setupAutoHeightWithBottomView:bottomView bottomMargin:15];
    }
}


@end
