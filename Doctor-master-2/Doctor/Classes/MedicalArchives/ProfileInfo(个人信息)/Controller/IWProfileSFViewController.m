//
//  IWProfileSFViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/22.
//
//

#import "IWProfileSFViewController.h"
#import "IWProfileSFTableViewCell.h"
#import "IWprofileCommunityModel.h"
#import "IWprofileProvinceModel.h"
#import "IWProfileCityModel.h"

#import "IWProfileInfoViewController.h"

@interface IWProfileSFViewController ()<UITableViewDelegate,UITableViewDataSource>


{
    NSMutableArray *dataSource;
    NSMutableArray *dataSourceBeforePushVC;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) IWprofileCommunityModel *profileModel;


@end

@implementation IWProfileSFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self tableView];

    if (self.isFromMine) {
        if (self.index.row == 3 ) {
            [self loadCommunityData];
        }
        
        if (self.index.row == 4){
            [self loadProvinceDatawithItem:self.type];
        }

        
    }else{
        if (self.index.row == 4 ) {
            [self loadCommunityData];
        }
        
        if (self.index.row == 5){
            [self loadProvinceDatawithItem:self.type];
        }

    }
    
    
    
}
- (void)setType:(NSString *)type{
    _type = type;
}

- (void)setCommunityID:(NSString *)communityID{
    _communityID = communityID;
}

