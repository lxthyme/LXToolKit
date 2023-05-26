//
//  LXWebViewTestVC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/3/14.
//  Copyright © 2022 CocoaPods. All rights reserved.
//
import RxSwift
import RxCocoa
import UIKit
import WebKit
import LXToolKit

class LXWebViewTestVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var webView: WKWebView = {
        // swiftlint:disable line_length
        // let meta = """
        // var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no');
        // document.head.appendChild(meta);
        // """
        let meta = """
        var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);
        """
        let css = """
        var style = document.createElement('style');
        style.innerHTML = 'body,html{width: 100%;height: 100%;}*{margin:0;padding:0;}img{max-width:100%;display:block; width:auto; height:auto;}';
        document.head.appendChild(style);
        """
        let metaScript = WKUserScript(source: meta, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let cssScript = WKUserScript(source: css, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        let controller = WKUserContentController()
        controller.addUserScript(metaScript)
        // controller.addUserScript(cssScript)
        let config = WKWebViewConfiguration()
        config.userContentController = controller
        let v = WKWebView(frame: .zero, configuration: config)
        v.navigationDelegate = self
        v.uiDelegate = self
        return v
    }()
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        bindViewModel()
    }
    // MARK: - 🍺UI Prepare & Masonry
    override open func prepareUI() {
        super.prepareUI()
        self.view.backgroundColor = .white;
        // webView.scrollView.rx.contentSize
        //     .subscribe(onNext: {[weak self] event in
        //         guard let `self` = self else { return }
        //         dlog("🛠1. onNext: \(event)")
        //     })
        //     .disposed(by: rx.disposeBag)
        [webView].forEach(self.view.addSubview)
        masonry()
    }
    override open func masonry() {
        super.masonry()
        webView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
    }
    override open func bindViewModel() {
        super.bindViewModel()
        // guard let vm = viewModel as? LXWebViewTestVCVM else { return }

        // let input = LXWebViewTestVCVM.Input()
        // let output = vm.transform(input: input)

        webView.loadHTMLString(mockData(), baseURL: nil)

        // output.dataList
        //     .asDriver(onErrorJustReturn: [])
        //     .drive(table.rx.items(cellIdentifier: <#LXEventCell#>.xl.xl_identifier, cellType: <#LXEventCell#>.self)) {tableView, vm, cell in
        //         // cell.bind(to: vm)
        //     }
        //     .disposed(by: rx.disposeBag)
    }
}
// MARK: 🌎LoadData
extension LXWebViewTestVC {}

// MARK: 👀Public Actions
extension LXWebViewTestVC {}

// MARK: 🔐Private Actions
extension LXWebViewTestVC {}

// MARK: - ✈️WKUIDelegate
@available(iOS 13.0.0, *)
extension LXWebViewTestVC: WKUIDelegate {
    func webView(_ webView: WKWebView, shouldAllowDeprecatedTLSFor challenge: URLAuthenticationChallenge) async -> Bool {
        return true
    }
}

// MARK: - ✈️WKNavigationDelegate
@available(iOS 13.0.0, *)
extension LXWebViewTestVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        dlog("-->didStartProvisionalNavigation navigation: \(navigation.debugDescription)")
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        dlog("-->decidePolicyFor navigationAction: \(navigationAction)\nurl: \(navigationAction.request.url)")
        // if let url = navigationAction.request.url,
        //    url.absoluteString != "about:blank" {
        // return .allow
        // } else {
        //     return .cancel
        // }
        return .allow
    }
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        dlog("-->webViewWebContentProcessDidTerminate")
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
        dlog("-->decidePolicyFor navigationResponse: \(navigationResponse)")
        return .allow
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        dlog("-->didFinish")
        webView.evaluateJavaScript("document.body.scrollHeight") { result, error in
            dlog("-->result: \(result.debugDescription)\nerror: \(error.debugDescription)")
        }
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        dlog("-->didFailProvisionalNavigation: \(navigation.debugDescription)\n\(error)")
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        dlog("-->didFail: \(navigation.debugDescription)\n\(error)")
    }
}

