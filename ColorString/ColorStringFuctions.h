//
//  ColorStringFuctions.h
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef ColorString_ColorStringFuctions_h
#define ColorString_ColorStringFuctions_h

#import "ColorStringEnums.h"

#define WhiteName @"White"
#define GreenName @"Green"
#define YellowName @"Yellow"
#define OrangeName @"Orange"
#define BlueName @"Blue"
#define RedName @"Red"
#define BrownName @"Brown"
#define GrayName @"Gray"
#define CyanName @"Cyan"
#define MagentaName @"Magenta"

#if !defined(TK_INLINE)
# if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
#  define TK_INLINE static inline
# elif defined(__MWERKS__) || defined(__cplusplus)
#  define TK_INLINE static inline
# elif defined(__GNUC__)
#  define TK_INLINE static __inline__
# else
#  define TK_INLINE static    
# endif
#endif /* !defined(TK_INLINE) */


TK_INLINE NSString *nameOfColor(PlayColor color);
TK_INLINE CGColorRef CGColorWithColor(PlayColor color);
TK_INLINE CABasicAnimation *transformAnimation(CATransform3D fromTransform,
                                               CATransform3D toTransform);
TK_INLINE NSArray *allFontNames(void);

NSString *nameOfColor(PlayColor color){
    switch (color) {
        case PlayColorWhite:
            return WhiteName;
        case PlayColorGreen:
            return GreenName;
        case PlayColorYellow:
            return YellowName;
        case PlayColorOrange:
            return OrangeName;
        case PlayColorBlue:
            return BlueName;
        case PlayColorRed:
            return RedName;
        case PlayColorBrown:
            return BrownName;
        case PlayColorGray:
            return GrayName;
        case PlayColorCyan:
            return CyanName;
        case PlayConlorMagenta:
            return MagentaName;
    }
    return nil;
}
CGColorRef CGColorWithColor(PlayColor color){
    switch (color) {
        case PlayColorWhite:
            return [[UIColor whiteColor] CGColor];
        case PlayColorGreen:
            return [[UIColor greenColor] CGColor];
        case PlayColorYellow:
            return [[UIColor yellowColor] CGColor];
        case PlayColorOrange:
            return [[UIColor orangeColor] CGColor];
        case PlayColorBlue:
            return [[UIColor blueColor] CGColor];
        case PlayColorRed:
            return [[UIColor redColor] CGColor];
        case PlayColorBrown:
            return [[UIColor brownColor] CGColor];
        case PlayColorGray:
            return [[UIColor grayColor] CGColor];
        case PlayColorCyan:
            return [[UIColor cyanColor] CGColor];
        case PlayConlorMagenta:
            return [[UIColor magentaColor] CGColor];
            
    }
    return nil;
}

CABasicAnimation *transformAnimation(CATransform3D fromTransform,
                                     CATransform3D toTransform)
{
    CABasicAnimation *animtion = [CABasicAnimation animationWithKeyPath:@"transform"];
    animtion.fromValue  = [NSValue valueWithCATransform3D:fromTransform];
    animtion.toValue = [NSValue valueWithCATransform3D:toTransform];
    return animtion;
}

NSArray *allFontNames(void){
    return [NSArray arrayWithObjects:
            @"American Typewriter"
            @"AmericanTypewriter Bold",
            @"AppleGothic",
            @"Arial",
            @"Arial Bold",
            @"Arial Bold Italic",
            @"Arial Italic",
            @"Arial Hebrew",
            @"Arial Hebrew Bold",
            @"Arial Rounded Bold",
            @"Bangla Sangam MN",
            @"Bangla Sangam MN Bold",
            @"Baskerville",
            @"Baskerville Bold",
            @"Baskerville Bold Italic",
            @"Baskerville Italic",
            @"Cochin",
            @"Cochin Bold",
            @"Cochin Bold Italic",
            @"Cochin Italic",
            @"Courier",
            @"Courier Bold",
            @"Courier Bold Oblique",
            @"Courier Oblique",
            @"Courier New",
            @"Courier New Bold",
            @"Courier New Bold Italic",
            @"Courier New Italic",
            @"Devanagari Sangam MN",
            @"Devanagari Sangam MN Bold",
            @"DB LCD Tem",
            @"Geeza Pro",
            @"Geeza Pro Bold",
            @"Georgia",
            @"Georgia Bold",
            @"Georgia Bold Italic",
            @"Georgia Italic",
            @"Gujarati Sangam MN",
            @"Gujarati Sangam MN Bold",
            @"Gurmukhi MN",
            @"Gurmukhi MN Bold",
            @"Heiti J Light",
            @"Heiti J Medium",
            @"Heiti K Light",
            @"Heiti K Medium",
            @"Heiti SC Light",
            @"Heiti SC Medium",
            @"Heiti TC Light",
            @"Heiti TC Medium",
            @"Helvetica",
            @"Helvetica Bold",
            @"Helvetica Bold Oblique",
            @"Helvetica Oblique",
            @"Helvetica Neue",
            @"Helvetica Neue Bold",
            @"Hiragino Kaku Gothic ProN W3",
            @"Hiragino Kaku Gothic ProN W6",
            @"Kannada Sangam MN",
            @"Kannada Sangam MN Bold",
            @"Malayalam Sangam MN",
            @"Malayalam Sangam MN Bold",
            @"MarkerFelt Thin",
            @"MarkerFelt Wide",
            @"Oriya Sangam MN",
            @"Oriya Sangam MN Bold",
            @"Palatino Roman",
            @"Palatino Bold",
            @"Palatino Bold Italic",
            @"Palatino Italic",
            @"Sinhala Sangam MN",
            @"Sinhala Sangam MN Bold",
            @"Tamil Sangam MN",
            @"Tamil Sangam MN Bold",
            @"Telugu Sangam MN",
            @"Telugu Sangam MN Bold",
            @"Thonbury",
            @"Thonburi Bold",
            @"Times New Roman",
            @"Times New Roman Bold",
            @"Times New Roman Bold Italic",
            @"Times New Roman Italic",
            @"Trebuchet MS",
            @"Trebuchet MS Bold Italic",
            @"Trebuchet MS Bold",
            @"Trebuchet MS Italic",
            @"Verdana",
            @"Verdana Bold",
            @"Verdana Bold Italic",
            @"Verdana Italic",
            @"Zapfino",
            nil];
}
#endif
