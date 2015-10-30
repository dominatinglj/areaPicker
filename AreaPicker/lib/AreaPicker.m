//
//  AreaPicker.m
//  AreaPicker
//
//  Created by 廖军 on 15/10/28.
//  Copyright © 2015年 com.qiang. All rights reserved.
//

#import "AreaPicker.h"
#import "LJTreeNode.h"

@interface AreaPicker()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *_pickerView;
}

@end

@implementation AreaPicker

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _pickerView.bounds = self.bounds;
    _pickerView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}

- (void)createView {
    if(!_pickerView) {
        LJTreeNode *node = [[LJTreeNode alloc] initWithPlistFile:[[NSBundle mainBundle] pathForResource:@"ProvincesCitiesAreas" ofType:@"plist"]];
        self.treeNode = node;
        
        _pickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
//        _pickerView.showsSelectionIndicator = YES;
        [self addSubview:_pickerView];
    }
}

#pragma mark - getter and setter

- (NSString *)area {
    return [self.areaComponents componentsJoinedByString:@" "];
}

- (NSArray<NSString *> *)areaComponents {
    NSMutableArray<NSString *> *result = [@[] mutableCopy];
    LJTreeNode *node = _selectedNode;
    while (node && node.value) {
        [result insertObject:node.value atIndex:0];
        node = node.parentNode;
    }
    return result;
}

- (void)setAreaComponents:(NSArray<NSString *> *)areaComponents {
    LJTreeNode *node = [_treeNode findSubWithArray:areaComponents];
    if (!node) {
        node = _treeNode.firstLeaf;
    } else {
        node = node.firstLeaf;
    }
    self.selectedNode = node;
}

- (void)setSelectedNode:(LJTreeNode *)selectedNode {
    _selectedNode = selectedNode;
    [_pickerView reloadAllComponents];
    NSArray<LJTreeNode *> *ancestors = _selectedNode.ancestors;
    NSMutableArray<LJTreeNode *> *nodes = [ancestors mutableCopy];
    [nodes addObject:_selectedNode];
    for (NSInteger i = 0; i < (NSInteger)nodes.count-1; i++) {
        LJTreeNode *parent = nodes[i];
        LJTreeNode *sub = nodes[i+1];
        NSUInteger index = [parent.subNodes indexOfObject:sub];
        [_pickerView selectRow:index inComponent:i animated:YES];
    }
}

#pragma mark - setter and getter

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _pickerView.bounds = self.bounds;
    _pickerView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}

- (void)setTreeNode:(LJTreeNode *)treeNode {
    _treeNode = treeNode;
    self.selectedNode = _treeNode.firstLeaf;
}

- (void)setTitleAttribute:(NSDictionary *)titleAttribute {
    _titleAttribute = titleAttribute;
    [_pickerView reloadAllComponents];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return _treeNode.depth-1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray<LJTreeNode *> *ancestors = _selectedNode.ancestors;
    if (component < ancestors.count) {
        return ancestors[component].subNodes.count;
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSArray<LJTreeNode *> *ancestors = _selectedNode.ancestors;
    if (ancestors.count <= component || ancestors[component].subNodes.count <= row) {
        return;
    }
    self.selectedNode = ancestors[component].subNodes[row].firstLeaf;
    
    if (_delegate && [_delegate respondsToSelector:@selector(areaPicker:didSelectNode:)]) {
        [_delegate areaPicker:self didSelectNode:_selectedNode];
    }
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *string = @"";
    NSArray<LJTreeNode *> *ancestors = _selectedNode.ancestors;
    if (component < ancestors.count) {
        string = ancestors[component].subNodes[row].value;
    }
    return [[NSAttributedString alloc] initWithString:string
                                           attributes:_titleAttribute];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.textAlignment=NSTextAlignmentCenter;
    }
    [pickerLabel setAttributedText:[self pickerView:pickerView attributedTitleForRow:row forComponent:component]];
    
    return pickerLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

