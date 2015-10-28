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
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self addSubview:_pickerView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self addSubview:_pickerView];
    }
    return self;
}

- (NSString *)selectedArea {
    NSMutableString *result = [@"" mutableCopy];
    LJTreeNode *node = _selectedNode;
    while (node) {
        [result insertString:node.value atIndex:0];
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
    _selectedNode = ancestors[component].subNodes[row].firstLeaf;
    [_pickerView reloadAllComponents];
    for (NSInteger i = component+1; i < (NSInteger)_pickerView.numberOfComponents; i++) {
        [_pickerView selectRow:0 inComponent:i animated:YES];
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
