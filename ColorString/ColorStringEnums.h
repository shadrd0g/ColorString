//
//  ColorStringEnums.h
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef ColorString_ColorStringEnums_h
#define ColorString_ColorStringEnums_h
typedef enum _PlayColor{
    PlayColorWhite,
    PlayColorGreen,
    PlayColorYellow,
    PlayColorOrange,
    PlayColorBlue,
    PlayColorRed,
    PlayColorBrown,
    PlayColorGray,
    PlayColorCyan,
    PlayConlorMagenta
}PlayColor;


typedef enum _PlayMode{
    PlayModeSelectionByName,
    PlayModeSelectionByColor
}PlayMode;

typedef enum _PlayMessage{
    PlayMessageOK,
    PlayMessageNG,
    PlayMessageNone,
    PlayMessageClear
}PlayMessage;

#endif
