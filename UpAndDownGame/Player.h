//
//  Player.h
//  UpAndDownGame
//
//  Created by Mac on 2011/8/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCSprite {
    double PlayerY;
    double v_y;
    int life;
    BOOL goingUP;
}
@property int life;
@property BOOL goingUP;
@property double v_y;
+(id)initPlayerAtY:(int)y;
-(id)InitPlayerAtY:(int)y;
-(void)running;
-(void)up;

@end
