//
//  Structure.swift
//  CoreImageFilters
//
//  Created by Dheeraj Kumar Sharma on 09/11/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

struct Categories {
    let title:String!
    let numberOfCategories:String!
    let subComponents:[SubCategoryFilter]!
}

struct SubCategoryFilter {
    let title:String!
    let description:String!
    let navigateTo:UIViewController!
}
