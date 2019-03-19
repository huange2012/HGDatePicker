//
//  WYDataPickerViewController.h
//  Finder
//
//  Created by huange on 2019/3/8.
//  Copyright © 2019 huange. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CompleteSelectedDate) (NSString *dateString);

@interface WYDataPickerViewController : UIViewController

@property (nonatomic, copy) CompleteSelectedDate selectedDate;

@end

NS_ASSUME_NONNULL_END
