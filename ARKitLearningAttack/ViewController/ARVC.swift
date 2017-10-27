//
//  ViewController.swift
//  ARKitLearningAttack
//
//  Created by admin on 27/10/2017.
//  Copyright © 2017 MuhammadAamir. All rights reserved.
//

import UIKit
import ARKit

class ARVC: UIViewController, ARSCNViewDelegate {
    
    // Variables and Constants
    var sceneView: ARSCNView!
    let configration = ARWorldTrackingConfiguration()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView = ARSCNView(frame: self.view.frame)
        sceneView.delegate = self
        view.addSubview(self.sceneView)
        self.sceneView.session.run(configration)
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.showsStatistics = true
        
        //        Placing Object when view loaded
        placeObject(x: 0.05, y: 0.05, z: 0.05, r: 0.0, a: -0.03)
        placeObject(x: 0.03, y: 0.03, z: 0.03, r: 0.02, a: 0.03)
    }
    
    
    func placeObject(x:CGFloat, y:CGFloat, z:CGFloat, r:CGFloat, a:CGFloat)
    {
        let node = SCNNode(geometry: SCNBox(width: x, height: y , length: z, chamferRadius: r))
        
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        
        node.position = SCNVector3(a, 0, -0.2)
        
        self.sceneView.scene.rootNode.addChildNode(node)
        node.addChildNode(node)
        print("Object Place")
    }
    
    
    
}

