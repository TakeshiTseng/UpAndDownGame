//
//  GameScene.h
//  UpAndDownGame
//
//  Created by Mac on 2011/8/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"
#import "Block1.h"
#import "CCParticleSystem.h"
#import "Menu.h"
#import "SimpleAudioEngine.h"
@interface GameScene : CCLayer{
    CCSprite *Bg;
    CCSprite *Bgs;
    Player *player;
    CCArray *BlockArray;
    CCArray *BgsArray;
    CCParticleSystemPoint *ExplosinEffect;
    CCLabelTTF *Time;
    int gameSpeed;
    int liveSec;
    BOOL isGameOver;
    int blockNum;
}
+(CCScene *)scene;
-(void)gameRunning;
-(void)RandomMakeBlock;
-(void)blockRunning;
-(void)removeBlock;
-(void)hitTest;
-(void)initBgs;
-(void)gameBgDisplay;
-(void)updateTime;
-(void)gameOver;
-(void)updateHighScore;
@end
