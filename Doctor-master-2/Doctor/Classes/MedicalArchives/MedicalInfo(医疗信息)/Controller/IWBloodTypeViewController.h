//
//  IWBloodTypeViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/26.
//
//

#import <UIKit/UIKit.h>

@interface IWBloodTypeViewController : UIViewController

//@property (nonatomic, copy) void(^saveButtonBlock)(NSString *text);

@property (nonatomic, copy) NSString *typeStr;

@property (nonatomic, copy) NSString *selectedName;
@property (nonatomic, strong) NSArray *selectArray;
@property (nonatomic, copy) NSString *textFieldtext;

@property (nonatomic, copy) void (^drinkTypeSaveBlock)(NSString *str1, NSString *str2);

@property (nonatomic, copy) NSString *memberID;

@end
