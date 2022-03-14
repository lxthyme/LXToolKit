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

class LXWebViewTestVC: LXBaseMVVMVC {
    // MARK: 📌UI
    private lazy var webView: WKWebView = {
        // swiftlint:disable line_length
        let meta = """
        var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no');
        document.head.appendChild(meta);
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
    override func bindViewModel() {
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

// MARK: - 🍺UI Prepare & Masonry
private extension LXWebViewTestVC {
    func prepareUI() {
        self.view.backgroundColor = .white;

        [webView].forEach(self.view.addSubview)
        masonry()
    }
    func masonry() {
        webView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
    }
    func mockData() -> String {
        // swiftlint:disable line_length
        return """
<style type="text/css">img{display:block;width:100%;height:auto;}</style><div xgroup="1" style="width:960px; margin:0; padding:0; text-align:center;"><table border="0" cellpadding="0" cellspacing="0" width="960" style="font-family:Microsoft Yahei;font-size:16px;line-height:24px">    <tbody><tr style="width:511px">      <td>        <div style="margin-top:40px;margin-left:80px;">               <img xid="1" height="105px" width="105px" style="position:relative;left:-100px"  src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d1.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d1.jpg">            </div><table>          <tbody><tr width="511px" height="120px">          </tr>          <tr>             <td>                 <table style="margin-left:131px;width:380px;height:109px;margin-bottom:152px">                   <tbody><tr><td style="text-align:left; font-family:Microsoft 黑体; font-weight:bold; font-size:18px;color:#bb7d05;vertical-align:top;padding-top: 0px;height:20px;" xid="2-1-1">安全 耐热 无害</td></tr>                   <tr><td style="text-align:left; font-family:Microsoft 黑体; font-weight:bold; font-size:26px;color:#bb7d05;vertical-align:top;padding-top: 0px;height:48px;" xid="2-1-2">乐 扣 乐 扣 保 鲜 盒</td></tr>                   <tr><td style="text-align:left; font-family:Microsoft Yahei; font-size:1px;color:#bb7d05;vertical-align:top;padding-top: 0px;height:17px;" xid="2-1-3"> --------------------------------------------------------------- </td></tr>                   <tr><td style="text-align:left; font-family:Microsoft Yahei; font-weight:bold; font-size:18px;color:#bb7d05;vertical-align:top;padding-top: 0px;height:24px;" xid="2-1-4">不管在哪里  乐扣永远和你在一起</td></tr>                 </tbody></table>             </td><td>          </td></tr>        </tbody></table>      </td><td width="13px"></td>      <td style="width:436px">        <div style="width:420px;height:420px;margin-right: 16px;margin-top:3px">            <img xid="1" height="420px" width="420px"  src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d2.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d2.jpg"></div>      </td>     </tr>     <tr style="height:66px;margin-bottom:0px;">     <td colspan="3" style="background:url('http://dams-pic.b0.upaiyun.com/images/1/0/百联-厨房家居模版_1720150120022939.jpg')">     </td>     </tr></tbody></table></div>                    <div xgroup="1" style="width:960px; margin:0; padding:0; text-align:center;"><p style="margin:0; height:50px; width:960px;"><img src="http://222.73.227.151/cfjj/cfjj_02.jpg" width="960"></p><table border="0" cellpadding="10" cellspacing="10" width="960" style="font-family:Microsoft Yahei;font-size:16px;line-height:24px"><tbody><tr>                         <td width="6%"></td><td width="40%" valign="middle"><table width="100%" style="table-layout:fixed;word-break:break-all;word-wrap:break-word; font-family:Microsoft Yahei;" class="table-a"><tbody><tr xgroup="1"><td width="100px" style="text-align:left; vertical-align:top;padding-top: 0px;font-family:Microsoft Yahei; font-size:14px; line-height: 20px; font-weight:bold; width:75px; height:45px;color:#000;"><b xid="2-1-1" style="text-align:left;">品名：</b></td><td style="text-align:left; font-family:Microsoft Yahei; font-size:14px;color:#000;vertical-align:top;padding-top: 0px;" xid="2-1-2">乐扣乐扣（LockLock）保鲜盒</td></tr><tr xgroup="1"><td width="100px" style="text-align:left; vertical-align:top;padding-top: 0px;font-family:Microsoft Yahei; font-size:14px; line-height: 20px; font-weight:bold; width:75px; height:45px;color:#000;"><b xid="2-2-1" style="text-align:left;">品牌：</b></td><td style="text-align:left; font-family:Microsoft Yahei; font-size:14px;color:#000;vertical-align:top;padding-top: 0px;" xid="2-2-2">乐扣乐扣（LockLock）</td></tr><tr xgroup="1"><td width="100px" style="text-align:left; vertical-align:top;padding-top: 0px;font-family:Microsoft Yahei; font-size:14px; line-height: 20px; font-weight:bold; width:75px; height:45px;color:#000;"><b xid="2-3-1" style="text-align:left;">产地：</b></td><td style="text-align:left; font-family:Microsoft Yahei; font-size:14px;color:#000;vertical-align:top;padding-top: 0px;" xid="2-3-2">韩国</td></tr><tr xgroup="1"><td width="100px" style="text-align:left; vertical-align:top;padding-top: 0px;font-family:Microsoft Yahei; font-size:14px; line-height: 20px; font-weight:bold; width:75px; height:45px;color:#000;"><b xid="2-4-1" style="text-align:left;">规格：</b></td><td style="text-align:left; font-family:Microsoft Yahei; font-size:14px;color:#000;vertical-align:top;padding-top: 0px;" xid="2-4-2">680ml</td></tr><tr xgroup="1"><td width="100px" style="text-align:left; vertical-align:top;padding-top: 0px;font-family:Microsoft Yahei; font-size:14px; line-height: 20px; font-weight:bold; width:75px; height:45px;color:#000;"><b xid="2-5-1" style="text-align:left;">用途：</b></td><td style="text-align:left; font-family:Microsoft Yahei; font-size:14px;color:#000;vertical-align:top;padding-top: 0px;" xid="2-5-2">食品用</td></tr></tbody></table></td>                        <td width="8%"></td><td width="40%"><div style="border:1px solid #fff;width:380px;height:380px"><img xid="1" height="380px" width="380px"  src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d2.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d2.jpg"></div></td>                        <td width="6%"></td></tr></tbody></table></div>                    <div xgroup="1" style="width:960px; margin:0; padding:0; text-align:center;"><p style="margin:0; height:50px; width:960px;"><img src="http://222.73.227.151/cfjj/cfjj_04.jpg" width="960"></p><table border="0" cellpadding="0" cellspacing="0" style="font-family:Microsoft Yahei;font-size:14px;"><tbody align="center"><tr><td width="72.5px"> </td><td "width="395px"" height="286px" style="background:url('http://dams-pic.b0.upaiyun.com/images/1/0/backgroud11120150119235207.jpg')">                               <img xid="3" width="365" height="256" style="padding-bottom: 10px; padding-left: 8px;" src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d3.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d3.jpg"></td><td width="75"></td><td "width="395px"" height="286px" style="background:url('http://dams-pic.b0.upaiyun.com/images/1/0/backgroud11120150119235207.jpg')">                               <img xid="3" width="365" height="256" style="padding-bottom: 10px; padding-left: 8px;" src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d4.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d4.jpg"></td><td width="72.5px"></td></tr><tr><td width="72.5px"></td><td width="395px" align="left" valign="top" style="font-family:Microsoft Yahei;font-size:16px;text-align:justify;color:#000;"><b xid="2-1-1">四面锁扣</b></td><td width="75"></td><td width="395px" align="left" valign="top" style="font-family:Microsoft Yahei;font-size:16px;text-align:Justify;color:#000;"><b xid="2-2-1">制作材料安全</b></td><td width="72.5px"></td></tr>                <tr><td width="72.5px"></td><td width="395px" align="left" valign="top" style="font-family:Microsoft Yahei;font-size:16px;text-align:Justify;color:#000;"><b xid="2-1-1">四面锁扣保鲜盒，完美的密封性及开关的密封性。适合存放各种调料和寿司等。</b></td><td width="75"></td><td width="365px" align="left" valign="top" style="font-family:Microsoft Yahei;font-size:16px;text-align:Justify;color:#000;"><b xid="2-2-1">食品级pp材料，通过QS质量安全认证，无毒无味，充分保证家人的健康。</b></td><td width="72.5px"></td></tr>                 <tr><td width="72.5px"></td><td width="75"></td><td width="72.5px"></td></tr></tbody></table></div><div xgroup="2"><div width="960px"></div></div>                    <div xgroup="1" style="width:960px; margin:0; padding:0; text-align:center;"><p style="margin:0; height:50px; width:960px;"><img src="http://222.73.227.151/cfjj/cfjj_06.jpg" width="960"></p><table border="0" cellpadding="10" cellspacing="10" width="960px" style="text-align:center;margin-left:80px">     <tbody>        <tr>    <td style="text-align:center"><img xid="3" width="850px"  src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d2.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d2.jpg"><br>   </td>        </tr>        <tr>           <td style="text-align:center"><img xid="4" width="850px"  src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d5.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d5.jpg"><br>   </td></tr>        <tr>           <td style="text-align:center"><br>   </td></tr>        <tr>           <td style="text-align:center"><br>   </td></tr>     </tbody></table></div><div xgroup="2"><div width="960px"></div></div>                    <div xgroup="1" style="width:960px; margin:0; padding:0; text-align:center;"><p style="margin:0; height:50px; width:960px;"><img src="http://222.73.227.151/cfjj/cfjj_08.jpg" width="960"></p><table border="0" cellpadding="10" cellspacing="10" width="960"><tbody>               <tr><td align="center"><img xid="1" width="850px" style="vertical-align: middle;" src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d6.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d6.jpg"><br></td></tr></tbody></table></div>                    <div xgroup="1" style="width:960px; margin:0; padding:0; text-align:center;"><p style="margin:0; height:50px; width:960px;"><img src="http://222.73.227.151/cfjj/cfjj_10.jpg" width="960"></p><table border="0" cellpadding="10" cellspacing="10" width="960px" style="font-family:Microsoft Yahei;font-size:16px;line-height:24px"><tbody><tr>                       <td width="3%"></td><td width="15%"><img xid="1" height="180px" width="180px"  src="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d1.jpg" alt="http://img15.st.iblimg.com/goods-6/2000/2017/02/SP_2000_20000009880001_d1.jpg"></td>                        <td width="3%"></td><td width="76%" valign="middle"><table width="100%" style="table-layout:fixed;word-break:break-all;word-wrap:break-word;"><tbody><tr xgroup="1"><td align="left" valign="top" style="font-family:Microsoft Yahei;font-size:17px;color:#000;" colspan="2"><b xid="2-1-1">乐扣的前身成立于1985年，主要生产厨房,浴室用品等600多种多样化的生活日用品.1997年公司领导阶层全面修改了企业政策,将产品研究,开发,制造和营销的重点放在乐扣乐扣（LOCK&LOCK）保鲜盒上。乐扣乐扣日用品（苏州）有限公司作为乐扣在中国的生产法人之一，成立于2006年10月，位于风景优美的苏州工业园区，占地面积约10万平方米。</b></td></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr><tr xgroup="1"></tr></tbody></table></td>                        <td width="3%"></td></tr></tbody></table></div><img style="width:960px;height:auto" src='https://img11.iblimg.com/goods-151/images/brand/2021/08/542357547.jpg' /><script type="text/javascript">!function(){var t=document.getElementsByTagName("table");if(t&&t.length){var e=[],n=!0,r=!1,a=void 0;try{for(var i,o=t[Symbol.iterator]();!(n=(i=o.next()).done);n=!0){var l=i.value;e.push(l.offsetWidth)}}catch(t){r=!0,a=t}finally{try{!n&&o.return&&o.return()}finally{if(r)throw a}}e.sort(function(t,e){return e-t});var u=window.screen.availWidth/e[0],c=document.createElement("meta");c.setAttribute("name","viewport"),c.setAttribute("content","width=device-width,minimum-scale="+u+",maximum-scale="+u+",user-scalable=no"),document.head.appendChild(c)}}();</script>
"""
    }
}
