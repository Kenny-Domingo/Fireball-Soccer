//
//  MyScene.m
//  Fireball Soccer
//
//  Created by Kenny Domingo on 02/10/2014.
//  Copyright (c) 2014 Kenny Domingo. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        // background menu music
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                             pathForResource:@"menu"
                                             ofType:@"wav"]];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        player.numberOfLoops = -1;
        [player play];
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.anchorPoint = CGPointMake(0.5, 0.5);
        self.size = CGSizeMake(333, 250);
        
        SKSpriteNode *menubg = [SKSpriteNode spriteNodeWithImageNamed:@"menubg"];
        menubg.zPosition =-1;
        menubg.size = CGSizeMake(333, 250);
        menubg.position = CGPointMake(0, 0);
        
        [self addChild:menubg];
        
        SKSpriteNode *startBtn = [SKSpriteNode spriteNodeWithImageNamed:@"startbtn"];
        startBtn.position = CGPointMake(0, 0);
        startBtn.size = CGSizeMake(153, 40);
        startBtn.name = @"startBtn";
        [self addChild:startBtn];
        
        SKAction *disappear = [SKAction fadeAlphaTo:0.0 duration:0.3];
        SKAction *appear = [SKAction fadeAlphaTo:1.0 duration:0.5];
        SKAction *pulse = [SKAction sequence:@[disappear, appear]];
        [startBtn runAction:[SKAction repeatActionForever:pulse]];
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"startBtn"]) {
        
        SKTransition *transition = [SKTransition doorsOpenVerticalWithDuration:1];
        
        GameScene *game = [[GameScene alloc] initWithSize:CGSizeMake(self.size.width, self.size.height)];
        [self runAction:[SKAction playSoundFileNamed:@"select.wav" waitForCompletion:NO]];
        [self.scene.view presentScene:game transition:transition];
        
        
    }
    
    
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    
}

-(void)didBeginContact:(SKPhysicsContact *)contact{
    
}


@end
