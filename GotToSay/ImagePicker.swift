//
//  ImagePicker.swift
//  GotToSay
//
//  Created by e2ne0 on 2020/7/22.
//  Copyright © 2020 god. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
	class Coordinator: NSObject,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
		let parent: ImagePicker
		init(_ parent: ImagePicker){
			self.parent = parent
			}
		func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey: Any]){
		if let uiImage = info[.originalImage] as? UIImage{
			parent.image = uiImage
		}
		parent.presentationMode.wrappedValue.dismiss()
		}
		func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
			parent.presentationMode.wrappedValue.dismiss()
		}
	}
	var sourceType: UIImagePickerController.SourceType = .photoLibrary
	@Environment(\.presentationMode) var presentationMode
	@Binding var image: UIImage?
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
		let picker = UIImagePickerController()
		picker.delegate = context.coordinator
		picker.sourceType = sourceType
		return picker
	}
	func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
		
	}
}
