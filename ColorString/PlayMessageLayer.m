//
//  PlayMessageLayer.m
//  ColorString
//
//  Created by Taka Okunishi on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayMessageLayer.h"

#define OKMessage @"OK"
#define NGMessage @"NG"
#define NonMessage @""
#define ClearMessage @"Clear!"

#define BoldFont @"Helvetica-Bold"

@implementation PlayMessageLayer
@synthesize textLayer;
@synthesize message;
@synthesize fitSize;
- (CATextLayer *)textLayer {
    if (textLayer) return textLayer;
    CATextLayer *layer = [CATextLayer layer];
    [layer setAlignmentMode:kCAAlignmentCenter];
    [layer setFont:BoldFont];
    [self addSublayer:layer];
    textLayer = layer;
    return textLayer;
}
- (void)setMessage:(PlayMessage)newMessage {
    message = newMessage;
    NSString *string;
    UIColor *color;
    CGFloat fontSize;
    switch (message) {
        case PlayMessageOK:
            string = OKMessage;
            color = [UIColor greenColor];
            fontSize = 12;
            self.fitSize = CGSizeMake(40, 40);
            break;
        case PlayMessageNG:
            string = NGMessage;
            color = [UIColor redColor];
            fontSize = 12;
            self.fitSize = CGSizeMake(40, 40);
            break;
        case PlayMessageNone:
            string = NonMessage;
            color = [UIColor blackColor];
            fontSize = 0;
            self.fitSize = CGSizeZero;
            break;
        case PlayMessageClear:
            string = ClearMessage;
            color = [UIColor whiteColor];
            fontSize = 44;
            self.fitSize = CGSizeMake(120, 120);
    }
    [self.textLayer setString:string];
    [self.textLayer setForegroundColor:color.CGColor];
    [self.textLayer setFontSize:fontSize];
    [self setNeedsDisplay];
}
#pragma mark -
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (void)layoutSublayers {
    CGFloat x, y;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    static const CGFloat textHeight = 40;
    
    x = 0;
    y = (height - textHeight) / 2;
    [self.textLayer setFrame:CGRectMake(x, y, width, textHeight)];
}

@end
