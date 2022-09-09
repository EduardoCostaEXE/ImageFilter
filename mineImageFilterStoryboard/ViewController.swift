//
//  ViewController.swift
//  mineImageFilterStoryboard
//
//  Created by Cabral Costa, Eduardo on 08/09/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var btnCompare: UIButton!
    @IBOutlet weak var viewFilterList: UIView!
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
        filterList.delegate = self
    }

    //SHARE
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

    //COMPARE
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
    @IBAction func showFilterTableView(_ sender: Any) {
        if (viewFilterList.isHidden == false){
            viewFilterList.isHidden = true
        } else {
            viewFilterList.isHidden = false
        }
    }

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
        let pink = Filter(name: "Pink", color: #colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1))
        filterArray.append(pink)
        let gray = Filter(name: "Gray", color: #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1))
        filterArray.append(gray)
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

        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let matchcolor = filterArray[row].filterColor

        //If re-click the button, remove the filter
        if filter.backgroundColor == filterArray[row].filterColor{
            filter.backgroundColor = .none
            btnCompare.isEnabled = false
            filter.isHidden = true
        } else {
            setFilter(color: matchcolor)
            btnCompare.isEnabled = true
        }
    }

    func setFilter(color: UIColor){
        filter.backgroundColor = color
        filter.isHidden = false
    }

    //New Photo
    @IBAction func newPhoto(_ sender: Any) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(
            title: "Camera",
            style: .default,
            handler: nil
        ))
        actionSheet.addAction(UIAlertAction(
            title: "Album",
            style: .default,
            handler: { action in self.showAlbum() }
        ))
        actionSheet.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        ))

        self.present(actionSheet, animated: true, completion: nil)
    }

    func showAlbum() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImageView, editingInfo: NSDictionary) {
        dismiss(animated: true, completion: nil)

        let selectedImage: UIImageView = image
        imageToFilter = selectedImage
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageToFilter.image = image
        }

        picker.dismiss(animated: true)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

}
