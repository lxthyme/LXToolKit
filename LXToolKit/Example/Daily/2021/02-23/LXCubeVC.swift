//
//  LXCubeVC.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2021/2/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import GLKit
import LXToolKit

private let kContainerWidth: CGFloat = 200

class LXCubeVC: UIViewController {
    // MARK: 📌UI
    private lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    private lazy var f0View: LXCubeFaceView = {
        let v = LXCubeFaceView(idx: 1)
        v.backgroundColor = .white
        return v
    }()
    private lazy var f1View: LXCubeFaceView = {
        let v = LXCubeFaceView(idx: 2)
        v.backgroundColor = .white
        return v
    }()
    private lazy var f2View: LXCubeFaceView = {
        let v = LXCubeFaceView(idx: 3)
        v.backgroundColor = .white
        return v
    }()
    private lazy var f3View: LXCubeFaceView = {
        let v = LXCubeFaceView(idx: 4)
        v.backgroundColor = .white
        return v
    }()
    private lazy var f4View: LXCubeFaceView = {
        let v = LXCubeFaceView(idx: 5)
        v.backgroundColor = .white
        return v
    }()
    private lazy var f5View: LXCubeFaceView = {
        let v = LXCubeFaceView(idx: 6)
        v.backgroundColor = .white
        return v
    }()
    // MARK: 🔗Vaiables
    lazy var faces = [f0View, f1View, f2View, f3View, f4View, f5View]
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
//        makeCube()
        start()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.xl.setRoundingCorners(borderColor: .red, borderWidth: 1, raddi: 150, corners: [.topLeft, .topRight], isDotted: true)
    }

}

// MARK: 🌎LoadData
extension LXCubeVC {}

// MARK: 👀Public Actions
extension LXCubeVC {}

// MARK: 🔐Private Actions
private extension LXCubeVC {
    func makeCube() {
        /// 父View的layer图层
        var perspective = CATransform3DIdentity
        perspective.m34 = -1 / 500.0
        perspective = CATransform3DRotate(perspective, -.pi / 4, 1, 0, 0)
        perspective = CATransform3DRotate(perspective, -.pi / 4, 0, 1, 0)
        self.containerView.layer.sublayerTransform = perspective

        /// face 0
        var transform = CATransform3DMakeTranslation(0, 0, 100)
        addFace(idx: 0, with: transform)

        /// face 1
        transform = CATransform3DMakeTranslation(100, 0, 0)
        transform = CATransform3DRotate(transform, .pi / 2, 0, 1, 0)
        addFace(idx: 1, with: transform)

        /// face 2
        transform = CATransform3DMakeTranslation(0, -100, 0)
        transform = CATransform3DRotate(transform, .pi / 2, 1, 0, 0)
        addFace(idx: 2, with: transform)

        /// face 3
        transform = CATransform3DMakeTranslation(0, 100, 0)
        transform = CATransform3DRotate(transform, -.pi / 2, 1, 0, 0)
        addFace(idx: 3, with: transform)

        /// face 4
        transform = CATransform3DMakeTranslation(-100, 0, 0)
        transform = CATransform3DRotate(transform, -.pi / 2, 0, 1, 0)
        addFace(idx: 4, with: transform)

        /// face 5
        transform = CATransform3DMakeTranslation(0, 0, -100)
        transform = CATransform3DRotate(transform, .pi, 0, 1, 0)
        addFace(idx: 5, with: transform)
    }
    func addFace(idx: Int, with transform: CATransform3D) {
        /// 获取face视图并将其添加到容器中
        let face = faces[idx]
        self.containerView.addSubview(face)

        /// 将face视图放在容器的中心
        face.bounds.size = CGSize(width: kContainerWidth, height: kContainerWidth)
        face.center = CGPoint(x: kContainerWidth / 2, y: kContainerWidth / 2)

        /// 添加transform
        face.layer.transform = transform
    }
}

// MARK: - 🍺UI Prepare & Masonry
private extension LXCubeVC {
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
         self.title = "Cube"

