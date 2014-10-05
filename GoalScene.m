//
//  GoalScene.m
//  Fireball Soccer
//
//  Created by Kenny Domingo on 05/10/2014.
//  Copyright (c) 2014 Kenny Domingo. All rights reserved.
//

#import "GoalScene.h"

@interface GoalScene () <SKPhysicsContactDelegate>{
    SKLabelNode *_scoreLabel;
    SKLabelNode *_scoreLabel1;
    SKLabelNode *_highScoreLabel;
    SKLabelNode *_highScoreLabel1;
    SKLabelNode *winner;
    SKLabelNode *winner1;
    NSUInteger _score;
    NSUInteger _score1;
    NSUInteger _highscore;
    NSUInteger _highscore1;
    NSUInteger reset;
    NSUInteger W;
    NSUInteger L;
    
    
}
@end
@implementation GoalScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.anchorPoint = CGPointMake(0.5, 0.5);
        self.physicsWorld.contactDelegate =self;
        self.size = CGSizeMake(480, 550);
        
        //scoring system
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _highscore = [defaults integerForKey:@"highScore"];
        _highscore1 = [defaults integerForKey:@"highScore1"];
        
        _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        _scoreLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)_highscore];
        _scoreLabel.fontColor = [UIColor yellowColor];
        _scoreLabel.fontSize = 150.0f;
        _scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        _scoreLabel.position =CGPointMake(-148, 98);
        _scoreLabel.zPosition = 1;
        _scoreLabel.name =@"score";
        
        [self addChild:_scoreLabel];
        
        _scoreLabel1 = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        _scoreLabel1.text = [NSString stringWithFormat:@"%lu", (unsigned long)_highscore];
        _scoreLabel1.fontColor = [UIColor redColor];
        _scoreLabel1.fontSize = 150.0f;
        _scoreLabel1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        _scoreLabel1.position =CGPointMake(-150, 100);
        _scoreLabel1.zPosition = 1;
        _scoreLabel1.name =@"score";
        
        [self addChild:_scoreLabel1];
        
        _highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        _highScoreLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)_highscore1];
        _highScoreLabel.fontColor = [UIColor yellowColor];
        _highScoreLabel.fontSize = 150.0f;
        _highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        _highScoreLabel.position =CGPointMake(68, 98);
        _highScoreLabel.zPosition = 1;
        _highScoreLabel.name = @"highscore";
        
        [self addChild:_highScoreLabel];
        
        _highScoreLabel1 = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        _highScoreLabel1.text = [NSString stringWithFormat:@"%lu", (unsigned long)_highscore1];
        _highScoreLabel1.fontColor = [UIColor greenColor];
        _highScoreLabel1.fontSize = 150.0f;
        _highScoreLabel1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        _highScoreLabel1.position =CGPointMake(70, 100);
        _highScoreLabel1.zPosition = 1;
        _highScoreLabel1.name = @"highscore";
        
        [self addChild:_highScoreLabel1];
        
        winner1 = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        winner1.text = @"";
        winner1.fontColor = [UIColor yellowColor];
        winner1.fontSize = 50.0f;
        winner1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        winner1.position =CGPointMake(-118, -23);
        winner1.zPosition = 1;
        winner1.name = @"winner1";
        
        [self addChild:winner1];
        
        winner = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        winner.text = @"";
        winner.fontColor = [UIColor purpleColor];
        winner.fontSize = 50.0f;
        winner.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        winner.position =CGPointMake(-120, -25);
        winner.zPosition = 1;
        winner.name = @"winner";
        
        [self addChild:winner];

    
        SKSpriteNode *startBtn = [SKSpriteNode spriteNodeWithImageNamed:@"startbtn"];
        startBtn.position = CGPointMake(-10, -100);
        startBtn.size = CGSizeMake(140, 40);
        startBtn.name = @"startBtn";
        [self addChild:startBtn];
        
        SKAction *disappear = [SKAction fadeAlphaTo:0.0 duration:0.3];
        SKAction *appear = [SKAction fadeAlphaTo:1.0 duration:0.5];
        SKAction *pulse = [SKAction sequence:@[disappear, appear]];
        [startBtn runAction:[SKAction repeatActionForever:pulse]];
        
        reset = 0;
        W = 4;
        L = 4;
        if (_highscore > W) {
            winner.text =@"YOU WIN";
            winner1.text =@"YOU WIN";
            [defaults setInteger:reset forKey:@"highScore"];
            [defaults setInteger:reset forKey:@"highScore1"];
            
        }else if (_highscore1 > L){
            winner.text =@"YOU LOSE";
            winner1.text =@"YOU LOSE";
            [defaults setInteger:reset forKey:@"highScore"];
            [defaults setInteger:reset forKey:@"highScore1"];
        }
        
        /*
        if ((_highscore > [defaults integerForKey:@"highScore"])||(_highscore1 > [defaults integerForKey:@"highScore1"])) {
            winner.text = @"GOOOOOOOAL";
        }
        if ([winner.text  isEqual: @""]) {
            winner.text =@"OUT OF BOUNDS";
            winner1.text =@"OUT OF BOUNDS";
        }
         */
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

