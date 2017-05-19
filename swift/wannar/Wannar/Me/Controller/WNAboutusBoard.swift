//
//  WNAboutusBoard.swift
//  Wannar
//
//  Created by 付国良 on 2017/4/27.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import UIKit
import FSPagerView
import Spring
import SABlurImageView

class WNAboutusBoard: UIViewController {

    var logo: SpringImageView!
    var slogan: SpringLabel!
    var model: Array<Array<String>>!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.configModel()
        self.buildUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        DispatchQueue.delay(0.0) { [weak self] in
            guard let _self = self else { return }
            
            _self.logo.duration = 1.0
            _self.logo.force = 1.0
            _self.logo.animation = Spring.AnimationPreset.ZoomIn.rawValue
            _self.logo.animateToNext(completion: {
                _self.slogan.duration = 1.5
                _self.slogan.force = 1.6
                _self.slogan.animation = Spring.AnimationPreset.SqueezeRight.rawValue
                _self.slogan.animate()
                _self.slogan.isHidden = false
            })
            _self.logo.animate()
            _self.logo.isHidden = false
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        wn_deinitMessage("关于我们")
    }
    
    // MARK: - Event
    fileprivate func configModel() -> Void {
        
        self.model =
            [["资质", "美国加州旅游牌照：CST#2119862-40\n\n美国联邦商业监督局［BBB］A级企业\n\n中国出入境中介许可准字［2013］第0001号"],
             ["电话", "美国\n888-928-2988\n\n中国\n400-000-2390\n\n香港\n3008-5867\n\n台湾\n02-5592-4871"],
             ["地址", "美国\n2880 Zanker Rd,Ste 203,San Jose,CA 95134\n\n中国\n北京市朝阳区朝外大街22号泛利大厦1515"],
             ["愿景", "人生,只有一次\n所幸,世界不只有一个地方\n我们要的就是,用这辈子玩遍这世界\n我们是'玩哪儿',是游遍世界的玩家\n也是华人欧美旅游的服务专家\n我们想帮助全世界15亿华人\n实现一种自由\n这种自由叫\n想玩哪儿,就玩哪儿"]]
    }
    fileprivate func buildUI() -> Void {

        self.view.backgroundColor = .white
        
        /// Background
        let imageView = SABlurImageView(image: UIImage.init(named: "loginBackground.jpg"))
        imageView.addBlurEffect(50, times: 1)
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview().offset(0.0)
        }
        
        
        /// Top View ///
        let topView = UIView.init()
        self.view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().offset(0.0)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        // Logo
        let logo = SpringImageView.init(image: UIImage.init(named: "logo")?.imageBy(tintColor: .themColor))
        logo.contentMode = .scaleAspectFill
        topView.addSubview(logo)
        logo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50.0)
            make.size.equalTo(CGSize.init(width: 120, height: 100))
        }
        logo.isHidden = true
        self.logo = logo
        
        // slogan
        let slogan = SpringLabel.init()
        slogan.text = "最有趣的欧美自由行"
        slogan.font = UIFont.init(name: WNConfig.FontName.kaitiBold, size: 18)
        slogan.textColor = .themColor
        topView.addSubview(slogan)
        slogan.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30.0)
        }
        slogan.isHidden = true
        self.slogan = slogan
        
        
        
        /// Bottom View ///
        let bottomView = UIView.init()
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0.0)
            make.top.equalTo(topView.snp.bottom).offset(0.0)
        }
        
        // Page View
        let pageView = FSPagerView.init()
        bottomView.addSubview(pageView)
        pageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview().offset(0.0)
        }
        pageView.register(WNAboutusCCell.self, forCellWithReuseIdentifier: "WNAboutusCCell")
        pageView.isInfinite = true
        pageView.interitemSpacing = 10
        pageView.transformer = FSPagerViewTransformer(type: .linear)
        pageView.itemSize = CGSize.init(width: UIScreen.width/3.0*2.0, height: UIScreen.height*0.6)
        pageView.delegate = self
        pageView.dataSource = self
        
        
        /// Back Btn
        let backBtn = UIButton.init(image: "")
        self.view.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0.0)
            make.top.equalToSuperview().offset(20.0)
            make.size.equalTo(CGSize.init(width: 50.0, height: 44.0))
        }
        backBtn.addControlEvent(.touchUpInside) { [weak self] (btn) in
            guard let strongSelf = self else { return }
            strongSelf.popViewController()
        }
    }
}

extension WNAboutusBoard: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return model.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell: WNAboutusCCell = pagerView.dequeueReusableCell(withReuseIdentifier: "WNAboutusCCell", at: index) as! WNAboutusCCell
        cell.titleLabel.text = model[index][0]
        cell.contentLabel.text = model[index][1]
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
}

