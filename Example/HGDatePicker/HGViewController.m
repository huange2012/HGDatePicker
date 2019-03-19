//
//  HGViewController.m
//  HGDatePicker
//
//  Created by huange on 03/19/2019.
//  Copyright (c) 2019 huange. All rights reserved.
//

#import "HGViewController.h"
#import "HGDataPickerViewController.h"

@interface HGViewController ()

@end

@implementation HGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(0, 80, 80, 40);
    [btn addTarget:self action:@selector(showDateView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showDateView {
    HGDataPickerViewController *dataPicker = [HGDataPickerViewController new];
    
    
    dataPicker.selectedDate = ^(NSString * _Nonnull dateString) {
        NSLog(@"selected: %@",dateString);
    };
    UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:dataPicker];
    
    [self presentViewController:NC animated:YES completion:nil];
}

@end
