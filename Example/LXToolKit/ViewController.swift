//
//  ViewController.swift
//  LXToolKit
//
//  Created by LX314 on 11/12/2019.
//  Copyright (c) 2019 LX314. All rights reserved.
//

import UIKit
import LXToolKit

class ViewController: LXBaseVC {

    private lazy var btnTest: UIButton = {
        let btn = UIButton(type: .custom)

        btn.setTitle("Test", for: .normal)
        btn.setTitleColor(.black, for: .normal)

        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 4

        btn.addTarget(self, action: #selector(btnTestAction(sender:)), for: .touchUpInside)
        return btn
    }()
    private var testVC = LXTestVC()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let vc =
//            LXApiTestVC()
//            LXMultiRequestTestVC()
//            LXOffScreenVC()
//            LXResolveIMPVC()
//            LXRequiredVC()
//            LXLightedVC()
//            LXProxyTestVC()
//            LXTestStringVC()
//            LXPresentVC()
//            LXTestVC()
//            LXStackViewVC()
//            LXWikipediaImageSearchVC()
//            LXStackTestVC()
//            LXImageTestVC()
//            LXDaily1117VC()
//            LXStackTestVC()
//            LXStackMessageVC()
//            LXMusicVC()
            LXSongVC()

        self.navigationController?.pushViewController(vc, animated: true)
//        self.present(testVC, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareUI()

//        let _ = LXBaseVC()
//        let identifier = self.xl_typeName
//        dlog("identifier: \(identifier)")

//        testArray()
//        testDictionary()
    }
}

