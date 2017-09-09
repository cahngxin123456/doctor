//
//  IWGuoMinTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import "IWGuoMinTableViewCell.h"

@implementation IWGuoMinTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWGuoMinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.backgroundColor=IWTableViewBgColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self addTageView];
    [self addTextField];
}

- (void)setSelectArray:(NSArray *)selectArray{
    _selectArray = selectArray;
    _tagView.clickArray = selectArray;

}

- (void)setOthername:(NSString *)othername{
    _othername = othername;
}

- (void)setGuominCellBlock:(void (^)(NSString *))guominCellBlock{
    _guominCellBlock = guominCellBlock;
}
- (void)addTageView
{
    IMJIETagFrame *frame = [[IMJIETagFrame alloc] init];
    frame.tagsMinPadding = 4;
    frame.tagsMargin = 10;
    frame.tagsLineSpacing = 10;
    frame.tagsArray = self.dataArray;
    self.height = frame.tagsHeight;
    
    IMJIETagView *tagView = [[IMJIETagView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, frame.tagsHeight)];
    tagView.clickbool = YES;
    tagView.backgroundColor = IWTableViewBgColor;
    tagView.borderSize = 0.5;
    tagView.clickborderSize = 0.5;
    tagView.tagsFrame = frame;
    tagView.clickStart = 1;//0-单选   1-多选
    //    tagView.clickString = @"华语";
//    tagView.clickArray = self.selectArray;
    tagView.delegate = self;
    [self.contentView addSubview:tagView];

    _tagView = tagView;
}
//
- (void)addTextField
{
    //添加textField
    UITextField *textField = [[UITextField alloc]init];
    textField.frame = CGRectMake(20, self.height + 20, IWWIDTH - 40 , 36);
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.font = [UIFont systemFontOfSize:14];
    textField.placeholder = NSLocalizedString(@"activity_medical_info_tobacco_other_tip", nil);
    textField.backgroundColor = [UIColor whiteColor];
    textField.textColor = [UIColor grayColor];
    textField.text = self.othername;
    [self.contentView addSubview:textField];
    _textField = textField;
}

#pragma mark 选中
-(void)IMJIETagView:(NSArray *)tagArray{
    
    NSLog(@"%@",tagArray);
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
    //遍历取出选中的title
    for (int i = 0; i<tagArray.count; i++) {
        //获取选中的下标
        int n = [tagArray[i] intValue];
        //根据下标找到title
        [resultArray addObject:self.dataArray[n]];
    }
    //拼接成字符串
    NSString *resulrstr = [resultArray componentsJoinedByString:@","];
    self.resultStr = resulrstr;
    if (_guominCellBlock) {
        _guominCellBlock(_resultStr);
    }
    
}





@end
