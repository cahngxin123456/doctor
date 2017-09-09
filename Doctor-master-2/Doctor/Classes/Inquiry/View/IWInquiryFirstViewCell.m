//
//  IWInquiryFirstViewCell.m
//  Doctor
//
//  Created by 雷王 on 17/1/9.
//
//

#import "IWInquiryFirstViewCell.h"
#import "SDWeiXinPhotoContainerView.h"
#import "UIView+SDAutoLayout.h"
#import "IWInquiry.h"

@interface IWInquiryFirstViewCell()
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UILabel *labelOverview;
@property (nonatomic, strong) UIView *viewReply;
@property (nonatomic, strong) UILabel *labelSuggest;
@property (nonatomic, strong) UILabel *labelSuggestCheck;
@property (nonatomic, strong) SDWeiXinPhotoContainerView *picContainerView;
@property (nonatomic, strong) UIView *divider;

@end

@implementation IWInquiryFirstViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self setup];
//        
//        self.backgroundColor = [UIColor whiteColor];
//    }
//    return self;
//}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWInquiryFirstViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setup];
    
    return cell;
}

- (void)setup {
    // 标题
    if (!self.labelTitle) {
        self.labelTitle = [[UILabel alloc] init];

    }
    self.labelTitle.font = [UIFont boldSystemFontOfSize:13];
    self.labelTitle.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.labelTitle];

    // 时间
    if (!self.labelTime) {
        self.labelTime = [[UILabel alloc] init];
        
    }
    self.labelTime.font = [UIFont systemFontOfSize:12];
    self.labelTime.textColor = [UIColor blueColor];
    self.labelTime.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.labelTime];

    // 医院
    if (!self.labelOverview) {
        self.labelOverview = [[UILabel alloc] init];
        
    }
    self.labelOverview.font = [UIFont systemFontOfSize:12];
    self.labelOverview.numberOfLines = 0;
    self.labelOverview.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.labelOverview];

    // 图片
    if (!self.picContainerView) {
        self.picContainerView = [[SDWeiXinPhotoContainerView alloc] init];
        
    }
    [self.contentView addSubview:self.picContainerView];


        // 回复
    if (!self.viewReply) {
        self.viewReply = [[UIView alloc] init];
        
    }
    self.viewReply.backgroundColor = IWColor(237, 231, 233);
    self.viewReply.hidden = YES;
    [self.contentView addSubview:self.viewReply];

    // 回复标题
    if (!self.labelSuggest) {
        self.labelSuggest = [[UILabel alloc] init];
        
    }
    self.labelSuggest.font = [UIFont systemFontOfSize:12];
    self.labelSuggest.numberOfLines = 0;
    self.labelSuggest.textColor = [UIColor grayColor];
    [self.viewReply addSubview:self.labelSuggest];
    
    // 回复内容
    if (!self.labelSuggestCheck) {
        self.labelSuggestCheck = [[UILabel alloc] init];
        
    }
    self.labelSuggestCheck.font = [UIFont systemFontOfSize:13];
    self.labelSuggestCheck.numberOfLines = 0;
    self.labelSuggestCheck.textColor = [UIColor orangeColor];
    [self.viewReply addSubview:self.labelSuggestCheck];
    
   

    
    // line
    if (!self.divider) {
        self.divider = [[UIView alloc] init];
        
    }
    self.divider.backgroundColor = [UIColor lightGrayColor];
    self.divider.alpha = 0.2;
    [self.contentView addSubview:self.divider];
    
    
//    NSArray *views = @[self.labelTitle, self.labelTime, self.labelOverview, self.picContainerView, self.viewReply, self.divider];
//    [self.contentView sd_addSubviews:views];
    
