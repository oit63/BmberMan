//
//  GameController.m
//  BmberMan
//
//  Created by  on 12-9-19.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameController.h"
#import "GameSetting.h"
#import "GameHero.h"
@implementation GameController
@synthesize hero;
-(id) init
{
    if (self=[super init]) 
    {
        self.isTouchEnabled=YES;
        CCSprite *ukeySprite=[CCSprite spriteWithFile:@"key.png"];
        [self addChild:ukeySprite];
        ukeySprite.position=ccp(1.5*TileWidth,1.5*TileHeight);
        
        CCSprite *dkeySprite=[CCSprite spriteWithFile:@"key.png"];
        [self addChild:dkeySprite];
        dkeySprite.position=ccp(1.5*TileWidth,0.5*TileHeight);
        dkeySprite.rotation=180;
        
        CCSprite *lkeySprite=[CCSprite spriteWithFile:@"key.png"];
        [self addChild:lkeySprite];
        lkeySprite.position=ccp(0.5*TileWidth,0.5*TileHeight);
        lkeySprite.rotation=-90;
        
        CCSprite *rkeySprite=[CCSprite spriteWithFile:@"key.png"];
        [self addChild:rkeySprite];
        rkeySprite.position=ccp(2.5*TileWidth,0.5*TileHeight);
        rkeySprite.rotation=90;
        
        CCSprite *bomb=[CCSprite spriteWithFile:@"bomb.png"];
        [self addChild:bomb];
        bomb.position=ccp(14.5*TileWidth,0.5*TileHeight);
    }
    return self;
}
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (fingerSprite) 
    {
        [self removeChild:fingerSprite cleanup:YES];
    }
    UITouch *touch=[touches anyObject];
    CGPoint location=[touch locationInView:touch.view];
    location = [[CCDirector sharedDirector] convertToGL: location];
    touchpos=[self convertToTilePos:location];
    
    if (touchpos.x==0.5*TileWidth&&touchpos.y==0.5*TileHeight)
    {
        hero.kact=kLeft;
    }
    if (touchpos.x==2.5*TileWidth&&touchpos.y==0.5*TileHeight)
    {
        hero.kact=kRight;
    }
    if (touchpos.x==1.5*TileWidth&&touchpos.y==0.5*TileHeight)
    {
        hero.kact=kDown;
    }
    if (touchpos.x==1.5*TileWidth&&touchpos.y==1.5*TileHeight)
    {
        hero.kact=kUp;
    }
    if (touchpos.x==14.5*TileWidth&&touchpos.y==0.5*TileHeight)
    {
        hero.kact=kFire;
    }
    
    
    
   
}
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    hero.kact=kStay;
}
//将屏幕随意位置转化为网格位置
-(CGPoint) convertToTilePos:(CGPoint) pos
{
    int x=pos.x/TileWidth;
    int y=pos.y/TileHeight;
    return CGPointMake((x+0.5)*TileWidth, (y+0.5)*TileHeight);
}
@end
