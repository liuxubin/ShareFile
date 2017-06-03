//
//  ViewController.m
//  ShareFlie
//
//  Created by 刘旭斌 on 2017/6/2.
//  Copyright © 2017年 kodbin. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "YXCollectViewController.h"

@interface ViewController ()


@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerViewController  *playerView;//没有用到
@property (nonatomic,strong) AVPlayerItem *items;

@property (nonatomic,strong) NSMutableArray *arrImages;
@property (nonatomic,strong) NSMutableArray *arrMovies;
@property (nonatomic,strong) NSMutableArray *arrMoviesUrl;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self localFile];
    
}

- (IBAction)imageFile:(id)sender {
    
    YXCollectViewController *vc = [[YXCollectViewController alloc]initWithArrData:self.arrImages];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)movieFile:(id)sender {
    
    YXCollectViewController *vc = [[YXCollectViewController alloc]initWithArrImages:self.arrMovies arrFileUrl:self.arrMoviesUrl];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)localFile{
    
    //文件夹路径
    // NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //文件管理类
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //目录枚举类
    NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:docsDir];
    //创建一个文件夹
//    NSString *directryPath = [docsDir stringByAppendingPathComponent:@"imageViews"];
//    [fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    //开始遍历路径下的目录
    NSString *fileName;
    self.arrImages = [NSMutableArray array];
    self.arrMovies = [NSMutableArray array];
    self.arrMoviesUrl = [NSMutableArray array];
    while (fileName = [dirEnum nextObject]) {
        
        NSLog(@"----------FielName : %@" , fileName);
        NSLog(@"-----------------FileFullPath : %@" , [docsDir stringByAppendingPathComponent:fileName]) ;
        
        // .jpg .jpeg .gif .png .bmp 判断图片格式
        BOOL isImage = [fileName containsString:@".jpg"]||[fileName containsString:@".jpeg"]||[fileName containsString:@".png"];
        if (isImage) {
            //图片
            UIImage *newimage=[UIImage imageWithContentsOfFile:[docsDir stringByAppendingPathComponent:fileName]];
            [self.arrImages addObject:newimage];
        }else{
           
            //影片
            //URL
            NSURL *url=[NSURL fileURLWithPath:[docsDir stringByAppendingPathComponent:fileName]];
            
            [self.arrMovies addObject:[self thim:url]];
            [self.arrMoviesUrl addObject:url];
            
            /*
             //item
             AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:url];
            //AVPlayer
            self.player = [[AVPlayer alloc]initWithPlayerItem:playerItem];
            //layer层
            AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
            layer.frame = CGRectMake(0, 100, self.view.frame.size.width, 200);
            layer.backgroundColor = [UIColor greenColor].CGColor;
            layer.videoGravity = AVLayerVideoGravityResize;
            [self.view.layer addSublayer:layer];
            //播放
            [self.player play];
             */
        
        }
        
    }
    
}

//取图片帧
- (UIImage *)thim:(NSURL *)url{

    UIImage *image = [UIImage imageNamed:@"图片"];
    AVAsset *sets = [AVAsset assetWithURL:url];
    AVAssetImageGenerator  *imageGen = [[AVAssetImageGenerator alloc] initWithAsset:sets];
    if (imageGen) {
        imageGen.appliesPreferredTrackTransform = YES;
        CMTime actualTime;
        //0:第几秒 10:每秒帧数
        CGImageRef cgImage = [imageGen copyCGImageAtTime:CMTimeMakeWithSeconds( 0, 10) actualTime:&actualTime error:NULL];
        if (cgImage) {
            image = [UIImage imageWithCGImage:cgImage];
            CGImageRelease(cgImage);
        }
    }
    return image;
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