//    UIView *contentView = self.contentView;
//    CGFloat margin = 8;
//    
//    self.labelTitle.sd_layout
//    .leftSpaceToView(contentView, margin)
//    .topSpaceToView(contentView, margin + 5)
//    .widthIs(100)
//    .heightIs(18);
//    
//    self.labelTime.sd_layout
//    .rightSpaceToView(contentView, margin)
//    .topEqualToView(self.labelTitle)
//    .widthIs(100)
//    .heightIs(18);
//    
//    self.labelOverview.sd_layout
//    .leftEqualToView(self.labelTitle)
//    .topSpaceToView(self.labelTitle, margin)
//    .rightSpaceToView(contentView, margin)
//    .autoHeightRatio(0);
//    
//    self.picContainerView.sd_layout
//    .leftEqualToView(self.labelTitle);
//    
//    self.viewReply.sd_layout
//    .topSpaceToView(self.picContainerView, 5)
//    .leftSpaceToView(contentView, 0)
//    .rightSpaceToView(contentView, 0)
//    .heightIs(50);
//    
//    self.labelSuggest.sd_layout
//    .leftSpaceToView(self.viewReply, margin)
//    .rightSpaceToView(self.viewReply, margin)
//    .topSpaceToView(self.viewReply, margin)
//    .autoHeightRatio(0);
//    
//    self.labelSuggestCheck.sd_layout
//    .leftSpaceToView(self.viewReply, margin)
//    .rightSpaceToView(self.viewReply, margin)
//    .topSpaceToView(self.labelSuggest, margin * 0.5)
//    .autoHeightRatio(0);
//    
//    self.divider.sd_layout
//    .leftEqualToView(self.labelTitle)
//    .rightEqualToView(contentView)
//    .heightIs(0.5);
}

