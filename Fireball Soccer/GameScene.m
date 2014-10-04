//
//  GameScene.m
//  Fireball Soccer
//
//  Created by Kenny Domingo on 02/10/2014.
//  Copyright (c) 2014 Kenny Domingo. All rights reserved.
//

#import "GameScene.h"
#import "leftPlayer.h"
#import "player1foot.h"
#import "rightPlayer.h"
#import "player2foot.h"

@interface GameScene () <SKPhysicsContactDelegate>{
    SKSpriteNode *ball;
    SKLabelNode *_scoreLabel;
    SKLabelNode *_scoreLabel1;
    SKLabelNode *_highScoreLabel;
    SKLabelNode *_highScoreLabel1;
    NSUInteger _score;
    NSUInteger _score1;
    NSUInteger _highscore;
    NSUInteger _highscore1;

}
@end

@implementation GameScene{
    leftPlayer *player1;
    player1foot *pfoot;
    rightPlayer *player2;
    player2foot *pfoot1;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.anchorPoint = CGPointMake(0.5, 0.5);
        self.physicsWorld.contactDelegate =self;
        self.size = CGSizeMake(480, 550);
        
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg1"];
        bg.zPosition =-1;
        bg.size = CGSizeMake(480, 550);
        bg.position = CGPointMake(0, 0);
        
        [self addChild:bg];
        
        //ball
        
        ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
        ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:10 center:CGPointMake(ball.position.x,ball.position.y)];
        ball.size = CGSizeMake(30,30);
        ball.name = @"ball";
        ball.zPosition = 1;
        ball.position = CGPointMake(-100,100);
        ball.physicsBody.allowsRotation = YES;
        ball.physicsBody.affectedByGravity = YES;
        ball.physicsBody.restitution = 0.8;
        
        
        //fireball fx
        
        SKNode *fire = [self fire1];
        [fire setPosition:CGPointMake(0,0)];
        [ball addChild:fire];
        
        [self addChild:ball];
        
        
        //player1
        
        player1 = [leftPlayer player1];
        [self addChild:player1];
        
        SKSpriteNode *boundary = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(30,110)];
        boundary.position = CGPointMake(player1.position.x, player1.position.y);
        boundary.zPosition = -2;
        boundary.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:boundary.size];
        boundary.physicsBody.affectedByGravity = YES;
        [self addChild:boundary];
        
        //player jump button
        
        SKSpriteNode *jumpbtn = [SKSpriteNode spriteNodeWithImageNamed:@"+btn3.png"];
        jumpbtn.position = CGPointMake(-200,-230);
        jumpbtn.size =CGSizeMake(80, 70);
        jumpbtn.zPosition = 1;
        jumpbtn.name = @"jumpbtn";
        [self addChild:jumpbtn];
        
        //player1 foot
        
        pfoot = [player1foot pfoot];
        [self addChild:pfoot];
        
        //player1 and foot joint
        
        SKPhysicsJointPin *joint1 = [SKPhysicsJointPin jointWithBodyA:pfoot.physicsBody bodyB:player1.physicsBody anchor:CGPointMake(player1.position.x, player1.position.y)];
        [self.physicsWorld addJoint:joint1];
        
        SKPhysicsJointFixed *joint2 = [SKPhysicsJointFixed jointWithBodyA:boundary.physicsBody bodyB:player1.physicsBody anchor:CGPointMake(player1.position.x, player1.position.y)];
        [self.physicsWorld addJoint:joint2];
        
        //player2
        
        player2 = [rightPlayer player2];
        [self addChild:player2];
        
        SKSpriteNode *boundary1 = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(30,110)];
        boundary1.position = CGPointMake(player2.position.x, player2.position.y);
        boundary1.zPosition = -2;
        boundary1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:boundary1.size];
        boundary1.physicsBody.affectedByGravity = YES;
        [self addChild:boundary1];
        
        //player2 foot
        
        pfoot1 = [player2foot pfoot1];
        [self addChild:pfoot1];
        
        //player2 and foot joint
        
        SKPhysicsJointPin *joint11 = [SKPhysicsJointPin jointWithBodyA:pfoot1.physicsBody bodyB:player2.physicsBody anchor:CGPointMake(player2.position.x, player2.position.y)];
        [self.physicsWorld addJoint:joint11];
        
        SKPhysicsJointFixed *joint22 = [SKPhysicsJointFixed jointWithBodyA:boundary1.physicsBody bodyB:player2.physicsBody anchor:CGPointMake(player2.position.x, player2.position.y)];
        [self.physicsWorld addJoint:joint22];
        
        
        //Goals
        
        SKSpriteNode *leftGoal = [SKSpriteNode spriteNodeWithImageNamed:@"GoalPost.png"];
        leftGoal.position = CGPointMake(-200, -80);
        leftGoal.size =CGSizeMake(70, 250);
        leftGoal.zPosition = 1;
        leftGoal.name = @"leftGoal";
        [self addChild:leftGoal];
        
        SKSpriteNode *tbar = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(60,5)];
        tbar.position = CGPointMake(-200,35);
        tbar.zPosition = -2;
        tbar.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:tbar.size];
        tbar.physicsBody.dynamic = NO;
        tbar.physicsBody.affectedByGravity = NO;
        [self addChild:tbar];
        
        SKSpriteNode *rightGoal = [SKSpriteNode spriteNodeWithImageNamed:@"GoalPost1.png"];
        rightGoal.position = CGPointMake(200, -80);
        rightGoal.size =CGSizeMake(70, 250);
        rightGoal.zPosition = 1;
        rightGoal.name = @"rightGoal";
        [self addChild:rightGoal];
        
        SKSpriteNode *tbar1 = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(60,5)];
        tbar1.position = CGPointMake(200,35);
        tbar1.zPosition = -2;
        tbar1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:tbar1.size];
        tbar1.physicsBody.dynamic = NO;
        tbar1.physicsBody.affectedByGravity = NO;
        [self addChild:tbar1];
        
        // frame walls
        
        SKSpriteNode *ground = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(self.frame.size.width,10)];
        ground.position = CGPointMake(0, -190);
        ground.zPosition = -2;
        ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.size];
        ground.physicsBody.dynamic = NO;
        ground.physicsBody.affectedByGravity = NO;
        [self addChild:ground];
        
        SKSpriteNode *ground2 = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(self.frame.size.width,10)];
        ground2.position = CGPointMake(0, 300);
        ground2.zPosition = -2;
        ground2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground2.size];
        ground2.physicsBody.dynamic = NO;
        ground2.physicsBody.affectedByGravity = NO;
        [self addChild:ground2];
        
        SKSpriteNode *ground3 = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(10,self.frame.size.height)];
        ground3.position = CGPointMake(250, 10);
        ground3.zPosition = -2;
        ground3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground3.size];
        ground3.physicsBody.dynamic = NO;
        ground3.physicsBody.affectedByGravity = NO;
        [self addChild:ground3];
        
        SKSpriteNode *ground4 = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(10,self.frame.size.height)];
        ground4.position = CGPointMake(-250, 10);
        ground4.zPosition = -2;
        ground4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground4.size];
        ground4.physicsBody.dynamic = NO;
        ground4.physicsBody.affectedByGravity = NO;
        [self addChild:ground4];
        
        _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        _scoreLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)_highscore];
        _scoreLabel.fontColor = [UIColor yellowColor];
        _scoreLabel.fontSize = 50.0f;
        _scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        _scoreLabel.position =CGPointMake(-50, 200);
        _scoreLabel.zPosition = 1;
        _scoreLabel.name =@"score";
        
        [self addChild:_scoreLabel];
        
        _scoreLabel1 = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        _scoreLabel1.text = [NSString stringWithFormat:@"%lu", (unsigned long)_highscore];
        _scoreLabel1.fontColor = [UIColor redColor];
        _scoreLabel1.fontSize = 50.0f;
        _scoreLabel1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        _scoreLabel1.position =CGPointMake(-49, 199);
        _scoreLabel1.zPosition = 1;
        _scoreLabel1.name =@"score";
        
        [self addChild:_scoreLabel1];
        
        _highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        _highScoreLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)_highscore1];
        _highScoreLabel.fontColor = [UIColor yellowColor];
        _highScoreLabel.fontSize = 50.0f;
        _highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        _highScoreLabel.position =CGPointMake(39, 199);
        _highScoreLabel.zPosition = 1;
        _highScoreLabel.name = @"highscore";
        
        [self addChild:_highScoreLabel];
        
        _highScoreLabel1 = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        _highScoreLabel1.text = [NSString stringWithFormat:@"%lu", (unsigned long)_highscore1];
        _highScoreLabel1.fontColor = [UIColor greenColor];
        _highScoreLabel1.fontSize = 50.0f;
        _highScoreLabel1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        _highScoreLabel1.position =CGPointMake(40, 200);
        _highScoreLabel1.zPosition = 1;
        _highScoreLabel1.name = @"highscore";
        
        [self addChild:_highScoreLabel1];
    }
    return self;
    
}

-(SKNode *)fire1
{
    SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"MyParticle3" ofType:@"sks"]];
    emitter.targetNode = self;
    [emitter setName:@"fire1"];
    return emitter;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"jumpbtn"]){
        [player1 jump];
        [pfoot jump];
        
    }
   
    
}
-(void)update:(CFTimeInterval)currentTime {
    
    //Goals scored
    
    if((ball.position.x < -178 && ball.position.y < 35) && (ball.position.x > -180 && ball.position.y < 35)){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _score+= 1;
        
        _scoreLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)_score];
        _scoreLabel1.text = [NSString stringWithFormat:@"%lu", (unsigned long)_score];
        
            [defaults setInteger:_score forKey:@"highScore"];
        
        
    }
    
    if((ball.position.x > 178 && ball.position.y < 35) &&
       (ball.position.x < 180 && ball.position.y < 35)){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _score1+= 1;
        
        _highScoreLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)_score1];
        _highScoreLabel1.text = [NSString stringWithFormat:@"%lu", (unsigned long)_score1];
        
            [defaults setInteger:_score1 forKey:@"highScore1"];
        
        
        
    }

    
    
}

-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    
}


@end
