//
//  CharacterItemView.swift
//  RickyMortySwiftUI
//
//  Created by serhat on 9.11.2024.
//

import SwiftUI
import Kingfisher

struct CharacterItemView: View {
    let image: String
    let name: String
    
    var body: some View {
        VStack(spacing: 0){
            KFImage(URL(string: image))
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 175)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            Rectangle()
                .foregroundColor(Color(.label))
                .frame(width: 150, height: 0.75)
            Text(name)
                .foregroundColor(Color(.label))
                .font(.body)
                .lineLimit(1)
                .fontWeight(.semibold)
                .frame(width: 150,height: 30,alignment: .center)
                .padding(.bottom, 5)
        }
        .background(Color(.secondarySystemBackground))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.label),lineWidth: 1)
                .shadow(radius: 4, x: 0, y: 4)
        }
        
    }
}

#Preview {
    CharacterItemView(image: "", name: "rickyMorty")
}
