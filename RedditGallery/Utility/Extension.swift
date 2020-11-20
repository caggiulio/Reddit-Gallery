//
//  Extension.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 17/11/20.
//

import Foundation
import UIKit

extension String {
    func convertSpecialCharacters() -> String {
        var newString = self
        let char_dictionary = [
            "&amp;": "&",
            "&lt;": "<",
            "&gt;": ">",
            "&quot;": "\"",
            "&apos;": "'"
        ];
        for (escaped_char, unescaped_char) in char_dictionary {
            newString = newString.replacingOccurrences(of: escaped_char, with: unescaped_char)
        }
        return newString
    }
}

public extension UIImageView {
    func addBlur(withVibrancy: Bool = false, withAlpha: CGFloat = 1.0, withAnimation: Bool = false) -> UIImageView {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if withVibrancy {
            let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
            let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
            blurEffectView.contentView.addSubview(vibrancyView)
        }
        if withAnimation {
            blurEffectView.alpha = 0.0
            UIView.animate(withDuration: 1) {
                blurEffectView.alpha = withAlpha
            }
        } else {
            blurEffectView.alpha = withAlpha
        }
        self.addSubview(blurEffectView)
        
        return self
    }
    
    func removeBlur() {
        for sub in self.subviews {
            if sub is UIVisualEffectView {
                sub.removeFromSuperview()
            }
        }
    }
    
    func addGradientTransparent() {
        // Create the gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds

        gradientLayer.colors = [
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(1).cgColor,
            UIColor.white.withAlphaComponent(1).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor
        ]
        
        gradientLayer.locations = [0.0, 0.1, 0.9, 1.0]
        self.layer.mask = gradientLayer
    }
    
    func addGradientTransparentAtBottom() {
        // Create the gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [
            UIColor.white.withAlphaComponent(1).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor
        ]
        
        gradientLayer.locations = [0.65, 1.0]
        self.layer.mask = gradientLayer
    }
}

extension Array where Element: Equatable {
  mutating func removeEqualItems(_ item: Element) {
        self = self.filter { (currentItem: Element) -> Bool in
            return currentItem != item
        }
    }
}

extension UICollectionViewCell {
    
    internal enum PreferredAnimation {
        case preferred
        case notPreferred
    }
    
    func animateCellWithBounce(mode: PreferredAnimation, completion: @escaping () -> ()) {
        
        let scaleZoom: CGFloat = 1.15
        let scaleReduce: CGFloat = 0.85
        
        if mode == .preferred {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: {
                    self.transform = CGAffineTransform(scaleX: scaleZoom, y: scaleZoom)
                }) { (_) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.transform = CGAffineTransform(scaleX: scaleReduce, y: scaleReduce)
                    }) { (_) in
                        UIView.animate(withDuration: 0.1, animations: {
                            self.transform = CGAffineTransform.identity
                        }) { (_) in
                            completion()
                        }
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: {
                    self.transform = CGAffineTransform(scaleX: scaleReduce, y: scaleReduce)
                }) { (_) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.transform = CGAffineTransform(scaleX: scaleZoom, y: scaleZoom)
                    }) { (_) in
                        UIView.animate(withDuration: 0.1, animations: {
                            self.transform = CGAffineTransform.identity
                        }) { (_) in
                            completion()
                        }
                    }
                }
            }
        }
    }
}

extension UIImageView {
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }
  

  @objc private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
}

public extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    func showLoader() {
        if let kWindow = UIWindow.key {
            for v in kWindow.subviews {
                if v.tag == 500 {
                    return
                }
            }
            let activityIndicator = UIActivityIndicatorView()
            let containerLoader = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            containerLoader.backgroundColor = UIColor.lightGray.withAlphaComponent(0.75)
            containerLoader.layer.cornerRadius = 10
            containerLoader.center = CGPoint(x: kWindow.screen.bounds.width / 2, y: kWindow.screen.bounds.height / 2)
            containerLoader.tag = 500
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            activityIndicator.center = CGPoint(x: containerLoader.bounds.width / 2, y: containerLoader.bounds.height / 2)
            activityIndicator.color = UIColor.white
            activityIndicator.startAnimating()
            containerLoader.addSubview(activityIndicator)
            kWindow.addSubview(containerLoader)
        }
    }
    
    func hideLoader() {
        if let kWindow = UIWindow.key {
            let act = kWindow.viewWithTag(500)
            act?.removeFromSuperview()
        }
    }
}

public extension UIViewController {
    func showLoader() {
        if let k = UIWindow.key {
            k.showLoader()
        }
    }
    
    func hideLoader() {
        if let k = UIWindow.key {
            k.hideLoader()
        }
    }
}
