//
//  WNListCityTCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/12.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNListCityTCell: UITableViewCell {

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var isSelect: Bool = false {
        didSet {
            titleLabel.textColor = isSelect ? .themColor : .textColor
        }
    }
    
    private var titleLabel: UILabel!
    
    class func cellWith(tableView: UITableView) -> WNListCityTCell {
        
        let cell: WNListCityTCell = tableView.dequeueReusableCell()
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
        
        // Title Label
        let titleLabel = UILabel.init(color: .textColor, size: 14, textAlignment: .left)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.top.equalToSuperview().offset(15.0)
            make.centerY.equalToSuperview()
        }
        self.titleLabel = titleLabel
        
        /// Separator Line
        let line = UIView.init()
        line.backgroundColor = UIColor.separatorColor
        self.contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.right.bottom.equalToSuperview().offset(0.0)
            make.height.equalTo(0.5)
        }
    }
}
