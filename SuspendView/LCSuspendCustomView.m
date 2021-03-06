//
//  LCSuspendCustomView.m
//  LuochuanAD
//
//  Created by care on 17/5/8.
//  Copyright © 2017年 luochuan. All rights reserved.
//
/**
博文地址:http://blog.csdn.net/luochuanad/article/details/71522241
Github地址:https://github.com/LuochuanAD/OC-SuspendView/tree/master
*/

#import "LCSuspendCustomView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#define NavigationBarHeight 64
#define TabBarHeight 49
typedef NS_ENUM(NSInteger,ButtonDirection){
    ButtonDirectionLeft    =0,
    ButtonDirectionRight   =1,
    ButtonDirectionTop     =3,
    ButtonDirectionBottom  =4
};
/**
 userInteractionEnabled=YES
 SuspendButton/SuspendScrollView/SuspendImageView/SuspendView/..
 添加点击事件事,可点击同时又不影响控件跟随手指移动, 需要重写touchesBegan:/..等3个方法.
 */
@implementation SuspendButton
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder]touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder]touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder]touchesEnded:touches withEvent:event];
}

@end
@implementation SuspendScrollView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder]touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder]touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder]touchesEnded:touches withEvent:event];
}

@end
@implementation SuspendImageView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder]touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder]touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder]touchesEnded:touches withEvent:event];
}

@end
@implementation SuspendView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder]touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder]touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder]touchesEnded:touches withEvent:event];
}

@end

@interface LCSuspendCustomView()<UIScrollViewDelegate>
{
    AVPlayer *_player;
   
}
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, strong) NSString *suspendViewType;
@end

@implementation LCSuspendCustomView

