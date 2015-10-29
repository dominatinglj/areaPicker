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
    AreaPicker *_picker;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    _picker = [[AreaPicker alloc] init];
    _picker.frame = CGRectMake(0, 100, self.view.frame.size.width, 300);
    _picker.backgroundColor = [UIColor greenColor];
//    picker.treeNode = node;
    _picker.titleAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    _picker.delegate = self;
    [self.view addSubview:_picker];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    _label.textColor = [UIColor blackColor];
    _label.text = @"选中区域";
    [self.view addSubview:_label];
}

- (void)areaPicker:(AreaPicker *)areaPicker didSelectNode:(LJTreeNode *)node {
    _label.text = areaPicker.area;
    _picker.frame = CGRectMake(0, 100, self.view.frame.size.width, 216);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
