//
//  AreaPicker.h
//  AreaPicker
//
//  Created by 廖军 on 15/10/28.
//  Copyright © 2015年 com.qiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJTreeNode;
@class AreaPicker;

@protocol AreaPickerDelegate <NSObject>

@optional

- (void)areaPicker:(AreaPicker *)areaPicker didSelectNode:(LJTreeNode *)node;

@end

@interface AreaPicker : UIView

@property (nonatomic,strong) LJTreeNode *treeNode;
@property (nonatomic,strong) NSDictionary *titleAttribute;
@property (nonatomic,strong) LJTreeNode *selectedNode;  //选中的节点
@property (nonatomic,strong) NSArray<NSString *> *areaComponents;   //区域的各个部件(从省开始)

@property (nonatomic,assign) id<AreaPickerDelegate> delegate;

/**
 *  获取选中的区域
 *
 *  @return 选中的区域
 */
- (NSString *)area;

///**
// *  区域的各个部件(从省开始)
// *
// *  @return 区域的各个部件
// */
//- (NSArray<NSString *> *)areaComponents;

@end
