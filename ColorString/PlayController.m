//
//  PlayController.m
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayController.h"
#import "ColorStringEnums.h"
#import "ColorStringFuctions.h"
#import "GADRequest.h"

@interface PlayController(private)
@property(nonatomic, readonly)PlayView *view;
@property(nonatomic, readonly)NSArray *cards;
- (void)clearPuzzle;
- (void)startNextPuzzle;
- (void)timeDidUp:(NSTimer *)timer;
- (void)stopTimer;
- (void)puzzleDidSolve;

PlayColor nextColor(int seed);
PlayMode nextMode(int seed);
NSString *nextFontName(int seed);
@end


@implementation PlayController
@synthesize cardInFocus;
@synthesize unsolvedCards;
@synthesize timer;
@synthesize timeupView, epilogView;
@synthesize interactionDiabled;
@synthesize bestScore, score;
@synthesize currentLevel;

- (void)setCardInFocus:(PlayCardLayer *)card {
    if ([cardInFocus isEqual:card]) return;
    cardInFocus.focused = NO;
    card.focused = YES;
    cardInFocus = card;
}
- (NSMutableArray *)unsolvedCards {
    if (unsolvedCards) return unsolvedCards;
    unsolvedCards = [[NSMutableArray alloc] initWithCapacity:[self.cards count]];
    return unsolvedCards;
}
- (PlayTimeupView *)timeupView {
    if (timeupView) return timeupView;
    timeupView = [[PlayTimeupView alloc] init];
    return timeupView;
}
- (PlayEpilogeView *)epilogView {
    if (epilogView) return epilogView;
    epilogView = [[PlayEpilogeView alloc] init];
    [epilogView.retryButton addTarget:self 
                               action:@selector(startNextPuzzle)
                     forControlEvents:UIControlEventTouchUpInside];
    
    return epilogView;
}
- (void)setScore:(NSInteger)newScore {
    score = newScore;
    [self.view.scoreLayer setScore:score];
}
- (NSInteger)currentLevel {
    return score / 10 + 1;
}
#pragma mark - 
- (void)dealloc {
    [timeupView release];
    [epilogView release];
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {
        [self setScore:0];
    }
    
    return self;
}
- (void)loadView {
    PlayView *view = [[[PlayView alloc] init] autorelease];
    [self setView:view];
}
- (void)viewDidAppear:(BOOL)animated{
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    [self.view setNeedsDisplay];
    [self.view layoutSubviews];
    
    [self startNextPuzzle];
}
#pragma mark -
- (void)touchesBegan:(NSSet *)touches 
           withEvent:(UIEvent *)event
{
    if (interactionDiabled) return;
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];   
    self.cardInFocus = [self.view hitCard:touchPoint];
}
- (void)touchesMoved:(NSSet *)touches 
           withEvent:(UIEvent *)event
{
    if (interactionDiabled) return;
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];  
    
    if (self.cardInFocus) {
        BOOL canceled = !CGRectContainsPoint(self.cardInFocus.frame, touchPoint);
        if (canceled) {
            self.cardInFocus = nil;
            return;
        }
    } else {        
        PlayCardLayer *card = [self.view hitCard:touchPoint];
        if (!card) return;
        self.cardInFocus = card;
    }
}
- (void)touchesEnded:(NSSet *)touches 
           withEvent:(UIEvent *)event
{
    if (interactionDiabled) return;
    PlayCardLayer *card = [self cardInFocus];
    CGPoint messagePosition = CGPointMake(CGRectGetMaxX(card.frame) - 40,
                                          CGRectGetMinY(card.frame) + 10);
    if (!self.cardInFocus) return;
    if (card.isTarget) {
        [self.unsolvedCards removeObject:card];
        self.score += 1;
        if(self.bestScore < self.score) self.bestScore = self.score;
        [self.view showMessage:PlayMessageOK
                      position:messagePosition];
        [card setHidden:YES];
        self.cardInFocus = nil;
        
        if ([self.unsolvedCards count] == 0){
            
            [self stopTimer];
            [self performSelector:@selector(puzzleDidSolve)
                       withObject:nil
                       afterDelay:0.2];
        }
    } else {
        [self.view showMessage:PlayMessageNG
                      position:messagePosition];
        [card shake];
        self.cardInFocus = nil;
    }
}
@end


