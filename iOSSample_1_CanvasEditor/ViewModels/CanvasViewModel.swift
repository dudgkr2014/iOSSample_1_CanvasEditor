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
  }
  
  // MARK: - States
  
  struct State {
    var canvasSize: CGSize = .zero
  }
  
  // MARK: - Properties
  
  @Published var state: State = State()
  
  // MARK: - Send
  
  func send(action: Action) {
    switch action {
    case .canvasDidAppear(let size):
      canvasDidAppear(with: size)
    }
  }
}

private extension CanvasViewModel {
  func canvasDidAppear(with size: CGSize) {
    setupCanvasSize(with: size)
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
}
