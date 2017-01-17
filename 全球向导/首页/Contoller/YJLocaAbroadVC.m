
//
//  YJLocaAbroadVC.m
//  全球向导
//
//  Created by SYJ on 2017/1/9.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "YJLocaAbroadVC.h"
#import "ZWCollectionViewFlowLayout.h"
#import "Public.h"
#import "HeadView.h"
#import "CityViewCell.h"

#import "NBSearchResultController.h"
#import "NBSearchController.h"
#import "SearchResult.h"
#import "NSMutableArray+FilterElement.h"

#import "YJHomeModel.h"
#import "YJCityModel.h"
#import "YJConitineModel.h"


@interface YJLocaAbroadVC ()<UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,NBSearchResultControllerDelegate,CityViewCellDelegate>
{
    UITableView *_tableView;
    HeadView    *_CellHeadView;
    NSMutableArray *_locationCity; //定位当前城市
    
    NSMutableArray *_dataArray; //热门数据原
    
    NSMutableDictionary *_allCitysDictionary; //所有数据字典
    NSMutableArray *_keys; //城市首字母
    NSMutableArray *hotArr;
    NSMutableArray *letterArr;//首字母下的数组
    NSMutableArray *cityIdArr;//城市id数组
    NSArray *continent;    //洲数组
    
}
@property (nonatomic, strong)NBSearchController *searchController; //搜索的控制器

@property (nonatomic, strong)NSMutableArray *searchList; //搜索结果的数组

@property (nonatomic, strong)NBSearchResultController *searchResultController; //搜索的结果控制器

@property(strong,nonatomic)NSMutableArray *allCityArray;  //所有城市数组

@property (nonatomic, strong) NSMutableArray *cityID; //所有城市id


@end

@implementation YJLocaAbroadVC

#pragma mark - 懒加载一些内容
- (NSMutableArray *)cityID{
    
    if (!_cityID) {
        _cityID = [NSMutableArray array];
    }
    return _cityID;
}

-(NSMutableArray *)allCityArray
{
    if (!_allCityArray) {
        _allCityArray = [NSMutableArray array];
    }
    return _allCityArray;
}
- (NSMutableArray *)searchList
{
    if (!_searchList) {
        _searchList = [NSMutableArray array];
    }
    return _searchList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    _locationCity = [NSMutableArray array];
    _allCitysDictionary = [NSMutableDictionary dictionary];
    _keys = [NSMutableArray array];
    hotArr = [NSMutableArray array];
    letterArr = [NSMutableArray array];
    cityIdArr = [NSMutableArray array];
    continent = [NSArray array];
    //获取网络数据
    [self getNetWork];
    
    //    [self loadData];
    [self initTableView];
    [self initSearchController];
    
    
}


- (void)getNetWork{
    
    [WBHttpTool GET:[NSString stringWithFormat:@"%@/mainApp/toSelectCity",BaseUrl] parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        XXLog(@"%@",dict);
//        
//        //定位城市
//        _locationCity = [NSMutableArray arrayWithObject:@"北京市"];
//        [_dataArray addObject:_locationCity];
        
        //最近访问
//        NSArray *recentArray = [NSArray arrayWithObjects:@"青岛市",@"济南市",@"深圳市",@"长沙市",@"无锡市", nil];
//        [_dataArray addObject:recentArray];
//        
        if ([dict[@"code"] isEqualToString:@"1"]) {
            
            YJHomeModel *model = [YJHomeModel mj_objectWithKeyValues:dict[@"data"]];
            continent = [YJConitineModel mj_objectArrayWithKeyValuesArray:model.contList];
            XXLog(@"continent >>>>>> %@",continent);
            //热门城市
            NSArray *hotArray = model.externalHotCityList;
            for (int i = 0; i < hotArray.count; i++  ) {
                YJCityModel *model = hotArray[i];
                XXLog(@"%@",model.title);
                [hotArr addObject:model.name];
            }
            [_dataArray addObject:hotArr];
            
            //把请求的数据添加到数据源
            
            _allCitysDictionary = model.externalOpenCityMap;
            XXLog(@"%@",dict);
            
            
            //添加所有城市数组及id
            for (NSArray *array in _allCitysDictionary.allValues) {
                for (NSDictionary *citys in array) {
                    YJCityModel *openCH = [YJCityModel mj_objectWithKeyValues:citys];
                    [self.allCityArray addObject:openCH.name];
                    [self.cityID addObject:[NSNumber numberWithInt:openCH.ID]];
                    XXLog(@"%@",self.allCityArray);
                    XXLog(@"%@",self.cityID);
                }
            }
            
            //判断更改城市组名
            NSMutableArray *arr = [NSMutableArray array];
            for (NSString *str in [_allCitysDictionary allKeys]) {
                
                NSString *titleName;
                XXLog(@"%@",str);
                NSInteger inter = [str integerValue];
                YJConitineModel *model = continent[inter];
                titleName = model.name;
                [arr addObject:titleName];
            }
            XXLog(@"%@",arr);

            
            [_keys addObjectsFromArray:[arr sortedArrayUsingSelector:@selector(compare:)]];
            
            [_keys insertObject:@"◎" atIndex:0];
            [_allCitysDictionary setObject:_locationCity forKey:@"◎"];
            
            
            XXLog(@"%@",self.allCityArray);
            [_tableView reloadData];
        }else{
            
            SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:dict[@"msg"] alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
            }];
            alertV.sure_btnTitleColor = TextColor;
            [alertV show];
            XXLog(@"失败");
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)initTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    _tableView.sectionIndexColor = RGB(150, 150, 150);
    [self.view addSubview:_tableView];
}
//点击返回
- (void)backBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)initSearchController //创建搜索控制器
{
    self.searchResultController= [[NBSearchResultController alloc]init];
    self.searchResultController.delegate = self;
    _searchController = [[NBSearchController alloc]initWithSearchResultsController:self.searchResultController];
    _searchController.delegate = self;
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.delegate = self;
    _tableView.tableHeaderView = self.searchController.searchBar;
    
}

