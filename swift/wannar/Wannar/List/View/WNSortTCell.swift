//
//  WNSortTCell.swift
//  Wannar
//
//  Created by 付国良 on 2017/5/10.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit

class WNSortTCell: UITableViewCell {

    var imageName: String = "" {
        didSet {
            self.icon.image = UIImage.init(named: imageName)?.imageBy(tintColor: isSelect ? .themColor : .textColor)
        }
    }
    var title: String = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
    var isSelect: Bool = false {
        didSet {
            self.titleLabel.textColor = isSelect ? .themColor : .textColor
            self.icon.image = UIImage.init(named: imageName)?.imageBy(tintColor: isSelect ? .themColor : .textColor)
        }
    }
    private var icon: UIImageView!
    private var titleLabel: UILabel!
    
    class func cellWith(tableView: UITableView) -> WNSortTCell {
        
        let cell: WNSortTCell = tableView.dequeueReusableCell()
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
    
        /// Icon
        let icon = UIImageView.init(mode: .scaleAspectFit)
        self.contentView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.size.equalTo(CGSize.init(width: 18.0, height: 18.0))
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(15.0)
        }
        self.icon = icon
        
        /// Title Label
        let titleLabel = UILabel.init(color: .textColor, size: 14.0, textAlignment: .left)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(10.0)
            make.right.equalToSuperview().offset(0.0)
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
