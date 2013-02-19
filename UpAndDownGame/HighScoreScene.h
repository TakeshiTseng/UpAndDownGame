//
//  HighScoreScene.h
//  UpAndDownGame
//
//  Created by Mac on 2011/8/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HighScoreScene : CCLayer {
    CCLabelTTF *backToMenuText;
    CCMenuItem *backToMenu;
    CCMenu *menu;
    CCSprite *Bg;
    CCLabelTTF *title;
}
+(CCScene *)scene;
-(void)back:(id)selector;
@end