@implementation PlayController(private)
@dynamic view;
@dynamic cards;
- (PlayView *)view {
    return (PlayView *)super.view;
}
- (NSArray *)cards {
    return self.view.cards;
}
#pragma mark -
- (void)clearPuzzle {
    interactionDiabled = NO;
    [self.unsolvedCards removeAllObjects];
    [self.view hideMessage];
    [self.view hideModalBox];
    [self stopTimer];
    [self.view hideBlockerView];
    
}
- (void)startNextPuzzle {
    [self clearPuzzle];
    [self.view setNeedsDisplay];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    srand([[NSDate date] timeIntervalSinceReferenceDate]);  
    PlayMode mode = nextMode(rand());
    PlayColor color = nextColor(rand() * rand());
    [self.view.instractionLayer setInstractionWithMode:mode
                                                 color:color];
    
    srand([[NSDate date] timeIntervalSinceReferenceDate]);  
    int hitIndex = rand() % [self.cards count]; //least one card target
    
    
    
    for (NSInteger index = 0; index < [self.cards count]; index++) {
        PlayCardLayer *card = [self.cards objectAtIndex:index];
        srand([[NSDate date] timeIntervalSinceReferenceDate]);  
        int seed = rand() * index ^ 2;
        [card setHidden:NO];
        
        PlayColor cardColorName = nextColor(seed);
        PlayColor cardFontColor = nextColor(seed*rand() + index);
        [card setColorName:cardColorName];
        [card setFontColor:cardFontColor];
        
        
        switch (mode) {
            case PlayModeSelectionByName:
                if (index == hitIndex)card.colorName = color;
                card.isTarget = (color == card.colorName);
                break;
            case PlayModeSelectionByColor:
                if (index == hitIndex)card.fontColor = color;
                card.isTarget = (color == card.fontColor);
                break;
        }
        if (card.isTarget){
            [self.unsolvedCards addObject:card];
        }
        
        NSString *fontName = nextFontName(seed + index ^ 2);
        [card.textLayer setFont:fontName];
    }
    
    NSTimeInterval interval = 6 + 3 / (self.currentLevel);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                  target:self
                                                selector:@selector(timeDidUp:)
                                                userInfo:nil
                                                 repeats:NO];
    
    [self.view.timeLayer startWithInterval:interval];
    
    [CATransaction commit];
    
}
- (void)timeDidUp:(NSTimer *)timer {
    interactionDiabled = YES;
    self.timer = nil;
    [self.view.timeLayer pause];
    [self.view.messageLayer setMessage:PlayMessageNone];
    [self.view showBlockerViewFromRight:self.timeupView];
    [self.epilogView setScore:self.score];
    [self.epilogView setBestScore:self.bestScore];
    [self.view performSelector:@selector(showModalBox:)
                    withObject:self.epilogView
                    afterDelay:1];
}
- (void)stopTimer {
    [self.view.timeLayer pause];
    if ([self.timer isValid]) [self.timer invalidate];
    self.timer = nil;
    
}


- (void)puzzleDidSolve {
    [self.view hideAllCards];
    [self.view showMessage:PlayMessageClear
                  position:CGPointMake(80, 155)];
    [self performSelector:@selector(startNextPuzzle)
               withObject:nil 
               afterDelay:0.8f];
    
    
}
PlayColor nextColor(int seed) {
    return abs(seed) % 10;
}
PlayMode nextMode(int seed) {
    return abs(seed) % 2;
}
NSString *nextFontName(int seed){
    NSArray *fontNames = allFontNames();
    NSInteger index =  abs(seed ^ 2 + seed) % [fontNames count];
    NSString *fontName = [fontNames objectAtIndex:index];
    return fontName;
}
@end