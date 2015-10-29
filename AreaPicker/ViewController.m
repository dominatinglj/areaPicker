//
//  ViewController.m
//  AreaPicker
//
//  Created by 廖军 on 15/10/28.
//  Copyright © 2015年 com.qiang. All rights reserved.
//

#import "ViewController.h"
#import "LJTreeNode.h"
#import "AreaPicker.h"

@interface ViewController ()<AreaPickerDelegate>
{
    UILabel *_label;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    AreaPicker *picker = [[AreaPicker alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
//    picker.treeNode = node;
    picker.titleAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    picker.delegate = self;
    [self.view addSubview:picker];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    _label.textColor = [UIColor blackColor];
    _label.text = @"选中区域";
    [self.view addSubview:_label];
}

- (void)areaPicker:(AreaPicker *)areaPicker didSelectNode:(LJTreeNode *)node {
    _label.text = areaPicker.area;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
