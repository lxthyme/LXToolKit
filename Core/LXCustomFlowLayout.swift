//
//  LXCustomFlowLayout.swift
//  Vape
//
//  Created by LXThyme on 2018/11/13.
//  Copyright © 2018年 ChenJianglin. All rights reserved.
//

import UIKit

class LXCustomFlowLayout: UICollectionViewFlowLayout {
    var maximumInteritemSpacing: CGFloat = 8.0

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return super.layoutAttributesForElements(in: rect)
        }

        for (idx, item) in attributes.enumerated() {
            let currentAttr = item
            let preAttr = attributes[idx - 1]

            let origin = preAttr.frame.maxX

            /// 根据  maximumInteritemSpacing 计算出的新的 x 位置
            let targetX = origin + self.maximumInteritemSpacing
            /// 只有系统计算的间距大于  maximumInteritemSpacing 时才进行调整
            if currentAttr.frame.maxX > targetX {
                /// 换行时不用调整
                if (targetX + currentAttr.frame.width) < self.collectionViewContentSize.width {
                    var frame = currentAttr.frame
                    frame.origin.x = targetX
                    currentAttr.frame = frame
                }
            }
        }

        return attributes
    }
}
