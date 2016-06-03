//
//  ThouStockKeyboard.m
//  ThouTool
//
//  Created by Thou on 16/3/7.
//  Copyright © 2016年 thou. All rights reserved.
//  自定义键盘

#import "ThouStockKeyboard.h"
#import "ThouThemeManager.h"
#import "UIButton+Color.h"
#import "UIView+Layout.h"
#import "MacroConst.h"

#define kKeyBoardHeight 216
#define kLineWidth 1
#define kNumFont [UIFont systemFontOfSize:27]

#define kASCIIButtonTag 9000
#define kShiftButtonTag 10000
#define kDeleteButtonTag 10001
#define kChangeButtonTag 10002
#define kSpaceButtonTag 10003
#define kReturnButtonTag 10004

#define kColorNormal [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1]
#define kColorHightlighted [UIColor colorWithRed:186.0/255 green:189.0/255 blue:194.0/255 alpha:1.0]

typedef NS_ENUM(NSInteger,ThouStockKeyboardShiftState){
    ThouStockKeyboardShiftStateLower,
    ThouStockKeyboardShiftStateUpper,
    ThouStockKeyboardShiftStateAlwaysUpper
};

@interface ThouStockKeyboard()

@property (nonatomic) ThouStockKeyboardShiftState shiftButtonState;

@property (nonatomic,retain) UIButton *dismissButton;

@property (nonatomic,retain) UIView *numKeyboard;
@property (nonatomic,retain) UIView *charKeyboard;

@property (nonatomic,retain) UIButton *shiftButton;

@end

@implementation ThouStockKeyboard

- (instancetype)initWithInputView:(id<UITextInputExtendRange>)view
{
    if (self = [super initWithFrame:CGRectMake(0, 0, UIScreenWidth, kKeyBoardHeight)]) {
        [self buildSubviews];
        [self setInputView:view];
    }
    return self;
}

- (void)buildSubviews
{
    _numKeyboard = [[UIView alloc] initWithFrame:self.bounds];
    _numKeyboard.tag = ThouStockKeyboardTypeNumber;
    _numKeyboard.hidden = NO;
    [super addSubview:_numKeyboard];
    
    _charKeyboard = [[UIView alloc] initWithFrame:self.bounds];
    _numKeyboard.tag = ThouStockKeyboardTypeCharacter;
    _charKeyboard.hidden = YES;
    [super addSubview:_charKeyboard];
    
    [self makeNumKeyboard];
    [self makeCharKeyboard];
}

- (void)changeKeyboard
{
    self.numKeyboard.hidden = !self.numKeyboard.hidden;
    self.charKeyboard.hidden = !self.charKeyboard.hidden;
    if ([self.delegate respondsToSelector:@selector(keyboard:changeType:)]) {
        [self.delegate keyboard:self changeType:ThouStockKeyboardTypeNumber];
    }
}

#pragma mark - 创建数字键盘
- (void)makeNumKeyboard
{
    for (int j=0; j<4; j++)
    {
        for (int i=0; i<3; i++)
        {
            UIButton *numButton = [self creatButtonWithPosition:CGPointMake(i, j)];
            [_numKeyboard addSubview:numButton];
        }
    }
    
    UIColor *color = [UIColor colorWithRed:188/255.0 green:192/255.0 blue:199/255.0 alpha:1];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(UIScreenWidth/3, 0, kLineWidth, self.bounds.size.height)];
    line1.backgroundColor = color;
    [_numKeyboard addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(UIScreenWidth/3*2, 0, kLineWidth, self.bounds.size.height)];
    line2.backgroundColor = color;
    [_numKeyboard addSubview:line2];
    
    for (int i=0; i<4; i++)
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height/4*i+1, UIScreenWidth, kLineWidth)];
        line.backgroundColor = color;
        [_numKeyboard addSubview:line];
    }
}

