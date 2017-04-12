//
//  ViewController.m
//  Broadcast
//
//  Created by songge on 2017/4/12.
//  Copyright © 2017年 songge. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVSpeechSynthesizerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *voiceText;


/** 语言数组 */
@property (nonatomic, strong) NSArray<AVSpeechSynthesisVoice *> *laungeVoices;

/** 语音合成器 */
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.synthesizer=[[AVSpeechSynthesizer alloc]init];
    self.synthesizer.delegate=self;
    
}

-(NSArray<AVSpeechSynthesisVoice *> *)laungeVoices{
    if (_laungeVoices == nil) {
        _laungeVoices =  @[
                           //美式英语
                           [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],
                           //英式英语
                           [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"],
                           //中文
                           [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]
                           ];
    }
    return _laungeVoices;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//暂停
- (IBAction)pauseClicked:(UIButton *)sender {
    
    if (self.synthesizer.isPaused == YES) {
        [sender setImage:[UIImage imageNamed:@"playVoice"] forState:UIControlStateNormal];
        [self.synthesizer continueSpeaking];
    } else {
          [sender setImage:[UIImage imageNamed:@"pauseVoice"] forState:UIControlStateNormal];
        [self.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
    
}

//播放
- (IBAction)broadcastClicked:(id)sender {
    //创建会话
    AVSpeechUtterance *utterance=[[AVSpeechUtterance alloc]initWithString:self.voiceText.text];
    //选择发音，英文中文
    utterance.voice = self.laungeVoices[2];
    
    //播放速度
    utterance.rate=0.4f;
    
    //音调
    utterance.pitchMultiplier=1.2f;
    
    //让语音合成器在播放下一句之前有短暂的暂停
    utterance.postUtteranceDelay=0.1f;
    
    //播放语言
    [self.synthesizer speakUtterance:utterance];
}

#pragma mark---代理
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance{
    /** 将要播放的语音文字 */
    NSString *willSpeakRangeOfSpeechString = [utterance.speechString substringWithRange:characterRange];
    
    NSLog(@"播放的语音文字:%@",willSpeakRangeOfSpeechString);
}

@end
