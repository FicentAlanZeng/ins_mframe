//
//  INS_TestModuleH5ViewController.swift
//  mframe_project
//
//  Created by Alan on 2022/5/9.
//

import UIKit
import moduleH5
import moduleUI
import SnapKit


class INS_TestModuleH5ViewController: INS_BaseTableViewController {
    
    let titleArray = ["测试 Native 调用JS， JS 调用Native， 并且互相传递参数", "JS 跳转新的Native界面", "导航栏设置", "JS获取设备信息","JS获取用户登录信息", "Loading" ,"Alert", "ActionSheet", "JS调用图片选择控件", "JS调用拍摄照片和视频", "获取定位信息", "Toast"]
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLine()
        self.navigationItem.title = "Demo List"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = INS_DEMOWKWebViewController.init()
            vc.urlStr = "https://www.yddtec.com/test_ios_js.html"
            vc.titleStr = "DEMO Native and JS"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1 {
            let vc = INS_WKWebViewController.init()
            vc.urlStr = "https://www.yddtec.com/test_ios_js_jump.html"
            vc.titleStr = "JS 跳转新的Native界面"
            self.navigationController?.pushViewController(vc, animated: true)
      
        }
        else if indexPath.row == 2 {
            let vc = INS_WKWebViewController.init()
            vc.urlStr = "https://www.yddtec.com/test_ios_js_nav_settings.html"
            vc.titleStr = "导航栏设置"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 3 {
            let vc = INS_WKWebViewController.init()
            vc.urlStr = "https://www.yddtec.com/test_ios_js_fetch_native_info.html"
            vc.titleStr = "JS获取设备信息"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if indexPath.row == 4 {
            let vc = INS_WKWebViewController.init()
            vc.urlStr = "https://www.yddtec.com/test_ios_js_fetch_user_info.html"
            vc.titleStr = "JS获取用户信息"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        else if indexPath.row == 5 {
            let vc = INS_WKWebViewController.init()
            vc.urlStr = "https://www.yddtec.com/test_ios_js_loading.html"
            vc.titleStr = "Show loading"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 6 {
            let vc = INS_WKWebViewController.init()
            vc.urlStr = "https://www.yddtec.com/test_ios_js_jump_alert.html"
            vc.titleStr = "JS 调用Alert"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 7 {
            let vc = INS_WKWebViewController.init()
            vc.urlStr = "https://www.yddtec.com/test_ios_js_jump_action_sheet.html"
            vc.titleStr = "JS 调用ActionSheet"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 8 || indexPath.row == 9 {
//            let url = Bundle.main.url(forResource: "test", withExtension: "html")
//            let webVC = CustomWebViewController.init(with: url!, navigType: .navbar)
//            self.navigationController?.pushViewController(webVC, animated: true)
            
            self.ins_msBottomToast("功能开发中")
        }
        
        else if indexPath.row == 10 {
            let vc = INS_WKWebViewController.init()
            vc.urlStr = "https://www.yddtec.com/test_ios_js_fetch_location_info.html"
            vc.titleStr = "JS 获取经纬度"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 11 {
            let vc = INS_WKWebViewController.init()
            vc.urlStr = "https://www.yddtec.com/test_ios_js_toast.html"
            vc.titleStr = "Toast"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellID")
        cell.selectionStyle = .none
        var lbl: UILabel? = cell.contentView.viewWithTag(100) as? UILabel
        if lbl == nil {
            lbl = UILabel.init()
            lbl!.tag = 100
            lbl!.numberOfLines = 0
            lbl!.font = UIFont.systemFont(ofSize: 16)
            lbl!.textColor = UIColor.ins_colorWithHexRGB(0x666666)
            cell.contentView.addSubview(lbl!)
            lbl!.snp.makeConstraints { make in
                make.left.equalTo(16)
                make.top.equalTo(6)
                make.bottom.equalTo(-6)
                make.trailing.lessThanOrEqualTo(-16)
            }
        }
        lbl!.text = titleArray[indexPath.row]
        
        var line: UIView? = cell.contentView.viewWithTag(101)
        if line == nil {
            line = UIView.init()
            line!.tag = 101
            line!.backgroundColor = UIColor.ins_colorWithHexRGB(0xE1E1E1)
            cell.contentView.addSubview(line!)
            line!.snp.makeConstraints { make in
                make.left.equalTo(16)
                make.height.equalTo(0.5)
                make.bottom.equalTo(0)
                make.trailing.equalTo(-16)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }


}