-(UIButton *)creatButtonWithPosition:(CGPoint)position
{
    int i = position.x;
    int j = position.y;
    CGFloat width = UIScreenWidth / 3;
    CGFloat height = self.bounds.size.height / 4;
    CGFloat x = i * width;
    CGFloat y = j * height;
    CGRect frame = CGRectMake(x, y, width, height);
    
    UIButton *numButton = [[UIButton alloc] initWithFrame:frame];
    [numButton addTarget:self action:@selector(clickNumberButton:) forControlEvents:UIControlEventTouchUpInside];
    numButton.tag = i + j * 3 + 1;
    NSString *numTitle = [NSString stringWithFormat:@"%zd",numButton.tag];
    if (numButton.tag<10)
    {
        [numButton setTitle:numTitle forState:UIControlStateNormal];
    }else if (numButton.tag == 11){
        [numButton setTitle:@"0" forState:UIControlStateNormal];
    }else if (numButton.tag == 10){
        [numButton setTitle:@"ABC" forState:UIControlStateNormal];
    }else if (numButton.tag == 12){
        [numButton setTitle:@"X" forState:UIControlStateNormal];
    }
    [numButton setTitleColor:thouBlackColor forState:UIControlStateNormal];
    
    if (numButton.tag == 10 || numButton.tag == 12)
    {
        [numButton setButtonColor:kColorHightlighted highLightColor:kColorNormal];
    }else{
        [numButton setButtonColor:kColorNormal highLightColor:kColorHightlighted];
    }
    return numButton;
}

-(void)clickNumberButton:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:
        {
            [self changeKeyboard];
        }
            break;
        case 12:
            [self inputViewBackspace];
            break;
        default:
            [self inputViewOutput:sender.titleLabel.text];
            break;
    }
}

#pragma mark - 创建字母键盘

#define kKeyTopPad  10
#define kKeyBottomPad  0
#define kButtonSideVerticalEdge  8
#define kButtonSideHorizontalEdge  3

#define kButtonWidth (UIScreenWidth / 10 - 2 * kButtonSideHorizontalEdge)
#define kButtonHeight ((self.bounds.size.height - kKeyTopPad - kKeyBottomPad) / 4 - 2 * kButtonSideVerticalEdge)
- (void)makeCharKeyboard
{
    NSArray *firstColumn = @[@"q", @"w", @"e", @"r", @"t", @"y", @"u", @"i", @"o", @"p"];
    [self buildColumn:0 withTitles:firstColumn buttonPad:0];
    
    NSArray *secondColumn = @[@"a", @"s", @"d", @"f", @"g", @"h", @"j", @"k", @"l"];
    [self buildColumn:1 withTitles:secondColumn buttonPad: (kButtonWidth + 2 * kButtonSideHorizontalEdge) / 2];
    
    
    NSArray *thirdColumn = @[@"z", @"x", @"c", @"v", @"b", @"n", @"m"];
    [self buildColumn:2 withTitles:thirdColumn buttonPad: 3 * (kButtonWidth + 2 * kButtonSideHorizontalEdge) / 2];
    
    [self spaceColumn];
    
    [self addExtraMapButton];
}

- (void)buildColumn:(NSInteger)column withTitles:(NSArray *)titils buttonPad:(CGFloat)pad
{
    CGFloat width = kButtonWidth;
    CGFloat height = kButtonHeight;
    for (NSInteger i = 0; i < titils.count; i++) {
        CGFloat x = kButtonSideHorizontalEdge * (2 * i+1) + i * width + pad;
        CGFloat y = kKeyTopPad + kButtonSideVerticalEdge * (2 * column+1) + column * height;
        UIButton *charButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [charButton addTarget:self action:@selector(clickCharButton:) forControlEvents:UIControlEventTouchUpInside];
        charButton.tag = kASCIIButtonTag;
        [charButton setTitle:titils[i] forState:UIControlStateNormal];
        [charButton setTitleColor:thouBlackColor forState:UIControlStateNormal];
        
        [charButton setButtonColor:kColorNormal highLightColor:kColorHightlighted];
        
        charButton.layer.cornerRadius = charButton.height * 0.1;
        charButton.layer.masksToBounds = YES;
        
        [_charKeyboard addSubview:charButton];
    }
}

- (void)spaceColumn
{
    NSInteger column = 3;
    NSArray *titils = @[@"空格"];
    CGFloat height = kButtonHeight;
    CGFloat x = 5 * (kButtonWidth + 2 * kButtonSideHorizontalEdge) / 2;
    CGFloat width = UIScreenWidth - 2 * x;
    CGFloat y = kKeyTopPad + kButtonSideVerticalEdge * (2 * column+1) + column * height;
    
    UIButton *charButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [charButton addTarget:self action:@selector(clickCharButton:) forControlEvents:UIControlEventTouchUpInside];
    charButton.tag = kSpaceButtonTag;
    [charButton setTitle:titils[0] forState:UIControlStateNormal];
    [charButton setTitleColor:thouBlackColor forState:UIControlStateNormal];
    
    [charButton setButtonColor:kColorNormal highLightColor:kColorHightlighted];
    
    charButton.layer.cornerRadius = charButton.height * 0.1;
    charButton.layer.masksToBounds = YES;
    
    [_charKeyboard addSubview:charButton];
}

