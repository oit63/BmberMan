//
//  GameEnemy.m
//  BmberMan
//
//  Created by  on 12-9-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameEnemy.h"
#import "GameSetting.h"

@implementation GameEnemy
@synthesize speed,act,tileArray;
-(id) initAtPosion:(CGPoint) pos Inlayer:(CCLayer *)layer
{
    CCSpriteFrame *spriteFrame=[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"enemy1.png"];
    if ([self initWithSpriteFrame:spriteFrame]) 
    {
        speed=3;
        act=arc4random()%2+1;
        //act=kVertical;
        self.position=pos;
        moneylabel=[CCLabelTTF labelWithString:@"100" fontName:@"Marker Felt" fontSize:16];
        moneylabel.color=ccc3(0, 255, 0);
        [layer addChild:moneylabel];
        moneylabel.visible=NO;
        [layer addChild:self];
        
        CCSpriteFrame *frame1=[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"enemy1.png"];
        CCSpriteFrame *frame2=[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"enemy2.png"];
        NSArray *frameArray=[NSArray arrayWithObjects:frame1,frame2, nil];
        
        CCAnimation *animation = [CCAnimation animationWithFrames:frameArray delay:0.2];
        id action = [CCAnimate actionWithAnimation: animation];
        [self runAction:[CCRepeatForever actionWithAction:action]];		
        // [self activit];
        [self schedule:@selector(enemyMove) interval:1/10.0f];


    }
               
    return self;
}
-(void) enemyMove
{
   
    if (act==kHorizon) //水平移动
    {
        CCSprite *tile;
        //speed=3;
        BOOL leftnEnable=NO;
        BOOL rightnEnable=NO;//判断角色的左边和右边是否可行
        if (self.position.x==1.5*TileWidth) 
        {
            leftnEnable=YES;//左边不可行
        }
        if (self.position.x==13.5*TileWidth) 
        {
            rightnEnable=YES;//右边不可行
        }
        for (int i=0; i<tileArray.count; i++) 
        {
            tile=[tileArray objectAtIndex:i];
            if (tile.position.y==self.position.y&&self.position.x-tile.position.x==TileWidth) 
            {
                leftnEnable=YES;//左边不可行
            }
            if (tile.position.y==self.position.y&&tile.position.x-self.position.x==TileWidth) 
            {
                rightnEnable=YES;//右边不可行
            }
        }
        if (leftnEnable&&rightnEnable) 
        {
            act=kVertical;
            return;
        }

        for (int i=0; i<tileArray.count; i++) 
        {
            tile=[tileArray objectAtIndex:i];
            if ((self.position.x<tile.position.x)&&tile.position.x-self.position.x<=TileWidth&&fabs(tile.position.y-self.position.y)<TileWidth&&speed>0) 
            {
                speed=-speed;
                break;
            }
            //如果遇到墙壁方向改变
            if (self.position.x>=13.5*TileWidth) 
            {
                self.position=ccp(13.5*TileWidth,self.position.y);
                speed=-speed;
                break;
            }

            //如果正在往左运动 且右侧有障碍 方向改变
            if ((self.position.x>tile.position.x)&&self.position.x-tile.position.x<=TileWidth&&fabs(tile.position.y-self.position.y)<TileWidth&&speed<0) 
            {
                speed=-speed;
                break;
            }
            //如果遇到墙壁方向改变
            if (self.position.x<=1.5*TileWidth) 
            {
                self.position=ccp(1.5*TileWidth,self.position.y);
                speed=-speed;
                break;
            }
            
            
        }
        
        self.position=ccp(self.position.x+speed,self.position.y);
        stepCount++;
    }
    if(act==kVertical)//竖直移动
    {
        CCSprite *tile;
        BOOL upnEnable=NO;
        BOOL downnEnable=NO;//判断角色的上边和下边是否可行
        if (self.position.y==0.5*TileHeight) 
        {
            downnEnable=YES;//下边不可行
        }
        if (self.position.y==8.5*TileHeight) 
        {
            upnEnable=YES;//上边不可行
        }
        for (int i=0; i<tileArray.count; i++) 
        {
            tile=[tileArray objectAtIndex:i];
            if (tile.position.x==self.position.x&&self.position.y-tile.position.y==TileHeight) 
            {
                downnEnable=YES;//左边不可行
            }
            if (tile.position.x==self.position.x&&tile.position.y-self.position.y==TileWidth) 
            {
                upnEnable=YES;//右边不可行
            }
        }
        if (downnEnable&&upnEnable) 
        {
            act=kHorizon;
            return;
        }

        for (int i=0; i<tileArray.count; i++) 
        {
            tile=[tileArray objectAtIndex:i];
            if ((self.position.y<tile.position.y)&&tile.position.y-self.position.y<=TileHeight&&fabs(tile.position.x-self.position.x)<TileWidth) 
            {
                speed=-speed;
                break;
            }
            //如果超越了最顶行，则重设位置为最顶行位置
            if (self.position.y>=(9-0.5)*TileHeight) 
            {
                self.position=ccp(self.position.x,(9-0.5)*TileHeight);
                speed=-speed;
                break;
            }
            if ((self.position.y>tile.position.y)&&self.position.y-tile.position.y<=TileHeight&&fabs(tile.position.x-self.position.x)<TileWidth) 
            {
                speed=-speed;
                break;
            }
            //如果超越了最底行，则重设位置为最底行位置
            if (self.position.y<=0.5*TileHeight) 
            {
                self.position=ccp(self.position.x,0.5*TileHeight);
                speed=-speed;
                break;
            }


            
        }   
        
        self.position=ccp(self.position.x,self.position.y+speed);
        stepCount++;
        NSLog(@"%i",stepCount);
    }
    if (stepCount>=64/Nandu) 
    {
        if ((int)(self.position.x+0.5*TileWidth)%TileWidth==0&&act==kHorizon) 
        {
            act=kVertical;
            stepCount=0;
        }
        else if ((int)(self.position.y+0.5*TileHeight)%TileHeight==0&&act==kVertical) 
        {
            act=kHorizon;
            stepCount=0;
        }
    }
      

}
-(void) enemyKill
{
    CCScaleTo *scale=[CCScaleTo actionWithDuration:1 scale:0];
    CCTintTo *tint=[CCTintTo actionWithDuration:1 red:255 green:255 blue:255];
       [self runAction:tint];
    CCSequence *seq=[CCSequence actions:scale,[CCCallFunc actionWithTarget:self selector:@selector(removeEnemy)], nil];
    [self runAction:seq];
    
        
    moneylabel.visible=TRUE;
    moneylabel.position=self.position;

    
    CCScaleTo *scaleto=[CCScaleTo actionWithDuration:1 scale:2];
    CCMoveBy *moveby=[CCMoveBy actionWithDuration:1 position:ccp(0,32)];
    [moneylabel runAction:scaleto];
    [moneylabel runAction:moveby];
    
    
}
-(void) removeEnemy
{
    [moneylabel removeFromParentAndCleanup:YES];
    [self removeFromParentAndCleanup:YES];
}
@end