//修改SearchBar的Cancel Button 的Title

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;
{
    [_searchController.searchBar setShowsCancelButton:YES animated:YES];
    UIButton *btn = [_searchController.searchBar valueForKey:@"_cancelButton"];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section < 1) {
        return 1;
    }else{
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObjectsFromArray:[[_allCitysDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)]];
        //添加多余三个索引
//        [arr insertObject:@"Θ" atIndex:0];
//        [_allCitysDictionary setObject:@"1" forKey:@"Θ"];
        //            [_keys insertObject:@"♡" atIndex:0];
        //            [_allCitysDictionary setObject:recentArray forKey:@"♡"];
        [arr insertObject:@"◎" atIndex:0];
        [_allCitysDictionary setObject:_locationCity forKey:@"◎"];
        
        NSArray *array = [_allCitysDictionary objectForKey:[arr objectAtIndex:section]];
        return array.count;
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _keys.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section< 1) {
        
        return [CityViewCell getHeightWithCityArray:_dataArray[indexPath.section]];
    }else{
        
        return 47;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section< 1) {
        
        static NSString *identfire=@"Cell";
        
        CityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfire];
        
        if (!cell) {
            
            cell = [[CityViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfire];
        }
        
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setContentView: _dataArray[indexPath.section]];
        return cell;
        
    }else{
        
        static NSString *identfire = @"cellID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfire];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfire];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObjectsFromArray:[[_allCitysDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)]];
        //添加多余三个索引
//        [arr insertObject:@"Θ" atIndex:0];
//        [_allCitysDictionary setObject:@"1" forKey:@"Θ"];
//        //            [_keys insertObject:@"♡" atIndex:0];
        //            [_allCitysDictionary setObject:recentArray forKey:@"♡"];
        [arr insertObject:@"◎" atIndex:0];
        [_allCitysDictionary setObject:_locationCity forKey:@"◎"];

        
        NSArray *array = [_allCitysDictionary objectForKey:[arr objectAtIndex:indexPath.section]];
        
        for (int i = 0; i < array.count; i ++ ) {
            [letterArr removeAllObjects];
            YJCityModel *model = [YJCityModel mj_objectWithKeyValues:array[i]];
            [letterArr addObject:model.name];
        }
        
        cell.textLabel.text = letterArr[indexPath.row];
        return cell;
    }
    
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _CellHeadView=[[HeadView alloc]init];
    
    if (section==0) {
        
        _CellHeadView.TitleLable.text = @"热门城市";
    }else{
        
        _CellHeadView.TitleLable.text = _keys[section];
    }
    
    return _CellHeadView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array= [_allCitysDictionary objectForKey:[_keys objectAtIndex:indexPath.section]];
    //存储城市id
    for (int i = 0; i < array.count; i ++ ) {
        [letterArr removeAllObjects];
        YJCityModel *model = [YJCityModel mj_objectWithKeyValues:array[i]];
        [letterArr addObject:model.name];
        NSNumber *cityID = [NSNumber numberWithInt:model.ID];
        [cityIdArr addObject:cityID];
    }
    [self popRootViewControllerWithName:letterArr[indexPath.row] cityID:cityIdArr[indexPath.row]];
}

-(void)SelectCityNameInCollectionBy:(NSString *)cityName
{
    [self popRootViewControllerWithName:cityName cityID:_cityID.firstObject];
}
#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = [self.searchController.searchBar text];
    // 移除搜索结果数组的数据
    [self.searchList removeAllObjects];
    //过滤数据
    self.searchList = [SearchResult getSearchResultBySearchText:searchString dataArray:self.allCityArray];
    if (searchString.length == 0 && self.searchList!= nil) {
        [self.searchList removeAllObjects];
        [self.cityID removeAllObjects];
    }
    self.cityID = [self.cityID filterTheSameElement];
    self.searchList = [self.searchList filterTheSameElement];
    NSMutableArray *dataSource = nil;
    if ([self.searchList count] > 0) {
        dataSource = [NSMutableArray array];
        // 结局了数据重复的问题
        for (NSString *str in self.searchList) {
            [dataSource addObject:str];
        }
    }
    NSMutableArray *cityIDSource = nil;
    if ([self.cityID count] > 0) {
        cityIDSource = [NSMutableArray array];
        // 结局了数据重复的问题
        for (NSNumber *ID in self.cityID) {
            [cityIDSource addObject:ID];
        }
    }
    
    
    //刷新表格
    self.searchResultController.dataSource = dataSource;
    self.searchResultController.cityIDArr = cityIDSource;
    [self.searchResultController.tableView reloadData];
    [_tableView reloadData];
    
}
/**
 *  点击了搜索的结果的 cell
 *
 *  @param resultVC  搜索结果的控制器
 *  @param cityName    搜索结果信息的模型
 */
- (void)resultViewController:(NBSearchResultController *)resultVC didSelectFollowCity:(NSString *)cityName cityID:(NSNumber *)cityID
{
    self.searchController.searchBar.text = @"";
    [self.searchController dismissViewControllerAnimated:NO completion:nil];
    [self popRootViewControllerWithName:cityName cityID:cityID];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.searchController.active ? nil : _keys;
}
-(void)returnText:(ReturnCityName)block
{
    self.returnBlock = block;
}
- (void)popRootViewControllerWithName:(NSString *)cityName cityID:(NSNumber *)cityID
{
    self.returnBlock(cityName,cityID);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
