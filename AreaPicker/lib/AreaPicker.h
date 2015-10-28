//
//  AreaPicker.h
//  AreaPicker
//
//  Created by 廖军 on 15/10/28.
//  Copyright © 2015年 com.qiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJTreeNode;

@interface AreaPicker : UIView

@property (nonatomic,strong) LJTreeNode *treeNode;
@property (nonatomic,strong) NSDictionary *titleAttribute;
@property (nonatomic,strong,readonly) LJTreeNode *selectedNode;

/**
 *  获取选中的区域
 *
 *  @return 选中的区域
 */
- (NSString *)selectedArea;

@end
