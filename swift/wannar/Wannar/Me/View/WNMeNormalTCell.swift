//
//  WNMeNormalTCell.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/22.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import UIKit

class WNMeNormalTCell: UITableViewCell {

    var iconImage : UIImageView?
    var titleLabel : UILabel?
    
    class func cellWith(tableView: UITableView) -> WNMeNormalTCell {
        
        let cell: WNMeNormalTCell = tableView.dequeueReusableCell()
        cell.selectionStyle = .none
        return cell
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.buildUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }

    private func buildUI() -> Void {
        
        /// Icon Image
        let iconImage = UIImageView.init()
        self.contentView.addSubview(iconImage)
        iconImage.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview().offset(0.0)
            make.width.equalTo(50.0)
        }
        self.iconImage = iconImage

        /// Title Label
        let titleLabel = UILabel.init(color: .textColor,
                                      fontName: WNConfig.FontName.normal,
                                      size: 15.0,
                                      textAlignment: .left)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImage.snp.right).offset(0.0)
            make.right.equalToSuperview().offset(0.0)
            make.top.equalToSuperview().offset(15.0)
            make.bottom.equalToSuperview().offset(-15.0)
        }
        self.titleLabel = titleLabel;
        
        /// Line View
        let lineView = UIView.init()
        lineView.backgroundColor = .separatorColor
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.right.bottom.equalToSuperview().offset(0.0)
            make.height.equalTo(0.5)
        }
        
    }
    
    public func loadData(model: Dictionary <String, String>?) -> Void {
        self.iconImage?.image = UIImage.init(named: (model?["iconImage"]!)!)
        self.titleLabel?.text = model?["title"]
    }
    
}
