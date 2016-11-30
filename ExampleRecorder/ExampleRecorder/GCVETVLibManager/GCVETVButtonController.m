//
//  ButtonControllerViewController.m
//  ExampleRecorder
//
//  Created by admin on 11/29/16.
//  Copyright © 2016 Alan Skipp. All rights reserved.
//

#import "GCVETVButtonController.h"

@interface GCVETVButtonController ()
@property (nonatomic, assign) BOOL isRecording;
@property (nonatomic, assign) int numberButton;
@end

@implementation GCVETVButtonController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil frame: (CGRect) frame{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.frame = frame;
        [self initView];
    }
    
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initView];
    }
    
    
    return self;
}

- (void) initView {
    _isRecording = NO;
    _numberButton = 2;
    float buttonWith = self.view.frame.size.width / _numberButton;
    CGRect toogleFrame = self.view.frame;
    toogleFrame.origin.x = 0;
    toogleFrame.origin.y = 0;
    toogleFrame.size.width = buttonWith;
    _toogleIcon = [[UIImageView alloc] initWithFrame:toogleFrame];
    _toogleIcon.contentMode = UIViewContentModeScaleAspectFit;
    _toogleIcon.image = [UIImage imageNamed:@"ic_stream"];
    
    _toogleIcon.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGestureToogle = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGestureToogle:)];
    
    tapGestureToogle.numberOfTapsRequired = 1;
    
    [tapGestureToogle setDelegate:self];
    
    
    CGRect closeFrame = self.view.frame;
    closeFrame.origin.x = buttonWith;
    closeFrame.origin.y = 0;
    closeFrame.size.width = buttonWith;
    _closeIcon = [[UIImageView alloc] initWithFrame:closeFrame];
    _closeIcon.contentMode = UIViewContentModeScaleAspectFit;
    _closeIcon.image = [UIImage imageNamed:@"ic_close"];
    
    _closeIcon.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGestureClose = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGestureToogle:)];
    
    tapGestureClose.numberOfTapsRequired = 1;
    
    [tapGestureClose setDelegate:self];
    
    [_closeIcon addGestureRecognizer:tapGestureClose];
    [_toogleIcon addGestureRecognizer:tapGestureToogle];
    
    CGRect bgFrame = self.view.frame;
    bgFrame.origin.x = 0;
    bgFrame.origin.y = 0;
    UIView *bgView = [[UIView alloc] initWithFrame:bgFrame];
    bgView.backgroundColor = [UIColor grayColor];
    bgView.alpha = 0.3;
    
    [self.view addSubview:bgView];
    [self.view addSubview:_toogleIcon];
    [self.view addSubview:_closeIcon];
}
- (void) tapGestureToogle: (UIGestureRecognizer *)gestureRecognizer
{
    UIImageView *tapImageView = (UIImageView *) gestureRecognizer.view;
    if([tapImageView isEqual:_toogleIcon]) {
        _toogleIcon.image = [UIImage imageNamed:_isRecording ? @"ic_stream" : @"ic_stop"];
        _isRecording = !_isRecording;
        if([self.delegate respondsToSelector:@selector(didToogleClick)]) {
            [self.delegate didToogleClick];
        }
    } else {
        _toogleIcon.image = [UIImage imageNamed:@"ic_stream"];
        _isRecording = NO;
        if([self.delegate respondsToSelector:@selector(didCloseClick)]) {
            [self.delegate didCloseClick];
        }
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
