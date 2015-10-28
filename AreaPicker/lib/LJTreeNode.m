//
//  LJTreeNode.m
//  AreaPicker
//
//  Created by 廖军 on 15/10/28.
//  Copyright © 2015年 com.qiang. All rights reserved.
//

#import "LJTreeNode.h"

@implementation LJTreeNode

- (instancetype)initWithPlistFile:(NSString *)file
{
    NSArray *subs = [NSArray arrayWithContentsOfFile:file];
    return [self initWithSubs:subs];
}

- (instancetype)initWithSubs:(NSArray *)subs
{
    self = [super init];
    if (self) {
        if (!_subNodes) {
            _subNodes = [NSMutableArray arrayWithCapacity:subs.count];
        }
        for (NSInteger i = 0; i < (NSInteger)subs.count; i++) {
            NSDictionary *dic = (NSDictionary *)subs[i];
            LJTreeNode *node;
            if ([subs[i] isKindOfClass:[NSDictionary class]]) {
                node = [[LJTreeNode alloc] initWithSubs:dic[@"subs"]];
                node.value = dic[@"value"];
            } else {
                node = [[LJTreeNode alloc] init];
                node.value = subs[i];
            }
            
            node.parentNode = self;
            [_subNodes addObject:node];
        }
    }
    return self;
}

- (NSUInteger)depth {
    if (!_subNodes.count) {
        return 1;
    }
    
    //获取子节点的最大深度，+1作为结果
    NSUInteger maxDepth = 0;
    for (LJTreeNode *treeNode in _subNodes) {
        NSUInteger tempDepth = treeNode.depth;
        if (tempDepth > maxDepth) {
            maxDepth = tempDepth;
        }
    }
    return maxDepth+1;
}

- (NSArray<LJTreeNode *> *)ancestors {
    NSMutableArray<LJTreeNode *> *result = [@[] mutableCopy];
    LJTreeNode *currentNode = _parentNode;
    while (currentNode) {
        [result insertObject:currentNode atIndex:0];
        currentNode = currentNode.parentNode;
    }
    return result;
}

- (LJTreeNode *)firstLeaf {
    if (!_subNodes.count) {
        return self;
    }
    return _subNodes.firstObject.firstLeaf;
}

@end
