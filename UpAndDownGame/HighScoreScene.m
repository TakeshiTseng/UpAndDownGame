//
//  HighScoreScene.m
//  UpAndDownGame
//
//  Created by Mac on 2011/8/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HighScoreScene.h"
#import "Menu.h"
#import "CCParticleSystem.h"
@implementation HighScoreScene
+(CCScene *)scene{
    CCScene *scene = [CCScene node];
    HighScoreScene *layer = [HighScoreScene node];
    [scene addChild:layer];
    return scene;
}
-(id)init{
    if ((self = [super init])) {
        //set background
        Bg = [CCSprite spriteWithFile:@"Bg3(UDG).png"];
        Bg.position = ccp(240, 160);
        [self addChild:Bg z:-1];
        
        //set "Back to menu item"
        backToMenuText = [CCLabelTTF labelWithString:@"Back to menu" fontName:@"AT" fontSize:18];
        backToMenu = [CCMenuItemLabel itemWithLabel:backToMenuText target:self selector:@selector(back:)];
        backToMenu.position = ccp(400,18);
        menu = [CCMenu menuWithItems:backToMenu, nil];
        menu.position = ccp(0,0);
        [self addChild:menu];
        title = [CCLabelTTF labelWithString:@"High Score" fontName:@"AT" fontSize:35];
        title.position = ccp(240, 300);
        [self addChild:title];
        NSMutableDictionary *data;
        NSString *path;
        CCLabelTTF *tl;
        path = [[NSBundle mainBundle]pathForResource:@"Score" ofType:@"plist"];
        data = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
        int c;
        for (NSString *key in data) {
            c = [key intValue];
            tl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@     %@",key,[data objectForKey:key]] fontName:@"AT" fontSize:20];
            tl.position = ccp(240, 290-c*30);
            tl.color = ccc3(255, 255, 255);
            [self addChild:tl];
        }
    }
    return self;
}
-(void)back:(id)selector{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionSlideInT transitionWithDuration:0.5 scene:[Menu node]]];
}
-(void)dealloc{
    [super dealloc];
}
@end
