//
//  IWInquiryDetailViewCell.m
//  Doctor
//
//  Created by 范超 on 2017/1/8.
//
//

#import "IWInquiryDetailViewCell.h"
#import "SDWeiXinPhotoContainerView.h"
#import "UIView+SDAutoLayout.h"
#import "IWGetInquiryDetail.h"
#import "IWMedicalReport.h"

@interface IWInquiryDetailViewCell()
@property (nonatomic, weak) UILabel *labelTitle;
@property (nonatomic, weak) UILabel *labelTime;
@property (nonatomic, weak) UILabel *labelOverview;
@property (nonatomic, weak) UIView *viewReport;
@property (nonatomic, weak) UIView *viewReply;
@property (nonatomic, weak) UILabel *labelsuggest;
@property (nonatomic, weak) UILabel *labelsuggestCheck;
@property (nonatomic, weak) UILabel *replyLabelTime;



@end

@implementation IWInquiryDetailViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        
        self.backgroundColor = IWTableViewBgColor;
    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"detail";
    IWInquiryDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWInquiryDetailViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setup {
    // 标题
    UILabel *labelTitle = [[UILabel alloc] init];
    labelTitle.font = [UIFont boldSystemFontOfSize:13];
    labelTitle.textColor = [UIColor blackColor];
    self.labelTitle = labelTitle;
    
    // 时间
    UILabel *labelTime = [[UILabel alloc] init];
    labelTime.font = [UIFont systemFontOfSize:12];
    labelTime.textColor = IWGlobalColor;
    labelTime.textAlignment = NSTextAlignmentRight;
    self.labelTime = labelTime;
    
    // remark
    UILabel *labelOverview = [[UILabel alloc] init];
    labelOverview.font = [UIFont systemFontOfSize:12];
    labelOverview.numberOfLines = 0;
    labelOverview.textColor = [UIColor grayColor];
    self.labelOverview = labelOverview;
    
    // 报告
    UIView *viewReport = [[UIView alloc] init];
    viewReport.backgroundColor = [UIColor clearColor];
    viewReport.hidden = YES;
    self.viewReport = viewReport;
    
    //回复 reply
    UIView *viewReply = [[UIView alloc] init];
    viewReport.backgroundColor = [UIColor cyanColor];
    viewReport.hidden = YES;
    self.viewReply = viewReply;
    
    
    NSArray *views = @[self.labelTitle, self.labelTime, self.labelOverview, self.viewReport,self.viewReply];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 8;
    
    self.labelTitle.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(100)
    .heightIs(18);
    
    self.labelTime.sd_layout
    .rightSpaceToView(contentView, margin)
    .topEqualToView(self.labelTitle)
    .widthIs(100)
    .heightIs(18);
    
    self.labelOverview.sd_layout
    .leftEqualToView(self.labelTitle)
    .topSpaceToView(self.labelTitle, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    self.viewReport.sd_layout
    .topSpaceToView(self.labelOverview, 5)
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .heightIs(40);
    
    
    self.viewReply.sd_layout
    .topSpaceToView(self.viewReport, 5)
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .autoHeightRatio(0);
}

- (void)setupReportView:(IWMedicalReport *)report view:(UIView *)view {
    // line
    UIView *divider = [[UIView alloc] init];
    divider.alpha = 0.3;
    divider.backgroundColor = [UIColor lightGrayColor];
    divider.frame = CGRectMake(0, 0, view.width, 0.5);
    [view addSubview:divider];
    
    // text
    UILabel *label0 = [[UILabel alloc] init];
    label0.font = [UIFont systemFontOfSize:12];
    label0.textColor = [UIColor darkGrayColor];
    label0.text = NSLocalizedString(@"inquiry_doctor_detail_tip", nil);
    label0.x = 8;
    label0.y = 0;
    label0.height = view.height;
    label0.width = 100;
    [view addSubview:label0];
    
    // arrow
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.width = 12;
    arrowImage.height = view.height;
    arrowImage.y = 0;
    arrowImage.x = view.width - 8 - arrowImage.width;
    arrowImage.contentMode = UIViewContentModeCenter;
    arrowImage.image = [UIImage imageWithName:@"common_icon_arrow"];
    [view addSubview:arrowImage];
    
    // text
    UIButton *label = [[UIButton alloc] init];
    label.tag = view.tag;
    label.titleLabel.font = [UIFont systemFontOfSize:11];
    [label setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [label setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [label setTitle:[NSString stringWithFormat:@"%@ %@", report.reportDate, report.reportType] forState:UIControlStateNormal];
    label.x = 8;
    label.y = 0;
    label.height = view.height;
    label.width = CGRectGetMinX(arrowImage.frame) - 8;
    [label addTarget:self action:@selector(loadDoctorDetail:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:label];
}

- (void)setupReplyVIewWithview:(UIView *)view{
    // line
    UIView *divider = [[UIView alloc] init];
    divider.alpha = 0.3;
    divider.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:divider];

    // text 回复
    UILabel *label0 = [[UILabel alloc] init];
    label0.font = [UIFont systemFontOfSize:12];
    label0.textColor = [UIColor darkGrayColor];
    label0.text = @"回复：";
    [view addSubview:label0];
    
    //时间
    UILabel *labelTime = [[UILabel alloc] init];
    labelTime.font = [UIFont systemFontOfSize:12];
    labelTime.textColor = IWGlobalColor;
    labelTime.textAlignment = NSTextAlignmentRight;
    [view addSubview:labelTime];
    self.replyLabelTime = labelTime;

    
    //suggest
    UILabel *labelsuggest = [[UILabel alloc] init];
    labelsuggest.font = [UIFont systemFontOfSize:12];
    labelsuggest.textColor = [UIColor grayColor];
    [view addSubview:labelsuggest];
    self.labelsuggest = labelsuggest;

    
    //suggestCheck
    UILabel *labelsuggestCheck = [[UILabel alloc] init];
    labelsuggestCheck.font = [UIFont systemFontOfSize:12];
    labelsuggestCheck.textColor = [UIColor orangeColor];
    [view addSubview:labelsuggestCheck];
    self.labelsuggestCheck = labelsuggestCheck;

    
    //对医生评价
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button setTitleColor:IWGlobalColor forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [button setTitle:NSLocalizedString(@"inquiry_doctor_title", nil) forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.borderColor = IWGlobalColor.CGColor;
    button.layer.borderWidth = 0.5;
    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(evaluateDoctorButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    CGFloat margin = 8;

//    divider.frame = CGRectMake(0, 0, view.width, 0.5);
    divider.sd_layout
    .topSpaceToView(view,0)
    .leftEqualToView(view)
    .rightEqualToView(view)
    .heightIs(0.5);
    
    label0.sd_layout
    .topSpaceToView(divider,5)
    .leftSpaceToView(view,margin)
    .widthIs(100)
    .heightIs(18);
    
    labelTime.sd_layout
    .topEqualToView(label0)
    .rightSpaceToView(view,margin)
    .bottomEqualToView(view)
    .widthIs(100);
    
    labelsuggest.sd_layout
    .topSpaceToView(label0,margin)
    .leftSpaceToView(view,margin)
    .rightSpaceToView(view,margin)
    .autoHeightRatio(0);
    
    labelsuggestCheck.sd_layout
    .topSpaceToView(labelsuggestCheck,margin)
    .leftEqualToView(labelsuggest)
    .rightEqualToView(labelsuggest)
    .autoHeightRatio(0);
    
    button.sd_layout
    .topSpaceToView(labelsuggestCheck,margin)
    .leftEqualToView(label0)
    .widthIs(50)
    .heightIs(18);
}


- (void)loadDoctorDetail:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(didClickLoadButton:)]) {
        IWMedicalReport *report = self.detail.reportList[button.tag];
        [self.delegate didClickLoadButton:report];
    }
}

- (void)evaluateDoctorButtonClick:(UIButton *)btn{
    
    if (_evaluateDoctorButtonBlock) {
        _evaluateDoctorButtonBlock();
    }
    
    
}

- (void)setDetail:(IWGetInquiryDetail *)detail {
    _detail = detail;
    
    self.labelTitle.text = [NSString stringWithFormat:@"%@ %@ %@", detail.name, detail.gender,detail.age];
    self.labelTime.text = detail.insertTime;
    self.labelOverview.text = detail.remark;
    
    self.replyLabelTime.text = detail.replyTime;
    self.labelsuggest.text = detail.suggest;
    self.labelsuggestCheck.text = detail.suggestCheck;
    
    UIView *bottomView = self.labelOverview;
   
    if (detail.reportList != nil) {
        self.viewReport.hidden = NO;
        
        // 设置列表
        int i = 0;
        int height = 26;
        for (IWMedicalReport *report in detail.reportList) {
            UIView *view = [[UIView alloc] init];
            view.tag = i;
            view.height = height;
            view.x = 0;
            view.y = i * view.height;
            view.width = kWidth;
            view.backgroundColor = [UIColor whiteColor];
            [self setupReportView:report view:view];
            i++;
            [self.viewReport addSubview:view];
        }
        self.viewReport.sd_layout
        .heightIs(height * detail.reportList.count + 5);
        
//        bottomView = self.viewReport;
    } else {
        self.viewReport.hidden = YES;
    }
    
    
    
    if (detail.suggest.length == 0) {
        self.viewReply.hidden = YES;
    }else{
        self.viewReply.hidden = NO;
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        [self.viewReply addSubview:view];

        [self setupReplyVIewWithview:view];

        view.sd_layout
        .topSpaceToView(self.viewReport,0)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .autoHeightRatio(0);
        
        
        self.viewReply.sd_layout
        .heightIs(view.height);
        

    }
    
    if (detail.reportList == nil) {
        if (detail.suggest.length == 0) {
            bottomView = self.labelOverview;
            
        }else{
            bottomView = self.viewReply;
        }
    }else{
        if (detail.suggest.length == 0) {
            bottomView = self.viewReport;
        }else{
            bottomView = self.viewReply;
        }
    }
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:-10];
}

@end
