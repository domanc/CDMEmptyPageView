//
//  UIView+CDMEmpty.m
//  NavBar
//
//  Created by Doman on 2017/5/2.
//  Copyright © 2017年 Doman. All rights reserved.
//

#import "UIView+CDMEmpty.h"
#import <objc/runtime.h>
#import "Masonry.h"

//屏幕高
#define kSCREENH [UIScreen mainScreen].bounds.size.height
//屏幕宽
#define kSCREENW [UIScreen mainScreen].bounds.size.width

@interface UIView ()

@property (nonatomic,copy) void(^reloadAction)();

@end

@implementation UIView (CDMEmpty)

- (void)setReloadAction:(void (^)())reloadAction{
    objc_setAssociatedObject(self, @selector(reloadAction), reloadAction, OBJC_ASSOCIATION_COPY);
}
- (void (^)())reloadAction{
    return objc_getAssociatedObject(self, _cmd);
}

//CDMNetErrorPageView
- (void)setNetErrorPageView:(CDMNetErrorPageView *)netErrorPageView{
    [self willChangeValueForKey:NSStringFromSelector(@selector(netErrorPageView))];
    objc_setAssociatedObject(self, @selector(netErrorPageView), netErrorPageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:NSStringFromSelector(@selector(netErrorPageView))];
}
- (CDMNetErrorPageView *)netErrorPageView{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)configReloadAction:(void (^)())block{
    self.reloadAction = block;
    if (self.netErrorPageView && self.reloadAction) {
        self.netErrorPageView.didClickReloadBlock = self.reloadAction;
    }
}

- (void)showNetErrorPageView{
    
    if (!self.netErrorPageView) {
        self.netErrorPageView = [[CDMNetErrorPageView alloc]initWithFrame:self.bounds];
        if (self.reloadAction) {
            self.netErrorPageView.didClickReloadBlock = self.reloadAction;
        }
    }
    [self addSubview:self.netErrorPageView];
    [self bringSubviewToFront:self.netErrorPageView];
}
- (void)hideNetErrorPageView{
    if (self.netErrorPageView) {
        [self.netErrorPageView removeFromSuperview];
        self.netErrorPageView = nil;
    }
}

//CDMBlankPageView
- (void)setBlankPageView:(CDMBlankPageView *)blankPageView{
    [self willChangeValueForKey:NSStringFromSelector(@selector(blankPageView))];
    objc_setAssociatedObject(self, @selector(blankPageView), blankPageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    [self didChangeValueForKey:NSStringFromSelector(@selector(blankPageView))];
}
- (CDMBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)showBlankPageView{
    
    if (!self.blankPageView) {
        self.blankPageView = [[CDMBlankPageView alloc]initWithFrame:self.bounds];
    }
    [self addSubview:self.blankPageView];
    [self bringSubviewToFront:self.blankPageView];
}
- (void)hideBlankPageView{
    if (self.blankPageView) {
        [self.blankPageView removeFromSuperview];
        self.blankPageView = nil;
    }
}


@end

#pragma mark ---  CDMNetErrorPageView
@interface CDMNetErrorPageView ()
@property (nonatomic,weak) UIImageView* errorImageView;
@property (nonatomic,weak) UILabel* errorTipLabel;
@property (nonatomic,weak) UIButton* reloadButton;

@end
@implementation CDMNetErrorPageView
- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView* errorImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wifi"]];
        _errorImageView = errorImageView;
        [self addSubview:_errorImageView];
        
        UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [reloadButton setTitle:@"  网络好像有点问题请点击重试~" forState:UIControlStateNormal];
        reloadButton.titleLabel.font =[UIFont systemFontOfSize:15];
        [reloadButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [reloadButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
        [reloadButton addTarget:self action:@selector(_clickReloadButton:) forControlEvents:UIControlEventTouchUpInside];
        _reloadButton = reloadButton;
        [self addSubview:_reloadButton];
        
        [_errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.mas_centerY).offset(-30);
        }];
        
        [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@20);
            make.top.equalTo(_errorImageView.mas_bottom).offset(10);
        }];
        

    }
    return self;
}
- (void)_clickReloadButton:(UIButton* )btn{
    if (_didClickReloadBlock) {
        _didClickReloadBlock();
    }
}

@end


#pragma mark --- CDMBlankPageView
@interface CDMBlankPageView ()
@property (nonatomic,weak) UIImageView* nodataImageView;
@property (nonatomic,weak) UILabel* nodataTipLabel;
@end

@implementation CDMBlankPageView

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView* nodataImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"120"]];
        _nodataImageView = nodataImageView;
        [self addSubview:_nodataImageView];
        
        UILabel* nodataTipLabel = [[UILabel alloc]init];
        nodataTipLabel.numberOfLines = 1;
        nodataTipLabel.font = [UIFont systemFontOfSize:15];
        nodataTipLabel.textAlignment = NSTextAlignmentCenter;
        nodataTipLabel.textColor = [UIColor grayColor];
        nodataTipLabel.text = @"暂无数据,请搞事~";
        _nodataTipLabel = nodataTipLabel;
        [self addSubview:_nodataTipLabel];
        
        [_nodataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(-10);
        }];
        
        [_nodataTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@50);
            make.top.equalTo(_nodataImageView.mas_bottom).offset(5);
        }];
    }
    return self;
}

@end





