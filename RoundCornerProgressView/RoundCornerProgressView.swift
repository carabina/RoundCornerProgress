//
//  RoundCornerProgressView.swift
//  PhucNguyen
//
//  Created by Phuc Nguyen on 8/18/16.
//  Copyright © 2016 Phuc Nguyen. All rights reserved.
//
import UIKit

@IBDesignable
public class RoundCornerProgressView: UIView {
    
    @IBInspectable public var trackRoundCorners: UIRectCorner = [.topRight, .bottomRight, .topLeft, .bottomLeft] {
        didSet {
            trackView.roundCorner(roundingCorners: trackRoundCorners, cornerRadius: CGSize(width: frame.size.height / 2, height: frame.size.height / 2))
            
        }
    }
    
    @IBInspectable public var progressRoundCorners: UIRectCorner = [] {
        didSet {
            progressView.roundCorner(roundingCorners: progressRoundCorners, cornerRadius: CGSize(width: frame.size.height / 2, height: frame.size.height / 2))
        }
    }
    
    private var trackView = UIView(frame: .zero)
    
    @IBInspectable public var trackTintColor = UIColor.lightGray {
        didSet {
            trackView.backgroundColor = trackTintColor
        }
    }
    
    private var progressView = UIView(frame: .zero)
    
    @IBInspectable public var progressTintColor = UIColor.red {
        didSet {
            progressView.backgroundColor = progressTintColor
        }
    }
    
    @IBInspectable public var progress: CGFloat = 0.3 {
        didSet {
            if progress < 0 {
                progress = 0
            } else if progress > 1 {
                progress = 1
            }
            progressView.frame = CGRect(origin: progressView.frame.origin, size: CGSize(width: frame.width * progress, height: frame.height))
            progressView.roundCorner(roundingCorners: progressRoundCorners, cornerRadius: CGSize(width: frame.size.height / 2, height: frame.size.height / 2))
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        setupSubviews()
    }
    
    private func setupSubviews() {
        trackView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: frame.width - 2, height: frame.height)))
        trackView.roundCorner(roundingCorners: trackRoundCorners, cornerRadius: CGSize(width: frame.size.height / 2, height: frame.size.height / 2))
        trackView.backgroundColor = trackTintColor
        trackView.clipsToBounds = true
        
        addSubview(trackView)
        
        progressView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: frame.width * progress, height: frame.height)))
        progressView.roundCorner(roundingCorners: progressRoundCorners, cornerRadius: CGSize(width: frame.size.height / 2, height: frame.size.height / 2))
        progressView.backgroundColor = progressTintColor
        trackView.addSubview(progressView)
    }
}

fileprivate extension UIView {
    func roundCorner(roundingCorners: UIRectCorner, cornerRadius: CGSize) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
