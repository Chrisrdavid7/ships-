//
//  ViewController.m
//  Ships
//
//  Created by Chris David on 11/29/15.
//  Copyright © 2015 Chris David. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

int score;
int lives;
int enemyAttackOccurance;
int enemoyPosition;
int randomSpeed;
float speedOfEnemy;


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    
    friendlyShip.hidden = YES;
    enemyShip.hidden = YES;
    motherShip.hidden = YES;
    missleShip.hidden = YES;
    
    scoreLabel.hidden = YES;
    livesLabel.hidden = YES;
    
    score = 0;
    lives = 3;
    
    scoreString = [NSString stringWithFormat:@"SCORE: 0"];
    livesString = [NSString stringWithFormat:@"LIVES: 0"];
    
    scoreLabel.text = scoreString;
    livesLabel.text = livesString;
    
    friendlyShip.center = CGPointMake(140,400);
    enemyShip.center = CGPointMake(140, -40);
    
    missleShip.center = CGPointMake(friendlyShip.center.x, friendlyShip.center.y);
    motherShip.layer.cornerRadius = 50;
}
- (IBAction)startGame:(id)sender{
    
    friendlyShip.hidden = NO;
    enemyShip.hidden = NO;
    motherShip.hidden = NO;
    missleShip.hidden = NO;
    
    scoreLabel.hidden = NO;
    livesLabel.hidden = NO;
    
    [self positionEnemy];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    

}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    friendlyShip.center = CGPointMake(point.x, friendlyShip.center.y);
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [missleMovementTimer invalidate];
    missleShip.hidden = NO;
    missleShip.center = CGPointMake(friendlyShip.center.x, friendlyShip.center.y);
    
    missleMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(enemyMovement) userInfo:nil repeats:YES];
    
}
- (void)positionEnemy{
    enemoyPosition = arc4random() % 249;
    enemoyPosition = enemoyPosition + 20;
    
    enemyShip.center = CGPointMake(enemoyPosition, -40);
    randomSpeed = arc4random() % 3;
    switch (randomSpeed) {
        case 0:
            speedOfEnemy = 0.03;
            break;
        case 1:
            speedOfEnemy = 0.02;
            break;
        case 2:
            speedOfEnemy = 0.01;
        default:
            break;
    }
    enemyAttackOccurance = arc4random() % 5;
    [self performSelectorOnMainThread:@selector(enemyMovementTimerMethod) withObject:NULL waitUntilDone:enemyAttackOccurance];
}
- (void)enemyMovementTimerMethod{
    enemyMovementTimer = [NSTimer scheduledTimerWithTimeInterval:speedOfEnemy target:self selector:@selector(enemyMovement) userInfo:nil repeats:YES];

}
- (void)enemyMovement{
    enemyShip.center = CGPointMake(enemyShip.center.x, enemyShip.center.y + 2);
    
    if (CGRectIntersectsRect(enemyShip.frame, motherShip.frame)) {
        lives = lives - 1;
        livesString = [NSString stringWithFormat:@"LIVES: %i", lives];
        livesLabel.text = livesString;
        [enemyMovementTimer invalidate];
        
        if (lives > 0) {
            [self positionEnemy];

        }
        if (lives == 0) {
            [self gameOver];
        }
    }
    
}
- (void)missleMovement{
    missleShip.hidden = NO;
    missleShip.center = CGPointMake(missleShip.center.x,  missleShip.center.y - 2);
    
    if (CGRectIntersectsRect(missleShip.frame, enemyShip.frame)) {
        score = score + 5;
        scoreString = [NSString stringWithFormat:@"SCORE: %i", score];
        scoreLabel.text = scoreString;
        [missleMovementTimer invalidate];
        
        missleShip.center = CGPointMake(friendlyShip.center.x, friendlyShip.center.y);
        missleShip.hidden = YES;
        
        [enemyMovementTimer invalidate];
        [self positionEnemy];
    }
    
}
- (void)gameOver{
    [enemyMovementTimer invalidate];
    [missleMovementTimer invalidate];
     [self performSelector:@selector(replayGame) withObject:nil afterDelay:3];
}
- (void)replayGame{
    
    friendlyShip.hidden = YES;
    enemyShip.hidden = YES;
    motherShip.hidden = YES;
    missleShip.hidden = YES;
    
    scoreLabel.hidden = YES;
    livesLabel.hidden = YES;
    
    score = 0;
    lives = 3;
    
    scoreString = [NSString stringWithFormat:@"SCORE: 0"];
    livesString = [NSString stringWithFormat:@"LIVES: 0"];
    
    scoreLabel.text = scoreString;
    livesLabel.text = livesString;
    
    friendlyShip.center = CGPointMake(140,400);
    enemyShip.center = CGPointMake(140, -40);
    
    missleShip.center = CGPointMake(friendlyShip.center.x, friendlyShip.center.y);
    motherShip.layer.cornerRadius = 50;

}

@end
