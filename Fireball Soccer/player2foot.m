//
//  player2foot.m
//  Fireball Soccer
//
//  Created by Kenny Domingo on 04/10/2014.
//  Copyright (c) 2014 Kenny Domingo. All rights reserved.
//

#import "player2foot.h"

@interface player2foot () <SKPhysicsContactDelegate>
@end

@implementation player2foot

+(id)pfoot1
{
    player2foot *pfoot1 = [player2foot spriteNodeWithImageNamed:@"rightFoot.png"];
    pfoot1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(35,20) center:CGPointMake(pfoot1.position.x,pfoot1.position.y)];
    pfoot1.position = CGPointMake(75, -40);
    pfoot1.name = @"player2foot";
    pfoot1.size =CGSizeMake(35,20);
    pfoot1.zPosition = 1;
    pfoot1.physicsBody.mass = 0.5;
    pfoot1.physicsBody.restitution = 0.5;
    pfoot1.physicsBody.affectedByGravity = YES;
    
    return pfoot1;
    
}

-(void)jump
{
    SKAction *jump = [SKAction moveBy:CGVectorMake(0, 60) duration:0.1];
    [self runAction:jump];
    
}

@end
