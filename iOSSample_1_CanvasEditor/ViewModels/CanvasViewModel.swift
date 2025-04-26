//
//  CanvasViewModel.swift
//  iOSSample_1_CanvasEditor
//
//  Created by 우영학 on 4/26/25.
//

import Foundation
import SwiftUI

final class CanvasViewModel: ObservableObject {
  
  // MARK: - Actions
  
  enum Action {
    case canvasDidAppear(size: CGSize)
    case canvasItemDidDrag(index: Int, gesture: DragGesture.Value)
    case canvasItemDragDidEnd
  }
  
  // MARK: - States
  
  struct State {
    var canvasSize: CGSize = .zero
    var canvasItems: [CanvasItem] = []
  }
  
  // MARK: - Properties
  
  @Published var state: State = State()
  
  private var positionDiffer: CGPoint?
  
  // MARK: - Send
  
  func send(action: Action) {
    switch action {
    case .canvasDidAppear(let size):
      canvasDidAppear(with: size)
    case .canvasItemDidDrag(let index, let gesture):
      canvasItemDidDrag(index: index, gesture: gesture)
    case .canvasItemDragDidEnd:
      canvasItemDragDidEnd()
    }
  }
}

private extension CanvasViewModel {
  func canvasDidAppear(with size: CGSize) {
    setupCanvasSize(with: size)
    addSampleImage()
  }
  
  func canvasItemDidDrag(index: Int, gesture: DragGesture.Value) {
    var updatedItems = state.canvasItems
    let selectedItem = updatedItems[index]
    
    if positionDiffer == nil {
      positionDiffer = CGPoint(
        x: selectedItem.position.x - gesture.startLocation.x,
        y: selectedItem.position.y - gesture.startLocation.y
      )
    }
    
    let newPosition = calculateNewPosition(gesture: gesture)
    selectedItem.position = newPosition
    updatedItems[index] = selectedItem
    
    state.canvasItems = updatedItems
  }
  
  func canvasItemDragDidEnd() {
    positionDiffer = nil
  }
}

// MARK: - User Functions

private extension CanvasViewModel {
  func setupCanvasSize(with defaultSize: CGSize) {
    var newWidth = defaultSize.width
    var newHeight = defaultSize.width * 16 / 9
    
    if newHeight > defaultSize.height {
      newWidth = defaultSize.height * 9 / 16
      newHeight = defaultSize.height
    }
    
    state.canvasSize = CGSize(width: newWidth, height: newHeight)
  }
  
  func addSampleImage() {
    state.canvasItems.append(
      CanvasItem(
        type: .image(Image(systemName: "gamecontroller.circle.fill")),
        position: .zero,
        size: CGSize(width: 50, height: 50),
        color: Color.blue
      )
    )
  }
  
  func calculateNewPosition(gesture: DragGesture.Value) -> CGPoint {
    var newPosition = CGPoint(
      x: gesture.location.x < state.canvasSize.width ? gesture.location.x : state.canvasSize.width,
      y: gesture.location.y < state.canvasSize.height ? gesture.location.y : state.canvasSize.height)
    
    newPosition = CGPoint(
      x: (gesture.location.x > 0 ? newPosition.x : 0) + positionDiffer!.x,
      y: (gesture.location.y > 0 ? newPosition.y : 0) + positionDiffer!.y
    )
    
    return newPosition
  }
}
