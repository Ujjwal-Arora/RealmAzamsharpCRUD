//
//  ShoppingItemCell.swift
//  RealmAzamsharpCRUD
//
//  Created by Ujjwal Arora on 05/01/25.
//

import SwiftUI

struct ShoppingItemCell: View {
    let item : ShoppingItemModel
    var selected : Bool
    let isSelected : (Bool) -> Void
    
    var body: some View {
        HStack{
            Image(systemName: selected ? "checkmark.circle" : "square")
                .onTapGesture {
                    isSelected(!selected)
                }
            VStack(alignment: .leading) {
                Text(item.title)
                Text(item.category)
                    .opacity(0.4)
            }
            Spacer()
            Text(item.quantity.formatted())
        }
        .opacity(selected ? 0.4 : 1.0)
    }
}

#Preview {
    ShoppingItemCell(item: ShoppingItemModel(), selected: true, isSelected: {_ in})
}
