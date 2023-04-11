//
//  LXYYLabelMoreTestVC.swift
//  LXToolKit_Exam
//
//  Created by lxthyme on 2022/5/16.
//  Copyright © 2022 CocoaPods. All rights reserved.
//
import RxSwift
import RxCocoa
import Masonry
import Foundation
import YYText
import LXToolKit

class LXYYLabelMoreTestVC: LXBaseMVVMVC {
    // MARK: 📌UI
    private lazy var labTitle: YYLabel = {
        let label = YYLabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        return label
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
        // guard let vm = viewModel as? LXYYLabelMoreTestVCVM else { return }

        // let input = LXYYLabelMoreTestVCVM.Input()
        // let output = vm.transform(input: input)

        // output.dataList
        //     .asDriver(onErrorJustReturn: [])
        //     .drive(table.rx.items(cellIdentifier: <#LXEventCell#>.xl.xl_identifier, cellType: <#LXEventCell#>.self)) {tableView, vm, cell in
        //         // cell.bind(to: vm)
        //     }
        //     .disposed(by: rx.disposeBag)
    }
    // override func updateUI() {
    //     super.updateUI()
    // }
}
// MARK: 🌎LoadData
extension LXYYLabelMoreTestVC {}

// MARK: 👀Public Actions
extension LXYYLabelMoreTestVC {}

// MARK: 🔐Private Actions
extension LXYYLabelMoreTestVC {}

// MARK: - 🍺UI Prepare & Masonry
private extension LXYYLabelMoreTestVC {
    func prepareLabTitle() {
        let font = UIFont.systemFont(ofSize: 14)
        labTitle.numberOfLines = 3
        labTitle.preferredMaxLayoutWidth = UIScreen.main.bounds.size.width - 16 * 2

        let string = "好想化做一只蝴蝶，乘着微风振翅高飞，现在马上，只想赶快和你见面，烦心的事放在一边，如果忘记那也无所谓，已经没有，多余时间可以浪费，似乎有，什么事会在这片晴空下出现"
        let attr = NSMutableAttributedString(string: string)
        attr.yy_font = font
        labTitle.attributedText = attr

        let attrDot = NSMutableAttributedString(string: "...详情")
        attrDot.yy_font = font
        attrDot.yy_color = .blue
        /// 不需要点击事件
        // labTitle.truncationToken = attrDot
        attrDot.yy_setTextHighlight((attrDot.string as NSString).range(of: "详情"),
                                    color: .blue,
                                    backgroundColor: .yellow) { containerView, text, range, rect in
            dlog("""
            1. tapped...
            2. containerView: \(containerView)
            3. text: \(text)
            4. range: \(range)
            5. rect: \(rect)
            """)
        }
        let labMore = YYLabel()
        labMore.attributedText = attrDot
        labMore.sizeToFit()
        let truncationToken = NSAttributedString.yy_attachmentString(withContent: labMore, contentMode: .center, attachmentSize: labMore.frame.size, alignTo: font, alignment: .center)
        labTitle.truncationToken = truncationToken
    }
    func prepareUI() {
        // self.view.backgroundColor = <#.white#>;

        prepareLabTitle()
        [labTitle].forEach(self.view.addSubview)

        masonry()
    }
    func masonry() {
        labTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100);
            $0.left.equalToSuperview().offset(16);
            $0.right.equalToSuperview().offset(-16);
        }
    }
}
