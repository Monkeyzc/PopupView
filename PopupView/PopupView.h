//
//  PopupView.h
//  PopupView
//
//  Created by Zhao Fei on 2016/10/12.
//  Copyright © 2016年 ZhaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupView : UIView
+ (void)addCellWithIcon:(UIImage *)icon text:(NSString *)text action: (void (^) ())action;
+ (void)popupView;
@end
