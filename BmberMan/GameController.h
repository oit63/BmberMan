//
//  GameController.h
//  BmberMan
//
//  Created by  on 12-9-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class GameHero;
@interface GameController : CCLayer 
{
    CGPoint touchpos;
    CCSprite *fingerSprite;
    GameHero *hero;
    
}
@property (retain,nonatomic) GameHero *hero;

-(CGPoint) convertToTilePos:(CGPoint) pos;
@end
