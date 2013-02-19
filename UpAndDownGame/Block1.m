//
//  Block1.m
//  UpAndDownGame
//
//  Created by Mac on 2011/8/16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Block1.h"


@implementation Block1
@synthesize BlockX;
@synthesize BlockV;
-(id)initBlockX:(int)x Y:(int)y V:(int)v{
    if ((self = [super initWithFile:@"Block.png"])) {
        BlockX = (double)x;
        BlockY = (double)y;
        BlockV = -1 * (double)v;
    }
    return self;
}
+(id)makeABlockAtX:(int)x Y:(int)y V:(int)v{
    return [[Block1 alloc]initBlockX:x Y:y V:v];
}
-(void)running{
    BlockX = BlockX + BlockV * 1/60;
    self.position = ccp(BlockX,BlockY);
}


@end
