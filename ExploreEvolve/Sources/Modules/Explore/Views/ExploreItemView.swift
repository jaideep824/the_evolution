//
//  ExploreItem.swift
//  ExploreEvolve
//
//  Created by Jaideep on 01/12/24.
//

import SwiftUI

struct ExploreItemView: View {
    let problem: Problem
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: problem.imageURL) { image in
                    image
                        .resizable()
                        .frame(height: 150)
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    
                } placeholder: {
                    ProgressView()
                }
                
                if problem.premiumState == .premium {
                    VStack {
                        Spacer()
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(.regularMaterial)
                                .clipShape(Circle())
                            Spacer()
                        }
                    }
                    .padding(10)
                }
            }
            
            VStack(spacing: 5) {
                Text(problem.title ?? "")
                    .font(.body.bold())
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .leading)
                    
                
                HStack(spacing: 3) {
                    Text(problem.sessions ?? "")
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 3, height: 3)
                    
                    Text(problem.mins ?? "")
                }
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    return ExploreItemView(problem: .example)
}
