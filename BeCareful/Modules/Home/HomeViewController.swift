//
//  ViewController.swift
//  BeCareful
//
//  Created by Jose Alberto on 21/03/20.
//  Copyright © 2020 IA Interactive. All rights reserved.
//  swiftlint:disable force_cast
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var recomendationsList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        recomendationsList.backgroundColor = .white
    }
}

// MARK: - Table View Methods
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recomendationsList.dequeueReusableCell(withIdentifier: "RecomendationsCell") as! RecomendationsTableViewCell
        return cell
    }
}
