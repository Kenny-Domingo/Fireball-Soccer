//
//  rightPlayer.m
//  Fireball Soccer
//
//  Created by Kenny Domingo on 04/10/2014.
//  Copyright (c) 2014 Kenny Domingo. All rights reserved.
//

#import "rightPlayer.h"

@interface rightPlayer () <SKPhysicsContactDelegate> 

@end

@implementation rightPlayer

+(id)player2

{
    rightPlayer *player2 = [rightPlayer spriteNodeWithImageNamed:@"rightPlayer.png"];
    player2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(55,110) center:CGPointMake(player2.position.x,player2.position.y)];
    player2.position = CGPointMake(100, -80);
    player2.name = @"player2";
    player2.size =CGSizeMake(55, 120);
    player2.zPosition = 1;
    player2.physicsBody.mass = 1;
    player2.physicsBody.restitution = 0.2;
    player2.physicsBody.affectedByGravity = YES;
    
    int randomPosition = arc4random()%50;
    
    SKAction *move = [SKAction moveByX:(randomPosition) y:50 duration:0.1];
    [player2 runAction:move];
    SKAction *endlessAction = [SKAction repeatActionForever:move];
    [player2 runAction:endlessAction];
    return player2;
}
@end