        containerView.backgroundColor = .cyan
//        f0View.backgroundColor = .green
//        f1View.backgroundColor = .purple
//        f2View.backgroundColor = .brown
//        f3View.backgroundColor = .magenta
//        f4View.backgroundColor = .orange
//        f5View.backgroundColor = .yellow
        self.view.backgroundColor = UIColor.lightGray

        [containerView].forEach(self.view.addSubview)
        masonry()
    }

    func masonry() {
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(300)
        }
    }
}

// MARK: - 🔐
private let LIGHT_DIRECTION: (x: Float, y: Float, z: Float) = (x: 0, y: 1, z: -0.5)
private let AMBIENT_LIGHT: CGFloat = 0.5
private extension LXCubeVC {
    func start() {
        //set up the container sublayer transform
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
//        perspective = CATransform3DRotate(perspective, -.pi / 4, 1, 0, 0)
//        perspective = CATransform3DRotate(perspective, -.pi / 4, 0, 1, 0)
        self.containerView.layer.sublayerTransform = perspective
        //add cube face 1
        var transform = CATransform3DMakeTranslation(0, 0, 100)
        addFace(idx: 0, withTransform: transform)
        //add cube face 2
        transform = CATransform3DMakeTranslation(100, 0, 0)
        transform = CATransform3DRotate(transform, .pi / 2, 0, 1, 0)
        addFace(idx: 1, withTransform: transform)
        //add cube face 3
        transform = CATransform3DMakeTranslation(0, -100, 0)
        transform = CATransform3DRotate(transform, .pi / 2, 1, 0, 0)
        addFace(idx: 2, withTransform: transform)
        //add cube face 4
        transform = CATransform3DMakeTranslation(0, 100, 0)
        transform = CATransform3DRotate(transform, -.pi / 2, 1, 0, 0)
        addFace(idx: 3, withTransform: transform)
        //add cube face 5
        transform = CATransform3DMakeTranslation(-100, 0, 0)
        transform = CATransform3DRotate(transform, -.pi / 2, 0, 1, 0)
        addFace(idx: 4, withTransform: transform)
        //add cube face 6
        transform = CATransform3DMakeTranslation(0, 0, -100)
        transform = CATransform3DRotate(transform, .pi, 0, 1, 0)
        addFace(idx: 5, withTransform: transform)
    }
    func applyLightingToFace(face: CALayer) {
        //add lighting layer
        let layer = CALayer()
        layer.frame = face.bounds
        face.addSublayer(layer)
        // convert the face transform to matrix
        // (GLKMatrix4 has the same structure as CATransform3D)
        // 译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
        let transform = face.transform
        let matrix4 = transform.xl.convertToGLKMatrix4
        let matrix3 = GLKMatrix4GetMatrix3(matrix4)
        //get face normal
        var normal = GLKVector3Make(0, 0, 1)
        normal = GLKMatrix3MultiplyVector3(matrix3, normal)
        normal = GLKVector3Normalize(normal)
        // get dot product with light direction
        let light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION.x, LIGHT_DIRECTION.y, LIGHT_DIRECTION.z))
        let dotProduct = GLKVector3DotProduct(light, normal)
        // set lighting layer opacity
        let shadow = CGFloat(1) + CGFloat(dotProduct) - AMBIENT_LIGHT
        let color = UIColor(white: 0, alpha: shadow)
        layer.backgroundColor = color.cgColor
    }

    func addFace(idx: NSInteger, withTransform transform: CATransform3D) {
        // get the face view and add it to the container
        let face = self.faces[idx]
        self.containerView.addSubview(face)
        // center the face view within the container
        let containerSize = self.containerView.bounds.size
//        face.center = CGPoint(x: containerSize.width / 2.0, y: containerSize.height / 2.0)
        face.bounds.size = CGSize(width: kContainerWidth, height: kContainerWidth)
        face.center = CGPoint(x: kContainerWidth / 2, y: kContainerWidth / 2)
        // apply the transform
        face.layer.transform = transform
        //apply lighting
        applyLightingToFace(face: face.layer)
    }
}
