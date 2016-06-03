//
//  ViewController.m
//  ThouRoute
//
//  Created by shidaqian on 6/1/16.
//  Copyright © 2016 shidaqian. All rights reserved.
//

#import "ViewController.h"
#import "ThouStockKeyboard.h"

@interface ViewController () <ThouStockKeyboardDelegate>

@property (nonatomic,strong) UITextView *textView;

@property (nonatomic,strong) ThouStockKeyboard *stockKeyboard;

@end 

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.textView];
}

- (UITextView *)textView
{
    // 左边距，右边距的宏，上下边距
    if (!_textView) {
        CGRect frame = CGRectMake(50, 100, 200, 80);
        _textView = [[UITextView alloc] initWithFrame:frame];
        _textView.backgroundColor = [UIColor greenColor];
        
        _stockKeyboard = [[ThouStockKeyboard alloc] initWithInputView:_textView];
        _stockKeyboard.delegate = self;
    }
    return _textView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)keyboardWillResignFirstResponse:(UIView *)keyboard
{
    NSLog(@"%@",self.textView.text);
}

- (void)keyboardBackspace:(UIView *)keyboard
{
    NSLog(@"%@",self.textView.text);
}

- (void)keyboard:(UIView *)keyboard input:(NSString *)character
{
    NSLog(@"%@",self.textView.text);
}

@end
