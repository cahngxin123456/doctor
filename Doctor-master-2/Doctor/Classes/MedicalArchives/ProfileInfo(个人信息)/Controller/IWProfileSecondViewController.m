//
//  IWProfileSecondViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import "IWProfileSecondViewController.h"
#import "IMJIETagFrame.h"
#import "IMJIETagView.h"
#import "IWprofileJobModel.h"

@interface IWProfileSecondViewController ()<IMJIETagViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *numArray;

@property (nonatomic, copy) NSString *resultStr;//选中的title
@property (nonatomic, copy) NSString *numStr;//

@property (nonatomic, strong) NSArray *familyArray;
@property (nonatomic, strong) NSArray *sexArray;

@property (nonatomic, copy) NSString *textFieldText;

@property (nonatomic, strong) IMJIETagView *tagView;

@end

@implementation IWProfileSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorRGBA(246, 246, 246, 1);
    NSIndexPath *indexPath= self.index;

    self.titleArray = [NSMutableArray arrayWithCapacity:0];
    self.numArray = [NSMutableArray arrayWithCapacity:0];
    
    if (indexPath.section == 0) {
        if (self.isFromMine) {
            if (indexPath.row == 1) {
                
                NSArray *array = @[NSLocalizedString(@"activity_medical_bear_sex_1", nil),NSLocalizedString(@"activity_medical_bear_sex_2", nil),NSLocalizedString(@"sex_other", nil)];
                
                self.titleArray = (NSMutableArray *)array;
                [self createTagViewWithTittleArray:self.titleArray andType:0 andHiddenTextField:YES];
                
            }
        }else{
            if (indexPath.row == 1) {
                
//                NSArray *array = @[NSLocalizedString(@"medical_archives_me", nil),NSLocalizedString(@"medical_archives_family", nil),NSLocalizedString(@"medical_archives_other", nil)];
                NSArray *array = @[NSLocalizedString(@"medical_archives_family", nil),NSLocalizedString(@"medical_archives_other", nil)];
                self.titleArray = (NSMutableArray *)array;
                
                [self createTagViewWithTittleArray:self.titleArray andType:0 andHiddenTextField:YES];
                
            }else if (indexPath.row == 2)
            {
                NSArray *array = @[NSLocalizedString(@"activity_medical_bear_sex_1", nil),NSLocalizedString(@"activity_medical_bear_sex_2", nil),NSLocalizedString(@"sex_other", nil)];
                
                self.titleArray = (NSMutableArray *)array;
                [self createTagViewWithTittleArray:self.titleArray andType:0 andHiddenTextField:YES];
            }

        }
        
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            [self loadJobData];
        }
        if (indexPath.row == 2){
            [self loadMarriageData];
        }
        
        if (indexPath.row == 3) {
            
            [self loadEducationData];
        }
        
    }else {
        
    }
    
    
}

