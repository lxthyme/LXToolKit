//
//  LotteryView.swift
//  LXSwiftUIKit
//
//  Created by lxthyme on 2022/9/7.
//

import SwiftUI

struct LotteryView: View {
    @ObservedObject var control = LotteryControl()
    let colors: [Color] = [.red, .black, .gray, .green, .blue, .orange, .yellow, .purple]
    var body: some View {
        // Color.cyan
        //     .ignoresSafeArea()
        //     .overlay {
                ZStack {
                    ForEach(0..<control.index, id: \.self) { idx in
                        Path { path in
                            path.move(to: CGPoint(x: 150, y: 150))
                            path.addArc(center: CGPoint(x: 150, y: 150),
                                        radius: 150,
                                        startAngle: Angle(degrees: Double(idx) * self.control.angle),
                                        endAngle: Angle(degrees: Double(idx + 1) * self.control.angle),
                                        clockwise: false)
                            path.addLine(to: CGPoint(x: 150, y: 150))
                        }.fill(self.colors[idx % self.colors.count])
                    }
                }
            // }
            .frame(width: 300, height: 300, alignment: .center)
            .rotationEffect(.degrees(control.rotation))
    }
}

struct LotteryView_Previews: PreviewProvider {
    static var previews: some View {
                LotteryView()
    }
}
