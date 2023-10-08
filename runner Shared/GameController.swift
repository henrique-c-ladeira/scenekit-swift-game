//
//  GameController.swift
//  runner Shared
//
//  Created by Henrique Ladeira on 05/10/23.
//

import SceneKit

#if os(macOS)
    typealias SCNColor = NSColor
#else
    typealias SCNColor = UIColor
#endif

class GameController: NSObject, SCNSceneRendererDelegate {
    
    let scene: SCNScene
    let sceneRenderer: SCNSceneRenderer
    
    let player: SCNNode
    let camera: SCNNode
    
    init(sceneRenderer renderer: SCNSceneRenderer) {
        sceneRenderer = renderer
        scene = SCNScene(named: "Art.scnassets/stage1.scn")!
        
        self.player = scene.rootNode.childNode(withName: "player", recursively: true)!
        self.camera = scene.rootNode.childNode(withName: "camera", recursively: true)!
        
        super.init()
        
        sceneRenderer.delegate = self
        
        camera.anchor(to: player)
        
        let floor = scene.rootNode.childNode(withName: "plane", recursively: true)!
        floor.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: floor.geometry!))
        
        
        for index in (0...10) {
            let block = scene.rootNode.childNode(withName: "blocker", recursively: true)!
            let newBlock = SCNNode(geometry: block.geometry);
            newBlock.position = block.position
            newBlock.position.z = block.position.z + 5 * Float(index)
            newBlock.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: newBlock.geometry!))
            scene.rootNode.addChildNode(newBlock)
        }
        
        player.runAction(SCNAction.repeatForever(SCNAction.moveBy(x: 0.01, y: 0, z: 3, duration: 1)))
        player.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: player.geometry!))
        
        
        sceneRenderer.scene = scene
    }
    
    func highlightNodes(atPoint point: CGPoint) {
        let hitResults = self.sceneRenderer.hitTest(point, options: [:])
        for result in hitResults {
            // get its material
            guard let material = result.node.geometry?.firstMaterial else {
                return
            }
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = SCNColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = SCNColor.red
            
            SCNTransaction.commit()
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // Called before each frame is rendered
        camera.anchor(to: player)
    }

}
