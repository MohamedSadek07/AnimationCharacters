//
//  UIImageView+Extension.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 25/11/2024.
//

import UIKit

extension UIImageView {
    func setLoadedImage(from urlString: String) {
    guard let imageUrl = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: imageUrl) { data, response, error in
        if let data = data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }.resume()
   }
}
