//
//  PopupViewCell.h
//  PopupView
//
//  Created by Zhao Fei on 2016/10/12.
//  Copyright © 2016年 ZhaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupViewCell : UITableViewCell

+ (instancetype)popupViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, assign, getter=isHaveSeparatorLine) BOOL haveSeparatorLine; //是否有分割线

@end
