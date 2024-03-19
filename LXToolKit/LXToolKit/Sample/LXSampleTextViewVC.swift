//
//  LXSampleTextViewVC.swift
//  LXToolKit
//
//  Created by lxthyme on 2023/12/15.
//
import UIKit
import RxOptional

open class LXSampleTextViewVC: LXBaseVC {
    // MARK: 📌UI
    private lazy var tvContent: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isScrollEnabled = true
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = .black
        tv.backgroundColor = .white
        tv.textAlignment = .left
        tv.returnKeyType = .done
        tv.keyboardType = .default
        // tv.textContainer.maximumNumberOfLines = 0
        // tv.textContainer.lineBreakMode = .byTruncatingTail
        // tv.contentInset = .zero
        // let padding = tv.textContainer.lineFragmentPadding
        // tv.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        return tv
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareUI()
    }

}

// MARK: 🌎LoadData
public extension LXSampleTextViewVC {
    func dataFill(content: String) {
        tvContent.text = content
    }
    func dataFillUnSupport(title: String = "UnSupported", content: String) {
        let attr = NSMutableAttributedString()
        if title.isNotEmpty {
            attr.append(NSAttributedString(string: "\(title)\n\n", attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.boldSystemFont(ofSize: 20)
            ]))
        }
        if content.isNotEmpty {
            attr.append(NSAttributedString(string: content, attributes: [
                .foregroundColor: UIColor.systemGray6,
                .font: UIFont.boldSystemFont(ofSize: 16)
            ]))
        }
        tvContent.attributedText = attr
    }
}

// MARK: 👀Public Actions
extension LXSampleTextViewVC {}

// MARK: 🔐Private Actions
private extension LXSampleTextViewVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXSampleTextViewVC {
    func prepareUI() {
        self.view.backgroundColor = .white
        // navigationItem.title = ""

        [tvContent].forEach(self.view.addSubview)

        masonry()
    }

    func masonry() {
        tvContent.snp.makeConstraints {
            $0.edges.equalTo(self.view.snp.margins)
        }
    }
}
