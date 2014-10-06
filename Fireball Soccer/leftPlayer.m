//
//  leftPlayer.m
//  Fireball Soccer
//
//  Created by Kenny Domingo on 04/10/2014.
//  Copyright (c) 2014 Kenny Domingo. All rights reserved.
//

#import "leftPlayer.h"

@interface leftPlayer () <SKPhysicsContactDelegate>
@end

@implementation leftPlayer

+(id)player1
{
    leftPlayer *player1 = [leftPlayer spriteNodeWithImageNamed:@"leftPlayer.png"];
    player1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(55,110) center:CGPointMake(player1.position.x,player1.position.y)];
    player1.position = CGPointMake(-100, -80);
    player1.name = @"player1";
    player1.size =CGSizeMake(55, 120);
    player1.zPosition = 1;
    player1.physicsBody.mass = 1;
    player1.physicsBody.restitution = 0.2;
    player1.physicsBody.affectedByGravity = YES;

    return player1;

}

-(void)jump
{
    int randomPosition = arc4random()%50;
    
    if(self.position.y > -100){
        
    }else{
    self.physicsBody.velocity = CGVectorMake(0+(randomPosition), 700);
        [self runAction:[SKAction playSoundFileNamed:@"Whoosh.mp3" waitForCompletion:NO]];
        
    }
    
}

@end