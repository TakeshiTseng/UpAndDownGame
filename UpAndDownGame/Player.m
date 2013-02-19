//
//  Player.m
//  UpAndDownGame
//
//  Created by Mac on 2011/8/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player
@synthesize life;
@synthesize goingUP;
@synthesize v_y;
-(id)InitPlayerAtY:(int)y{
    if((self = [super initWithFile:@"Arrow.png"])){
        PlayerY= y;
        life = 10;
        v_y = 0;
        goingUP = NO;
    }
    return self;
}
+(id)initPlayerAtY:(int)y{
    return [[Player alloc]InitPlayerAtY:y];
}
-(void)running{
    PlayerY = PlayerY + (v_y*1/60);
    v_y = v_y - 1.5;
    if(v_y > 150){
        v_y = 150;
    }
    else if(v_y < -150){
        v_y = -150;
    }
    if (PlayerY<0) {
        PlayerY = 0;
        v_y = 0;
    }
    else if(PlayerY > 320){
        PlayerY = 320;
        v_y=0;
    }
//    NSLog([NSString stringWithFormat:@"y = %f v = %f\n",PlayerY,v_y]);
    self.position = ccp(100, (int)PlayerY);
}
-(void)up{
    if(goingUP){
        v_y += 3.5;
    }
}
@end
