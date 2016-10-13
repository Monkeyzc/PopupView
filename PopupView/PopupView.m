//
//  PopupView.m
//  PopupView
//
//  Created by Zhao Fei on 2016/10/12.
//  Copyright © 2016年 ZhaoFei. All rights reserved.
//

#import "PopupView.h"
#import "PopupViewCell.h"

static CGFloat devicePadding = 20.0f;
static CGFloat popupViewWidth = 120.f;
static CGFloat popupViewpadding = 8.0f;
static CGFloat Trianglewidth = 3;
static CGFloat rowHeight = 32.f;

@interface PopupView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) NSInteger rows;
@property (nonatomic, strong) NSMutableArray *iconArray;
@property (nonatomic, strong) NSMutableArray *textArray;
@property (nonatomic, strong) NSMutableArray *actionBlocks;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *Triangle;
@property (nonatomic, strong) UIView *bgView;
@end

PopupView *popupView;
BOOL isShow = NO;

@implementation PopupView

+ (instancetype)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.rows = 0;
        self.Triangle = [[UIImageView alloc] initWithImage:[PopupView drawTriangle]];
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

- (NSMutableArray *)iconArray {
    if (!_iconArray) {
        _iconArray = [NSMutableArray array];
    }
    return _iconArray;
}

- (NSMutableArray *)textArray {
    if (!_textArray) {
        _textArray = [NSMutableArray array];
    }
    return _textArray;
}

- (NSMutableArray *)actionBlocks {
    if (!_actionBlocks) {
        _actionBlocks = [NSMutableArray array];
    }
    return _actionBlocks;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = popupView;
        _tableView.delegate = popupView;
        _tableView.rowHeight = rowHeight;
        [self addSubview:_tableView];
    }
    return _tableView;
}

+ (UIImage *)drawTriangle {
    
    UIGraphicsBeginImageContextWithOptions( CGSizeMake(2 * Trianglewidth, 2 * Trianglewidth), NO, 0);

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //绘制三角形
    CGContextMoveToPoint(context, Trianglewidth, 0);
    CGContextAddLineToPoint(context, 2 * Trianglewidth, 2 * Trianglewidth);
    CGContextAddLineToPoint(context, 0, 2 * Trianglewidth);
    //关闭路径，闭环，（连接起点和最后一个点）
    CGContextSetLineWidth(context, 2);
    CGContextClosePath(context);
    [[UIColor whiteColor] setFill];
    
    CGContextFillPath(context);

    //获取生成的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}


+ (void)addCellWithIcon:(UIImage *)icon text:(NSString *)text action:(void (^)())action {
    if (!icon) {
        return;
    }
    
    popupView = [PopupView shareInstance];
    popupView.rows += 1;
    [popupView.iconArray addObject:icon];
    [popupView.textArray addObject: (text.length ? text : @"item")];
    [popupView.actionBlocks addObject: (action ? [action copy] : [NSNull null])];
}

+ (void)popupView {
    isShow = !isShow;
    isShow == YES ? [PopupView show] : [PopupView hide];
}

+ (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    
    if (popupView == nil) {
        popupView = [PopupView shareInstance];
    }
    
    
    popupView.bgView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:popupView action:@selector(clickBgViewToHide)];
    [popupView.bgView addGestureRecognizer:tap];
    [window addSubview:popupView.bgView];
    
    popupView.Triangle.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - devicePadding - Trianglewidth * 2, 64 + 2, Trianglewidth * 2, Trianglewidth * 2);
    popupView.layer.cornerRadius = 4;
    popupView.layer.masksToBounds = YES;
    [window addSubview:popupView.Triangle];
    
    popupView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - popupViewWidth - popupViewpadding, CGRectGetMaxY(popupView.Triangle.frame), popupViewWidth, rowHeight * popupView.rows);
    
    [popupView addSubview: popupView.tableView];
    
    [window addSubview: popupView];
    
}

+ (void)hide {
    if (popupView == nil) {
        return;
    }
    [popupView.bgView removeFromSuperview];
    [popupView.Triangle removeFromSuperview];
    [popupView removeFromSuperview];
    
    popupView = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PopupViewCell *cell = [PopupViewCell popupViewCellWithTableView:tableView];
    
    cell.iconView.image = self.iconArray[indexPath.row];
    cell.titleLable.text = self.textArray[indexPath.row];
    
    if (indexPath.row == self.textArray.count - 1) {
        cell.haveSeparatorLine = YES;
    }else{
        cell.haveSeparatorLine = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id block = self.actionBlocks[indexPath.row];
    if (![block isEqual:[NSNull null]]) {
        [PopupView popupView];
        ((void (^)())block)();
    }
}

- (void)clickBgViewToHide{
    NSLog(@"clickBgViewToHide");
    [PopupView popupView];
}

@end
