//
//  HowToPlayScene.m
//  UpAndDownGame
//
//  Created by Mac on 2011/8/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HowToPlayScene.h"
#import "Menu.h"

@implementation HowToPlayScene
+(CCScene *) scene{
    CCScene *scene = [CCScene node];
    HowToPlayScene *layer = [HowToPlayScene node];
    [scene addChild:layer];
    return scene;
}
-(id)init{
    if ((self = [super init])) {
        //set background
        Bg = [CCSprite spriteWithFile:@"Bg2(UDG).png"];
        Bg.position = ccp(240, 160);
        [self addChild:Bg z:-1];
        //set "Back to menu item"
        backToMenuText = [CCLabelTTF labelWithString:@"Back to menu" fontName:@"AT" fontSize:18];
        backToMenu = [CCMenuItemLabel itemWithLabel:backToMenuText target:self selector:@selector(back:)];
        backToMenu.position = ccp(400,18);
        menu = [CCMenu menuWithItems:backToMenu, nil];
        menu.position = ccp(0,0);
        [self addChild:menu];
    }
    return self;
}
-(void)back:(id)selector{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionSlideInR transitionWithDuration:0.5 scene:[Menu node]]];
}
-(void)dealloc{
    [super dealloc];
}
@end
