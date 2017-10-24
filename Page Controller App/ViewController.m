
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIPageControl *myPageControl;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@end

@implementation ViewController


-(void)loadScrollViewWithPage:(UIView *)page
{
    NSUInteger pageCount = [[_myScrollView subviews] count] - 1;
    
    CGRect bounds = _myScrollView.bounds;
    bounds.origin.x = bounds.size.width * pageCount;
    bounds.origin.y = 0;
    page.frame = bounds;
    [_myScrollView addSubview:page];
}

-(void) createPages
{
    CGRect pageRect = _myScrollView.frame;
    
    UIView *page1 = [[UIView alloc] initWithFrame:pageRect];
    page1.backgroundColor = [UIColor redColor];
    
    UIView *page2 = [[UIView alloc] initWithFrame:pageRect];
    page2.backgroundColor = [UIColor blueColor];
    
    UIView *page3 = [[UIView alloc] initWithFrame:pageRect];
    page3.backgroundColor = [UIColor greenColor];
    
    UIView *page4 = [[UIView alloc] initWithFrame:pageRect];
    page4.backgroundColor = [UIColor darkGrayColor];
    
    //add them to scrooll view
    [self loadScrollViewWithPage:page1];
    [self loadScrollViewWithPage:page2];
    [self loadScrollViewWithPage:page3];
    [self loadScrollViewWithPage:page4];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewDidAppear:(BOOL)animated

{
[super viewDidAppear:true];
    
    int pageCount = 4;
    
    _myScrollView.showsHorizontalScrollIndicator = YES;
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.delegate = self;
    _myScrollView.contentSize = CGSizeMake(_myScrollView.frame.size.width * pageCount,
                                           _myScrollView.frame.size.height);
    
    _myScrollView.pagingEnabled = true;
    

    
    
    _myPageControl.numberOfPages = pageCount;
    _myPageControl.currentPage = 0;
    [_myPageControl addTarget:self
                       action:@selector(changePage:)
             forControlEvents: UIControlEventValueChanged];
    
    
    
    
    
    // creat pages
    [self createPages];
}




- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _myPageControl.currentPage = page;
}






-(void)changePage:(id)sender
{
    NSUInteger page = _myPageControl.currentPage;
    
    //update the sroll view to the appropriate page
    CGRect frame = _myScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [_myScrollView scrollRectToVisible:frame animated:YES];
}


@end
