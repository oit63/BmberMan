//
//  GameLayer.m
//  BmberMan
//
//  Created by  on 12-9-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "GameHero.h"
#import "GameSetting.h"
#import "GameEnemy.h"
#import "SimpleAudioEngine.h"
#import "MainScene.h"
#import "GameInf.h"
@implementation GameLayer
@synthesize hero;
-(id) init
{
    if (self=[super init]) 
    {
        width=416;
        height=288;
        tileWidth=tileHeight=32;
        GameInf *gameinf=[GameInf sharedGameInf];
        level=gameinf.level;
        score=gameinf.score;
        
        [self reInit];
        
        
    }
    return self;
}
-(void) reInit
{
    CCSprite *leftBoard=[CCSprite spriteWithFile:@"board.png"];
    CCSprite *rightBoard=[CCSprite spriteWithFile:@"board.png"];
    leftBoard.anchorPoint=ccp(0,0);
    rightBoard.anchorPoint=ccp(0,0);
    [self addChild:leftBoard];
    [self addChild:rightBoard];
    leftBoard.position=ccp(0,TileHeight);
    rightBoard.position=ccp(14*TileWidth,TileHeight);
    
    scoreLabel=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"score: %i",score] fontName:@"Marker Felt" fontSize:32];
    scoreLabel.position=ccp(11.5*TileWidth,winHeight-TileHeight/2);
    
    levelLabel=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"level: %i",level] fontName:@"Marker Felt" fontSize:32];
    levelLabel.position=ccp(2.5*TileWidth,winHeight-TileHeight/2);
    
    timeLabel=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"time: %i",time] fontName:@"Marker Felt" fontSize:32];
    timeLabel.position=ccp(7*TileWidth,winHeight-TileHeight/2);
    
    [self addChild:scoreLabel];
    [self addChild:levelLabel];
    [self addChild:timeLabel];

    time=120;
    isBomb=NO;
    isKey=NO;
    nullPoints=[[NSMutableArray alloc] init];
    tileArray=[[NSMutableArray alloc] init];
    enemyArray=[[NSMutableArray alloc] init];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"chaojimali.m4a" loop:YES];
    
    heroStartPostion=ccp(48,16);//角色的初始位置
    [self initTile];//初始化砖块 石块
    [self initHero];//初始化角色
    [self initEnemy];//初始化敌人
    [self initBomb];//初始化炸弹
    
    [self schedule:@selector(gameUpdate) interval:1/10.0];
}
-(void) initTile
{
    int i,j;//i列j行
    CCSpriteFrame *shitouFrame=[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"shitou.png"];
    CCSpriteFrame *zhuankuaiFrame=[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"zhuankuai.png"];
    //布置石块
    for (i=3; i<=width/tileWidth; i+=2)
    {
        for (j=2; j<=height/tileHeight; j+=2)
        {
            CCSprite *shitou=[CCSprite spriteWithSpriteFrame:shitouFrame];
            [self addChild:shitou];
            shitou.tag=0;
            [tileArray addObject:shitou];
            shitou.position=ccp((i-0.5)*tileWidth,(j-0.5)*tileHeight);
            
        }
    }
    //布置砖块
    for (i=2; i<=width/tileWidth+1; i+=1) 
    {
        for (j=1; j<=height/tileHeight+1; j+=2)
        {
            if ((i==2&&j==1)||(i==2&&j==2)||(i==3&&j==1)) 
            {
                continue;
            }
            if (arc4random()%10<1) 
            {
                CCSprite *zhuankuai=[CCSprite spriteWithSpriteFrame:zhuankuaiFrame];
                [self addChild:zhuankuai];
                zhuankuai.tag=1;
                zhuankuai.position=ccp((i-0.5)*tileWidth,(j-0.5)*tileHeight);
                [tileArray addObject:zhuankuai];
            }
            else 
            {
                CGPoint point=ccp((i-0.5)*tileWidth,(j-0.5)*tileHeight);
                [nullPoints addObject:[NSValue valueWithCGPoint:point]];
            }
            
            
        }
    }
    
}
-(void) initHero
{
    hero=[[GameHero alloc] initAtPoint:heroStartPostion InLayer:self]  ;
    //[hero autorelease];
    hero.tileArray=tileArray;
    
}
-(void) initEnemy
{
   
    for (int i=0; i<EnemyNum; i++) 
    {
        
        NSValue *point=[nullPoints objectAtIndex:arc4random()%nullPoints.count];//随即获取一处空位置
        GameEnemy *enemy=[[GameEnemy alloc] initAtPosion:[point CGPointValue] Inlayer:self];
        [enemyArray addObject:enemy];
        enemy.tileArray=tileArray;
        //[enemy schedule:@selector(EnemyMove) interval:1/30.0];
        [nullPoints removeObject:point];
    }
    
       
}

