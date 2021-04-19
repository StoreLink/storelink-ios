//
//  BaseTextField.swift
//  Storelink
//
//  Created by Акан Акиш on 11/28/20.
//  Copyright © 2020 Акан Акиш. All rights reserved.
//

import UIKit

open class BaseTextField: TextFieldEffects {
    
    private enum Constants {
        static let borderSize: CGFloat = 1
        static let borderCornerRadius: CGFloat = 4
        static let textFieldInsets = CGPoint(x: 16, y: 5)
        static let placeholderInsets = CGPoint(x: 16, y: 5)
        static let bottomInset: CGFloat = 5
        static let rightViewSize: CGFloat = 24
        static let leftAndRigthPadding: CGFloat = 16
    }
    
    private let placeholderLabel = UILabel()
    private let borderLayer = CALayer()
    
    /**
     The color of the border when it has content.
     
     This property applies a color to the edges of the control. The default value for this property is a clear color.
     */
    open var activeBorderColor: UIColor = Colors.teal.color {
        didSet {
            updateBorder()
            updatePlaceholder()
        }
    }
    
    /**
     The color of the border when it has no content.
     
     This property applies a color to the edges of the control. The default value for this property is a clear color.
     */
    open var inactiveBorderColor: UIColor = .lightGray {
        didSet {
            updateBorder()
            updatePlaceholder()
        }
    }
    
    /**
     The color of the placeholder text.
     
     This property applies a color to the complete placeholder string. The default value for this property is a black color.
     */
    open var placeholderColor: UIColor = .black {
        didSet {
            updatePlaceholder()
        }
    }
    
    /**
     The scale of the placeholder font.
     
     This property determines the size of the placeholder label relative to the font size of the text field.
     */
    open var placeholderFontScale: CGFloat = 0.8 {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            updateBorder()
        }
    }
    
    // MARK: TextFieldEffects
    
    override open func drawViewsForRect(_ rect: CGRect) {
        updateBorder()
        updatePlaceholder()
        
        addSubview(placeholderLabel)
        layer.addSublayer(borderLayer)
    }
    
    override open func animateViewsForTextEntry() {
        UIView.animate(withDuration: 0.3, animations: {
            self.updateBorder()
            self.updatePlaceholder()
        }, completion: { _ in
            self.animationCompletionHandler?(.textEntry)
        })
    }
    
    override open func animateViewsForTextDisplay() {
        UIView.animate(withDuration: 0.3, animations: {
            self.updateBorder()
            self.updatePlaceholder()
        }, completion: { _ in
            self.animationCompletionHandler?(.textDisplay)
        })
    }
    
    // MARK: Publid
    
    public func showError() {
        borderLayer.borderColor = UIColor.red.cgColor
    }
    
    public func hideError() {
        borderLayer.borderColor = inactiveBorderColor.cgColor
    }
    
    // MARK: Private
    
    private func updatePlaceholder() {
        placeholderLabel.frame = placeholderRect(forBounds: bounds)
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = isFirstResponder ? activeBorderColor : placeholderColor
        placeholderLabel.textAlignment = textAlignment
        
        if isFirstResponder || text!.isNotEmpty {
            placeholderLabel.font = placeholderFontFromFont(UIFont.systemFont(ofSize: 15, weight: .medium))
        } else {
            placeholderLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        }
    }
    
    private func updateBorder() {
        borderLayer.frame = rectForBounds(bounds)
        borderLayer.cornerRadius = Constants.borderCornerRadius
        borderLayer.borderWidth = Constants.borderSize
        borderLayer.borderColor = isFirstResponder ? activeBorderColor.cgColor : inactiveBorderColor.cgColor
    }
    
    private func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
     let smallerFont = UIFont(descriptor: font.fontDescriptor, size: font.pointSize * placeholderFontScale)
        return smallerFont
    }
    
    private var placeholderHeight: CGFloat {
        return placeholderFontFromFont(font!).lineHeight
    }
    
    private func rectForBounds(_ bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
    }
    
    // MARK: - Overrides
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if isFirstResponder || text!.isNotEmpty {
            return CGRect(x: Constants.placeholderInsets.x, y: Constants.placeholderInsets.y, width: bounds.width - Constants.placeholderInsets.x, height: placeholderHeight)
        } else {
            return CGRect(x: Constants.placeholderInsets.x, y: 0, width: bounds.width - Constants.placeholderInsets.x, height: bounds.height)
        }
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: Constants.textFieldInsets.x,
                      y: Constants.textFieldInsets.y + placeholderHeight,
                      width: bounds.width - Constants.placeholderInsets.x - Constants.leftAndRigthPadding - (rightViewMode == .always ? Constants.rightViewSize : 0),
                      height: bounds.height - placeholderHeight - Constants.textFieldInsets.y - Constants.bottomInset)
    }
    
    open override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - Constants.rightViewSize - 16,
                      y: (bounds.height - Constants.rightViewSize) / 2,
                      width: Constants.rightViewSize,
                      height: Constants.rightViewSize)
    }
}
