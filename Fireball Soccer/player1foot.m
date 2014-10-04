//
//  player1foot.m
//  Fireball Soccer
//
//  Created by Kenny Domingo on 04/10/2014.
//  Copyright (c) 2014 Kenny Domingo. All rights reserved.
//

#import "player1foot.h"

@interface player1foot () <SKPhysicsContactDelegate>
@end

@implementation player1foot

+(id)pfoot
{
    player1foot *pfoot = [player1foot spriteNodeWithImageNamed:@"leftFoot.png"];
    pfoot.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(35,50) center:CGPointMake(pfoot.position.x,pfoot.position.y)];
    pfoot.position = CGPointMake(-50, -80);
    pfoot.name = @"player1foot";
    pfoot.size =CGSizeMake(35, 50);
    pfoot.zPosition = 1;
    pfoot.physicsBody.mass = 0.5;
    pfoot.physicsBody.restitution = 0.5;
    pfoot.physicsBody.affectedByGravity = YES;
    
    return pfoot;
    
}

-(void)jump
{
    SKAction *jump = [SKAction moveBy:CGVectorMake(0, 60) duration:0.1];
    [self runAction:jump];

}

@end