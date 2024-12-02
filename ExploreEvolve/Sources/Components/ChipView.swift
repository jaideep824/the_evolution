//
//  ChipView.swift
//  ExploreEvolve
//
//  Created by Jaideep on 02/12/24.
//

import SwiftUI

struct ChipView: View {
    let title: String
    let isSelected: Bool
    var onTapped: () -> Void
    
    var body: some View {
        Button {
            onTapped()
        } label: {
            HStack {
                Text(title)
                    .font(.body)
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(height: 40)
            .frame(minWidth: 100)
            .background(.white.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    ChipView(title: "❤️ Relationships", isSelected: true) {
        print("Chip Tapped")
    }
}
