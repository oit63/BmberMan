//
//  GameInf.m
//  BmberMan
//
//  Created by  on 12-9-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameInf.h"

@implementation GameInf
@synthesize score,level;
static GameInf *gameinf;
+(id) sharedGameInf
{
    if (!gameinf) 
    {
        gameinf=[[GameInf alloc] init];
        
    }   
    return gameinf;
}
-(id) init
{
    if (self=[super init])
    {
        score=0;
        level=1;
    }
    return self;
}
@end
