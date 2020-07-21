//
//  ViewController.swift
//  HelloSwiftUI
//
//  Created by e2ne0 on 2020/7/2.
//  Copyright © 2020 e2ne0. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SwiftUI

protocol delegate_washTag{
    func sendTag() -> washTagInfo
}

class ViewController: UIViewController, ARSCNViewDelegate, delegate_washTag {
    @IBOutlet var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main){
            configuration.detectionImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 5
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
	var tag: washTagInfo! = washTagInfo()

    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        guard let imageAnchor = anchor as? ARImageAnchor else {return nil}
        guard let imageName = imageAnchor.name else {return nil}
        if imageName != nil{
			let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi/2
			print("hi")
			if imageName == "tagSisley"{
				tag.wash = "GentleWashAtOrBelow30"
				tag.bleach = "DoNotBleach"
				tag.tumbleDry = "DoNotTumbleDry"
				tag.dry = "LineDryInShade"
				tag.iron = "IronAtLowTemperature"
				tag.dryClean = "DoNotDryClean"
				createHostingController(for: planeNode,imgName: imageName,myTag: tag)
				loadtag = tag
			}else{createHostingController(for: planeNode,imgName: imageName)}
            node.addChildNode(planeNode)
            return node
        }else{
            return nil
        }
    }
	
	func sendTag() -> washTagInfo {
		return tag
	}
	
    func createHostingController(for node: SCNNode,imgName: String) {
        let arVC = UIHostingController(rootView: ARView(name:imgName,num:0))
			
        DispatchQueue.main.async {
            arVC.willMove(toParent: self)
            self.addChild(arVC)
            
            arVC.view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
            self.view.addSubview(arVC.view)
            self.show(hostingVC: arVC, on: node)
        }
		
    }
    
	func createHostingController(for node: SCNNode,imgName: String, myTag:washTagInfo) {
        let arVC = UIHostingController(rootView: ARView(name:imgName, num:0, myTag:myTag))
		
        DispatchQueue.main.async {
            arVC.willMove(toParent: self)
            self.addChild(arVC)
            
            arVC.view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
            self.view.addSubview(arVC.view)
            self.show(hostingVC: arVC, on: node)
        }
    }
	
    func show(hostingVC: UIHostingController<ARView>, on node:SCNNode)
    {
        let material = SCNMaterial()
        hostingVC.view.isOpaque = false
        material.diffuse.contents = hostingVC.view
        node.geometry?.materials = [material]
        hostingVC.view.backgroundColor = UIColor.clear
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
