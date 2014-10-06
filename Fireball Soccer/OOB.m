//
//  OOB.m
//  Fireball Soccer
//
//  Created by Kenny Domingo on 06/10/2014.
//  Copyright (c) 2014 Kenny Domingo. All rights reserved.
//

#import "OOB.h"

@interface OOB () <SKPhysicsContactDelegate>{
    SKLabelNode *_scoreLabel;
    SKLabelNode *_scoreLabel1;
    SKLabelNode *_highScoreLabel;
    SKLabelNode *_highScoreLabel1;
    SKLabelNode *vs;
    SKLabelNode *vs1;
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
@implementation OOB

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        [self runAction:[SKAction playSoundFileNamed:@"Yahoo!.mp3" waitForCompletion:NO]];
        
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                             pathForResource:@"gameplay"
                                             ofType:@"mp3"]];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        player.numberOfLoops = -1;
        [player play];
        
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.anchorPoint = CGPointMake(0.5, 0.5);
        self.physicsWorld.contactDelegate =self;
        self.size = CGSizeMake(480, 550);
        
        SKSpriteNode *menubg = [SKSpriteNode spriteNodeWithImageNamed:@"menubg"];
        menubg.zPosition =-1;
        menubg.size = CGSizeMake(480, 550);
        menubg.position = CGPointMake(0, 0);
        
        [self addChild:menubg];
        
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
        
        vs = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        vs.text = @"-";
        vs.fontColor = [UIColor yellowColor];
        vs.fontSize = 150.0f;
        vs.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        vs.position =CGPointMake(-34, 98);
        vs.zPosition = 1;
        vs.name = @"vs";
        
        [self addChild:vs];
        
        vs1 = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        vs1.text = @"-";
        vs1.fontColor = [UIColor blueColor];
        vs1.fontSize = 150.0f;
        vs1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        vs1.position =CGPointMake(-32, 100);
        vs1.zPosition = 1;
        vs1.name = @"vs1";
        
        [self addChild:vs1];
        
        winner1 = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        winner1.text = @"OUT OF BOUNDS";
        winner1.fontColor = [UIColor yellowColor];
        winner1.fontSize = 50.0f;
        winner1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        winner1.position =CGPointMake(-208, -23);
        winner1.zPosition = 1;
        winner1.name = @"winner1";
        
        [self addChild:winner1];
        
        winner = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];
        winner.text = @"OUT OF BOUNDS";
        winner.fontColor = [UIColor purpleColor];
        winner.fontSize = 50.0f;
        winner.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        winner.position =CGPointMake(-210, -25);
        winner.zPosition = 1;
        winner.name = @"winner";
        
        [self addChild:winner];
        
        
        SKSpriteNode *startBtn = [SKSpriteNode spriteNodeWithImageNamed:@"startbtn"];
        startBtn.position = CGPointMake(-10, -100);
        startBtn.size = CGSizeMake(148, 50);
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