- (void)initWithSuspendType:(NSString *)suspendType{
    
    self.suspendViewType=[NSString stringWithFormat:@"%@",suspendType];
    if ([suspendType isEqualToString:@"0"]) {
        [self createCustomButton];
        
    }else if ([suspendType isEqualToString:@"1"]){
        [self createCustomImageView];
        
    }else if ([suspendType isEqualToString:@"2"]){
        [self createCustomGif];
        
    }else if ([suspendType isEqualToString:@"3"]){
        [self createCustomMusic];
    }else if ([suspendType isEqualToString:@"4"]){
        [self createCustomVideo];
    }else if ([suspendType isEqualToString:@"5"]){
        [self createCustomScrollView];
    }else if ([suspendType isEqualToString:@"6"]){
        [self createCustomOtherView];
    }else{
        
    }
}
- (void)createCustomButton{
    if (!_customButton) {
        _customButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _customButton.frame=CGRectMake(0, 0, self.viewWidth, self.viewHeight);
        [_customButton setBackgroundImage:[UIImage imageNamed:@"button_on"] forState:UIControlStateNormal];
        _customButton.imageView.contentMode=UIViewContentModeScaleToFill;
        _customButton.selected=YES;
        _customButton.userInteractionEnabled=NO;
        [self addSubview:_customButton];
    }
}
- (void)createCustomImageView{
    if (!_customImgV) {
        _customImgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lovelyGirl"]];
        _customImgV.frame=CGRectMake(0, 0, self.viewWidth, self.viewHeight);
        _customImgV.userInteractionEnabled=NO;
        [self addSubview:_customImgV];
    }
}
- (void)createCustomGif{
    if (!_customGif) {
        NSData *data=[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"emojiGif" ofType:@"gif"]];
        _customGif=[[UIWebView alloc]init];
        _customGif.frame=CGRectMake(0, 0, self.viewWidth, self.viewHeight);
        _customGif.scalesPageToFit=YES;
        _customGif.scrollView.bounces=NO;
        [_customGif setOpaque:0];
        _customGif.userInteractionEnabled=NO;
        [_customGif loadData:data MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
        [self addSubview:_customGif];
    }
}
//自己搭建音乐界面
- (void)createCustomMusic{
    if (!_customContentView) {
        _customContentView=[[SuspendView alloc]init];
        _customContentView.frame=CGRectMake(0, 0, self.viewWidth, self.viewHeight);
        _customContentView.backgroundColor=[UIColor greenColor];
        _customContentView.userInteractionEnabled=YES;
        UIButton *playButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        playButton.frame=CGRectMake(0, 0, self.viewWidth/2, 50);
        [playButton setTitle:@"play" forState:UIControlStateNormal];
        [playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(playMusic:) forControlEvents:UIControlEventTouchUpInside];
        [_customContentView addSubview:playButton];
        UIButton *pauseButton=[UIButton buttonWithType:UIButtonTypeCustom];
        pauseButton.frame=CGRectMake(self.viewWidth/2, 0, self.viewWidth/2, 50);
        [pauseButton setTitle:@"pause" forState:UIControlStateNormal];
        [pauseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [pauseButton addTarget:self action:@selector(pauseMusic:) forControlEvents:UIControlEventTouchUpInside];
        [_customContentView addSubview:pauseButton];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"keys" ofType:@"mp3"];
        NSURL *remoteURL = [NSURL fileURLWithPath:filePath];
        _player = [AVPlayer playerWithURL:remoteURL];
        
        [self addSubview:_customContentView];
    }
}
- (void)playMusic:(UIButton *)btn{
    [_player play];
}
- (void)pauseMusic:(UIButton *)btn{
    [_player pause];
}
//自己搭建视频界面
- (void)createCustomVideo{
    if (!_customContentView) {
        _customContentView=[[SuspendView alloc]init];
        _customContentView.frame=CGRectMake(0, 0, self.viewWidth, self.viewHeight);
        _customContentView.userInteractionEnabled=YES;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"keep" ofType:@"mp4"];
        NSURL *remoteURL = [NSURL fileURLWithPath:filePath];
        _player = [AVPlayer playerWithURL:remoteURL];
        AVPlayerViewController*_playerVc = [[AVPlayerViewController alloc] init];
        _playerVc.player = _player;
        _playerVc.view.frame =CGRectMake(0, 0, self.viewWidth, self.viewHeight);
        [_customContentView addSubview:_playerVc.view];
        
        [self addSubview:_customContentView];
        
        [_playerVc.player play];
    }
}
- (void)createCustomScrollView{
    if (!_customScrollView) {
        _customScrollView=[[SuspendScrollView alloc]init];
        _customScrollView.frame=CGRectMake(0, 0, self.viewWidth, self.viewHeight);
        for (int i=0; i<4; i++) {
            UIImageView *imgeView=[[UIImageView alloc]initWithFrame:CGRectMake(self.viewWidth*i, 0, self.viewWidth, self.viewHeight-4)];
            imgeView.image=[UIImage imageNamed:[NSString stringWithFormat:@"tree_%02d",i]];
            _customScrollView.showsHorizontalScrollIndicator=YES;
            [_customScrollView addSubview:imgeView];
        }
        _customScrollView.pagingEnabled=YES;
        _customScrollView.contentSize=CGSizeMake(self.viewWidth*4, 0);
        _customScrollView.delegate=self;
        _customScrollView.scrollEnabled=NO;
        _customScrollView.backgroundColor=[UIColor grayColor];
        [self addSubview:_customScrollView];
    }
}
//自定义界面
- (void)createCustomOtherView{
    if (!_customContentView) {
        _customContentView=[[SuspendView alloc]init];
        _customContentView.frame=CGRectMake(0, 0, self.viewWidth, self.viewHeight);
        _customContentView.backgroundColor=[UIColor grayColor];
        _customContentView.userInteractionEnabled=YES;
         [self addSubview:_customContentView];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch=[touches anyObject];
    _startPoint=[touch locationInView:_rootView];
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch=[touches anyObject];
    CGPoint currentPoint=[touch locationInView:_rootView];
    self.superview.center=currentPoint;
   
    
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];

    UITouch *touch=[touches anyObject];
    CGPoint currentPoint=[touch locationInView:_rootView];
    if ((pow((_startPoint.x-currentPoint.x), 2)+pow((_startPoint.y-currentPoint.y), 2))<1) {
        if ([self.suspendDelegate respondsToSelector:@selector(suspendCustomViewClicked:)]) {
            [self.suspendDelegate  suspendCustomViewClicked:self];
            
        }
    }
    CGFloat left = currentPoint.x;
    CGFloat right = WINDOWS.width - currentPoint.x;
    CGFloat top = currentPoint.y+NavigationBarHeight;
    CGFloat bottom = WINDOWS.height - currentPoint.y-TabBarHeight-NavigationBarHeight;
    ButtonDirection direction = ButtonDirectionLeft;
    CGFloat minDistance = left;
    if (right < minDistance) {
        minDistance = right;
        direction = ButtonDirectionRight;
    }
    if (top < minDistance) {
        minDistance = top;
        direction = ButtonDirectionTop;
    }
    if (bottom < minDistance) {
        direction = ButtonDirectionBottom;
    }
    NSInteger topOrButtom;
    if (self.superview.center.y<_viewHeight/2+NavigationBarHeight) {
        topOrButtom=_viewHeight/2+NavigationBarHeight;
    }else if (self.superview.center.y>WINDOWS.height-TabBarHeight-_viewHeight/2-NavigationBarHeight){
        topOrButtom=WINDOWS.height-TabBarHeight-_viewHeight/2-NavigationBarHeight;
    }else{
        topOrButtom=self.superview.center.y;
    }
    NSInteger leftOrRight;
    if (self.superview.center.x<_viewWidth/2) {
        leftOrRight=_viewWidth/2;
    }else if (self.superview.center.x>WINDOWS.width-_viewWidth/2){
        leftOrRight=WINDOWS.width-_viewWidth/2;
    }else{
        leftOrRight=self.superview.center.x;
    }

    switch (direction) {
        case ButtonDirectionLeft:
        {
            
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(self.superview.frame.size.width/2, topOrButtom);
            }];
            if ([self.suspendDelegate respondsToSelector:@selector(dragToTheLeft)]) {
                [self.suspendDelegate dragToTheLeft];
            }
            break;
        }
        case ButtonDirectionRight:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(WINDOWS.width - self.superview.frame.size.width/2, topOrButtom);
            }];
            if ([self.suspendDelegate respondsToSelector:@selector(dragToTheRight)]) {
                [self.suspendDelegate dragToTheRight];
            }
            break;
        }
        case ButtonDirectionTop:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(leftOrRight, self.superview.frame.size.height/2+NavigationBarHeight);
            }];
            if ([self.suspendDelegate respondsToSelector:@selector(dragToTheTop)]) {
                [self.suspendDelegate dragToTheTop];
            }
            break;
        }
        case ButtonDirectionBottom:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(leftOrRight, WINDOWS.height - self.superview.frame.size.height/2-TabBarHeight);
            }];
            if ([self.suspendDelegate respondsToSelector:@selector(dragToTheBottom)]) {
                [self.suspendDelegate dragToTheBottom];
            }
            break;
        }
        default:
            break;
    }
    
}
@end
