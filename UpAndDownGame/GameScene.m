//
//  GameScene.m
//  UpAndDownGame
//
//  Created by Mac on 2011/8/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "CCTouchDispatcher.h"
#import <math.h>
@implementation GameScene
+(CCScene *)scene{
    CCScene *scene = [CCScene node];
    GameScene *layer = [GameScene node];
    [scene addChild:layer];
    return scene;
}
-(id)init{
    if ((self = [super init])) {
        srand(time(NULL));
        Bg = [CCSprite spriteWithFile:@"Bg4(UDG).png"];
        Bg.position = ccp(240, 160);
        [self addChild:Bg z:-1];
        [self initBgs];
        player = [Player initPlayerAtY:160];
        player.position = ccp(100, 160);
        [self addChild:player];
        
        BlockArray = [[CCArray alloc]init];
        gameSpeed = 2;
        liveSec = 0;
        isGameOver = NO;
        blockNum = 7;
        
        Time = [[CCLabelTTF alloc]initWithString:@"Time:0.0" fontName:@"AT" fontSize:30];
        Time.color = ccc3(0,0,0);
        Time.position = ccp(370,280);
        [self addChild:Time];
        
        // loading sound...
//        [[SimpleAudioEngine sharedEngine]setMute:YES];
//        for(int c=0;c<6;c++){
//            [[SimpleAudioEngine sharedEngine]playEffect:[NSString stringWithFormat:@"%d",c]];
//        }
//        [[SimpleAudioEngine sharedEngine]setMute:NO];
        
		[[SimpleAudioEngine sharedEngine]preloadBackgroundMusic:@"0.mp3"];
		[[SimpleAudioEngine sharedEngine]preloadBackgroundMusic:@"1.mp3"];
		[[SimpleAudioEngine sharedEngine]preloadBackgroundMusic:@"2.mp3"];
		[[SimpleAudioEngine sharedEngine]preloadBackgroundMusic:@"3.mp3"];
		[[SimpleAudioEngine sharedEngine]preloadBackgroundMusic:@"4.mp3"];
		[[SimpleAudioEngine sharedEngine]preloadBackgroundMusic:@"5.mp3"];

		
        
        [self schedule:@selector(gameRunning) interval:1/60];
        [self schedule:@selector(RandomMakeBlock) interval:1/10];
        [self schedule:@selector(removeBlock) interval:1/60];
        [self schedule:@selector(blockRunning) interval:1/60];
        [self schedule:@selector(hitTest) interval:1/60];
        [self schedule:@selector(gameBgDisplay) interval:1/60];
        [self schedule:@selector(updateTime) interval:0.1];
        [[CCTouchDispatcher sharedDispatcher]addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
    }
    return self;
}
-(void)updateTime{
    [Time setString:[NSString stringWithFormat:@"Time:%.1f",(float)liveSec/10]];
    liveSec++;
    gameSpeed = 2 + (int)liveSec/500;
    if (liveSec%100==0&&liveSec!=0) {
        blockNum++;
    }
}
-(void)initBgs{
    int c;
    BgsArray = [[CCArray alloc]init];
    for(c=0;c<3;c++){
        Bgs = [CCSprite spriteWithFile:@"Bg6(UDG).png"];
        Bgs.position = ccp(240+c*470,310 );
        [BgsArray addObject:Bgs];
        [self addChild:Bgs];
    }
    for(c=0;c<3;c++){
        Bgs = [CCSprite spriteWithFile:@"Bg5(UDG).png"];
        Bgs.position = ccp(240+c*470,10 );
        [BgsArray addObject:Bgs];
        [self addChild:Bgs];
    }
    
}
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    if(isGameOver){
        [[CCDirector sharedDirector]replaceScene:[CCTransitionFadeTR transitionWithDuration:1 scene:[Menu scene]]];
        isGameOver = NO;
    }
    player.goingUP = YES;
    return YES;
}
-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    player.goingUP = NO;
}