//播放爆炸效果
-(void) putBombEffect
{
    bombEffect=[CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bombEffects.png"]];
    bombEffect.scale=0.333;
    CCScaleTo *scale=[CCScaleTo actionWithDuration:0.3 scale:1];
   //CCRepeatForever *repeat=[CCRepeatForever actionWithAction:scale];
    CCSequence *seq=[CCSequence actions:scale,[CCHide action], nil];
    [bombEffect runAction:seq];
    [self addChild:bombEffect z:-1];
    
    [bombEffect setPosition:bomb.position];
   
    
}
-(void) initBomb
{
    CCSpriteFrame *bombFrame=[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bomb.png"];
    bomb=[CCSprite spriteWithSpriteFrame:bombFrame];
    
    CCScaleTo *scale1=[CCScaleTo actionWithDuration:0.5 scale:1.2];
    CCScaleTo *scale2=[CCScaleTo actionWithDuration:0.5 scale:0.8];
    CCSequence *seq=[CCSequence actions:scale1,scale2, nil];
    CCRepeatForever *repeat=[CCRepeatForever actionWithAction:seq];
    [bomb runAction:repeat];
    [self addChild:bomb z:-1];
    [tileArray addObject:bomb];
    //hero.tileArray=tileArray;
    bomb.visible=NO;
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"dingshi.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"baozha.mp3"];
    
     
}
//安放炸弹
-(void) putBomb
{
    if (isBomb) 
    {
        return;
    }
    bomb.visible=YES;
    [self schedule:@selector(bombDown) interval:3];   
    CGPoint pos=hero.heroSprite.position;
    pos=[self convertToTilePos:pos];
    [bomb setPosition: pos];
    isBomb=YES;
    [[SimpleAudioEngine sharedEngine] playEffect:@"dingshi.mp3"];

    
    
}
//炸弹爆炸
-(void) bombDown
{
    CCSprite *tile;
   //遍历贴图集 如果有与炸弹距离一个单位的砖块 则移除
    for (int i=0; i<tileArray.count; i++) 
    {
        tile=[tileArray objectAtIndex:i];
        
        if (ccpDistance(tile.position, bomb.position)<=TileHeight&&tile.tag==1) 
        {
            [tileArray removeObject:tile];

            [tile removeFromParentAndCleanup:NO];
            score+=10;
            i--;//注意此处因为索引位置的贴图改变 需要重新检查该索引位置
            scoreLabel.string=[NSString stringWithFormat:@"score: %i",score];
        }
        if (tileArray.count==28&&!isKey)//贴图数为28 即砖块数为0-23为石块 24-26为砖块 27 为炸弹
        {
            key=[CCSprite spriteWithFile:@"yaoshi.png"];
            [self addChild:key z:-1];
             CCSprite *tile=[tileArray objectAtIndex:arc4random()%3+24];//在三个砖块随机生成一个位置
            key.position=tile.position;
            isKey=YES;
            
        }
                
    }
    for (int i=0; i<enemyArray.count; i++) 
    {
        GameEnemy *enemy=[enemyArray objectAtIndex:i];
        if ((fabs(bomb.position.x-enemy.position.x)<TileWidth||fabs(bomb.position.y-enemy.position.y)<TileHeight)&&ccpDistance(bomb.position, enemy.position)<=TileWidth*2) //如果敌人与炸弹在一条直线上并且距离小于两个单位
        {
            [enemyArray removeObject:enemy];
            [enemy unschedule:@selector(enemyMove)];
            [enemy enemyKill];
            score+=100;
            i--;
            scoreLabel.string=[NSString stringWithFormat:@"score: %i",score];
            
        }
    }
    if ((fabs(bomb.position.x-hero.heroSprite.position.x)<TileWidth||fabs(bomb.position.y-hero.heroSprite.position.y)<TileHeight)&&ccpDistance(bomb.position, hero.heroSprite.position)<TileWidth*2) //如果角色与炸弹在一条直线上并且距离小于两个单位
    {
        [self gameOver];
    }
    bomb.visible=NO;
    
    isBomb=NO;
    [self putBombEffect];
    [bomb setPosition:CGPointMake(-16, -16)];
    [[SimpleAudioEngine sharedEngine] playEffect:@"baozha.mp3"];
    [self unschedule:@selector(bombDown)];
    

}

-(void) gameUpdate
{
    [self updateTime];
    [self checkHeroState];
    [self checkGameState];
    
}
-(void) updateTime
{
    static int i=0;
    if (i==10) 
    {
        time--;
        timeLabel.string=[NSString stringWithFormat:@"time: %i",time];
        i=0;
    }
    i++;
    
}
-(void) checkHeroState
{
    switch (hero.kact) 
    {
        case 1:
            [hero MoveUp];
            break;
        case 2:
            [hero MoveLeft];
            break;
        case 3:
            [hero MoveRight];
            break;
        case 4:
            [hero MoveDown];
            break;
        case 5:
            [self putBomb];
            break;
        case 6:
            [hero OnStay];
            break;
        default:
            break;
    }
    for(int i=0;i<enemyArray.count;i++)
    {
        GameEnemy *enemy=[enemyArray objectAtIndex:i];
        if(ccpDistance(enemy.position, self.hero.heroSprite.position)<tileWidth-abs(enemy.speed))
        {
            [self gameOver];
        }
            
    }
}
-(void) checkGameState
{
    if (enemyArray.count==0&&hero.heroSprite.position.x==key.position.x&&hero.heroSprite.position.y==key.position.y) 
    {
        [self gameWin];
    }
    //[self gameWin];
    if (time<=0) 
    {
        [self gameOver];
    }
}
-(void) loadNextlevel:(int)lel
{
    level=lel;
    
    [self reInit];
}
-(void) gameWin
{
    [self unschedule:@selector(gameUpdate)];
    GameInf *gameinf=[GameInf sharedGameInf];
    gameinf.score=score;
    gameinf.level=++level;
    CCScene *scene=[MainScene scene];
    CCTransitionShrinkGrow *transitionScene = [CCTransitionShrinkGrow transitionWithDuration:3 scene:scene];
    
    [[CCDirector sharedDirector] replaceScene:transitionScene];

}

-(void) gameOver
{
    [self unschedule:@selector(gameUpdate)];
    GameInf *gameinf=[GameInf sharedGameInf];
    gameinf.score=0;
    gameinf.level=1;
    CCScene *scene=[MainScene scene];
    CCTransitionShrinkGrow *transitionScene = [CCTransitionShrinkGrow transitionWithDuration:3 scene:scene];
    
    [[CCDirector sharedDirector] replaceScene:transitionScene];

}
-(void) dealloc
{
    [super dealloc];
    [tileArray dealloc];
}
-(CGPoint) convertToTilePos:(CGPoint) pos
{
    int x=pos.x/TileWidth;
    int y=pos.y/TileHeight;
    return CGPointMake((x+0.5)*TileWidth, (y+0.5)*TileHeight);
}

@end
