//
//  LXWWDCDownloader.swift
//  wwdc-dl
//
//  Created by lxthyme on 2023/8/12.
//
import UIKit
import Alamofire

class LXWWDCDownloader: UIViewController {
    // MARK: 📌UI
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
        startDownload()
    }

}

// MARK: 🌎LoadData
extension LXWWDCDownloader {}

// MARK: 👀Public Actions
extension LXWWDCDownloader {}

// MARK: 🔐Private Actions
private extension LXWWDCDownloader {
    func startDownload() {
        wwdc2013()
    }
    /**
     // document.querySelectorAll('.links.small')[3].previousElementSibling
     list = Array.from(document.querySelectorAll('.links.small'))
     .map(t => {
         return {
             [t.previousElementSibling.innerText]: Array.from(t.querySelectorAll('li a'))
                 .map(t => { return { [t.innerText]: t.href } })
                 .reduce((prev, current) => {
                     let k = Object.keys(current)[0]
                     let v = current[k]
                     if(prev[k]) { console.log(`-->[dump1]: ${k}: ${prev[k]} & ${v}`) }
                     return { ...prev, [k] : v}
                 }, {})
         }
     }).reduce((prev, current) => {
         let k = Object.keys(current)[0]
         let v = current[k]
         if(prev[k]) { console.log(`-->[dump2]: ${k}: ${prev[k]} & ${v}`) }
         return { ...prev, [k] : v}
     }, {}) 
     */
    func wwdc2013() {
        // async let wwdc2013 = AF.request("https://developer.apple.com/videos/play/wwdc2023/10034/")
        //
        // let wwdc2013Response = await wwdc2013.response
        //
        // print("-->wwdc2013Response: \(wwdc2013Response)")

        AF.request("https://developer.apple.com/videos/play/wwdc2023/10034/")
            .responseString(completionHandler: { response in
                print("-->wwdc2013Response: \(response)")
            })
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXWWDCDownloader {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        // [<#table#>].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {}
}
