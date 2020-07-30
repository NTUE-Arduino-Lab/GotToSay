//
//  KeyBoardAviodance.swift
//  GotToSay
//
//  Created by e2ne0 on 2020/7/23.
//  Copyright © 2020 god. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import UIKit



extension UIResponder {
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }

    private static weak var _currentFirstResponder: UIResponder?

    @objc private func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }
    
    var globalFrame: CGRect? {
        guard let view = self as? UIView else { return nil }
        return view.superview?.convert(view.frame, to: nil)
    }
}

extension UITextField{
	@objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
       self.resignFirstResponder()
    }
}

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

struct KeyboardAdaptive: ViewModifier {
    @State private var bottomPadding: CGFloat = 0

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.bottomPadding)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    let keyboardTop = geometry.frame(in: .global).height - keyboardHeight
                    let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
                    self.bottomPadding = max(0, focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom)
            }
            .animation(.easeOut(duration: 0.16))
        }
    }
}

final class _TextFieldCoordinator: NSObject {
    var control: _TextField

    init(_ control: _TextField) {
        self.control = control
        super.init()
        control.textField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        control.textField.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        control.textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        control.textField.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(_:)), for: .editingDidEndOnExit)
    }

    @objc private func textFieldEditingDidBegin(_ textField: UITextField) {
        control.onEditingChanged(true)
    }

    @objc private func textFieldEditingDidEnd(_ textField: UITextField) {
        control.onEditingChanged(false)
    }

    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        control.text = textField.text ?? ""
    }

    @objc private func textFieldEditingDidEndOnExit(_ textField: UITextField) {
        control.onCommit()
    }
}

struct _TextField: UIViewRepresentable {

    private let title: String?
    @Binding var text: String
	private let changeColor: Bool
    let onEditingChanged: (Bool) -> Void
    let onCommit: () -> Void
	
    let textField = UITextField()
	
	init(title: String?, text: Binding<String>, changeColor: Bool = false,onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = {}) {
        self.title = title
        self._text = text
		self.changeColor = changeColor
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
    }
	
    func makeCoordinator() -> _TextFieldCoordinator {
        _TextFieldCoordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
		let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
		let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		toolBar.items = [spacer, doneButton]
        toolBar.setItems([spacer, doneButton], animated: true)

		textField.attributedPlaceholder = NSAttributedString(string: title ?? "", attributes:
		[NSAttributedString.Key.foregroundColor: UIColor.gray])
		
		textField.inputAccessoryView = toolBar
		if changeColor{
			textField.textColor = UIColor.black
		}
		textField.delegate = context.coordinator as? UITextFieldDelegate
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}


