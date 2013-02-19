//
//  Block1.h
//  UpAndDownGame
//
//  Created by Mac on 2011/8/16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Block1 : CCSprite {
    double BlockX;
    double BlockY;
    double BlockV;
    
}
@property double BlockX;
@property double BlockV;
+(id)makeABlockAtX:(int)x Y:(int)y V:(int)v;
-(id)initBlockX:(int)x Y:(int)y V:(int)v;
-(void)running;
@end
