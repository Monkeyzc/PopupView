//
//  PopupViewCell.m
//  PopupView
//
//  Created by Zhao Fei on 2016/10/12.
//  Copyright © 2016年 ZhaoFei. All rights reserved.
//

#import "PopupViewCell.h"
#import "Masonry/Masonry.h"

static CGFloat padding = 16.f;
static CGFloat iconSize = 16;

@interface PopupViewCell()

@property (nonatomic, strong) UIImageView *separatorLineView;

@end

@implementation PopupViewCell

+ (instancetype)popupViewCellWithTableView:(UITableView *)tableView {
    
    static NSString *cellID = @"PopupViewCell";
    
    PopupViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[PopupViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconView];
        
        self.titleLable = [[UILabel alloc] init];
        self.titleLable.textColor = [UIColor blackColor];
        self.titleLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLable];
        
        //添加分割线
        self.separatorLineView = [[UIImageView alloc] init];
        self.separatorLineView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.separatorLineView];
        self.separatorLineView.hidden = YES;
        
        [self.contentView addSubview:self.separatorLineView];
    
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(padding);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(iconSize));
        make.height.equalTo(@(iconSize));
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconView.mas_trailing).offset(padding);
        make.centerY.equalTo(self.contentView);
        make.trailing.equalTo(self.contentView).offset(-padding);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.textLabel);
        make.trailing.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@(1 / ([UIScreen mainScreen].scale)));
    }];
}

-(void)setHaveSeparatorLine:(BOOL)haveSeparatorLine{
    _haveSeparatorLine = haveSeparatorLine;
    self.separatorLineView.hidden = haveSeparatorLine;
}
@end
