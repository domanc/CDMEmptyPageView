//
//  UIView+CDMEmpty.h
//  NavBar
//
//  Created by Doman on 2017/5/2.
//  Copyright © 2017年 Doman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDMNetErrorPageView , CDMBlankPageView;

@interface UIView (CDMEmpty)

//CDMNetErrorPageView
@property (nonatomic,strong) CDMNetErrorPageView * netErrorPageView;
- (void)configReloadAction:(void(^)())block;
- (void)showNetErrorPageView;
- (void)hideNetErrorPageView;

//CDMBlankPageView
@property (nonatomic,strong) CDMBlankPageView* blankPageView;
- (void)showBlankPageView;
- (void)hideBlankPageView;

@end


#pragma mark --- CDMNetErrorPageView
@interface CDMNetErrorPageView : UIView
@property (nonatomic,copy) void(^didClickReloadBlock)();
@end

#pragma mark --- CDMBlankPageView
@interface CDMBlankPageView : UIView

@end
