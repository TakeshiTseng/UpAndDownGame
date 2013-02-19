//
//  Menu.m
//  UpAndDownGame
//
//  Created by Mac on 2011/8/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Menu.h"
#import "HowToPlayScene.h"
#import "HighScoreScene.h"
#import "GameScene.h"
@implementation Menu
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
    Menu *layer = [Menu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        //set background
        bg = [CCSprite spriteWithFile:@"Bg(UDG).png"];
        bg.position = ccp(240, 160);
        [self addChild:bg];
        //
        ccColor3B black = ccc3(0, 0, 0);
        //set title
        Title = [CCLabelTTF labelWithString:@"Up Or Down?" fontName:@"AT" fontSize:64];
        Title.color = black;
        Title.position = ccp(240, 240);
        [self addChild:Title];
        //
        //set menu item
        StartText = [CCLabelTTF labelWithString:@"Start" fontName:@"AT" fontSize:30];
        StartText.color = black;
        Start = [CCMenuItemLabel itemWithLabel:StartText target:self selector:@selector(startGame:)];
        Start.position = ccp(240, 130);
        
        HighScoreText = [CCLabelTTF labelWithString:@"High score" fontName:@"AT" fontSize:30];
        HighScoreText.color = black;
        HighScore = [CCMenuItemLabel itemWithLabel:HighScoreText target:self selector:@selector(highScore:)];
        HighScore.position = ccp(240, 100);
        
        HowToPlayText = [CCLabelTTF labelWithString:@"How to play?" fontName:@"AT" fontSize:30];
        HowToPlayText.color = black;
        HowToPlay = [CCMenuItemLabel itemWithLabel:HowToPlayText target:self selector:@selector(howToPlay:)];
        HowToPlay.position = ccp(240, 70);
        menu = [CCMenu menuWithItems:Start,HighScore,HowToPlay, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu];
        
	}
	return self;
}
-(void)startGame:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[GameScene node]]];
}
-(void)highScore:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionSlideInB transitionWithDuration:0.5 scene:[HighScoreScene node]]];
}
-(void)howToPlay:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionSlideInL transitionWithDuration:0.5 scene:[HowToPlayScene node]]];
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
