//
//  IWAppMenu.h
//  Conedot
//
//  Created by 范超 on 15/9/13.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWAppMenu : NSObject
//    "appName": "通知nt",
//            "id": "297e9e794faaceff014fabe8a847059a",
//            "appIcon": "http://conedot.com:7070/uploads/appIcon/2015/201509/20150909/20150909101926_Yjko7n.png",
//            "appId": "402881fa4fa6600b014fa66ceb710002",
//            "companyId": 101915,
//            "usingStatus": 1,
//            "appType": "notice"


@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *appIcon;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, assign) int usingStatus;
@property (nonatomic, copy) NSString *appType;

@end
