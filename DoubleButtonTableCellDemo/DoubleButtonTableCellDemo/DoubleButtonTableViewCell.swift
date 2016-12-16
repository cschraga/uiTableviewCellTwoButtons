//
//  DoubleButtonTableViewCell.swift
//  DoubleButtonTableCellDemo
//
//  Created by Christian Schraga on 12/16/16.
//  Copyright © 2016 Straight Edge Digital. All rights reserved.
//

import UIKit

enum DoubleButtonType: Int{
    case left = 0,
         right = 1
}

protocol DoubleButtonCellDelegate {
    func doubleButtonCell(cell: DoubleButtonTableViewCell, buttonClicked: DoubleButtonType)
}

class DoubleButtonTableViewCell: UITableViewCell {

    //data
    var leftButtonImage: UIImage? {
        get{
            return leftButton.image(for: .normal)
        }
        set(newImage){
            if newImage != nil {
                leftButton.setImage(newImage!.withRenderingMode(.alwaysTemplate), for: .normal)
                leftButton.tintColor = self.color
            } else {
                leftButton.setImage(newImage, for: .normal)
            }
        }
    }

    
    var rightButtonImage: UIImage? {
        get{
            return rightButton.image(for: .normal)
        }
        set(newImage){
            if newImage != nil {
                rightButton.setImage(newImage!.withRenderingMode(.alwaysTemplate), for: .normal)
                rightButton.tintColor = self.color
            } else {
                rightButton.setImage(newImage, for: .normal)
            }
        }
    }
    
    var labelText: String? {
        get{
            return label.text
        }
        set(newText){
            label.text = newText
        }
    }
    
    var indexPath: IndexPath?  //set by view controller
    
    //ui
    internal var leftButton:  UIButton!
    internal var rightButton: UIButton!
    internal var label:       UILabel! // custom since I don't like the way the default label spaces things
    
    //formatting
    var leftButtonSize  = CGSize.zero
    var rightButtonSize = CGSize.zero
    var buttonPadding   = CGFloat(5.0)
    var color           = UIColor.black  //color of everything
    var contentInset    = UIEdgeInsetsMake(2.0, 5.0, 2.0, 5.0)
    var labelFont: UIFont{
        get{
            return label.font
        }
        set(newVal){
            label.font = newVal
        }
    }
    
    //actions for buttons
    var buttonDelegate: DoubleButtonCellDelegate?
    
    //lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    convenience init(){
        self.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
    }
    
    fileprivate func setup(){
        leftButton = UIButton(type: .custom)
        leftButton.tag = 0
        leftButton.addTarget(self, action: #selector(DoubleButtonTableViewCell.buttonPressed(sender:)), for: .touchUpInside)
        self.contentView.addSubview(leftButton)
        
        rightButton = UIButton(type: .custom)
        rightButton.tag = 1
        rightButton.addTarget(self, action: #selector(DoubleButtonTableViewCell.buttonPressed(sender:)), for: .touchUpInside)
        self.contentView.addSubview(rightButton)
        
        label  = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        self.contentView.addSubview(label)
        
        leftButtonSize  = CGSize(width: 20.0, height: 20.0)
        rightButtonSize = CGSize(width: 20.0, height: 20.0)
        drawUI()
    }
    
    //convenience loader for view controller
    func load(text: String, indexPath: IndexPath?, buttonDelegate: DoubleButtonCellDelegate?, leftButtonImage: UIImage?, rightButtonImage: UIImage?){
        self.indexPath         = indexPath
        self.labelText         = text
        self.leftButtonImage   = leftButtonImage
        self.rightButtonImage  = rightButtonImage
        self.buttonDelegate    = buttonDelegate
        drawUI()
    }
    
    
    //formatting
    func drawUI(){
        label.textColor = color
        
        var x = contentInset.left
        let y = contentInset.top
        var w = leftButtonSize.width
        let h = leftButtonSize.height
        leftButton.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x += buttonPadding + w
        w  =  labelWidth()
        label.frame = CGRect(x: x, y: y, width: w, height: h)
        
        x += w + buttonPadding
        w  = rightButtonSize.width
        rightButton.frame = CGRect(x: x, y: y, width: w, height: h)
        
    }
    
    fileprivate func labelWidth() -> CGFloat{
        let maxWidth = contentView.bounds.width - contentInset.left - contentInset.right - leftButtonSize.width - rightButtonSize.width - 2.0*buttonPadding
        let w = min(maxWidth, label.intrinsicContentSize.width)
        return w
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawUI()
    }
    
    
    //selectors
    func buttonPressed(sender: UIButton){
        let type = DoubleButtonType(rawValue: sender.tag)!
        if let delegate = buttonDelegate {
            delegate.doubleButtonCell(cell: self, buttonClicked: type)
        } else {
            print("button pressed but there is no delegate")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
