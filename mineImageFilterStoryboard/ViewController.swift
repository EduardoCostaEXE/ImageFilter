//
//  ViewController.swift
//  mineImageFilterStoryboard
//
//  Created by Cabral Costa, Eduardo on 08/09/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var filterList: UITableView!
    @IBOutlet weak var imageToFilter: UIImageView!
    @IBOutlet weak var filter: UIView!

    var filterArray: [Filter] = []
    let filterCellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        configureFilterList()
        configureTableView()

        filter.layer.opacity = 0.5
    }

    func configureTableView() {
        filterList.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: filterCellId)
        filterList.dataSource = self
    }

    @IBAction func shareImage(_ sender: Any) {
        let activityController = UIActivityViewController(
            activityItems: [
                "Check out this beautiful image!",
                imageToFilter.image!
            ],
            applicationActivities: nil
        )
        present(activityController, animated: true, completion: nil)
    }

    @IBAction func showOriginalImage(_ sender: Any) {
        filter.isHidden = true
    }
    @IBAction func showFilter(_ sender: Any) {
        filter.isHidden = false
    }

    @IBAction func compareFunc(_ sender: Any) {
        if filter.isHidden == false {
            filter.isHidden = true
        } else {
            filter.isHidden = false
        }
    }


    //TABLE VIEW
    func configureFilterList(){
        let yellow = Filter(name: "Yellow", color: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
        filterArray.append(yellow)
        let green = Filter(name: "Green", color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        filterArray.append(green)
        let lightBlue = Filter(name: "Light Blue", color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        filterArray.append(lightBlue)
        let darkBlue = Filter(name: "Dark Blue", color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        filterArray.append(darkBlue)
        let red = Filter(name: "Red", color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        filterArray.append(red)
        let pink = Filter(name: "Pink", color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        filterArray.append(pink)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = filterList.dequeueReusableCell(withIdentifier: filterCellId) as! FilterTableViewCell

        let row = indexPath.row
        let match = filterArray[row]

        cell.filterName.text = match.filterName
        cell.filterColor.backgroundColor = match.filterColor

        return cell
    }
}

