//
//  CharacterCellView.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import SwiftUI

struct CharacterCellView: View {
    //MARK: Variables
    var dataSource: CharacterCellViewDataSource
    //MARK: Body
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: dataSource.imageLink)) { image in
                image.resizable(resizingMode: .stretch)
            } placeholder: {
                Color.gray
            }
            .clipped()
            .frame(width: 100, height: 100)
            .cornerRadius(16)
            
            VStack(alignment: .leading) {
                Text(dataSource.name)
                    .font(.headline)
                
                Text(dataSource.specie)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(.gray.opacity(0.5), lineWidth: 0.5)
                .padding(.all, 4)
        }
    }
}

#Preview {
    CharacterCellView(dataSource: CharacterCellViewDataSource(name: "",
                                                              specie: "",
                                                              imageLink: ""))
}

//MARK: DataSource
struct CharacterCellViewDataSource {
    var name: String
    var specie: String
    var imageLink: String
}
