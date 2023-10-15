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
    
    let levelScene: LevelScene
    
    init(sceneRenderer renderer: SCNSceneRenderer) {
        sceneRenderer = renderer
        levelScene = LevelScene();
        
        super.init()
        
        sceneRenderer.delegate = self
        sceneRenderer.scene = levelScene
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        levelScene.update()
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
