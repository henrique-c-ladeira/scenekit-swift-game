//
//  Camera.swift
//  runner
//
//  Created by Henrique Ladeira on 09/10/23.
//

import SceneKit

class Camera {
    let node: SCNNode
    let camera: SCNCamera
    
    init() {
//        let cameraScene = SCNScene(named: "Art.scnassets/stage1.scn")!
//        node = cameraScene.rootNode.childNode(withName: "camera", recursively: true)!
//        guard let camera = node.camera else { camera = SCNCamera(); return }
//        self.camera = camera
        node = SCNNode()
        node.position = SCNVector3(0,0,0)
        node.eulerAngles = SCNVector3(0, Double.pi, 0)
        camera  = SCNCamera()
        node.camera = camera
    }
    
    func addToScene(_ scene: SCNScene) {
        scene.rootNode.addChildNode(node)
        scene.rootNode.camera = camera
    }
    
    func anchor(to node: SCNNode) {
        self.node.anchor(to: node)
        
    }
}
