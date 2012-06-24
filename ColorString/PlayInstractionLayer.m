//
//  InstractionLayer.m
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayInstractionLayer.h"
#import "ColorStringFuctions.h"

#define ChooseLetterText @"Target Letters:"
#define ChooseColorText  @"Target Color:"

#define QuatoFormat @"\"%@\""

#define ItalicFont @"Helvetica-BoldOblique"
#define NormalFont @"Helvetica"
#define BoldFont @"Helvetica-Bold"

static CGFloat textWidth1 = 140, textWidth2 = 140;


@implementation PlayInstractionLayer
@synthesize textLayer1, textLayer2;
@synthesize textColor;
static const CGFloat fontSize1 = 23, fontSize2 = 29;
- (CATextLayer *)textLayer1 {
    if (textLayer1) return textLayer1;
    CATextLayer *layer = [CATextLayer layer];
    [layer setFontSize:fontSize1];
    [layer setAlignmentMode:kCAAlignmentLeft];
    [layer setForegroundColor:self.textColor];
    [self addSublayer:layer];
    textLayer1 = layer;
    return textLayer1;
}
- (CATextLayer *)textLayer2 {
    if (textLayer2) return textLayer2;
    CATextLayer *layer = [CATextLayer layer];
    [layer setAlignmentMode:kCAAlignmentLeft];
    [layer setForegroundColor:self.textColor];
    [layer setFontSize:fontSize2];
    [self insertSublayer:layer
     above:self.textLayer1];
    textLayer2 = layer;
    return textLayer2;
}
- (CGColorRef)textColor {
    return [[UIColor whiteColor] CGColor];
}
- (void)setInstractionWithMode:(PlayMode)mode
                         color:(PlayColor)color
{
    NSString *colorName = nameOfColor(color);
    switch (mode) {
        case PlayModeSelectionByName:
            [self.textLayer1 setString:ChooseLetterText];
            [self.textLayer1 setFont:NormalFont];
            [self.textLayer2 setString:[NSString stringWithFormat:QuatoFormat, colorName]];
            [self.textLayer2 setFont:ItalicFont];
            textWidth1 = 150;
            break;
        case PlayModeSelectionByColor:
            [self.textLayer1 setString:ChooseColorText];
            [self.textLayer1 setFont:NormalFont];
            [self.textLayer2 setString:colorName];
            [self.textLayer2 setFont:ItalicFont];
            textWidth1 = 135;
            break;
    }
}
#pragma mark -
- (id)init
{
    self = [super init];
    if (self) {
        UIColor *borderColor = [UIColor grayColor];
        [self setBorderColor:borderColor.CGColor];
    }
    
    return self;
}

- (void)layoutSublayers {
    CGFloat x, y;
    CGFloat height = CGRectGetHeight(self.bounds);
    x = 0;
    y = (height - fontSize1) / 2;
    [self.textLayer1 setFrame:CGRectMake(x, y, textWidth1, fontSize1)];
    x += textWidth1;
    y = (height - fontSize2) / 2;
    [self.textLayer2 setFrame:CGRectMake(x, y, textWidth2, fontSize2)];
}
@end
