//
//  ViewController.swift
//  Assignment_4
//
//  Created by student on 1/4/24.
//

import UIKit

class ViewController: UIViewController {
    
    var character = ViewModel.Figure()

    @IBOutlet weak var charName: UILabel!
    @IBOutlet weak var charImg: UIImageView!
    @IBOutlet weak var charText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultURL = "https://duckduckgo.com"
        if let imgOriginalURL = URL(string: defaultURL + character.imgUrl) {
            URLSession.shared.dataTask(with: imgOriginalURL, completionHandler: {
                (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                DispatchQueue.main.async {
                    self.charImg.image = UIImage(data: data!)
                }
            }).resume()
        }

        self.charName.text = self.character.name
        self.charText.text = self.character.text
    }


}