-(void)RandomMakeBlock{
    int count = [BlockArray count];
    int Y;
    int V;
    int X;
    if (count <= blockNum){
        X = 500+rand()%480;
        Y = 18 + rand()%300;
        V = gameSpeed*20 + rand()%40 + 40;
        Block1 *newBlock = [Block1 makeABlockAtX:X Y:Y V:V];
        [BlockArray addObject:newBlock];
        [self addChild:newBlock];
    }
}
-(void)removeBlock{
    for (Block1 *temp in BlockArray) {
        if (temp.BlockX<=-18) {

            [[SimpleAudioEngine sharedEngine]playEffect:[NSString stringWithFormat:@"%d.mp3",rand()%6]];
            [BlockArray removeObject:temp];
            [self removeChild:temp cleanup:YES];
        }
    }
}
-(void)blockRunning{
    int count = [BlockArray count];
    int c;
    Block1 *pickBlock;
    for(c=0;c<count;c++){
        pickBlock = [BlockArray objectAtIndex:c];
        [pickBlock running];
    }
}
-(void)gameRunning{
    [player running];
    [player up];
}
-(void)hitTest{
    CGRect hitBox;
    Block1 *TestBox;
    CGPoint p;
    CGPoint b;
    double distance;
    double distanceLimit;
    double angle;
    int c;
    for (c=0; c<[BlockArray count]; c++) {
        hitBox = [[BlockArray objectAtIndex:c] boundingBox];
        if (CGRectIntersectsRect([player boundingBox], hitBox)) {
        TestBox = [BlockArray objectAtIndex:c];
        b = TestBox.position;
        p = player.position;
        distance = sqrt(pow((double)(b.x-p.x), 2)+pow((double)(b.y-p.y), 2));
        angle = atan((double)(b.y-p.y)/(b.x-p.x));
        distanceLimit = 18 * 1/cos(angle);
        if (distance < distanceLimit) {
            [[SimpleAudioEngine sharedEngine]playEffect:@"boom.mp3"]; 
            ExplosinEffect = [CCParticleExplosion node];
            ExplosinEffect.position = player.position;
            ExplosinEffect.life = .7f;
            [self addChild:ExplosinEffect z:1];
            [self removeChild:player cleanup:YES];
            [self unschedule:@selector(gameRunning)];
            [self unschedule:@selector(hitTest)];
            [self unschedule:@selector(updateTime)];
            [self gameOver];
            break;
        }
        }
    }
}
-(void)gameBgDisplay{
    int c;
    for(c=0;c<[BgsArray count];c++){
        Bgs = [BgsArray objectAtIndex:c];
        Bgs.position = ccp(Bgs.position.x - gameSpeed, Bgs.position.y);
        if (Bgs.position.x<=-240) {
            Bgs.position = ccp(240+470*2, Bgs.position.y);
        }
    }
}
-(void)gameOver{
    CCAction *FadeIn;
    CCAction *FadeIn2;
    FadeIn = [CCFadeIn actionWithDuration:2];
    FadeIn2 = [CCFadeIn actionWithDuration:2];
    CCLabelTTF *GameOverText = [CCLabelTTF labelWithString:@"Game Over" fontName:@"AT" fontSize:64];
    CCLabelTTF *GameOverText2 = [CCLabelTTF labelWithString:@"Touch to continue" fontName:@"AT" fontSize:18];
    GameOverText.position = ccp(240, 160);
    GameOverText.color = ccc3(0, 0, 0);
    GameOverText.opacity = 0;//0~255

    GameOverText2.position = ccp(360, 120);
    GameOverText2.color = ccc3(0, 0, 0);
    GameOverText2.opacity = 0;//0~255
    
    [self addChild:GameOverText];
    [self addChild:GameOverText2];
    
    [GameOverText runAction:FadeIn];
    [GameOverText2 runAction:FadeIn2];
    [self updateHighScore];
    isGameOver = YES;
    NSLog(@"isGmaeOver\n");
}
-(void)updateHighScore{
    NSMutableDictionary *data;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Score" ofType:@"plist"];
    data = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    NSString *myScore = [NSString stringWithFormat:@"%.1f",((double)liveSec)/10];
    NSString *tempk = [NSString stringWithFormat:@"%d",[data count]+1];
    [data setObject:myScore forKey:tempk];
    double scoreTable[[data count]];
    int c=0;
    for (id k in data) {
        scoreTable[c] = [[data objectForKey:k]doubleValue];
        c++;
    }
    for (int c2 = 0; c2<=[data count]; c2++) {
        for (c=0; c<[data count]-1; c++) {
            if (scoreTable[c]<scoreTable[c+1]) {
                int temp = scoreTable[c];
                scoreTable[c] = scoreTable[c+1];
                scoreTable[c+1] = temp;
            }
        }
    }
    for (c=1; c<=[data count]; c++) {
        NSString *tempScore = [NSString stringWithFormat:@"%.1f",scoreTable[c-1]];
        NSString *key = [NSString stringWithFormat:@"%d",c];
        [data setObject:tempScore forKey:key];
    }
    [data writeToFile:path atomically:YES];
}
-(void)dealloc{
    [super dealloc];
}

@end
