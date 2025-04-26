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
      GeometryReader { geo in
        HStack {
          ZStack {
            ForEach(viewModel.state.canvasItems.indices, id: \.self) { itemIndex in
              let item = viewModel.state.canvasItems[itemIndex]
              let itemPositionForCanvas = CGPoint(
                x: item.position.x + item.size.width / 2,
                y: item.position.y + item.size.height / 2
              )
              
              CanvasItemView(item: item)
                .frame(width: item.size.width, height: item.size.height)
                .position(itemPositionForCanvas)
                .foregroundStyle(item.color)
                .gesture(
                  DragGesture()
                    .onChanged { gesture in
                      viewModel.send(action: .canvasItemDidDrag(index: itemIndex, gesture: gesture))
                    }
                    .onEnded { _ in
                      viewModel.send(action: .canvasItemDragDidEnd)
                    }
                )
            }
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
