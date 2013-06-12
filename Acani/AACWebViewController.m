#import "AACWebViewController.h"

#define WebView() ((UIWebView *)self.view)

UIBarButtonItem *ActivityIndicatorBarButtonItem()
{
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicatorView.frame = CGRectMake(0, 0, 34, activityIndicatorView.frame.size.height);
    [activityIndicatorView startAnimating];
    return [[UIBarButtonItem alloc] initWithCustomView:activityIndicatorView];
}

@interface AACWebViewController () <UIWebViewDelegate> {
    NSString *_URLString;
}
@end

@implementation AACWebViewController

- (id)initWithURLString:(NSString *)URLString
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _URLString = URLString;
    }
    return self;
}

#pragma mark - NSObject

- (void)dealloc
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - UIViewController

- (void)loadView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    webView.delegate = self;
    self.view = webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [WebView() loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_URLString]]];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.navigationItem.rightBarButtonItem = ActivityIndicatorBarButtonItem();
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.navigationItem.rightBarButtonItem = nil;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Cannot Open Page", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alertView show];
}

@end
