//
//  GameLayer.h
//  BmberMan
//
//  Created by  on 12-9-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class GameHero;

@interface GameLayer : CCLayer 
{
    int width;
    int height;
    int tileWidth;
    int tileHeight;
    int score;
    int level;
    int time;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *levelLabel;
    CCLabelTTF *timeLabel;

    CGPoint heroStartPostion;
    NSMutableArray *nullPoints; //记录没有石块和砖块的空位置 以备安放敌人
    NSMutableArray *tileArray;//记录布置石块，砖块的位置
    NSMutableArray *enemyArray;
    GameHero *hero;
    CCSprite *bomb;
    CCSprite *bombEffect;
    CCSprite *key;//通关钥匙
    BOOL isBomb;//是否炸弹已存在
    BOOL isKey;//是否钥匙已存在
}
@property(retain,nonatomic) GameHero *hero;
-(CGPoint) convertToTilePos:(CGPoint) pos;
-(void) initTile;
-(void) initHero;
-(void) initEnemy;
-(void) initBomb;
-(void) gameUpdate;
-(void) checkHeroState;
-(void) checkGameState;
-(void) updateTime;
-(void) gameOver;
-(void) gameWin;
-(void) reInit;
@end
