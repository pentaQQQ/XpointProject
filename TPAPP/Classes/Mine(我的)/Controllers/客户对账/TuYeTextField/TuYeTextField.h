//
//  TuYeTextField.h
//  impi
//
//  Created by Chris on 15/4/15.
//  Copyright (c) 2015年 Zoimedia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TuYeTextField;

@protocol TuYeTextFieldDelegate <UITextFieldDelegate>

@optional
- (BOOL)textFieldShouldBeginEditing:(TuYeTextField *)textField;
- (void)textFieldDidBeginEditing:(TuYeTextField *)textField;

- (BOOL)textFieldShouldEndEditing:(TuYeTextField *)textField;
- (void)textFieldDidEndEditing:(TuYeTextField *)textField;

- (BOOL)textFieldShouldReturn:(TuYeTextField *)textField;

@end

@interface TuYeTextField : UITextField

@end
