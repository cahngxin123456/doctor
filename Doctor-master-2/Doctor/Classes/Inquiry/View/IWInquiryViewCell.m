//
//  IWInquiryViewCell.m
//  Doctor
//
//  Created by 范超 on 2017/1/7.
//
//

#import "IWInquiryViewCell.h"
#import "SDWeiXinPhotoContainerView.h"
#import "UIView+SDAutoLayout.h"
#import "IWInquiry.h"

@interface IWInquiryViewCell()
@property (nonatomic, weak) UILabel *labelTitle;
@property (nonatomic, weak) UILabel *labelTime;
@property (nonatomic, weak) UILabel *labelOverview;
@property (nonatomic, weak) UIView *viewReply;
@property (nonatomic, weak) UILabel *labelSuggest;
@property (nonatomic, weak) UILabel *labelSuggestCheck;
@property (nonatomic, weak) SDWeiXinPhotoContainerView *picContainerView;
@property (nonatomic, weak) UIView *divider;

@end

@implementation IWInquiryViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"inquiry";
    IWInquiryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWInquiryViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
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
    labelTime.textColor = [UIColor blueColor];
    labelTime.textAlignment = NSTextAlignmentRight;
    self.labelTime = labelTime;
    
    // 医院
    UILabel *labelOverview = [[UILabel alloc] init];
    labelOverview.font = [UIFont systemFontOfSize:12];
    labelOverview.numberOfLines = 0;
    labelOverview.textColor = [UIColor grayColor];
    self.labelOverview = labelOverview;
    
    // 图片
    SDWeiXinPhotoContainerView *picContainerView = [[SDWeiXinPhotoContainerView alloc] init];
    self.picContainerView = picContainerView;
    
    // 回复
    UIView *viewReply = [[UIView alloc] init];
    viewReply.backgroundColor = IWColor(237, 231, 233);
    viewReply.hidden = YES;
    self.viewReply = viewReply;
    
    // 回复标题
    UILabel *labelSuggest = [[UILabel alloc] init];
    labelSuggest.font = [UIFont systemFontOfSize:12];
    labelSuggest.numberOfLines = 0;
    labelSuggest.textColor = [UIColor grayColor];
    self.labelSuggest = labelSuggest;
    [self.viewReply addSubview:labelSuggest];
    
    // 回复内容
    UILabel *labelSuggestCheck = [[UILabel alloc] init];
    labelSuggestCheck.font = [UIFont systemFontOfSize:13];
    labelSuggestCheck.numberOfLines = 0;
    labelSuggestCheck.textColor = [UIColor orangeColor];
    self.labelSuggestCheck = labelSuggestCheck;
    [self.viewReply addSubview:labelSuggestCheck];
    
    // line
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor lightGrayColor];
    divider.alpha = 0.2;
    self.divider = divider;
    
    NSArray *views = @[self.labelTitle, self.labelTime, self.labelOverview, self.picContainerView, self.viewReply, self.divider];
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
    
    self.picContainerView.sd_layout
    .leftEqualToView(self.labelTitle);
    
    self.viewReply.sd_layout
    .topSpaceToView(self.picContainerView, 5)
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .heightIs(50);
       
    self.labelSuggest.sd_layout
    .leftSpaceToView(self.viewReply, margin)
    .rightSpaceToView(self.viewReply, margin)
    .topSpaceToView(self.viewReply, margin)
    .autoHeightRatio(0);
    
    self.labelSuggestCheck.sd_layout
    .leftSpaceToView(self.viewReply, margin)
    .rightSpaceToView(self.viewReply, margin)
    .topSpaceToView(self.labelSuggest, margin * 0.5)
    .autoHeightRatio(0);
    
    self.divider.sd_layout
    .leftEqualToView(self.labelTitle)
    .rightEqualToView(contentView)
    .heightIs(0.5);
}

- (void)setInqurity:(IWInquiry *)inqurity{
    if (inqurity != nil) {
        _inqurity = inqurity;
        
        self.labelTitle.text = [NSString stringWithFormat:@"%@ %@ %@", inqurity.name, inqurity.gender,inqurity.age];
        self.labelTime.text = inqurity.insertTime;
        self.labelOverview.text = inqurity.overview;
        self.picContainerView.picPathStringsArray = inqurity.pictures;
        
        CGFloat picContainerTopMargin = 0;
        if (inqurity.pictures.count > 0) {
            picContainerTopMargin = 10;
        }
        
        self.picContainerView.sd_layout.topSpaceToView(self.labelOverview, picContainerTopMargin);
//        if (inqurity.pictures.count > 0) {
//            NSString *strurl = [inqurity.pictures objectAtIndex:0];
//            if (strurl.length>0) {
//                self.divider.sd_layout.topSpaceToView(self.picContainerView, 8);
//            }
//            else{
//                self.divider.sd_layout.topSpaceToView(self.labelOverview, 8);
//
//            }
//            
//        } else {
//            self.divider.sd_layout.topSpaceToView(self.labelOverview, 8);
//
//        }
        if (inqurity.pictures.count > 0) {
            NSString *strurl = [inqurity.pictures objectAtIndex:0];
            if (strurl.length>0) {
                self.viewReply.sd_layout.topSpaceToView(self.picContainerView, 8);
            }
            else{
                self.viewReply.sd_layout.topSpaceToView(self.labelOverview, 8);
                
            }
            
        } else {
            self.viewReply.sd_layout.topSpaceToView(self.labelOverview, 8);
            
        }


        if (inqurity.suggest != nil && self.statusType == 1) {
         

            self.viewReply.hidden = NO;
            self.labelSuggest.text = inqurity.suggest;
            self.labelSuggestCheck.text = inqurity.suggestCheck;
            
            

            self.divider.sd_layout.topSpaceToView(self.viewReply, 0);
        } else {
            
            self.viewReply.hidden = YES;
            self.labelSuggest.text = @"";
            self.labelSuggestCheck.text = @"";
//            if (inqurity.pictures.count > 0) {
//                NSString *strurl = [inqurity.pictures objectAtIndex:0];
//                if (strurl.length>0) {
//                    self.divider.sd_layout.topSpaceToView(self.picContainerView, 8);
//                }
//                else{
//                    self.divider.sd_layout.topSpaceToView(self.labelOverview, 8);
//                    
//                }
//                
//            } else {
//            }
                self.divider.sd_layout.topSpaceToView(self.viewReply, 8);
                
//            }


        }
        
         UIView *bottomView = self.divider;
        [self setupAutoHeightWithBottomView:bottomView bottomMargin:0];
        
    }
}


@end
