//
//  IWShengYuTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/26.
//
//

#import "IWShengYuTableViewCell.h"

@interface IWShengYuTableViewCell()

@property (nonatomic, weak) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, weak) UITextField *inputDate;
@end

@implementation IWShengYuTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWShengYuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell sexLabel];
    [cell manButton];
    [cell womenButton];
    [cell timeLabel];
    [cell resultButton];
    [cell firstButton];
    [cell secondButton];
    [cell thirdButton];
    [cell arrowImageview];
    
    return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    [_sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.height.mas_equalTo(@(40));
        make.width.mas_equalTo(@(50));
    }];
    
    [_manButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.sexLabel.mas_right).offset(-10);
        make.height.mas_equalTo(@(40));
        make.width.mas_equalTo(@(80));
    }];
    [_womenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.manButton.mas_right).offset(10);
        make.height.mas_equalTo(@(40));
        make.width.mas_equalTo(@(80));

    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexLabel.mas_bottom);
        make.left.equalTo(self.sexLabel.mas_left);
        make.height.mas_equalTo(@(40));
        make.width.mas_equalTo(@(70));
    }];
    [_resultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).offset(10);
        make.height.mas_equalTo(@(30));
        make.right.equalTo(self.contentView.mas_right).offset(-25);
        make.centerY.equalTo(self.timeLabel.mas_centerY);
    }];
    [_firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom);
        make.left.equalTo(self.timeLabel.mas_left);
        make.height.mas_equalTo(@(40));
        make.width.mas_equalTo(@(80));
    }];
    [_secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom);
        make.left.equalTo(self.firstButton.mas_right).offset(10);
        make.height.mas_equalTo(@(40));
        make.width.mas_equalTo(@(100));
    }];
    [_thirdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom);
        make.left.equalTo(self.secondButton.mas_right).offset(10);
        make.width.mas_equalTo(@(80));
        make.height.mas_equalTo(@(40));

    }];
    
    [_arrowImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.resultButton.mas_centerY);
        make.right.equalTo(self.resultButton.mas_right).offset(-5);
        make.width.mas_equalTo(@(12));
        make.height.mas_equalTo(@(12));
    }];

    [super updateConstraints];
    
    [self setupTimeView];
}
#pragma mark - 懒加载视图

-(UILabel *)sexLabel{
    if (_sexLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        label.font = IWFont;
        label.text = @"性别";
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _sexLabel = label;
    }
    return _sexLabel;
}

-(UILabel *)timeLabel{
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        label.font = IWFont;
        label.text = @"出生年月";
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _timeLabel = label;
    }
    return _timeLabel;
}

