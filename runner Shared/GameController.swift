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
    
    let sceneRenderer: SCNSceneRenderer
    
    let player: Player
    let camera: Camera
    let stage: Stage
    
    init(sceneRenderer renderer: SCNSceneRenderer) {
        sceneRenderer = renderer
        stage = Stage();
        let scene = stage.scene
        
        player = Player(from: "player.scn")
        camera = Camera()
        super.init()
        
        sceneRenderer.delegate = self
        
        player.addToScene(scene)
        camera.addToScene(scene)
        sceneRenderer.scene = scene
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // Called before each frame is rendered
        if(player.node.position.z > 80) {
            player.node.position.z = 0
        }
        camera.anchor(to: player.node)
        
    }
}

extension GameController {
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
}
