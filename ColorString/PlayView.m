//
//  PlayView.m
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayView.h"

static const NSInteger rows = 4, colums = 3;

@implementation PlayView
#pragma mark -
@synthesize timeLayer, instractionLayer, messageLayer;
@synthesize scoreLayer;
@synthesize cards;

- (PlayTimeLayer *)timeLayer {
    if (timeLayer) return timeLayer;
    PlayTimeLayer *layer = [PlayTimeLayer layer];
    [self.layer addSublayer:layer];
    timeLayer = layer;
    return timeLayer;
}
- (PlayInstractionLayer *)instractionLayer {
    if (instractionLayer) return instractionLayer;
    PlayInstractionLayer *layer = [PlayInstractionLayer layer];
    [self.layer insertSublayer:layer
                         above:self.timeLayer];
    instractionLayer = layer;    
    return instractionLayer;
}
- (PlayMessageLayer *)messageLayer {
    if (messageLayer) return messageLayer;
    PlayMessageLayer *layer = [PlayMessageLayer layer];
    [self.layer addSublayer:layer];
    messageLayer = layer;
    return messageLayer;
}
- (PlayScoreLayer *)scoreLayer {
    if (scoreLayer) return scoreLayer;
    PlayScoreLayer *layer = [PlayScoreLayer layer];
    [self.layer addSublayer:layer];
    scoreLayer = layer;
    return scoreLayer;
}
- (NSArray *)cards {
    if (cards) return cards;
    int count = rows * colums;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger index = 0; index < count; index++) {
        PlayCardLayer *card = [PlayCardLayer layer];
        [self.layer addSublayer:card];
        [array addObject:card];
    }
    cards = [[NSArray alloc] initWithArray:array];
    return cards;
}

#pragma mark -
- (void)dealloc {
    [cards release];
    [super dealloc];
}
- (id)init {
    self = [super init];
    if  (self){
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"woodBack.png"]];
    }
    return self;
}

- (void)layoutSubviews {
    static const CGFloat padding = 12;
    CGFloat x, y;
    //    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds);
    
    static const CGFloat margin = 12;
    static const CGFloat scoreWidth = 70, scoreHeight = 20;
    x = width - scoreWidth - margin, y = margin;
    [self.scoreLayer setFrame:CGRectMake(x, y, scoreWidth, scoreHeight)];

    y += scoreHeight + margin;
    static const CGFloat timeHieght = 3 , barWidth = 300;
    static const CGFloat instractionHeight = 35;
    x = margin;
    [self.instractionLayer setFrame:CGRectMake(x, y, barWidth, instractionHeight)];
    y += instractionHeight * 0.7;
    x = margin;
    [self.timeLayer setFrame:CGRectMake(x, y, barWidth, timeHieght)];
    
//    y += timeHieght + margin * 2;
    
    
    y += instractionHeight * 0.5 + margin * 2;
    
    static const CGFloat cardWidth = 100, cardHeight = 60;
    
    CGFloat cardAreaLeft = padding + (width - padding * 2 - cardWidth * colums) / 2;
    CGFloat cardAreaTop = y;
    for (NSInteger index = 0; index < [self.cards count]; index++) {
        PlayCardLayer *card = [self.cards objectAtIndex:index];
        int colum = index % colums;
        x = cardAreaLeft + cardWidth * colum;
        if (colum > 0) x -= card.borderWidth * colum;
        int row = index / colums;
        y = cardAreaTop + cardHeight * row;
        if (row > 0) y -= card.borderWidth * row;
        [card setFrame:CGRectMake(x, y, cardWidth, cardHeight)];
        
    }
}
#pragma mark -
- (PlayCardLayer *)hitCard:(CGPoint)point {
    for (PlayCardLayer *card in self.cards) {
        BOOL hit = CGRectContainsPoint(card.frame, point);
        if (hit) return card; 
    }
    return nil;
}
- (void)hideAllCards {
    for (PlayCardLayer *card in self.cards) {
        [card setHidden:YES];
    }
}
- (void)showMessage:(PlayMessage)message 
           position:(CGPoint)position
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES]; 
    [self.messageLayer setMessage:message];
    CGRect frame = CGRectMake(position.x, 
                              position.y, 
                              self.messageLayer.fitSize.width,
                              self.messageLayer.fitSize.height);
    [self.messageLayer setFrame:frame];
    [CATransaction commit];
    
    static const CGFloat displayDuration = 0.65;
    
    CATransform3D transform = CATransform3DMakeRotation(M_PI / 10, 0, 0, 1);
    CABasicAnimation *animtion = [CABasicAnimation animationWithKeyPath:@"transform"];
    animtion.duration = displayDuration;
    animtion.fromValue = [NSValue valueWithCATransform3D:transform];
    transform = CATransform3DTranslate(transform, 0, -10, 0);
    animtion.toValue = [NSValue valueWithCATransform3D:transform];
    [self.messageLayer addAnimation:animtion
                             forKey:@"tilt"];
    [self performSelector:@selector(hideMessage)
               withObject:nil
               afterDelay:displayDuration];
}
- (void)hideMessage {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self.messageLayer setMessage:PlayMessageNone];
    [CATransaction commit];
    
}
#define ModalTag 987
- (void)showModalBox:(UIView *)modalBox {
    [self hideModalBox];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    static const CGFloat modalWidth = 180, modalHeight = 140;
    CGFloat x, y;
    x = (width - modalWidth) / 2;
    y = 160;
    [modalBox setFrame:CGRectMake(x, y, modalWidth, modalHeight)];
    [modalBox setTag:ModalTag];
    [self addSubview:modalBox];
}
- (void)hideModalBox {
    UIView *modalView = [self viewWithTag:ModalTag];
    [modalView removeFromSuperview];
}
#define BlockerTag 123
- (void)showBlockerViewFromRight:(UIView *)blockerView {
    [blockerView setFrame:self.bounds];
    [blockerView setTag:BlockerTag];
    [self addSubview:blockerView];
    CGFloat tx = CGRectGetWidth(blockerView.frame);
    CGAffineTransform transform = CGAffineTransformMakeTranslation(tx, 0);
    [blockerView setTransform:transform];
    static const NSTimeInterval duration = 0.6;
    [UIView animateWithDuration:duration
                     animations:^{
                         [blockerView setTransform:CGAffineTransformIdentity];
                     }];
    
}
- (void)hideBlockerView {
    UIView *blockerView = [self viewWithTag:BlockerTag];
    [blockerView removeFromSuperview];
}
@end


