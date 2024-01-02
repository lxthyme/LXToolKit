//
//  LXListItemModel.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import Foundation
import HandyJSON

class LXListItemModel: NSObject, HandyJSON {
    var title: String?
    var dateString: String?

    @objc(User)class User: NSObject, NSCoding, HandyJSON {

        var identifier: Int64?
        var username: String?
        var firstName: String?
        var lastName: String?
        var photos: [LXListItemModel.Photo]?
        func encode(with coder: NSCoder) {
            coder.encode(identifier, forKey: "identifier")
            coder.encode(username, forKey: "username")
            coder.encode(firstName, forKey: "firstname")
            coder.encode(lastName, forKey: "lastname")
            coder.encode(photos, forKey: "photos")
        }

        required init?(coder: NSCoder) {
            identifier = coder.decodeInt64(forKey: "identifier")
            username = coder.decodeObject(forKey: "username") as? String
            firstName = coder.decodeObject(forKey: "firstname") as? String
            lastName = coder.decodeObject(forKey: "lastname") as? String
            photos = coder.decodeObject(forKey: "photos") as? [LXListItemModel.Photo]
        }

        required override init() {}

        // func mapping(mapper: HelpingMapper) {}
        // override var debugDescription: String { return "" }
    }
    var userList: [LXListItemModel.User] = []

    @objc(Photo)class Photo: NSObject, NSCoding, HandyJSON {
        var identifier: Int64?
        var name: String?
        var creationDate: Date?
        var rating: Float?
        var user: LXListItemModel.User?
        func encode(with coder: NSCoder) {
            coder.encode(identifier, forKey: "identifier")
            coder.encode(name, forKey: "name")
            coder.encode(creationDate, forKey: "creationDate")
            coder.encode(rating, forKey: "rating")
            coder.encode(user, forKey: "user")
        }

        required init?(coder: NSCoder) {
            identifier = coder.decodeInt64(forKey: "identifier")
            name = coder.decodeObject(forKey: "name") as? String
            creationDate = coder.decodeObject(forKey: "creationDate") as? Date
            rating = coder.decodeFloat(forKey: "rating")
            user = coder.decodeObject(forKey: "user") as? LXListItemModel.User
        }
        required override init() {}

        // func mapping(mapper: HelpingMapper) {}
        // override var debugDescription: String { return "" }
    }
    var photoList: [LXListItemModel.Photo] = []

    required override init() {
        super.init()
        self.readArchive()
    }

    // func mapping(mapper: HelpingMapper) {}
    // override var debugDescription: String { return "" }
}

// MARK: - <#Title...#>
private extension LXListItemModel {
    func readArchive() {
        guard let url = Bundle.main.url(forResource: "photodata", withExtension: "bin"),
            let data = try? Data(contentsOf: url, options: .mappedIfSafe) else {
                return
        }
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        guard let users = unarchiver.decodeObject(of: [LXListItemModel.User.self], forKey: "users") as? [LXListItemModel.User],
            let photos = unarchiver.decodeObject(of: [LXListItemModel.Photo.self], forKey: "photos") as? [LXListItemModel.Photo] else {
                return
        }
        unarchiver.finishDecoding()

        userList = users
        photoList = photos
    }
}

// MARK: - <#Title...#>
extension LXListItemModel {
    func sortedPhotos() -> [LXListItemModel.Photo] {
        return self.photoList.sorted { (p1, p2) -> Bool in
            if let d1 = p1.creationDate, let d2 = p2.creationDate {
                return d1.compare(d2) == .orderedAscending
            } else if let _ = p1.creationDate {
                return true
            } else {
                return false
            }
        }
    }
}
