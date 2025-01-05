//
//  CategoryFilterView.swift
//  RealmAzamsharpCRUD
//
//  Created by Ujjwal Arora on 05/01/25.
//

import SwiftUI

struct CategoryFilterView: View {
    let categories =  ["All","Produce","Fruit","Meat","Condiments","Beverages","Snacks","Dairy"]

    @Binding var selectedCategory: String
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                ForEach(categories,id: \.self) { category in
                    Text(category)
                        .frame(minWidth: 100)
                        .padding(6)
                        .foregroundStyle(.white)
                        .background(selectedCategory == category ? .orange : .green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            selectedCategory = category
                        }
                }
            }
        }
    }
}

#Preview {
    CategoryFilterView(selectedCategory: .constant("Produce"))
}
