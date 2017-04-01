//
//  WNSetupTCell.swift
//  Wannar
//
//  Created by 付国良 on 2016/11/24.
//  Copyright © 2016年 玩哪儿. All rights reserved.
//

import UIKit

class WNSetupTCell: UITableViewCell {

    private var titleLabel: UILabel?
    private var subtitleLabel: UILabel?
    private var arrowImage: UIImageView?
    
    
    class func cellWith(tableView: UITableView) -> WNSetupTCell {
        
        let cell: WNSetupTCell = tableView.dequeueReusableCell()
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
    
    
    private func buildUI() {
        
        /// Title Label
        let titleLabel: UILabel = UILabel.init(color: UIColor.textColor(),
                                               size: 15)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.top.equalToSuperview().offset(10.0)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.titleLabel = titleLabel
        
        
        /// Arrow Image View
        let arrowImage: UIImageView = UIImageView.init(mode: .scaleAspectFit)
        self.contentView.addSubview(arrowImage)
        arrowImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10.0)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 8.0, height: 18.0))
        }
        self.arrowImage = arrowImage
        
        
        /// Subtitle Label
        let subtitleLabel: UILabel = UILabel.init(color: UIColor.textColor(),
                                                  size: 11.0,
                                                  textAlignment: .right)
        self.contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(arrowImage.snp.left).offset(-10.0)
            make.centerY.equalToSuperview()
        }
        self.subtitleLabel = subtitleLabel
        
    }

    public func loadData(model: WNSetupRowModel) -> Void {
    
        self.titleLabel?.text = model.title
        self.subtitleLabel?.text = model.subtitle
        
    }
    
}
