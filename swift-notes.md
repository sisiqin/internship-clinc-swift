
1、设置UITextField的placeholder字体的颜色和字号

```
textField.placeholder = @"请输入用户名";  
[textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];  
[textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];

// <#注释#>
```


2、创建按钮添加拖动和点击事件

```
//添加点击事件
[btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//添加拖动事件
[btn addTarget:self action:@selector(dragMoving:withEvent:)forControlEvents: UIControlEventTouchDragInside];
//添加拖动结束时的事件
[btn addTarget:self action:@selector(dragEnded:withEvent:)forControlEvents: UIControlEventTouchUpInside];

/**
*事件
*/
//拖动过程中
- (void)dragMoving:(UIControl *)c withEvent:ev
{
CGPoint point = [[[ev allTouches] anyObject] locationInView:self.view];   
point.x = MIN(MAX(point.x, btn.width * 0.5 + 10) , self.view.width - btn.width * 0.5 - 10);//范围
point.y = MIN(MAX(point.y, 100), self.view.height - btn.height * 0.5 - 10);//范围
c.center = point;
_isClick = NO;
}
//拖动结束
- (void)dragEnded:(UIControl *)c withEvent:ev
{
XDLog(@"dragEnded....");   
CGPoint point = [[[ev allTouches] anyObject] locationInView:self.view];
point.x = MIN(MAX(point.x, btn.width * 0.5 + 10), self.view.width - btn.width * 0.5 - 10);//范围
point.y = MIN(MAX(point.y, 100) , self.view.height - btn.height * 0.5 - 10);//范围
c.center = point;
[UIView animateWithDuration:0.2 animations:^{
c.centerX = c.centerX < self.view.width - c.centerX ? 30 : self.view.width - 30;
}];
_isClick = YES;
}
//点击事件
- (void)btnClick:(UIButton *)btn
{
if (_isClick) {
//点击方法
}
}

```

3、判断是否同一日

- (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
NSCalendar* calendar = [NSCalendar currentCalendar];

unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];

return [comp1 day]   == [comp2 day] &&
[comp1 month] == [comp2 month] &&
[comp1 year]  == [comp2 year];
}

4、禁止横屏


```
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
return UIInterfaceOrientationMaskPortrait;
}
```

5、电池状态栏改变颜色


```
[self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];

默认的黑色（UIStatusBarStyleDefault）
白色（UIStatusBarStyleLightContent）

- (UIStatusBarStyle)preferredStatusBarStyle
{
return UIStatusBarStyleLightContent;
}

```

6、UITableView的Group样式下顶部空白处理
```
UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
self.tableView.tableHeaderView = view;

#pragma mark - 处理导航栏下1px横线
_imageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
return (UIImageView *)view;
}
for (UIView *subview in view.subviews) {
UIImageView *imageView = [self findHairlineImageViewUnder:subview];
if (imageView) {
return imageView;
}
}
return nil;
}

//UITableView点击一下就出现灰色但是立马消失掉。

//点击那一刻可以指示出点击了哪一行，灰色停留一秒钟消失掉。

//1.设置cell点击时候为灰色

cell.selectionStyle = UITableViewCellSelectionStyleGray;  

//2.在tableView代理方法didSelectedRow方法这样写

- (void)tableView：(UITableView *)tableView didSelecteRowAtIndexPath:(NSIndexPath *)indexPath{

[ tableView deselectRowAtIndexPath:indexPath animated:YES];//直接取消选中这一行

}

```

7、对图片尺寸进行压缩

```
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
// Create a graphics image context
UIGraphicsBeginImageContext(newSize);

// Tell the old image to draw in this new context, with the desired
// new size
[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];

// Get the new image from the context
UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();

// End the context
UIGraphicsEndImageContext();

// Return the new image.
return newImage;
}
```

8、虚线图片
```

- (UIImage *)imageWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth
{
UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
[[UIColor clearColor] set];
CGContextRef context = UIGraphicsGetCurrentContext();
CGContextBeginPath(context);
CGContextSetLineWidth(context, borderWidth);
CGContextSetStrokeColorWithColor(context, color.CGColor);
CGFloat lengths[] = { 3, 1 };
CGContextSetLineDash(context, 0, lengths, 1);
CGContextMoveToPoint(context, 0.0, 0.0);
CGContextAddLineToPoint(context, size.width, 0.0);
CGContextAddLineToPoint(context, size.width, size.height);
CGContextAddLineToPoint(context, 0, size.height);
CGContextAddLineToPoint(context, 0.0, 0.0);
CGContextStrokePath(context);
UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();
return image;
}

```
9、button 按钮图片和文字(图片左·文字右，文字隔图片10px)

