//
//  noDataFoundNip.swift
//  Mazad
//
//  Created by Mohamed Ahmed on 10/27/22.
//

import UIKit

class noDataFoundNip: UIView {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var content: UILabel!
    
    init(_ icon: UIImage, _ content: String) {
        self.init()
        self.setErrorWith(icon, content: content)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let view = Bundle.main.loadNibNamed("noDataFoundNip", owner: self, options: nil)?.first as? UIView
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view?.frame = bounds
        addSubview(view!)
    }
    
    func setErrorWith(_ icon: UIImage, content: String) {
        self.icon.image = icon
        self.content.text = content
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
