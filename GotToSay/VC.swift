//
//  VC.swift
//  HelloSwiftUI
//
//  Created by e2ne0 on 2020/7/10.
//  Copyright © 2020 e2ne0. All rights reserved.
//

import SwiftUI


struct VC: View {
    var body: some View{
			myController()
    }
}
struct myController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<myController>) -> UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyBoard.instantiateViewController(identifier: "Home")
        return controller
    }
	
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<myController>) {
		
    }
}

struct VC_Previews: PreviewProvider {
    static var previews: some View {
        VC()
    }
}