- (void)setInqurity:(IWInquiry *)inqurity{
    if (inqurity != nil) {
        _inqurity = inqurity;
        
        self.labelTitle.text = [NSString stringWithFormat:@"%@ %@ %@", inqurity.name, inqurity.gender,inqurity.age];
        CGRect boundslabelTitle = [self.labelTitle.text getTextWidthAndHeightWithFont:self.labelTitle.font.pointSize withWidth:999999];
        self.labelTitle.frame = CGRectMake(5, 0, boundslabelTitle.size.width+20, boundslabelTitle.size.height);
        
        self.labelTime.text = inqurity.insertTime;
        CGRect boundslabelTime = [self.labelTime.text getTextWidthAndHeightWithFont:self.labelTime.font.pointSize withWidth:999999];
        self.labelTime.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-boundslabelTime.size.width-20, self.labelTitle.frame.origin.y, boundslabelTime.size.width+10, boundslabelTime.size.height);

        
        
        self.labelOverview.text = inqurity.overview;
        //设置行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.labelOverview.text == nil ? @"" : self.labelOverview.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4.0f];//调整行间距
        NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:self.labelOverview.font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil];
        [attributedString addAttributes:attributes range:NSMakeRange(0, [attributedString length])];
        self.labelOverview.attributedText = attributedString;
        self.labelOverview.numberOfLines = 0;
                      CGRect tmpRect = [self.labelOverview.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-self.labelTitle.frame.origin.x*2, 2000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.labelOverview.font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil] context:nil];
                self.labelOverview.frame = CGRectMake(self.labelTitle.frame.origin.x, CGRectGetMaxY(self.labelTitle.frame)+6, tmpRect.size.width, tmpRect.size.height);
        
        
        
        self.picContainerView.picPathStringsArray = inqurity.pictures;
        CGFloat picW = 0;
        CGFloat picH = 0;
      
        if (inqurity.pictures !=nil && [inqurity.pictures isKindOfClass:[NSArray class]] && inqurity.pictures.count == 1) {
            NSString *strUrl = [inqurity.pictures objectAtIndex:0];
            if (strUrl != nil && strUrl.length>0) {
                picW = 100;
                picH = 100;
            }
          
        }
        else if (inqurity.pictures!=nil && [inqurity.pictures isKindOfClass:[NSArray class]] && inqurity.pictures.count > 1)
        
        {
            CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
            picW = w*3;
            if (inqurity.pictures.count<=3) {
                picH =w;

            }
            else if (inqurity.pictures.count>3 && inqurity.pictures.count<=6)
            {
                picH =2*w;

            }
            else if (inqurity.pictures.count>6 && inqurity.pictures.count<=9)
            {
                picH =3*w;
                
            }

        }

        self.picContainerView.frame = CGRectMake(self.labelTitle.frame.origin.x, CGRectGetMaxY(self.labelOverview.frame)+8, picW, picH);
        
        if (inqurity.suggest != nil && self.statusType == 1) {
            self.viewReply.hidden = NO;

            self.labelSuggest.text = inqurity.suggest;
            //设置行间距
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.labelSuggest.text == nil ? @"" : self.labelSuggest.text];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:4.0f];//调整行间距
            NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:self.labelSuggest.font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil];
            [attributedString addAttributes:attributes range:NSMakeRange(0, [attributedString length])];
            self.labelSuggest.attributedText = attributedString;
            self.labelSuggest.numberOfLines = 0;
            CGRect tmpRect = [self.labelSuggest.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-self.labelTitle.frame.origin.x*2, 2000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.labelSuggest.font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil] context:nil];
            if (self.labelSuggest.text.length>0) {
                self.labelSuggest.frame = CGRectMake(self.labelTitle.frame.origin.x,6, tmpRect.size.width, tmpRect.size.height);

            }
            else{
                self.labelSuggest.frame = CGRectMake(self.labelTitle.frame.origin.x,0, 0, 0);
  
            }
            
            self.labelSuggestCheck.text = inqurity.suggestCheck;
            //设置行间距
            NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:self.labelSuggestCheck.text == nil ? @"" : self.labelSuggestCheck.text];
            NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle2 setLineSpacing:4.0f];//调整行间距
            NSDictionary* attributes2 = [NSDictionary dictionaryWithObjectsAndKeys:self.labelSuggestCheck.font,NSFontAttributeName,paragraphStyle2,NSParagraphStyleAttributeName, nil];
            [attributedString2 addAttributes:attributes2 range:NSMakeRange(0, [attributedString2 length])];
            self.labelSuggestCheck.attributedText = attributedString2;
            self.labelSuggestCheck.numberOfLines = 0;
            CGRect tmpRect2 = [self.labelSuggestCheck.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-self.labelTitle.frame.origin.x*2, 2000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.labelSuggestCheck.font,NSFontAttributeName,paragraphStyle2,NSParagraphStyleAttributeName, nil] context:nil];
            self.labelSuggestCheck.frame = CGRectMake(self.labelTitle.frame.origin.x, CGRectGetMaxY(self.labelSuggest.frame)+6, tmpRect2.size.width, tmpRect2.size.height);
            
            if (self.labelSuggest.text.length>0) {
                self.labelSuggestCheck.frame = CGRectMake(self.labelTitle.frame.origin.x, CGRectGetMaxY(self.labelSuggest.frame)+6, tmpRect2.size.width, tmpRect2.size.height);
                
            }
            else{
                self.labelSuggestCheck.frame = CGRectMake(self.labelTitle.frame.origin.x, 0, 0, 0);
                
            }

            self.viewReply.frame = CGRectMake(0, CGRectGetMaxY(self.picContainerView.frame)+6,[UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(self.labelSuggestCheck.frame)+5);
            self.divider.frame = CGRectMake(0, CGRectGetMaxY(self.viewReply.frame), [UIScreen mainScreen].bounds.size.width, 1);

        }
        else{
            self.viewReply.hidden = YES;

        self.divider.frame = CGRectMake(0, CGRectGetMaxY(self.labelOverview.frame)+picH+25, [UIScreen mainScreen].bounds.size.width, 1);
            self.divider.frame = CGRectMake(0, CGRectGetMaxY(self.picContainerView.frame)+25, [UIScreen mainScreen].bounds.size.width, 1);

        }
        self.cellHeight = CGRectGetMaxY(self.divider.frame)+5;
        
    }
}


@end
