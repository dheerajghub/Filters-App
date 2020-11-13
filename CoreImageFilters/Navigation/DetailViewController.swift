//
//  DetailViewController.swift
//  CoreImageFilters
//
//  Created by Dheeraj Kumar Sharma on 09/11/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var categoryFilters:[SubCategoryFilter]?
    
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
        view.addSubview(tableView)
        tableView.pin(to: view)
    }
    
}

extension DetailViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let categoryFilters = categoryFilters {
            return categoryFilters.count
        }
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let categoryFilters = categoryFilters {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListWithDescriptionTableViewCell", for: indexPath) as! ListWithDescriptionTableViewCell
            cell.titleLabel.text = categoryFilters[indexPath.row].title
            cell.descriptionLabel.text = categoryFilters[indexPath.row].description
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let categoryFilters = categoryFilters {
            let width = tableView.frame.width - 40
            let font = UIFont(name: "Avenir-Medium", size: 16)
            let estimatedH = categoryFilters[indexPath.row].description.height(withWidth: width, font: font!)
            return estimatedH + 50
        }
        return CGFloat()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let categoryFilters = categoryFilters {
            let VC = categoryFilters[indexPath.row].navigateTo!
            VC.navigationItem.title = categoryFilters[indexPath.row].title
            navigationController?.pushViewController(VC, animated: true)
        }
    }
    
}
