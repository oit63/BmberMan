//
//  GameInf.h
//  BmberMan
//
//  Created by  on 12-9-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameInf : NSObject
{
    int score;
    int level;
}
@property(assign) int score;
@property(assign) int level;
+(id) sharedGameInf;
@end