- (void)addExtraMapButton
{
    // shift键
    NSInteger column = 2;
    CGFloat height = kButtonHeight;
    CGFloat width = kButtonWidth * 1.3;
    CGFloat x = kButtonSideHorizontalEdge;
    CGFloat y = kKeyTopPad + kButtonSideVerticalEdge * (2 * column+1) + column * height;
    
    _shiftButtonState = ThouStockKeyboardShiftStateLower;
    UIButton *shiftButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [shiftButton addTarget:self action:@selector(clickCharButton:) forControlEvents:UIControlEventTouchUpInside];
    shiftButton.tag = kShiftButtonTag;
    [shiftButton setImage:ThemeImage(@"/keyboard/shift_keyboard") forState:UIControlStateNormal];
    [shiftButton setButtonColor:kColorHightlighted];
    
    shiftButton.layer.cornerRadius = shiftButton.height * 0.1;
    shiftButton.layer.masksToBounds = YES;
    
    [_charKeyboard addSubview:shiftButton];
    _shiftButton = shiftButton;
    
    // delete键
    x = UIScreenWidth - width - kButtonSideHorizontalEdge;
    
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [deleteButton addTarget:self action:@selector(clickCharButton:) forControlEvents:UIControlEventTouchUpInside];
    deleteButton.tag = kDeleteButtonTag;
    [deleteButton setImage:ThemeImage(@"/keyboard/delete_keyboard") forState:UIControlStateNormal];
    [deleteButton setButtonColor:kColorHightlighted highLightColor:kColorNormal];
    
    deleteButton.layer.cornerRadius = deleteButton.height * 0.1;
    deleteButton.layer.masksToBounds = YES;
    
    [_charKeyboard addSubview:deleteButton];
    
    
    column = 3;
    // 切换键盘键
    x = kButtonSideHorizontalEdge;
    y = kKeyTopPad + kButtonSideVerticalEdge * (2 * column+1) + column * height;
    width = (kButtonWidth + kButtonSideHorizontalEdge ) * 2.5;
    
    UIButton *changeButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [changeButton addTarget:self action:@selector(clickCharButton:) forControlEvents:UIControlEventTouchUpInside];
    changeButton.tag = kChangeButtonTag;
    [changeButton setTitle:@"123" forState:UIControlStateNormal];
    [changeButton setTitleColor:thouBlackColor forState:UIControlStateNormal];
    [changeButton setButtonColor:kColorHightlighted highLightColor:kColorNormal];
    
    changeButton.layer.cornerRadius = changeButton.height * 0.1;
    changeButton.layer.masksToBounds = YES;
    
    [_charKeyboard addSubview:changeButton];
    
    // 确定键
    x = UIScreenWidth - width - kButtonSideHorizontalEdge;
    
    UIButton *returnButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [returnButton addTarget:self action:@selector(clickCharButton:) forControlEvents:UIControlEventTouchUpInside];
    returnButton.tag = kReturnButtonTag;
    [returnButton setTitle:@"确定" forState:UIControlStateNormal];
    [returnButton setTitleColor:thouBlackColor forState:UIControlStateNormal];
    [returnButton setButtonColor:kColorHightlighted highLightColor:kColorNormal];
    
    returnButton.layer.cornerRadius = returnButton.height * 0.1;
    returnButton.layer.masksToBounds = YES;
    
    [_charKeyboard addSubview:returnButton];
}

