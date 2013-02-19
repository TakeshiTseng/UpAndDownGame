//
//  Menu.h
//  UpAndDownGame
//
//  Created by Mac on 2011/8/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Menu : CCLayer {
    CCSprite *bg;
    CCMenu *menu;
    CCLabelTTF *StartText;
    CCMenuItemLabel *Start;
    CCLabelTTF *HighScoreText;
    CCMenuItemLabel *HighScore;
    CCLabelTTF *HowToPlayText;
    CCMenuItemLabel *HowToPlay;
    CCLabelTTF *Title;
}
+(CCScene *) scene;

-(void)startGame:(id)sender;
-(void)highScore:(id)sender;
-(void)howToPlay:(id)sender;
@end