- (void)setParentCode:(NSString *)parentCode{
    _parentCode = parentCode;
}
- (void)setIsFromMine:(BOOL)isFromMine{
    _isFromMine = isFromMine;
}
#pragma mark - 加载社区数据
- (void)loadCommunityData
{
    dataSource = [NSMutableArray array];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    NSNumber *companyId = @(IWCompanyId);
    NSString *type = @"community";
    NSString *communityId = _communityID;
    NSString *loginID = [NSString stringWithFormat:@"%@",[IWUserTool user].loginId];
    [params setValue:companyId forKey:@"companyId"];
    [params setValue:loginID forKey:@"loginId"];
    [params setValue:type forKey:@"type"];
    if (self.communityID) {
        [params setValue:communityId forKey:@"communityId"];
    }
    
    [IWHttpTool postWithURL:SERVER_GET_COMMUNITY_HOSPITAL_URL params:params success:^(id json) {
        
        if ([json[@"code"] intValue] == 0) {
            NSDictionary *tempDic = json[@"datas"];
            NSDictionary *communityDatas = tempDic[@"communityDatas"];
            for (NSDictionary * subDic in communityDatas) {
                IWprofileCommunityModel *model = [[IWprofileCommunityModel alloc] init];
                [model setValuesForKeysWithDictionary:subDic];
                [dataSource addObject:model];
            }
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
    
    }];
    
}

- (void)loadcommunitydataBefofePuchVCWIthCommunityID:(NSString *)communityID{
    dataSourceBeforePushVC = [NSMutableArray arrayWithCapacity:0];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSNumber *companyId = @(IWCompanyId);
    NSString *type = @"community";
    NSString *communityId = communityID;
    NSString *loginID = [NSString stringWithFormat:@"%@",[IWUserTool user].loginId];
    
    [params setValue:companyId forKey:@"companyId"];
    [params setValue:loginID forKey:@"loginId"];
    [params setValue:type forKey:@"type"];
    [params setValue:communityId forKey:@"communityId"];
    
    
    [IWHttpTool postWithURL:SERVER_GET_COMMUNITY_HOSPITAL_URL params:params success:^(id json) {
        
        if ([json[@"code"] intValue] == 0) {
            
            NSDictionary *tempDic = json[@"datas"];
            NSDictionary *communityDatas = tempDic[@"communityDatas"];
            
            for (NSDictionary * subDic in communityDatas) {
                IWprofileCommunityModel *model = [[IWprofileCommunityModel alloc] init];
                [model setValuesForKeysWithDictionary:subDic];
                [dataSourceBeforePushVC addObject:model];
            }
            
            if (dataSourceBeforePushVC.count > 0) {
                IWProfileSFViewController *vc = [[IWProfileSFViewController alloc] init];
                vc.navigationItem.title = @"社区";
                vc.index = self.index;
                vc.isFromMine = self.isFromMine;
                
                vc.communityID = communityID;
                [self .navigationController pushViewController:vc animated:YES];
                
            }else{
                NSString *communituName = self.profileModel.communityName;
                NSString *communituID = self.profileModel.communityId;
                
                NSDictionary * dic = @{@"communituName":communituName,@"communituID":communituID};
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCommunityName" object:nil userInfo:dic];
                
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[IWProfileInfoViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
        
            }

        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 加载所属区域数据
- (void)loadProvinceDatawithItem:(NSString *)paramtype{
    
    dataSource = [NSMutableArray array];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSNumber *companyId = @(IWCompanyId);
    NSString *loginID = [NSString stringWithFormat:@"%@",[IWUserTool user].loginId];
    NSString *type;
    NSString *parentCode;
    if (paramtype == nil) {
         type = @"province";
        
        [params setValue:companyId forKey:@"companyId"];
        [params setValue:loginID forKey:@"loginId"];
        [params setValue:type forKey:@"listType"];

    }else{
        type = paramtype;
        parentCode = self.parentCode;
        [params setValue:companyId forKey:@"companyId"];
        [params setValue:loginID forKey:@"loginId"];
        [params setValue:type forKey:@"listType"];
        [params setValue:parentCode forKey:@"parentCode"];

    }
    [IWHttpTool postWithURL:SERVER_GET_ADDRESS_URL params:params success:^(id json) {
        if ([json[@"code"] intValue] == 0) {
            NSArray *tempDic = json[@"datas"];
            
            for (int i = 0; i<tempDic.count; i++) {
                IWprofileProvinceModel *model = [[IWprofileProvinceModel alloc] init];
                [model setValuesForKeysWithDictionary:tempDic[i]];
                [dataSource addObject:model];
            }
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}


-(UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        tableView.backgroundColor=[UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.dataSource=self;
        tableView.delegate=self;
        tableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
#pragma mark - tableView delegate and tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IWProfileSFTableViewCell *cell = [IWProfileSFTableViewCell normalTableViewCellWithTableView:tableView];
    
    if (self.isFromMine) {
        if (self.index.row == 3) {
            cell.communitymodel = dataSource[indexPath.row];
        }else if (self.index.row == 4){
            cell.provinceModel = dataSource[indexPath.row];
        }else{
            cell.cityModel = dataSource[indexPath.row];
        }

    }else{
        if (self.index.row == 4) {
            cell.communitymodel = dataSource[indexPath.row];
        }else if (self.index.row == 5){
            cell.provinceModel = dataSource[indexPath.row];
        }else{
            cell.cityModel = dataSource[indexPath.row];
        }

    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isFromMine) {
        
        if (self.index.row == 3) {
            IWprofileCommunityModel *model = dataSource[indexPath.row];
            self.profileModel = model;
            NSString *communityID = model.communityId;
            [self loadcommunitydataBefofePuchVCWIthCommunityID:communityID];
            
        }
        
        if (self.index.row == 4) {
            
            IWprofileProvinceModel *provinceModel = dataSource[indexPath.row];
            
            IWProfileSFViewController *vc = [[IWProfileSFViewController alloc] init];
            vc.index = self.index;
            vc.isFromMine =self.isFromMine;
            vc.navigationItem.title = provinceModel.regionName;
            
            if (self.type == nil) {
                vc.type = @"city";
                vc.parentCode = provinceModel.regionCode;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([self.type isEqualToString:@"city"]){
                vc.type = @"county";
                vc.parentCode = provinceModel.regionCode;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                
                IWProfileCityModel *model = dataSource[indexPath.row];
                NSString *resultText = model.regionName;
                NSString *regionCode = model.regionCode;
                
                NSDictionary *dic = @{@"regionName":resultText,@"regionCode":regionCode};
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changecityName" object:nil userInfo:dic];
                
                
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[IWProfileInfoViewController class] ]) {
                        [self.navigationController popToViewController:vc  animated:YES];
                        
                    }
                }
                
            }
            
        }

    }else{
        
        if (self.index.row == 4) {
            IWprofileCommunityModel *model = dataSource[indexPath.row];
            self.profileModel = model;
            NSString *communityID = model.communityId;
            [self loadcommunitydataBefofePuchVCWIthCommunityID:communityID];
            
        }
        
        if (self.index.row == 5) {
            
            IWprofileProvinceModel *provinceModel = dataSource[indexPath.row];
            
            IWProfileSFViewController *vc = [[IWProfileSFViewController alloc] init];
            vc.index = self.index;
            vc.navigationItem.title = provinceModel.regionName;
            
            if (self.type == nil) {
                vc.type = @"city";
                vc.parentCode = provinceModel.regionCode;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([self.type isEqualToString:@"city"]){
                vc.type = @"county";
                vc.parentCode = provinceModel.regionCode;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                
                IWProfileCityModel *model = dataSource[indexPath.row];
                NSString *resultText = model.regionName;
                NSString *regionCode = model.regionCode;
                
                NSDictionary *dic = @{@"regionName":resultText,@"regionCode":regionCode};
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changecityName" object:nil userInfo:dic];
                
                
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[IWProfileInfoViewController class] ]) {
                        [self.navigationController popToViewController:vc  animated:YES];
                        
                    }
                }
                
            }
            
        }

    }
}

@end