- (void)switchShiftButtonState
{
    _shiftButtonState ++;
    if (_shiftButtonState > ThouStockKeyboardShiftStateAlwaysUpper) {
        _shiftButtonState = ThouStockKeyboardShiftStateLower;
    }
    // 根据键盘状态设值shift键图标及背景色
    if (_shiftButtonState == ThouStockKeyboardShiftStateLower) {
        [_shiftButton setButtonColor:kColorHightlighted];
        [_shiftButton setImage:ThemeImage(@"/keyboard/shift_keyboard") forState:UIControlStateNormal];
    }else if(_shiftButtonState == ThouStockKeyboardShiftStateUpper){
        [_shiftButton setButtonColor:kColorNormal];
        [_shiftButton setImage:ThemeImage(@"/keyboard/shift_keyboard_up") forState:UIControlStateNormal];
    }else if(_shiftButtonState == ThouStockKeyboardShiftStateAlwaysUpper){
        [_shiftButton setButtonColor:kColorNormal];
        [_shiftButton setImage:ThemeImage(@"/keyboard/shift_keyboard_alwaysUP") forState:UIControlStateNormal];
    }
}

- (void)clickCharButton:(UIButton *)sender
{
    switch (sender.tag) {
        case kShiftButtonTag:
        {
            [self switchShiftButtonState];
            WEAKSELF
            [_charKeyboard.subviews enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.tag != kASCIIButtonTag) {
                    return;
                }
                if(__weakSelf.shiftButtonState != ThouStockKeyboardShiftStateLower){
                    NSString *title = [obj.titleLabel.text uppercaseString];
                    [obj setTitle:title forState:UIControlStateNormal];
                }else{
                    NSString *title = [obj.titleLabel.text lowercaseString];
                    [obj setTitle:title forState:UIControlStateNormal];
                }
            }];
        }
            break;
        case kDeleteButtonTag:
            [self inputViewBackspace];
            break;
        case kChangeButtonTag:
        {
            [self changeKeyboard];
        }
            break;
        case kSpaceButtonTag:
            [self inputViewOutput:@" "];
            break;
        case kReturnButtonTag:
            [self inputViewResignFirstResponse];
            break;
        default:
        {
            [self inputViewOutput:sender.titleLabel.text];
            if(self.shiftButtonState == ThouStockKeyboardShiftStateUpper){
                //大写状态下输入一个字符就切换到小写
                self.shiftButtonState++;       //此时状态为ThouStockKeyboardShiftStateAlwaysUpper，再切换就到了ThouStockKeyboardShiftStateLower
                [self clickCharButton:_shiftButton];
            }
        }
            break;
    }
}

#pragma mark - 创建收起键盘按钮
- (UIView *)addToolBar
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = 40;
    
    NSInteger rightPad = 10;
    NSInteger sideLength = 20;
    NSInteger x = UIScreenWidth - sideLength - rightPad;
    NSInteger y = (height - sideLength) / 2;
    CGRect frame = CGRectMake(x, y, sideLength, sideLength);
    _dismissButton = [[UIButton alloc] initWithFrame:frame];
    [_dismissButton addTarget:self action:@selector(inputViewResignFirstResponse) forControlEvents:UIControlEventTouchUpInside];
    [_dismissButton setImage:ThemeImage(@"/keyboard/down_keyboard") forState:UIControlStateNormal];
    
    frame = CGRectMake(0, 0, width, height);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view addSubview:_dismissButton];
    return view;
}

#pragma mark - inputView处理
- (void)setInputView:(id<UITextInputExtendRange>)inputView
{
    _inputView = inputView;
    _inputView.inputView = self;
    _inputView.inputAccessoryView = [self addToolBar];
}

- (void)inputViewResignFirstResponse
{
    [self.delegate keyboardWillResignFirstResponse:self];
    [(UIView *)_inputView resignFirstResponder];
}

- (void)inputViewBackspace
{
    NSString *characters = _inputView.text;
    if (characters.length  <= 0) {
        return;
    }
    
    characters = [characters substringToIndex:characters.length - 1];
    _inputView.text = characters;
    
    if ([self.delegate respondsToSelector:@selector(keyboardBackspace:)]) {
        [self.delegate keyboardBackspace:self];
    }
}

- (void)inputViewOutput:(NSString *)character
{
    NSRange range = [_inputView selectedRange];
    NSMutableString *characters = [_inputView.text mutableCopy];
    [characters replaceCharactersInRange:range withString:character];
    _inputView.text = characters;
    range.location++;
    range.length = 0;
    _inputView.selectedRange = range;
    
    if ([self.delegate respondsToSelector:@selector(keyboard:input:)]) {
        [self.delegate keyboard:self input:character];
    }
}

@end