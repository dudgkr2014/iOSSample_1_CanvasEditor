//
//  CanvasItemView.swift
//  iOSSample_1_CanvasEditor
//
//  Created by 우영학 on 4/26/25.
//

import SwiftUI

struct CanvasItemView: View {
  
  // MARK: - Properties
  
  let item: CanvasItem
  
  // MARK: - Initializer
  
  init(item: CanvasItem) {
    self.item = item
  }
  
  // MARK: - View
  
  var body: some View {
    switch item.type {
    case .image(let image):
      image
        .resizable()
    case .text(let text):
      Text(text)
    }
  }
}
