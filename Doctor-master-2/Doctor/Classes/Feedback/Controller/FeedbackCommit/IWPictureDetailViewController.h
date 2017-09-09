//
//  IWPictureDetailViewController.h
//  Conedot
//
//  Created by 范超 on 15/4/13.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWPictureDetailViewController;

@protocol IWPictureDetailViewControllerDelegate <NSObject>

@optional
- (void)deleteImageWithController:(IWPictureDetailViewController *)vc;

@end

@interface IWPictureDetailViewController : UIViewController
@property (nonatomic, copy) NSString *path;
@property (nonatomic, assign) id<IWPictureDetailViewControllerDelegate> delegate;
@end
