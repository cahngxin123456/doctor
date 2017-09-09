//
//  IWTrainningWebViewController.m
//  Conedot
//
//  Created by 范超 on 16/7/2.
//  Copyright © 2016年 范超. All rights reserved.
//

#import "IWTrainningWebViewController.h"
#import "ScanViewController.h"

@interface IWTrainningWebViewController () <UIWebViewDelegate>
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, assign) int gesState;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation IWTrainningWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRightIcon];
}

- (void)setupRightIcon {
    UIBarButtonItem *scan = [[UIBarButtonItem alloc] initWithImage:[UIImage resizedImageWithName:@"scan"] style:UIBarButtonItemStyleDone target:self action:@selector(scan:)];
    
    self.navigationItem.rightBarButtonItems = @[scan];
}

- (void)scan:(UIBarButtonItem *)item {
    ScanViewController *vc = [[ScanViewController alloc] init];
    vc.classId = self.classId;
    [self.navigationController pushViewController:vc animated:YES];
}

// 功能：UIWebView响应长按事件
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *host=[[request URL].host lowercaseString];if([host hasSuffix:@"itunes.apple.com"])
    {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0]
                                   isEqualToString:@"myweb"]) {
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"touch"])
        {
            //NSLog(@"you are touching!");
            //NSTimeInterval delaytime = Delaytime;
            if ([(NSString *)[components objectAtIndex:2] isEqualToString:@"start"])
            {
                /*
                 @需延时判断是否响应页面内的js...
                 */
                _gesState = GESTURE_STATE_START;
                NSLog(@"touch start!");
                
                float ptX = [[components objectAtIndex:3]floatValue];
                float ptY = [[components objectAtIndex:4]floatValue];
                NSLog(@"touch point (%f, %f)", ptX, ptY);
                
                NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).tagName", ptX, ptY];
                NSString * tagName = [self.webView stringByEvaluatingJavaScriptFromString:js];
                self.imageURL = nil;
                if ([tagName isEqualToString:@"IMG"]) {
                    self.imageURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", ptX, ptY];
                    
                    
                    //把图片后缀去掉，保存原图
                    //                    NSString *ext =  _imgURL substringToIndex:[_imgURL inde]
                    
                    
                }
                if (self.imageURL) {
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleLongTouch) userInfo:nil repeats:NO];
                }
            }
            else if ([(NSString *)[components objectAtIndex:2] isEqualToString:@"move"])
            {
                //**如果touch动作是滑动，则取消hanleLongTouch动作**//
                _gesState = GESTURE_STATE_MOVE;
                NSLog(@"you are move");
            }
            else if ([(NSString*)[components objectAtIndex:2]isEqualToString:@"end"]) {
                [_timer invalidate];
                _timer = nil;
                _gesState = GESTURE_STATE_END;
                NSLog(@"touch end");
            }
        }
        return NO;
    }
    return YES;
}
// 功能：如果点击的是图片，并且按住的时间超过1s，执行handleLongTouch函数，处理图片的保存操作。
- (void)handleLongTouch {
    NSLog(@"%@", self.imageURL);
    if (self.imageURL && self.gesState == GESTURE_STATE_START) {
//        UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存压缩图",@"保存高清图", nil];
//        sheet.cancelButtonIndex = sheet.numberOfButtons - 1;
//        [sheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}

@end
