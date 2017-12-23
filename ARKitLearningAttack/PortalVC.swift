//
//  PortalVC.swift
//  ARKitLearningAttack
//
//  Created by admin on 14/11/2017.
//  Copyright © 2017 MuhammadAamir. All rights reserved.
//

import UIKit
import ARKit

class PortalVC: UIViewController, ARSCNViewDelegate {
    
    
    @IBOutlet weak var PlaneLBL: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else {return}
        DispatchQueue.main.async {
            self.PlaneLBL.isHidden = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.PlaneLBL.isHidden = true
        }
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        guard let sceneView = sender.view as? ARSCNView else {return}
        let touchLocation = sender.location(in: sceneView)
        let hitTestResult = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        if !hitTestResult.isEmpty {
            self.addPortal(hitTestResult: hitTestResult.first!)
        }else{
            
        }
    }
    
    func addPortal(hitTestResult: ARHitTestResult){
        let portalScene = SCNScene(named: "Portal.scnassets/Portal.scn")
        let portalNode = portalScene!.rootNode.childNode(withName: "Portal", recursively: false)!
        let transform = hitTestResult.worldTransform
        let planeXposition = transform.columns.3.x
        let planeYposition = transform.columns.3.y
        let planeZposition = transform.columns.3.z
        portalNode.position = SCNVector3(planeXposition, planeYposition, planeZposition)
        self.sceneView.scene.rootNode.addChildNode(portalNode)
        self.addPlane(nodeName: "roof", portalNode: portalNode, imageName: "top")
        self.addPlane(nodeName: "bottom", portalNode: portalNode, imageName: "bottom")
        self.addWall(nodeName: "LeftSideWall", portalNode: portalNode, imageName: "sideA")
        self.addWall(nodeName: "RightSideWall", portalNode: portalNode, imageName: "sideA")
        self.addWall(nodeName: "BackWall", portalNode: portalNode, imageName: "back")
        self.addWall(nodeName: "SideDoorA", portalNode: portalNode, imageName: "sideDoorA")
        self.addWall(nodeName: "SideDoorB", portalNode: portalNode, imageName: "sideDoorB")


    }
    func addnode(){
        let zoombi = SCNScene(named: "Portal.scnassets/Zoombi.scn")
        let zoombiNode = zoombi?.rootNode.childNode(withName: "Zoombi", recursively: true)
        zoombiNode?.position = SCNVector3(0, 0, -1)
        self.sceneView.scene.rootNode.addChildNode(zoombiNode!)
    }
    
    func addPlane(nodeName: String, portalNode: SCNNode, imageName: String){
     let child = portalNode.childNode(withName: nodeName, recursively: true)
        child?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Portal.scnassets/\(imageName).png")
    }
   
    func addWall(nodeName: String, portalNode: SCNNode, imageName: String){
        let child = portalNode.childNode(withName: nodeName, recursively: true)
        child?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Portal.scnassets/\(imageName).png")
    }
    
    @IBAction func Add3DModel(_ sender: Any) {
    }
    
    
    
}
