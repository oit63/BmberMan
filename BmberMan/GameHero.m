//
//  GameHero.m
//  BmberMan
//
//  Created by  on 12-9-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameHero.h"
#import "GameSetting.h"

@implementation GameHero
@synthesize kact,heroSprite,tileArray,touchPos;
-(id) initAtPoint:(CGPoint) point InLayer:(CCLayer *)layer
{
    if (self=[super init]) 
    {
        heroSprite=[CCSprite spriteWithFile:@"down.png"];
        [layer addChild:heroSprite];
        heroSprite.position=point;
        kact=kStay;
        speed=8;
        
    }
    return self;
}
-(void) MoveUp
{
    [self changWithSpriteFile:@"up.png"];
    kact=kUp;
    org=ku;
    CCSprite *tile;
    for (int i=0; i<tileArray.count; i++) 
    {
        tile=[tileArray objectAtIndex:i];
        
        if ((heroSprite.position.y<tile.position.y)&&tile.position.y-heroSprite.position.y==TileHeight) 
        {
            if (tile.position.x==heroSprite.position.x) 
            {
                return;
            }
            if (tile.position.x>heroSprite.position.x&&tile.position.x-heroSprite.position.x<TileWidth) 
            {
                heroSprite.position=ccp(tile.position.x-TileWidth,heroSprite.position.y);
                break;
            }
            if (tile.position.x<heroSprite.position.x&&heroSprite.position.x-tile.position.x<TileWidth) 
            {
                heroSprite.position=ccp(tile.position.x+TileWidth,heroSprite.position.y);
                break;
            }
        }
        //如果超越了最顶行，则重设位置为最顶行位置
        if (heroSprite.position.y>=(9-0.5)*TileHeight) 
        {
            heroSprite.position=ccp(heroSprite.position.x,(9-0.5)*TileHeight);
            return;
        }

    }   
            
    heroSprite.position=ccp(heroSprite.position.x,heroSprite.position.y+speed);
    
}
- (void) MoveLeft
{
    [self changWithSpriteFile:@"left.png"];
    kact=kLeft;
    org=kl;
    CCSprite *tile;
    for (int i=0; i<tileArray.count; i++) 
    {
        tile=[tileArray objectAtIndex:i];
        
        if ((heroSprite.position.x>tile.position.x)&&heroSprite.position.x-tile.position.x==TileWidth) 
        {
            
            if (tile.position.y==heroSprite.position.y) 
            {
                return;
            }
            if (tile.position.y>heroSprite.position.y&&tile.position.y-heroSprite.position.y<TileHeight) 
            {
                heroSprite.position=ccp(heroSprite.position.x,tile.position.y-TileHeight);
                break;
            }
            if (tile.position.y<heroSprite.position.y&&heroSprite.position.y-tile.position.y<TileHeight) 
            {
                heroSprite.position=ccp(heroSprite.position.x,tile.position.y+TileHeight);
                break;
            }

        }
        //如果超越了最左列，则重设位置为最左列位置
        if (heroSprite.position.x<=1.5*TileWidth) 
        {
            heroSprite.position=ccp(1.5*TileWidth,heroSprite.position.y);
            return;
        }
        
    }   
    
    heroSprite.position=ccp(heroSprite.position.x-speed,heroSprite.position.y);
}
- (void) MoveRight
{
    [self changWithSpriteFile:@"right.png"];
    kact=kRight;
    org=kr;
    CCSprite *tile;
    for (int i=0; i<tileArray.count; i++) 
    {
        tile=[tileArray objectAtIndex:i];
        
        if ((heroSprite.position.x<tile.position.x)&&tile.position.x-heroSprite.position.x==TileWidth) 
        {
            if (tile.position.y==heroSprite.position.y) 
            {
                return;
            }
            if (tile.position.y>heroSprite.position.y&&tile.position.y-heroSprite.position.y<TileHeight) 
            {
                heroSprite.position=ccp(heroSprite.position.x,tile.position.y-TileHeight);
                break;
            }
            if (tile.position.y<heroSprite.position.y&&heroSprite.position.y-tile.position.y<TileHeight) 
            {
                heroSprite.position=ccp(heroSprite.position.x,tile.position.y+TileHeight);
                break;
            }

        }
        //如果超越了最左列，则重设位置为最左列位置
        if (heroSprite.position.x>=13.5*TileWidth) 
        {
            heroSprite.position=ccp(13.5*TileWidth,heroSprite.position.y);
            return;
        }
        
    }   
    
    heroSprite.position=ccp(heroSprite.position.x+speed,heroSprite.position.y);
}
-(void) MoveDown
{
    [self changWithSpriteFile:@"down.png"];
    kact=kDown;
    org=kd;
    CCSprite *tile;
    for (int i=0; i<tileArray.count; i++) 
    {
        tile=[tileArray objectAtIndex:i];
        
        if ((heroSprite.position.y>tile.position.y)&&heroSprite.position.y-tile.position.y==TileHeight) 
        {
            if (tile.position.x==heroSprite.position.x) 
            {
                return;
            }
            if (tile.position.x>heroSprite.position.x&&tile.position.x-heroSprite.position.x<TileWidth) 
            {
                heroSprite.position=ccp(tile.position.x-TileWidth,heroSprite.position.y);
                break;
            }
            if (tile.position.x<heroSprite.position.x&&heroSprite.position.x-tile.position.x<TileWidth) 
            {
                heroSprite.position=ccp(tile.position.x+TileWidth,heroSprite.position.y);
                break;
            }

        }
        
        //如果超越了最底行，则重设位置为最底行位置
        if (heroSprite.position.y<=0.5*TileHeight) 
        {
            heroSprite.position=ccp(heroSprite.position.x,0.5*TileHeight);
            return;
        }
        
    }   
    
    heroSprite.position=ccp(heroSprite.position.x,heroSprite.position.y-speed);
}
-(void) OnFire:(CCSprite *)bomb
{
    kact=kFire;
    
     
    
    

}
-(void) OnStay
{
    kact=kStay;
}

-(void) changWithSpriteFile:(NSString *)fileName
{
    
    CCSprite *sprite=[CCSprite spriteWithFile:fileName];
    
    [heroSprite setTexture:sprite.texture];
}
@end
