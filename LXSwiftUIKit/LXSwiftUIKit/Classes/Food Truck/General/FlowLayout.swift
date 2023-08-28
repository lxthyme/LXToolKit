//
//  FlowLayout.swift
//  LXSwiftUIKit
//
//  Created by lxthyme on 2023/8/25.
//

import SwiftUI

struct FlowLayout: Layout {
    var alignment: Alignment = .center
    var spacing: CGFloat

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            alignment: alignment,
            spacing: spacing
        )
        return result.bounds
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            alignment: alignment,
            spacing: spacing
        )

        for row in result.rows {
            let rowXOffset = (bounds.width - row.frame.width) * alignment.horizontal.percent
            for idx in row.range {
                let xPos = rowXOffset + row.frame.minX + row.xOffsets[idx - row.range.lowerBound] + bounds.minX
                let rowYAlignment = (row.frame.height - subviews[idx].sizeThatFits(.unspecified).height) * alignment.vertical.percent
                let yPos = row.frame.minY + rowYAlignment + bounds.minY
                subviews[idx].place(at: CGPoint(x: xPos, y: yPos), anchor: .topLeading, proposal: .unspecified)
            }
        }
    }
}

// MARK: - 🔐
private extension FlowLayout {
    struct FlowResult {
        var bounds = CGSize.zero

        struct Row {
            var range: Range<Int>
            var xOffsets: [Double]
            var frame: CGRect
        }
        var rows: [Row] = []

        init(in maxPossibleWidth: Double, subviews: Subviews, alignment: Alignment, spacing: CGFloat?) {
            var itemsInRow = 0
            var remainingWidth = maxPossibleWidth.isFinite ? maxPossibleWidth : .greatestFiniteMagnitude
            var rowMinY = 0.0
            var rowHeight = 0.0
            var xOffsets: [Double] = []
            for (idx, subview) in zip(subviews.indices, subviews) {
                let idealSize = subview.sizeThatFits(.unspecified)
                if idx != 0 && widthInRow(idx: idx, idealWidth: idealSize.width) > remainingWidth {
                    finalizeRow(idx: max(idx - 1, 0), idealSize: idealSize)
                }
                addToRow(idx: idx, idealSize: idealSize)

                if idx == subviews.count - 1 {
                    finalizeRow(idx: idx, idealSize: idealSize)
                }
            }

            func spacingBefore(idx: Int) -> Double {
                guard itemsInRow > 0 else { return 0 }
                return spacing ?? subviews[idx - 1].spacing.distance(to: subviews[idx].spacing, along: .horizontal)
            }
            func widthInRow(idx: Int, idealWidth: Double) -> Double {
                idealWidth + spacingBefore(idx: idx)
            }
            func addToRow(idx: Int, idealSize:CGSize) {
                let width = widthInRow(idx: idx, idealWidth: idealSize.width)

                xOffsets.append(maxPossibleWidth - remainingWidth + spacingBefore(idx: idx))
                remainingWidth -= width
                rowHeight = max(rowHeight, idealSize.height)
                itemsInRow += 1
            }
            func finalizeRow(idx: Int, idealSize: CGSize) {
                let rowWidth = maxPossibleWidth - remainingWidth
                rows.append(
                    Row(
                        range: idx - max(itemsInRow - 1, 0) ..< idx + 1,
                        xOffsets: xOffsets,
                        frame: CGRect(x: 0, y: rowMinY, width: rowWidth, height: rowHeight)
                    )
                )
                bounds.width = max(bounds.width, rowWidth)
                let ySpacing = spacing ?? ViewSpacing().distance(to: ViewSpacing(), along: .vertical)
                bounds.height += rowHeight + (rows.count > 1 ? ySpacing : 0)
                rowMinY += rowHeight + ySpacing
                itemsInRow = 0
                rowHeight = 0
                xOffsets.removeAll()
                remainingWidth = maxPossibleWidth
            }
        }
    }
}

// MARK: - 🔐
private extension HorizontalAlignment {
    var percent: Double {
        switch self {
        case .leading: return 0
        case .trailing: return 1
        default: return 0.5
        }
    }
}

// MARK: - 🔐
private extension VerticalAlignment {
    var percent: Double {
        switch self {
        case .top: return 0
        case .bottom: return 1
        default: return 0.5
        }
    }
}
