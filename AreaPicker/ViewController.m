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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    AreaPicker *picker = [[AreaPicker alloc] initWithFrame:CGRectMake(0, 100, 300, 300)];
//    picker.treeNode = node;
    picker.titleAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [self.view addSubview:picker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