extension LXWebViewTestVC {
    func mockData() -> String {
        // swiftlint:disable line_length
        return """
<style type="text/css">img{display:block;width:100%;height:auto;}</style><img style="width:960px;height:auto" src='https://img14.iblimg.com/goods-151/images/brand/2022/04/442006102.png' /><div xgroup="1" style="width:960px; margin:0; padding:0; text-align:center;"><table border="0" cellpadding="0" cellspacing="0" width="960" style="font-family:Microsoft Yahei;font-size:16px;line-height:24px">    <tbody><tr style="width:511px">      <td>        <div style="margin-top:40px;margin-left:80px;">               <img xid="1" height="105px" width="105px" style="position:relative;left:-100px"  src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d1.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d1.jpg">            </div><table>          <tbody><tr width="511px" height="120px">          </tr>          <tr>             <td>                 <table style="margin-left:131px;width:380px;height:109px;margin-bottom:152px">                   <tbody><tr><td style="text-align:left; font-family:Microsoft 黑体; font-weight:bold; font-size:18px;color:#ffa801;vertical-align:top;padding-top: 0px;height:20px;" xid="2-1-1">健康  美味  可口</td></tr>                   <tr><td style="text-align:left; font-family:Microsoft 黑体; font-weight:bold; font-size:26px;color:#ffa801;vertical-align:top;padding-top: 0px;height:48px;" xid="2-1-2">茱蒂丝家乐什锦饼干</td></tr>                   <tr><td style="text-align:left; font-family:Microsoft Yahei; font-size:1px;color:#ffa801;vertical-align:top;padding-top: 0px;height:17px;" xid="2-1-3"> --------------------------------------------------------------- </td></tr>                   <tr><td style="text-align:left; font-family:Microsoft Yahei; font-weight:bold; font-size:18px;color:#ffa801;vertical-align:top;padding-top: 0px;height:24px;" xid="2-1-4">优质原料  独特工艺  营养丰富</td></tr>                 </tbody></table>             </td><td>          </td></tr>        </tbody></table>      </td><td width="13px"></td>      <td style="width:436px">        <div style="width:420px;height:420px;margin-right: 16px;margin-top:3px">            <img xid="1" height="420px" width="420px"  src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d2.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d2.jpg"></div>      </td>     </tr>     <tr style="height:66px;margin-bottom:0px;">     <td colspan="3" style="background:url('http://dams-pic.b0.upaiyun.com/images/1/0/百联-进口类新模板_1720150120044027.jpg')">     </td>     </tr></tbody></table></div>                    <div xgroup="1" style="width:960px; margin:0; padding:0; text-align:center;"><p style="margin:0; height:50px; width:960px;"></p><table border="0" cellpadding="10" cellspacing="10" width="960" style="font-family:Microsoft Yahei;font-size:16px;line-height:24px"><tbody><tr>                       <td width="8%"></td><td width="40%"><div style="border:1px solid #fff;width:400px;height:400px"><img xid="1" height="400px" width="400px"  src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d2.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d2.jpg"></div></td>                        <td width="2%"></td><td width="40%" valign="middle"><table width="100%" style="table-layout:fixed;word-break:break-all;word-wrap:break-word; font-family:Microsoft Yahei;" class="table-a"><tbody><tr xgroup="1">    <td style="text-align:left; vertical-align:top;padding-top: 0px;font-family:Microsoft Yahei; font-size:14px; line-height: 20px; font-weight:bold; width:75px; height:45px;color:#000;"><b xid="2-1-1" style="text-align:left;">品名：</b></td><td style="text-align:left; font-family:Microsoft Yahei; font-size:14px;color:#000;vertical-align:top;padding-top: 0px;" xid="2-1-2">茱蒂丝家乐什锦饼干530G</td></tr><tr xgroup="1">    <td style="text-align:left; vertical-align:top;padding-top: 0px;font-family:Microsoft Yahei; font-size:14px; line-height: 20px; font-weight:bold; width:75px; height:45px;color:#000;"><b xid="2-2-1" style="text-align:left;">品牌：</b></td><td style="text-align:left; font-family:Microsoft Yahei; font-size:14px;color:#000;vertical-align:top;padding-top: 0px;" xid="2-2-2">茱蒂丝</td></tr><tr xgroup="1">    <td style="text-align:left; vertical-align:top;padding-top: 0px;font-family:Microsoft Yahei; font-size:14px; line-height: 20px; font-weight:bold; width:75px; height:45px;color:#000;"><b xid="2-3-1" style="text-align:left;">原产国：<br></b></td><td style="text-align:left; font-family:Microsoft Yahei; font-size:14px;color:#000;vertical-align:top;padding-top: 0px;" xid="2-3-2">马来西亚</td></tr><tr xgroup="1">    <td style="text-align:left; vertical-align:top;padding-top: 0px;font-family:Microsoft Yahei; font-size:14px; line-height: 20px; font-weight:bold; width:75px; height:45px;color:#000;"><b xid="2-4-1" style="text-align:left;">规格：<br></b></td><td style="text-align:left; font-family:Microsoft Yahei; font-size:14px;color:#000;vertical-align:top;padding-top: 0px;" xid="2-4-2">1盒</td></tr><tr xgroup="1">    <td style="text-align:left; vertical-align:top;padding-top: 0px;font-family:Microsoft Yahei; font-size:14px; line-height: 20px; font-weight:bold; width:75px; height:45px;color:#000;"><b xid="2-5-1" style="text-align:left;">净含量：<br></b></td><td style="text-align:left; font-family:Microsoft Yahei; font-size:14px;color:#000;vertical-align:top;padding-top: 0px;" xid="2-5-2">530G</td></tr><tr xgroup="1">    <td style="text-align:left; vertical-align:top;padding-top: 0px;font-family:Microsoft Yahei; font-size:14px; line-height: 20px; font-weight:bold; width:75px; height:45px;color:#000;"><b xid="2-6-1" style="text-align:left;">配料：<br></b></td><td style="text-align:left; font-family:Microsoft Yahei; font-size:14px;color:#000;vertical-align:top;padding-top: 0px;" xid="2-6-2">小麦粉、白沙糖、植物油、脱脂奶粉、乳糖、玉米淀粉、乳清粉、花生酱、鸡蛋、食盐、柠檬酸、食用香料</td></tr><tr xgroup="1">    <td style="text-align:left; vertical-align:top;padding-top: 0px;font-family:Microsoft Yahei; font-size:14px; line-height: 20px; font-weight:bold; width:75px; height:45px;color:#000;"><b xid="2-7-1" style="text-align:left;">保质期：<br></b></td><td style="text-align:left; font-family:Microsoft Yahei; font-size:14px;color:#000;vertical-align:top;padding-top: 0px;" xid="2-7-2">见包装</td></tr><tr xgroup="1">    <td style="text-align:left; vertical-align:top;padding-top: 0px;font-family:Microsoft Yahei; font-size:14px; line-height: 20px; font-weight:bold; width:75px; height:45px;color:#000;"><b xid="2-8-1" style="text-align:left;">储存方法：</b></td><td style="text-align:left; font-family:Microsoft Yahei; font-size:14px;color:#000;vertical-align:top;padding-top: 0px;" xid="2-8-2">置于阴凉干燥处</td></tr></tbody></table></td>                        <td width="8%"></td></tr></tbody></table></div>                    <div xgroup="1" style="width:960px; margin:0; padding:0; text-align:center;"><p style="margin:0; height:50px; width:960px;"></p><table border="0" cellpadding="10" cellspacing="10" style="font-family:Microsoft Yahei;font-size:16px;line-height:24px"><tbody align="center"><tr><td width="72.5px"> </td><td "width="395px"" height="286px" style="background:url('http://dams-pic.b0.upaiyun.com/images/1/0/backgroud11120150119235207.jpg')">                               <img xid="3" width="365" height="256" style="padding-bottom: 10px; padding-left: 8px;" src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d3.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d3.jpg"></td><td width="75"></td><td "width="395px"" height="286px" style="background:url('http://dams-pic.b0.upaiyun.com/images/1/0/backgroud11120150119235207.jpg')">                               <img xid="3" width="365" height="256" style="padding-bottom: 10px; padding-left: 8px;" src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d4.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d4.jpg"></td><td width="72.5px"></td></tr><tr><td width="72.5px"></td><td width="395px" align="left" valign="top" style="font-family:Microsoft Yahei;font-size:16px;text-align:justify;color:#000;"><b xid="2-1-1">精选优质小麦粉，食用棕榈油等原料，采用先进技术复合式饼干生产线生产。</b></td><td width="75"></td><td width="395px" align="left" valign="top" style="font-family:Microsoft Yahei;font-size:16px;text-align:justify;color:#000;"><b xid="2-2-1">无论是当做早餐美味还是下午茶点，总能带给大家愉悦的口感和无穷的乐趣。</b></td><td width="72.5px"></td></tr>                <tr><td width="72.5px"></td><td width="75"></td><td width="72.5px"></td></tr>                 <tr><td width="72.5px"></td><td width="75"></td><td width="72.5px"></td></tr></tbody></table></div><div xgroup="2"><div width="960px"></div></div>                    <div xgroup="1" style="width:960px; margin:0; padding:0; text-align:center;"><p style="margin:0; height:50px; width:960px;"></p><table border="0" width="960px" style="text-align:center;">  <tbody><tr xgroup="2">    <td align="center"><img xid="1" width="850px"  src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d2.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d2.jpg"></td>  </tr>  <tr xgroup="2">    <td align="center"><img xid="2" width="850px"  src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d5.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d5.jpg"></td>  </tr>  <tr xgroup="2">    <td align="center"><img xid="3" width="850px"  src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d6.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d6.jpg"></td>  </tr>  <tr xgroup="2">    <td align="center"></td>  </tr>  <tr xgroup="2">    <td align="center"></td>  </tr>  <tr xgroup="2">    <td align="center"></td>  </tr>  <tr xgroup="2">    <td align="center"></td>  </tr>  <tr xgroup="2">    <td align="center"></td>  </tr></tbody></table><div width="960px"></div></div>                    <div xgroup="1" style="width:960px; margin:0; padding:0; text-align:center;"><p style="margin:0; height:50px; width:960px;"></p><table border="0" cellpadding="10" cellspacing="10" width="960"><tbody>               <tr><td align="center"><img xid="1" width="850px" style="vertical-align: middle;" src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d7.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d7.jpg"><br></td></tr></tbody></table></div>                    <div xgroup="1" style="width:960px; margin:0; padding:0; text-align:center;"><p style="margin:0; height:50px; width:960px;"></p><table border="0" cellpadding="10" cellspacing="10" width="960px" style="font-family:Microsoft Yahei;font-size:16px;line-height:24px"><tbody><tr>                       <td width="3%"></td><td width="15%"><img xid="1" height="180px" width="180px"  src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d1.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000002001001_d1.jpg"></td>                         <td width="3%"></td><td width="76%" valign="middle"><table width="100%" style="table-layout:fixed;word-break:break-all;word-wrap:break-word;"><tbody><tr xgroup="1"><td align="left" valign="top" style="font-family:Microsoft Yahei;font-size:17px;color:#000;" colspan="2"><b xid="2-1-1">茱蒂饼干自1981年开始扎根于马来西亚，一直都秉承着一个简单的经营理念，食品工业是一项良心事业，经过这数十年积极的市场开拓并建立起广泛的分销管道。朱莉产品除了“色”“香”“味”俱全，更是加入了“爱”的元素。<br></b></td></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr></tbody></table></td>                        <td width="3%"></td></tr></tbody></table></div><script type="text/javascript">!function(){var t=document.getElementsByTagName("table");if(t&&t.length){var e=[],n=!0,r=!1,a=void 0;try{for(var i,o=t[Symbol.iterator]();!(n=(i=o.next()).done);n=!0){var l=i.value;e.push(l.offsetWidth)}}catch(t){r=!0,a=t}finally{try{!n&&o.return&&o.return()}finally{if(r)throw a}}e.sort(function(t,e){return e-t});var u=window.screen.availWidth/e[0],c=document.createElement("meta");c.setAttribute("name","viewport"),c.setAttribute("content","width=device-width,minimum-scale="+u+",maximum-scale="+u+",user-scalable=no"),document.body.appendChild(c)}}();</script>
"""
    }
}
