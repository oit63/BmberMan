//
//  GameHero.h
//  BmberMan
//
//  Created by  on 12-9-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
typedef enum {
	kUp =  1,
	kLeft = 2,
	kRight = 3,
	kDown = 4,
	kFire = 5,
	kStay = 6,
} HeroAct;//定义角色行为
typedef enum {
    ku=1,
    kl=2,
    kr=3,
    kd=4,
    
} ToOrg;//定义面朝的方向
@interface GameHero : NSObject 
{
    CCSprite *heroSprite;
    float speed;
    HeroAct kact;
    ToOrg org;
    NSMutableArray *tileArray;//贴图数组
    CGPoint touchPos;
  
    NSTimer *timer;
}
@property(assign) HeroAct kact;
@property(retain,nonatomic) CCSprite *heroSprite;
@property(retain,nonatomic) NSMutableArray *tileArray;
@property(assign)CGPoint touchPos;
-(id) initAtPoint:(CGPoint) point InLayer:(CCLayer *)layer;
-(void) changWithSpriteFile:(NSString *)fileName;
- (void) MoveLeft;
- (void) MoveRight;
- (void) MoveUp;
- (void) MoveDown;
- (void) OnFire:(CCSprite *)bomb;
- (void) OnStay;
@end
