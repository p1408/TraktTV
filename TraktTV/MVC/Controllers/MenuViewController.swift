//
//  ViewController.swift
//  TraktTV
//
//  Created by pedro cortez osorio on 5/18/19.
//  Copyright © 2019 gamestorming. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var moviewTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    var arrayMovies : [Movie] = [Movie]()
    var currentPage = 1
    var query: String?
    var numberOverView = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        moviewTableView.rowHeight = UITableView.automaticDimension
        moviewTableView.estimatedRowHeight = 150
        getMovies("")
        let gestoTap = UITapGestureRecognizer(target: self, action: #selector(tap))
        gestoTap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(gestoTap)
    }
    
    @objc func tap(){
        self.view.endEditing(true)
    }
    
    func getMovies(_ query: String?){
        let str = query ?? ""
        UserManager.sharedManager.popularMovies(query: str, page: "\(currentPage)", successResponse: { (movies) in
            for mov in movies {
                self.arrayMovies.append(mov)
            }
            self.numberOverView = 0
            self.getOverView(code: self.arrayMovies[0].idMovie!.slug!)
            
        }) { (error) in
            let alert = UIAlertController(title: "TraktTV", message: "\(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getOverView(code: String){
        UserManager.sharedManager.overViewMoview(code: code, successResponse: { (message) in
            self.arrayMovies[self.numberOverView].overview = message
            self.numberOverView += 1
            
            if self.arrayMovies.count == self.numberOverView {
                self.moviewTableView.reloadData()
                return
            }
            self.getOverView(code: self.arrayMovies[self.numberOverView].idMovie!.slug!)
        }) { (error) in
            let alert = UIAlertController(title: "TraktTV", message: "\(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func clearData() {
        arrayMovies.removeAll()
    }
    
    //MARK: - TextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("texto en textField \(textField.text!)-")
        print("cadena nueva \(string)-")
        clearData()
        var searchT = ""
        if string == "" {
            searchT = String(textField.text!.dropLast())
        }else{
            searchT = textField.text! + string
        }
        getMovies(searchT)
        
        return true
    }
    
    
    //MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        cell.fillCell(arrayMovies[indexPath.row])
        return cell
    }
    
    
    //MARK: - ScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y + scrollView.frame.height) >= scrollView.contentSize.height {
            
            self.currentPage += 1
            self.getMovies("")
        }
        
    }
}

