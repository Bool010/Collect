//
//  WNFilterTCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/3.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNFilterTCell: UITableViewCell {

    var titleLabel: UILabel!
    var isSelect: Bool = false {
        didSet {
            self.titleLabel.textColor = isSelect ? .themColor : .textColor
        }
    }
    
    class func cellWith(tableView: UITableView) -> WNFilterTCell {
        
        let cell: WNFilterTCell = tableView.dequeueReusableCell()
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
    
    fileprivate func buildUI() -> Void {
        
        let titleLabel = UILabel.init(color: .textColor, fontName: WNConfig.FontName.normal, size: 14.0, textAlignment: .left)
        titleLabel.numberOfLines = 0
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.top.equalToSuperview().offset(10.0)
            make.bottom.equalToSuperview().offset(-10.0)
            make.right.equalToSuperview().offset(-10.0)
        }
        self.titleLabel = titleLabel
        
        let separator = UIView.init()
        separator.backgroundColor = UIColor.separatorColor
        self.contentView.addSubview(separator)
        separator.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.bottom.equalToSuperview().offset(0.0)
            make.height.equalTo(0.5)
        }
        
    }

}
