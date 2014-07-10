//
//  GameEnemy.h
//  BmberMan
//
//  Created by  on 12-9-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
typedef enum 
{
    kHorizon=1,
    kVertical=2,

}enemyAct;
@interface GameEnemy : CCSprite
{
   
    float speed;
    enemyAct act;
    NSMutableArray *tileArray;
    int stepCount;//记录走的步数
    CCSprite *moneylabel;
    
}
-(void) enemyMove;
-(void) enemyKill;
@property(assign) enemyAct act;
@property(assign) float speed;
@property(retain,nonatomic) NSMutableArray *tileArray; 
-(id) initAtPosion:(CGPoint) pos Inlayer:(CCLayer *)layer;
@end
