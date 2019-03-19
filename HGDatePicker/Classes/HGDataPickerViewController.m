//
//  WYDataPickerViewController.m
//  Finder
//
//  Created by huange on 2019/3/8.
//  Copyright © 2019 huange. All rights reserved.
//

#import "HGDataPickerViewController.h"

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#define kDevice_Is_iPhoneX   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhoneXR   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhoneX_Max   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define SCREEN_STATEBAR_H    (kDevice_Is_iPhoneX || kDevice_Is_iPhoneX_Max || kDevice_Is_iPhoneXR ? 44 : 20)
#define SCREEN_BOTTOM_H    (kDevice_Is_iPhoneX || kDevice_Is_iPhoneX_Max || kDevice_Is_iPhoneXR ? 34 : 0)
#define TITLE_VIEW_HEIGHT    (44+SCREEN_STATEBAR_H)

@interface WYDataPickerViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *yearsArray;
@property (nonatomic, strong) NSMutableArray *monthsArray;

@property (nonatomic, assign) int currentYearIndex;
@property (nonatomic, assign) int currentMonthIndex;

@end

@implementation WYDataPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initData];
    [self initUI];
}


- (void)initData {
    NSDateFormatter* yearFormatter = [[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@"yyyy"];
    int currentYear  = [[yearFormatter stringFromDate:[NSDate date]] intValue];
    
    
    //Create Years Array from 1960 to This year
    _yearsArray = [[NSMutableArray alloc] init];
    for (int i = 2018; i <= currentYear; i++) {
        [_yearsArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    self.currentYearIndex = (int)(_yearsArray.count - 1);
    //month
    NSDateFormatter* monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"MM"];
    int currentmonth  = [[monthFormatter stringFromDate:[NSDate date]] intValue];
    self.currentMonthIndex = currentmonth - 1;
    
    _monthsArray = [NSMutableArray new];
    for (int i = 1; i <= 12; i++) {
        [_monthsArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
}

- (void)initUI {
    [self setupDate];

    self.title = @"选择时间";
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(completeAction)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)setupDate {
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, TITLE_VIEW_HEIGHT, WIDTH, HEIGHT - TITLE_VIEW_HEIGHT - SCREEN_BOTTOM_H - 49)];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    [self.view addSubview:_pickerView];
    
    [self.pickerView selectRow:self.yearsArray.count - 1 inComponent:0 animated:NO];
    [self.pickerView selectRow:self.currentMonthIndex inComponent:1 animated:NO];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)completeAction {
    NSString *yearString = [self.yearsArray objectAtIndex:self.currentYearIndex];
    NSString *monthString = [self.monthsArray objectAtIndex:self.currentMonthIndex];
    NSString *selectedString = nil;
    if ([monthString integerValue] < 10) {
        selectedString = [NSString stringWithFormat:@"%@0%@", yearString, monthString];
    }else {
        selectedString = [NSString stringWithFormat:@"%@%@", yearString, monthString];
    }
    
    if (self.selectedDate) {
        self.selectedDate(selectedString);
    }
    
    
    [self back];
}

#pragma mark - data source
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;   //year + month
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (0 == component) {
        return self.yearsArray.count;
    }else {
        return self.monthsArray.count;
    }
}

#pragma mark - picker view delegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {//第一列
        NSString *yearString = self.yearsArray[row];
        
        return [NSString stringWithFormat:@"%@%@", yearString, @"年"];
    }else {
        NSString *month = self.monthsArray[row];
        return [NSString stringWithFormat:@"%@%@", month, @"月"];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (0 == component) {
        self.currentYearIndex = (int)row;
    }else {
        self.currentMonthIndex = (int)row;
    }
}

@end
