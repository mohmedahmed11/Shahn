//
//  HeaderView.swift
//  StretchyHeaderLBTA
//
//  Created by Brian Voong on 12/22/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "logo"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // custom code for layout
        addSubview(imageView)
        imageView.fillSuperview()
        
        //blur
        setupVisualEffectBlur()
    }
    
    var animator: UIViewPropertyAnimator!
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    fileprivate func setupVisualEffectBlur() {
//        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        
        // iOS 13 UPDATE: You now have to set .effect to nil, otherwise blur instantly begins at full intensity
        animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear, animations: {
            self.visualEffectView.effect = nil
        })
        // Reverse animator so that we can use fractionComplete of 0 as our "starting point". You don't have to do this, but it makes for easier calculations in your StretchyHeaderController.scrollViewDidScroll
        animator.isReversed = true
        animator.fractionComplete = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
