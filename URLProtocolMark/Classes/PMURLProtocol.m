//
//  PMURLProtocol.m
//  URLProtocolMark
//
//  Created by steve on 01/09/2018.
//

#import "PMURLProtocol.h"

static NSString *const PROTOCOL_Key = @"LPDS_URL_PROTOCOL_Key";

@interface PMURLProtocol()<NSURLSessionDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSessionDataTask *task;

@end

@implementation PMURLProtocol

+ (void)load {
    [PMURLProtocol start];
}

+ (void)start {
    [PMURLProtocol registerClass:[PMURLProtocol class]];
}

+ (void)end {
    [PMURLProtocol unregisterClass:[PMURLProtocol class]];
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    // 过滤已经拦截过的 request 防止死循环
    if ([NSURLProtocol propertyForKey:PROTOCOL_Key inRequest:request]) {
        return NO;
    }
//    NSString *scheme = [[request URL] scheme];
//    if ([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
//        [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame) {
//        return YES;
//    }
    NSString *host = [[request URL] host] ?: @"";
    for (NSString *domain in [self filterSites]) {
        if ([domain containsString:host]) {
            return YES;
        }
    }
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    return [mutableReqeust copy];
}

- (void)startLoading {
    NSURLRequest *request = [[self class] canonicalRequestForRequest:self.request];
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    // 过滤已经拦截过的 request 防止死循环
    [NSURLProtocol setProperty:@(YES) forKey:PROTOCOL_Key inRequest:mutableRequest];
    // 使用NSURLSession继续把重定向的request发送出去
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *currentQueue = [NSOperationQueue currentQueue];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:currentQueue];
    self.task = [session dataTaskWithRequest:[mutableRequest copy]];
    [self.task resume];
}

- (void)stopLoading {
    [self.task cancel];
}

# pragma mark: NSURLSessionDelegate

// 将拦截后的请求结果返回到原来的请求结果里去
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        [self.client URLProtocol:self didFailWithError:error];
    } else {
        [self.client URLProtocolDidFinishLoading:self];
    }
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    completionHandler(NSURLSessionResponseAllow);
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse *cachedResponse))completionHandler
{
    completionHandler(proposedResponse);
}

// url 白名单
+ (NSArray<NSString *> *)filterSites {
    return @[
             @"https://www.google.com/",
             @"https://www.baidu.com/"
            ];
}


@end

/// https://blog.moecoder.com/2016/10/26/support-nsurlprotocol-in-wkwebview/
