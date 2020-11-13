//
//  HomeViewController.swift
//  CoreImageFilters
//
//  Created by Dheeraj Kumar Sharma on 09/11/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var category = [Categories]()
    let data = DataViewController()
    
    lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.tableFooterView = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ListWithDescriptionTableViewCell.self, forCellReuseIdentifier: "ListWithDescriptionTableViewCell")
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Data controller as Child to reduce weight
        addChild(data)
        view.addSubview(data.view)
        data.didMove(toParent: self)
        category = data.categories!
        
        view.addSubview(tableView)
        tableView.pin(to: view)
        navigationItem.title = "Core Image Category"
    }
    
}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListWithDescriptionTableViewCell", for: indexPath) as! ListWithDescriptionTableViewCell
        cell.titleLabel.text = category[indexPath.row].title
        cell.descriptionLabel.text = "\(category[indexPath.row].numberOfCategories ?? "0") Filters"
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = DetailViewController()
        VC.navigationItem.title = category[indexPath.row].title
        VC.categoryFilters = category[indexPath.row].subComponents
        navigationController?.pushViewController(VC, animated: true)
    }
    
}
