//
//  HelloWorldLayer.m
//  BmberMan
//
//  Created by  on 12-9-17.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "MainScene.h"
#import "GameLayer.h"
#import "GameController.h"
#import "GameInf.h"
// HelloWorldLayer implementation
@implementation MainScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainScene *layer = [MainScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) 
    {
        self.isTouchEnabled=YES;
		CCSpriteFrameCache *frameCache=[CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"img.plist"];
        CCSprite *gr=[CCSprite spriteWithFile:@"background.png"];
        [self addChild:gr];
        gr.anchorPoint=ccp(0,0);
        

        GameLayer *gameLayer=[GameLayer node];
        [self addChild:gameLayer];
        
        GameController *gameController=[GameController node];
        [self addChild:gameController];
        gameController.hero=gameLayer.hero;
        
        gameLayer.anchorPoint=ccp(0,0);
        
        
		
    }
	return self;
}
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
