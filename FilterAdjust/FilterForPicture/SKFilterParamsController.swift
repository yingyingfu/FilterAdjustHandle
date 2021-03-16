//
//  SKFilterParamsController.swift
//
//  Created by 付颖颖 on 2020/11/17.
//

import UIKit

class SKFilterParamsController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var dataList:[SKFilterModel] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let tbView = UITableView.init(frame: self.view.frame, style: .plain)
        tbView.showsVerticalScrollIndicator = false
        tbView.showsHorizontalScrollIndicator = false
        tbView.dataSource = self
        tbView.delegate = self
        tbView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing:UITableViewCell.self))
        
        return tbView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI(){
        self.view.addSubview(self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let model = self.dataList[indexPath.row]
        if model.isSelect {
            cell.textLabel?.textColor = .red
            cell.textLabel?.text = model.filterName + ":" + model.currentValue.description
        }else{
            cell.textLabel?.textColor = .black
            cell.textLabel?.text = model.filterName + ":" + model.defaultValue.description
        }
        
        return cell
    }

}
