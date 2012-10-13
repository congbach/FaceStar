//
//  PlayViewController.m
//  FaceGuitar
//
//  Created by YangShun on 12/10/12.
//  Copyright (c) 2012 YangShun. All rights reserved.
//

#import "PlayViewController.h"
#import "Controllers.h"

@interface PlayViewController () <ControllersDelegate> {
    Column *col1;
    Column *col2;
    Column *col3;
    Column *col4;
    NSTimer *updateTimer;
    int counter;
    IBOutlet UILabel *hit;
    IBOutlet UILabel *miss;
}

@end

@implementation PlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [Controllers sharedControllers].delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    counter = 0;
    
    col1 = [[Column alloc] init];
    col1.frame = CGRectMake(0, 0, 120, 600);
    col1.center = CGPointMake(204, 420);
    col1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:col1];
    
    col2 = [[Column alloc] init];
    col2.frame = CGRectMake(0, 0, 120, 600);
    col2.center = CGPointMake(410, 420);
    col2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:col2];
    
    col3 = [[Column alloc] init];
    col3.frame = CGRectMake(0, 0, 120, 600);
    col3.center = CGPointMake(614, 420);
    col3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:col3];
    
    col4 = [[Column alloc] init];
    col4.frame = CGRectMake(0, 0, 120, 600);
    col4.center = CGPointMake(820, 420);
    col4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:col4];

    updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/30.0f
                                                   target:self
                                                 selector:@selector(updateColumns)
                                                 userInfo:nil
                                                  repeats:YES];
    [updateTimer fire];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateHitCount)
                                                 name:@"hit"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateMissCount)
                                                 name:@"miss"
                                               object:nil];
}

- (IBAction)press:(id)sender {
    int number = ((UIButton*)sender).tag;
    switch (number) {
        case 1:
            if (col1.active) {
                col1.currHitDot.state = kHit;
                col1.currHitDot.backgroundColor = [UIColor orangeColor];
                col1.active = NO;
                [self updateHitCount];
            } else {
                [self updateMissCount];
            }
            break;
        case 2:
            if (col2.active) {
                col2.currHitDot.state = kHit;
                col2.currHitDot.backgroundColor = [UIColor orangeColor];
                col2.active = NO;
                [self updateHitCount];
            } else {
                [self updateMissCount];
            }
            break;
        case 3:
            if (col3.active) {
                col3.currHitDot.state = kHit;
                col3.currHitDot.backgroundColor = [UIColor orangeColor];
                col3.active = NO;
                [self updateHitCount];
            } else {
                [self updateMissCount];
            }
            break;
        case 4:
            if (col4.active) {
                col4.currHitDot.state = kHit;
                col4.currHitDot.backgroundColor = [UIColor orangeColor];
                col4.active = NO;
                [self updateHitCount];
            } else {
                [self updateMissCount];
            }
            break;
            
        default:
            break;
    }
}

- (void)updateHitCount {
    hit.text = [NSString stringWithFormat:@"%d", [hit.text intValue]+1];
}

- (void)updateMissCount {
    miss.text = [NSString stringWithFormat:@"%d", [miss.text intValue]+1];
}

- (void)generateDots {
    if (arc4random() % 3 == 0) {
        [col1 addBlock];
    }
    if (arc4random() % 3 == 0) {
        [col2 addBlock];
    }
    if (arc4random() % 3 == 0) {
        [col3 addBlock];
    }
    if (arc4random() % 3 == 0) {
        [col4 addBlock];
    }
}

- (void)updateColumns {
    counter++;
    if (counter == 30) {
        [self generateDots];
        counter = 0;
    }
    [col1 update];
    [col2 update];
    [col3 update];
    [col4 update];
    NSLog(@"col1: %d, col2: %d, col3: %d, col4: %d", col1.active,
                                                      col2.active,
                                                      col3.active,
                                                      col4.active);
}

- (void)generateDotForCol1:(BOOL)one
                      col2:(BOOL)two
                      col3:(BOOL)three
                      col4:(BOOL)four {
    if (one) {
        [col1 addBlock];
    }
    if (two) {
        [col2 addBlock];
    }
    if (three) {
        [col3 addBlock];
    }
    if (four) {
        [col4 addBlock];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)controllers:(Controllers *)controllers didChangeButtonStateButtonType:(ControllerButtonType)buttonType newButtonState:(ControllerButtonState)buttonState
{
    if (buttonType == kButtonTap)
    {
        TunesController *tunesController = [Controllers sharedControllers].tunesController;
        if (tunesController.aButtonState == kButtonPressed || tunesController.aButtonState == kButtonJustPressed)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 1;
            [self press:button];
        }
        if (tunesController.bButtonState == kButtonPressed || tunesController.bButtonState == kButtonJustPressed)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 2;
            [self press:button];
        }
        if (tunesController.xButtonState == kButtonPressed || tunesController.xButtonState == kButtonJustPressed)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 3;
            [self press:button];
        }
        if (tunesController.yButtonState == kButtonPressed || tunesController.yButtonState == kButtonJustPressed)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 4;
            [self press:button];
        }
    }
}

@end