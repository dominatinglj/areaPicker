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

@synthesize selectedNode = _selectedNode;

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
    _pickerView.frame = self.bounds;
}

- (void)createView {
    if(!_pickerView) {
        LJTreeNode *node = [[LJTreeNode alloc] initWithPlistFile:[[NSBundle mainBundle] pathForResource:@"ProvincesCitiesAreas" ofType:@"plist"]];
        self.treeNode = node;
        
        _pickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        [self addSubview:_pickerView];
    }
}

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

#pragma mark - setter and getter

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _pickerView.frame = self.bounds;
}

- (void)setTreeNode:(LJTreeNode *)treeNode {
    _treeNode = treeNode;
    _selectedNode = _treeNode.firstLeaf;
    [_pickerView reloadAllComponents];
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
    _selectedNode = ancestors[component].subNodes[row].firstLeaf;
    [_pickerView reloadAllComponents];
    for (NSInteger i = component+1; i < (NSInteger)_pickerView.numberOfComponents; i++) {
        [_pickerView selectRow:0 inComponent:i animated:YES];
    }
    
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