- (void)setIsFromMine:(BOOL)isFromMine{
    _isFromMine = isFromMine;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)loadJobData{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setValue:@"occupation" forKey:@"category"];
    [params setValue:@"database" forKey:@"type"];
    NSString *urlstr = @"http://114.55.25.162:7070/Common/GetDictionary/2J.do";
    [IWHttpTool postWithURL:urlstr params:params success:^(id json) {
        if ([json[@"code"] intValue] == 0) {
            NSArray *temparray = json[@"datas"];
            for (NSDictionary *subDic in temparray) {
                IWprofileJobModel *jobModel = [[IWprofileJobModel alloc] init];
                [jobModel setValuesForKeysWithDictionary:subDic];
                [_titleArray addObject:jobModel.dictName];
                [_numArray addObject:jobModel.dictValue];
            }
            [self createTagViewWithTittleArray:_titleArray andType:0 andHiddenTextField:NO];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadMarriageData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setValue:@"database" forKey:@"type"];
    [params setValue:@"maritalStatus" forKey:@"category"];
    
    NSString *urlstr = @"http://114.55.25.162:7070/Common/GetDictionary/2J.do";
    
    [IWHttpTool postWithURL:urlstr params:params success:^(id json) {
        
        if ([json[@"code"] intValue] == 0) {
            
            NSArray *temparray = json[@"datas"];
            
            for (NSDictionary *subDic in temparray) {
                
                IWprofileJobModel *jobModel = [[IWprofileJobModel alloc] init];
                [jobModel setValuesForKeysWithDictionary:subDic];
                [_titleArray addObject:jobModel.dictName];
                [_numArray addObject:jobModel.dictValue];

            }
            
            [self createTagViewWithTittleArray:_titleArray andType:0 andHiddenTextField:YES];        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)loadEducationData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setValue:@"education" forKey:@"category"];
    [params setValue:@"database" forKey:@"type"];
    
    NSString *urlstr = @"http://114.55.25.162:7070/Common/GetDictionary/2J.do";
    [IWHttpTool postWithURL:urlstr params:params success:^(id json) {
        
        if ([json[@"code"] intValue] == 0) {
            
            NSArray *temparray = json[@"datas"];
            for (NSDictionary *subDic in temparray) {
                
                IWprofileJobModel *jobModel = [[IWprofileJobModel alloc] init];
                [jobModel setValuesForKeysWithDictionary:subDic];
                [_titleArray addObject:jobModel.dictName];
                [_numArray addObject:jobModel.dictValue];

            }
            
            [self createTagViewWithTittleArray:_titleArray andType:0 andHiddenTextField:YES];        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)createTagViewWithTittleArray:(NSArray *)array andType:(int) type andHiddenTextField:(BOOL)hiddeTextField
{
    IMJIETagFrame *frame = [[IMJIETagFrame alloc] init];
    frame.tagsMinPadding = 4;
    frame.tagsMargin = 10;
    frame.tagsLineSpacing = 10;
    frame.tagsArray = array;
    
     self.tagView = [[IMJIETagView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, frame.tagsHeight)];
    self.tagView.clickbool = YES;
    self.tagView.borderSize = 0.5;
    self.tagView.clickborderSize = 0.5;
    self.tagView.tagsFrame = frame;
    self.tagView.clickStart = type;
    self.tagView.clickString = self.selectName;//单选  tagView.clickStart 为0
    //    tagView.clickArray = @[@"误解向",@"我们仍未知道那天所看见的花的名字"];//多选 tagView.clickStart 为1
    self.tagView.delegate = self;
    
    [self.view addSubview:self.tagView];
    
    if (hiddeTextField == YES) {
        [self setupSaveBtnWithTagViewHeight:frame.tagsHeight];
        
    }else{
        
        
        [self setupTextFieldAndSaveBurronWithTagViewHeight:frame.tagsHeight];
        
    }
    
    
    
}

- (void)setupTextFieldAndSaveBurronWithTagViewHeight:(CGFloat)y
{
    UIView *bgview = [[UIView alloc] init];
    bgview.frame = CGRectMake(0, y + 20, self.view.frame.size.width, 130);
    [self.view addSubview:bgview];
    
    
    UITextField *textField = [[UITextField alloc]init];
    textField.frame = CGRectMake(10, 0, self.view.frame.size.width - 20, 40);
    textField.borderStyle =  UITextBorderStyleRoundedRect;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.font = [UIFont systemFontOfSize:14];
    textField.backgroundColor = [UIColor clearColor];
    textField.textColor = [UIColor grayColor];
    textField.delegate = self;
    textField.placeholder = NSLocalizedString(@"other_one_tip", nil);
    [bgview addSubview:textField];
    _textField = textField;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, _textField.frame.origin.y + 10 + _textField.frame.size.height, self.view.frame.size.width - 20, 40);
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10;
    
    NSArray *imageNameArray = @[@"t_btn_normal",@"t_btn_press"];
    for (int i = 0; i<2; i++) {
        // 加载图片
        UIImage *image = [UIImage imageNamed:imageNameArray[i]];
        // 设置端盖的值
        CGFloat top = image.size.height * 0.5;
        CGFloat left = image.size.width * 0.5;
        CGFloat bottom = image.size.height * 0.5;
        CGFloat right = image.size.width * 0.5;
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        // 拉伸图片
        UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
        
        if (i == 0) {
            [button setBackgroundImage:newImage forState:UIControlStateNormal];
            
        }else
        {
            [button setBackgroundImage:newImage forState:UIControlStateHighlighted];
        }
    }
    
    [bgview addSubview:button];
    _saveButton=button;
}

- (void)setupSaveBtnWithTagViewHeight:(CGFloat)y
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, y + 20, self.view.frame.size.width - 20, 40);
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10;
    
    NSArray *imageNameArray = @[@"t_btn_normal",@"t_btn_press"];
    for (int i = 0; i<2; i++) {
        // 加载图片
        UIImage *image = [UIImage imageNamed:imageNameArray[i]];
        // 设置端盖的值
        CGFloat top = image.size.height * 0.5;
        CGFloat left = image.size.width * 0.5;
        CGFloat bottom = image.size.height * 0.5;
        CGFloat right = image.size.width * 0.5;
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        // 拉伸图片
        UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
        
        if (i == 0) {
            [button setBackgroundImage:newImage forState:UIControlStateNormal];
            
        }else
        {
            [button setBackgroundImage:newImage forState:UIControlStateHighlighted];
        }
    }
    
    [self.view addSubview:button];
    _saveButton=button;
    
    
}

//点击事件
-(void)buttonClicked:(UIButton *)button{
    [_textField resignFirstResponder];
    NSLog(@"buttonClicked");
    NSLog(@"%@",self.resultStr);
    
    if (_saveButtonBlock) {
        
        if (self.textFieldText == nil) {
            if (self.index.section == 0) {
                if (self.resultStr == nil) {
                    _saveButtonBlock(self.selectName,nil);
                }else{
                    _saveButtonBlock(self.resultStr,nil);
                }
            }else{
                if (self.resultStr == nil) {
                    NSUInteger index = [self.titleArray indexOfObject:self.selectName];
                    if (index != NSNotFound) {
                        self.numStr = [self.numArray objectAtIndex:index];
                    }
                    _saveButtonBlock(self.selectName,self.numStr);
                    
                }else{
                    _saveButtonBlock(self.resultStr,self.numStr);
                }
            }
            
        }else{
            _saveButtonBlock(self.textFieldText,nil);
        }
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark 选中
-(void)IMJIETagView:(NSArray *)tagArray{
    
    NSLog(@"%@",tagArray);
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *numArray = [NSMutableArray arrayWithCapacity:0];
    //遍历取出选中的title
    for (int i = 0; i<tagArray.count; i++) {
        //获取选中的下标
        int n = [tagArray[i] intValue];
        //根据下标找到title
        [resultArray addObject:self.titleArray[n]];
        if (self.numArray.count > 0) {
            [numArray addObject:self.numArray[n]];

        }
    }
    //拼接成字符串
    NSString *resulrstr = [resultArray componentsJoinedByString:@"，"];
    NSString *num = numArray.firstObject;
    self.resultStr = resulrstr;
    self.numStr = num;
}


#pragma mark - textField delegit
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.textFieldText = textField.text;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
