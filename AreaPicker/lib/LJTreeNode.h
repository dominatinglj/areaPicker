//
//  LJTreeNode.h
//  AreaPicker
//
//  Created by 廖军 on 15/10/28.
//  Copyright © 2015年 com.qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJTreeNode : NSObject

@property (nonatomic,strong) NSMutableArray<LJTreeNode *> *subNodes;
@property (nonatomic,strong) LJTreeNode *parentNode;
@property (nonatomic,strong) NSString *value;

- (instancetype)initWithPlistFile:(NSString *)file;

- (LJTreeNode *)findSubWithArray:(NSArray<NSString *> *)array;

/**
 *  获取最大深度
 *
 *  @return 最大深度
 */
- (NSUInteger)depth;

/**
 *  获取所有祖先节点
 *
 *  @return 所有祖先节点
 */
- (NSArray<LJTreeNode *> *)ancestors;

/**
 *  获取第一个叶子节点
 *
 *  @return 节点
 */
- (LJTreeNode *)firstLeaf;

@end