```
//当图片过大时·文字可能显示不出来·所以要把图片压缩成button一样的高度·就可以显示出来
[btn setImage:image forState:UIControlStateNormal];
[btn setTitle:name forState:UIControlStateNormal];
btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

//button 折行显示设置
/*
NSLineBreakByWordWrapping = 0,         // Wrap at word boundaries, default
NSLineBreakByCharWrapping,     // Wrap at character boundaries
NSLineBreakByClipping,     // Simply clip 裁剪从前面到后面显示多余的直接裁剪掉

文字过长 button宽度不够时: 省略号显示位置...
NSLineBreakByTruncatingHead,   // Truncate at head of line: "...wxyz" 前面显示
NSLineBreakByTruncatingTail,   // Truncate at tail of line: "abcd..." 后面显示
NSLineBreakByTruncatingMiddle  // Truncate middle of line:  "ab...yz" 中间显示省略号
*/
button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
// you probably want to center it
button.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to
button.layer.borderColor = [UIColor blackColor].CGColor;
button.layer.borderWidth = 1.0;

// underline Terms and condidtions
NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"View Terms and Conditions"];

//设置下划线...
/*
NSUnderlineStyleNone                                    = 0x00, 无下划线
NSUnderlineStyleSingle                                  = 0x01, 单行下划线
NSUnderlineStyleThick NS_ENUM_AVAILABLE(10_0, 7_0)      = 0x02, 粗的下划线
NSUnderlineStyleDouble NS_ENUM_AVAILABLE(10_0, 7_0)     = 0x09, 双下划线
*/
[tncString addAttribute:NSUnderlineStyleAttributeName
value:@(NSUnderlineStyleSingle)
range:(NSRange){0,[tncString length]}];
//此时如果设置字体颜色要这样
[tncString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]  range:NSMakeRange(0,[tncString length])];

//设置下划线颜色...
[tncString addAttribute:NSUnderlineColorAttributeName value:[UIColor redColor] range:(NSRange){0,[tncString length]}];
[button setAttributedTitle:tncString forState:UIControlStateNormal];
```

10、刷新框架的适配iOS11
```
if (@available(iOS 11.0, *)) {
self.tableview.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
} else {
self.automaticallyAdjustsScrollViewInsets = false;
}

//代码适配iOS11

#define naviBarH ([[UIApplication sharedApplication] statusBarFrame].size.height + 44)
#define tabBarH ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define AboveIOS9  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
// iPhone X 尺寸 375*812
#define XY_iPhoneX (IS_IPHONE && XY_ScreenWidth == 375.f && XY_ScreenHeight == 812.f)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SafeAreaBottomHeight (kWJScreenHeight == 812.0 ? 34 : 0)

//iOS11 刷新单个cell或者刷新一组cell 的时候需要用到，不然会移动
_tableView.estimatedRowHeight = 0;
_tableView.estimatedSectionHeaderHeight = 0;
_tableView.estimatedSectionFooterHeight = 0;

//代码适配安全区域
- (void)viewSafeAreaInsetsDidChange {
[super viewSafeAreaInsetsDidChange];

NSLog(@"viewSafeAreaInsetsDidChange-%@",NSStringFromUIEdgeInsets(self.view.safeAreaInsets));

[self updateOrientation];
}
- (void)updateOrientation {
if (@available(iOS 11.0, *)) {
CGRect frame = self.customerView.frame;
frame.origin.x = self.view.safeAreaInsets.left;
frame.size.width = self.view.frame.size.width - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right;
frame.size.height = self.view.frame.size.height - self.view.safeAreaInsets.bottom;
self.customerView.frame = frame;
} else {
// Fallback on earlier versions
}
}
```

11、UITableViewcell 镶嵌 UITextField 复用的问题

```
//1
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
if (block) {
block([textField.text stringByReplacingCharactersInRange:range withString:string]);
}
return YES;;
}

//2
cell. block = ^(NSString *title) {
[self.dataDic setObject:title forKey:@(indexPath.row)];
};
NSArray *arr = [self.dataDic allKeys];
if ([arr containsObject:@(indexPath.row)]) {
cell.textField.text = [self.dataDic objectForKey:@(indexPath.row)];
}else{
cell.textField.text = nil;
}

```
