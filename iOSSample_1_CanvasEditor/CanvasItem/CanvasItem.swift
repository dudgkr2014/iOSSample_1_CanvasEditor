//
//  CanvasItem.swift
//  iOSSample_1_CanvasEditor
//
//  Created by 우영학 on 4/26/25.
//

import Foundation
import SwiftUI

enum ItemType {
  case image(Image)
  case text(String)
}

class CanvasItem: Identifiable {
  var type: ItemType
  var position: CGPoint
  var size: CGSize
  var color: Color
  
  init(type: ItemType, position: CGPoint, size: CGSize, color: Color) {
    self.type = type
    self.position = position
    self.size = size
    self.color = color
  }
}
