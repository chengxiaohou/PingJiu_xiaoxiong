//
//  NewsVC.m
//  PingJiu
//
//  Created by 小熊 on 2018/11/28.
//  Copyright © 2018年 小熊. All rights reserved.
//

#import "NewsVC.h"

@interface NewsVC ()
@property (weak, nonatomic) IBOutlet EETableView *tableView;
@property (nonatomic,strong) NSArray *MJDatas;
@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = NO;
    [self.nav setTitle:@"红酒资讯" leftText:nil rightTitle:nil showBackImg:nil];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getTheDatas];
}

- (void)getTheDatas
{
    _MJDatas = @[
    @{@"time":@"2016-01-11 ",@"image":@"http://www.wine-world.com/UserFiles/images/2015/penny/00-Gamay-20151126.jpg",@"title":@"博若莱的年轻，来自佳美的轻盈",@"content":@"今年的博若莱新酒已上市，年轻的博若莱新酒又迎来一大批粉丝。您或许会疑问：为何博若莱葡萄酒适合如此年轻时饮用呢？其实这与酿造它的葡萄品种——佳美有密不可分的关系。",@"url":@"http://api.wine.app887.com/article.html?id=780745996"},
       
    @{@"time":@"2016-01-11",@"image":@"http://www.wine-world.com/UserFiles/images/01-wien-151126.jpg",@"title":@"入门级葡萄酒干货",@"content":@"对于葡萄酒爱好者而言，各种葡萄酒装备是必不可少的。从各种穿越古今的开瓶器，到各种创意十足的醒酒器，都可以让你享受到滋润的葡萄酒生活。ABSTRACT：When the party is over (and the bottles recycled), refined accessories become imbued wiht del",@"url":@"http://api.wine.app887.com/article.html?id=441129720"},
    @{@"time":@"2017-01-11 ",@"image":@"http://www.wine-world.com/UserFiles/images/2015/Mia/QQ%E5%9B%BE%E7%89%8720151127153754.jpg",@"title":@"插画版葡萄酒指南",@"content":@"插画版葡萄酒指南，图多字少！分分钟带你入门！ABSTRACT：Words are too boring to make a wine guide.（文/Mia）",@"url":@"http://api.wine.app887.com/article.html?id=234047635"},
    @{@"time":@"",@"image":@"http://www.wine-world.com/UserFiles/images/01-GSM-BLEND-180913.jpg",@"title":@"提起罗讷混酿，可别再说你只知道GSM",@"content":@"提起罗讷混酿，很多人的第一反应都是GSM。殊不知，其实罗讷河谷还存在许多种混酿，其中不乏世界顶级酒款。今天，我们便一同来探索罗讷河谷的混酿艺术。提起世界知名的混酿葡萄酒，除了波尔多混酿（Bordeaux Blend），同样来自法国的罗讷混酿（Rhone Valley Blend）也广受全球酿酒师和葡萄酒爱好者的追捧。在美国的华盛顿州） ",@"url":@"https://apiwinealone.app887.com//article/wine/article.html?id=1539611343046"},
     @{@"time":@"2018-11-25",@"image":@"http://news-social.b0.upaiyun.com//2018/5/1526048177.jpg",@"title":@"巴达果尼",@"content":@"晚上喝红酒提高记忆力、消除皱纹！所以女生要多喝红酒！特别是巴达果尼红酒?",@"url":@"https://apiwinealone.app887.com//article/wine/userpost.html?id=1542275592801"},
 
                 ];
}

#pragma mark - ......::::::: UITableViewDataSource :::::::......

#pragma mark TV段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark TV行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _MJDatas.count;
}

#pragma mark ［配置TV单元格］
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    NSDictionary *dic = _MJDatas[indexPath.row];
    SetImageViewImageWithURL_C(cell.image1, dic[@"image"], PlaceHolderName);
    cell.label1.text = dic[@"title"];
    cell.label2.text = dic[@"content"];
    cell.label3.text = dic[@"time"];
    return cell;
}

#pragma mark TV单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = _MJDatas[indexPath.row];
    [WebVC showWithUrl:dic[@"url"] andTheTitle:dic[@"title"] andTheDiff:200];
    
}



@end
