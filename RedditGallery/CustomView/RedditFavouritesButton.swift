//
//  RedditFavouritesButton.swift
//  RedditGallery
//
//  Created by Nunzio Giulio Caggegi on 18/11/20.
//

import UIKit

class RedditFavouritesButton: UIButton {

    override init(frame: CGRect) {
            super.init(frame: frame)
            configeBtn()
    }

        required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
            configeBtn()
        }
    
    func configeBtn() {
        self.addTarget(self, action: #selector(defaultAction(_:)), for: .touchUpInside)
    }
    
    override func draw(_ rect: CGRect) {
        self.setImage(UIImage(systemName: "heart"), for: .normal)
        self.tintColor = .systemRed
    }
    
    @objc func defaultAction (_ sender: UIButton) {
        
    }
    
    func setSelected(_ value: Bool) {
        DispatchQueue.main.async {
            
            func animate() {
                    let pulse = CASpringAnimation(keyPath: "transform.scale")
                    pulse.duration = 0.3
                    pulse.fromValue = 1.0
                    pulse.toValue = 1.12
                    pulse.autoreverses = true
                    pulse.repeatCount = 2
                    pulse.initialVelocity = 1.0
                    pulse.damping = 0.8
                    self.layer.add(pulse, forKey: nil)
            }
            
            animate()
            
            if value {
                self.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                self.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }

    
}
