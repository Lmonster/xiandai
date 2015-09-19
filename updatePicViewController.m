//
//  updatePicViewController.m
//  new_LinearAlgebra
//
//  Created by WorkSpace_付国强 on 8/24/15.
//  Copyright (c) 2015 付国强. All rights reserved.
//

#import "updatePicViewController.h"

@interface updatePicViewController ()
<UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UITableViewDelegate,
UITableViewDataSource>

@end

@implementation updatePicViewController {
    NSMutableArray  *listArray;
    UIImage         *updateImage;
    UIImagePickerController *imagePick;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pickPic)];
    self.navigationItem.rightBarButtonItem = addItem;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)pickPic {
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"请选择来源" delegate:self cancelButtonTitle:@"返回" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    [action showInView:self.view];
}

#pragma mark - action sheet delegate 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    imagePick = [[UIImagePickerController alloc] init];
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            imagePick.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            imagePick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePick.allowsEditing = YES;
    imagePick.delegate = self;
    [self.navigationController presentViewController:imagePick animated:YES completion:nil];
}

#pragma mark - uiimage picker delegate 
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"开始加载");
    updateImage = [info objectForKey:UIImagePickerControllerEditedImage];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://apis.baidu.com/apistore/idlocr/ocr"]];
    request.HTTPMethod = @"POST";
    [request addValue:@"be09225a3d081c90a9564e96dc9156f5" forHTTPHeaderField:@"apikey"];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    NSData *imageData = UIImageJPEGRepresentation(updateImage, 0.9);
    NSString *imageString = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *paramentString = [NSString stringWithFormat:@"fromdevice=iPhone&clientip=10.10.10.0&detecttype=LocateRecognize&languagetype=CHN_ENG&imagetype=1&image=%@",imageString];
    NSData *paramentData = [paramentString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = paramentData;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *res , NSData *data , NSError *error){
        if (!error) {
            NSLog(@"success");
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",[dic objectForKey:@"errMsg"]);
            NSDictionary *aDic = [[dic objectForKey:@"retData"] firstObject];
            NSString *string = [aDic objectForKey:@"word"];
            NSLog(@"%@",string);
            [imagePick dismissViewControllerAnimated:YES completion:nil];
        }
    }];
//    /9j/4AAQSkZJRgABAQEAYABgAAD/2wBDABMNDxEPDBMREBEWFRMXHTAfHRsbHTsqLSMwRj5KSUU+RENNV29eTVJpU0NEYYRiaXN3fX59S12Jkoh5kW96fXj/2wBDARUWFh0ZHTkfHzl4UERQeHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHj/wAARCAAfACEDAREAAhEBAxEB/8QAGAABAQEBAQAAAAAAAAAAAAAAAAQDBQb/xAAjEAACAgICAgEFAAAAAAAAAAABAgADBBESIRMxBSIyQXGB/8QAFAEBAAAAAAAAAAAAAAAAAAAAAP/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/APawEBAQEBAgy8i8ZTVV3UY6V1eU2XoWDDZB19S646Gz39w9fkKsW1r8Wm2yo1PYis1be0JG9H9QNYCAgc35Cl3yuVuJZl0cB41rZQa32dt2y6OuOiOxo61vsLcVblxaVyXD3hFFjL6La7I/sDWAgICAgICB/9k=
}

#pragma mark - table view data source 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell ==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
