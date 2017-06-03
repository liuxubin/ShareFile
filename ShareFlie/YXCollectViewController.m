//
//  YXCollectViewController.m
//  ShareFlie
//
//  Created by 刘旭斌 on 2017/6/3.
//  Copyright © 2017年 kodbin. All rights reserved.
//

#import "YXCollectViewController.h"
#import "YXCollectionViewCell.h"
#import "HUPhotoBrowser.h"
#import "KRVideoPlayerController.h"

#define Width self.view.bounds.size.width
#define Height self.view.bounds.size.height

@interface YXCollectViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectView;
@property (nonatomic,strong)NSMutableArray *arrData;
@property (nonatomic,strong)NSMutableArray *arrFileUrl;
@property (nonatomic,assign)DATATYPE type;
@property (nonatomic,strong)KRVideoPlayerController *videoController;

@end

@implementation YXCollectViewController

//图片
- (instancetype)initWithArrData:(NSMutableArray *)arrData{

    if (self = [super init]) {
        self.arrData = arrData;
        self.type = IMAGES;
    }
    return self;
}
//视频
- (instancetype)initWithArrImages:(NSMutableArray *)arrImages arrFileUrl:(NSMutableArray *)arrFileUrl{

    if (self = [super init]) {
        self.arrData = arrImages;
        self.type = MOVIES;
        self.arrFileUrl = arrFileUrl;
    }
    return self;

}

- (UICollectionView *)collectView{

    if (!_collectView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(110, 110);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Width, Height) collectionViewLayout:layout];
        _collectView.backgroundColor = [UIColor lightGrayColor];
        _collectView.dataSource = self;
        _collectView.delegate = self;
        [_collectView registerNib:[UINib nibWithNibName:@"YXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    [self.view addSubview:self.collectView];
    
    
    
    
    
    
    
    
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


    YXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.image.image = self.arrData[indexPath.row];
    
    if (self.type == IMAGES) {
        cell.im.hidden = YES;
    }
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.type == IMAGES) {
  
        YXCollectionViewCell *cell = (YXCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //本地加载
         [HUPhotoBrowser showFromImageView:cell.image withImages:self.arrData placeholderImage:nil atIndex:indexPath.row dismiss:nil];
        //网络加载
         //        [HUPhotoBrowser showFromImageView:cell.image withURLStrings:self.arrData atIndex:indexPath.row];
        
        
    }else if (self.type == MOVIES){
    
    
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, Width, Width*(9.0/16.0))];
        
        self.videoController.contentURL = self.arrFileUrl[indexPath.row];
        
        [self.videoController showInWindow];
    
    }


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
