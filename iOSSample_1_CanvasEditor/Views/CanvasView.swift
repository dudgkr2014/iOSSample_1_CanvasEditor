//
//  CanvasView.swift
//  iOSSample_1_CanvasEditor
//
//  Created by 우영학 on 4/26/25.
//

import SwiftUI

struct CanvasView: View {
  
  // MARK: - ViewModel
  
  @StateObject private var viewModel: CanvasViewModel = CanvasViewModel()
  
  // MARK: - View
  
  var body: some View {
    VStack {
      HStack {
        // 버튼 들어갈 공간
      }
      
      
      GeometryReader { geo in
        HStack {
          ZStack {
            
          }
          .frame(width: viewModel.state.canvasSize.width, height: viewModel.state.canvasSize.height)
          .background(Color.white)
        }
        .frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
        .onAppear {
          viewModel.send(action: .canvasDidAppear(size: geo.size))
        }
      }
    }
    .padding(20)
    .background(Color.gray)
  }
}