-(UIButton *)manButton{
    if (_manButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        button.tag=1001;
        [button addTarget:self action:@selector(personbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"男" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"choose_btn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"choose_btn_highlighted"] forState:UIControlStateSelected];
        button.titleLabel.font = IWFont;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [self.contentView addSubview:button];
        _manButton=button;
    }
    return _manButton;
}

-(UIButton *)womenButton{
    if (_womenButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        button.tag=1002;
        [button addTarget:self action:@selector(personbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"女" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"choose_btn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"choose_btn_highlighted"] forState:UIControlStateSelected];
        button.titleLabel.font = IWFont;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        [self.contentView addSubview:button];
        _womenButton=button;
    }
    return _womenButton;
}
-(UIButton *)firstButton{
    if (_firstButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        button.tag=2001;
        [button addTarget:self action:@selector(typebuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"顺产" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"choose_btn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"choose_btn_highlighted"] forState:UIControlStateSelected];
        button.titleLabel.font = IWFont;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        [self.contentView addSubview:button];
        _firstButton=button;
    }
    return _firstButton;
}
-(UIButton *)secondButton{
    if (_secondButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        button.tag=2002;
        [button addTarget:self action:@selector(typebuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"剖腹产" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"choose_btn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"choose_btn_highlighted"] forState:UIControlStateSelected];
        button.titleLabel.font = IWFont;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        [self.contentView addSubview:button];
        _secondButton=button;    }
    return _secondButton;
}
-(UIButton *)thirdButton{
    if (_thirdButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        button.tag=2003;
        [button addTarget:self action:@selector(typebuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"难产" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"choose_btn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"choose_btn_highlighted"] forState:UIControlStateSelected];
        button.titleLabel.font = IWFont;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        [self.contentView addSubview:button];
        _thirdButton=button;    }
    return _thirdButton;
}
-(UIButton *)resultButton{
    if (_resultButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor whiteColor];
        button.tag=1;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = IWFont;
        button.layer.cornerRadius = 2;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        [button addTarget:self action:@selector(resultbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"" forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        _resultButton=button;
    }
    return _resultButton;
}


- (UIImageView *)arrowImageview{
    if (_arrowImageview == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"common_icon_arrow"];
        [self.contentView addSubview:imageView];
        _arrowImageview = imageView;
    }
    return _arrowImageview;
}

//点击事件
- (void)personbuttonClicked:(UIButton *)btn
{
    if (!btn.isSelected) {
        self.personSelectedbtn.selected = !self.personSelectedbtn.selected;
        btn.selected = !btn.selected;
        self.personSelectedbtn = btn;
    }
//    if (btn.tag == 1001) {
//    }else{
//        
//    }

    
    if (_personBlock) {
        _personBlock(self.index,btn.tag);
    }

    
}

- (void)typebuttonClicked:(UIButton *)btn
{
    if (!btn.isSelected) {
        self.typeSelectedBtn.selected = !self.typeSelectedBtn.selected;
        btn.selected = !btn.selected;
        self.typeSelectedBtn = btn;
    }


//    if (btn.tag == 2001) {
//        
//    }else if (btn.tag == 2002){
//        
//    }else{
//        
//    }
    
    if (_typeBlock) {
        _typeBlock(self.index,btn.tag);
    }
    
}

- (void)resultbuttonClicked:(UIButton *)btn{
    if (_resultButtonBlock) {
        _resultButtonBlock(self.index);
    }
}

- (void)setupTimeView {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.formatter = formatter;
    
    UIDatePicker *datePicker = [self setupDatePicker];
    datePicker.datePickerMode = UIDatePickerModeDate;
    UIToolbar *beginToolbar = [self toolBar:@selector(showSelectDate)];
    [self.inputDate setInputView:datePicker];
    [self.inputDate setInputAccessoryView:beginToolbar];
    self.datePicker = datePicker;
}

- (UIToolbar *)toolBar:(SEL)selector {
    UIToolbar *toolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    toolbar.barTintColor = [UIColor lightGrayColor];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStyleDone target:self action:selector];
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    
    return toolbar;
}

- (void)showSelectDate {
    self.inputDate.text = [self.formatter stringFromDate:self.datePicker.date];
    [self.inputDate resignFirstResponder];
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
#pragma mark -数据处理
- (void)setShengyuModel:(IWShengYu *)shengyuModel{
    _shengyuModel = shengyuModel;
    
    if ([shengyuModel.childGender isEqualToString:@"男"]) {
        self.manButton.selected = YES;
        self.personSelectedbtn = self.manButton;
    }
    if ([shengyuModel.childGender isEqualToString:@"女"]) {
        self.womenButton.selected = YES;
        self.personSelectedbtn = self.womenButton;
    }
    
    [self.resultButton setTitle:shengyuModel.birthday forState:UIControlStateNormal];
    
    if ([shengyuModel.birthType isEqualToString:@"顺产"]) {
        self.firstButton.selected = YES;
        self.typeSelectedBtn = self.firstButton;
    }
    
    if ([shengyuModel.birthType isEqualToString:@"剖腹产"]) {
        self.secondButton.selected = YES;
        self.typeSelectedBtn = self.secondButton;
    }
    
    if ([shengyuModel.birthType isEqualToString:@"难产"]) {
        self.thirdButton.selected = YES;
        self.typeSelectedBtn = self.thirdButton;

    }
    
}



@end
