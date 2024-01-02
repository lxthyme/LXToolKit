//
//  NotificationViewController.swift
//  Content
//
//  Created by LXThyme Jason on 2020/10/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!

    func didReceive(_ notification: UNNotification) {
        print("didReceive: ", notification)
        let content = notification.request.content

        if let aps = content.userInfo["aps"] as? [String: Any],
            let alert = aps["alert"] as? [String: Any],
            let urlImageString = alert["image"] as? String,
            let url = URL(string: urlImageString) {
            URLSession.downloadImage(atURL: url) { [weak self] (data, error) in
                if let _ = error {
                    return
                }
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }
    }

}
extension URLSession {

    class func downloadImage(atURL url: URL, withCompletionHandler completionHandler: @escaping (Data?, NSError?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            completionHandler(data, nil)
        }
        dataTask.resume()
    }
}