// MARK: - 🔐Private Actions
private extension ViewController {
    @objc func btnTestAction(sender: UIButton) {
        let vc = LXSongVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController {
    func testArray() {
        let a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        ({
            let search = 5
            let r_contains = a.contains(search)
            let r_firstIndex = a.firstIndex(of: search)
            let r_firstIndex_where = a.firstIndex(where: { $0 == search })
            let r_first_where = a.first(where: { $0 == search })
            dlog("r_contains: \(r_contains)", "r_firstIndex: \(r_firstIndex)", "r_firstIndex_where: \(r_firstIndex_where)", "r_first_where: \(r_first_where)")
        })()

        ({
            let search = 51
            let r_contains = a.contains(search)
            let r_firstIndex = a.firstIndex(of: search)
            let r_firstIndex_where = a.firstIndex(where: { $0 == search })
            let r_first_where = a.first(where: { $0 == search })
            dlog("r_contains: \(r_contains)", "r_firstIndex: \(r_firstIndex)", "r_firstIndex_where: \(r_firstIndex_where)", "r_first_where: \(r_first_where)")
        })()

        ({
            let r_min = a.min()
            let r_min_by1 = a.min(by: { $0 > $1 })
            let r_min_by2 = a.min(by: { $0 < $1 })
            dlog("r_min: \(r_min)", "r_min_by1: \(r_min_by1)", "r_min_by2: \(r_min_by2)")

            let r_max = a.max()
            let r_max_by1 = a.max(by: { $0 > $1 })
            let r_max_by2 = a.max(by: { $0 < $1 })
            dlog("r_max: \(r_max)", "r_max_by1: \(r_max_by1)", "r_max_by2: \(r_max_by2)")
        })()

        ({
            let aVersion = "3.14.10"
            let bVersion = "3.130.10"

            let r1 = aVersion.versionToInt().lexicographicallyPrecedes(bVersion.versionToInt())
            let r2 = bVersion.versionToInt().lexicographicallyPrecedes(aVersion.versionToInt())
            dlog("lexicographicallyPrecedes: \(r1)\t\t\(r2)")
        })()

        ({
            var a = [30, 40, 20, 30, 30, 60, 10]

            let r = a.partition(by: { $0 > 30 })
            dlog("partition r: \(r) >>> a: \(a)")
        })()

        ({
            let a = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

            let prefix_while = a.prefix(while: { $0 > 3 })
            let prefix_maxLength = a.prefix(3)
            let prefix_upTo = a.prefix(upTo: 3)
            let prefix_through = a.prefix(through: 3)
            dlog("prefix_while: \(prefix_while)",
                "prefix_maxLength: \(prefix_maxLength)",
                "prefix_upTo: \(prefix_upTo)",
                "prefix_through: \(prefix_through)")

            let suffix_maxLength = a.suffix(3)
            let suffix_from = a.suffix(from: 3)

            dlog("suffix_maxLength: \(suffix_maxLength)", "suffix_from: \(suffix_from)")
        })()

        ({
            for x in sequence(first: 1, next: { $0 + 1}).prefix(5) {
                dlog("prefix x: \(x)")
            }

            for x in sequence(first: 2, next: { $0 * $0 }).prefix(while: { $0 < 100 }) {
                dlog("prefix_while x: \(x)")
            }

            for x in sequence(first: self.view, next: { $0?.superview }) {
                dlog("view x: \(x)")
            }
        })()

        ({
            let a = 1...3
            let b = 1...10
            let r_elementsEqual = a.elementsEqual(b)
            let r_elementsEqual2 = a.elementsEqual([1, 2, 3])
            let r2_elementsEqual_by = a.elementsEqual(b, by: {(e1, e2) in
                dlog("E: (\(e1), \(e2))")
                return e1 == e2
            })
            dlog("r_elementsEqual: \(r_elementsEqual)",
                "r_elementsEqual2: \(r_elementsEqual2)",
                "r2_elementsEqual_by: \(r2_elementsEqual_by)")
        })()

        ({
            let r_separator = a.split(separator: 3)
            let r_whereSeparator = a.split(whereSeparator: { $0 % 3 == 0 })
            let r_omittingEmptySubsequences = a.split(separator: 3, maxSplits: 2, omittingEmptySubsequences: false)

            dlog("r_separator: \(r_separator)",
            "r_whereSeparator: \(r_whereSeparator)",
            "r_omittingEmptySubsequences: \(r_omittingEmptySubsequences)")

            let line = "BLANCHE:   I don't want realism. I want magic!"
            dlog(line.split(separator: " "))
            dlog(line.split(separator: " ", maxSplits: 1))
            dlog(line.split(separator: " ", omittingEmptySubsequences: false))
        })()

        ({
            let r_while = a.drop(while: { $0 < 6 })
            let r_dropFirst = a.dropFirst(3)
            let r_dropLast = a.dropLast(3)

            var b = a
            b.removeAll(where: { $0 % 3 != 0 })
            dlog("r_while: \(r_while)",
            "r_dropFirst: \(r_dropFirst)",
            "r_dropLast: \(r_dropLast)",
            "a: \(a)",
            "",
            "b: \(b)")
        })()

        ({
            let r = a.firstIndex(of: 3)
            dlog("r: \(r)")
        })()

        ({
            let b = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
            let r = zip(a, b)
            let r_zip_map = r.map { $0 + $1 }
            dlog("r: \(r)",
            "r_zip_map: \(r_zip_map)")
        })()
    }

    func testDictionary() {
        let a: [String: String] = ["a": "vA", "b": "vB", "c": "vC", "d": "vD"]
        let b = ["d": "bbD", "e": "bbE", "f": "bbF"]

        let s1 = ({
            var b = a
            b["a"] = nil

            dlog("b: \(b)")
        })

        let s2 = ({
            var c = a
            c.merge(b, uniquingKeysWith: { $1 })
            dlog("c: \(c)")
        })

        let s3 = ({
            let frequncies = "hello".frequencies
            let r = frequncies.filter { $0.value > 1 }
            dlog("frequncies: \(frequncies)",
                "r: \(r)"
            )
        })
//        s1()
         s2()
        s3()
    }
}

extension String {
    func versionToInt() -> [Int] {
        return self.components(separatedBy: ".")
            .map { Int($0) ?? 0 }
    }
}

extension Sequence where Element: Hashable {
    var frequencies: [Element: Int] {
        let frequencyPairs = self.map { ($0, 1) }
        return Dictionary(frequencyPairs, uniquingKeysWith: +)
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension ViewController {
    func prepareUI() {
        [btnTest].forEach(self.view.addSubview)
        masonry()
    }
    func masonry() {
        btnTest.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
