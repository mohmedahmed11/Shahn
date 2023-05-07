//
//  noUserDataNotLoadedNip.swift
//  Mazad
//
//  Created by Mohamed Ahmed on 10/29/22.
//

import UIKit

class noUserDataNotLoadedNip: UIView {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var content: UILabel!
    var reloadData: (() -> ())?
    
    init(_ icon: UIImage?, _ content: String) {
        self.init()
        if let icon = icon {
            self.icon.image = icon
        }
        self.content.text = content
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let view = Bundle.main.loadNibNamed("noUserDataNotLoadedNip", owner: self, options: nil)?.first as? UIView
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view?.frame = bounds
        addSubview(view!)
    }
    
    
    @IBAction func reloadDataAction(_ sender: UIButton) {
        reloadData?()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
