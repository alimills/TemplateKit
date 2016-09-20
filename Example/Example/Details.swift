//
//  Details.swift
//  Example
//
//  Created by Matias Cudich on 9/4/16.
//  Copyright © 2016 Matias Cudich. All rights reserved.
//

import Foundation
import TemplateKit

struct DetailsProperties: ViewProperties {
  public var key: String?
  public var layout: LayoutProperties?
  public var style: StyleProperties?
  public var gestures: GestureProperties?

  public var message: String?

  public init(_ properties: [String : Any]) {
    message = properties.get("message")
  }
}

func ==(lhs: DetailsProperties, rhs: DetailsProperties) -> Bool {
  return lhs.message == rhs.message && lhs.equals(otherViewProperties: rhs)
}

struct DetailsState: State, Equatable {
  var text = "hi"
  var bg = UIColor.red
}

func ==(lhs: DetailsState, rhs: DetailsState) -> Bool {
  return lhs.text == rhs.text && lhs.bg == rhs.bg
}

class Details: CompositeComponent<DetailsState, DetailsProperties, UIView> {
  public override var properties: DetailsProperties {
    didSet {
      state.text = properties.message ?? "hi"
    }
  }

  override func render() -> Element {
//    return Element(ElementType.box, ["backgroundColor": state.bg], [
//      Element(ElementType.text, ["text": "\(state.text) blah"]),
//      Element(ElementType.text, ["text": "there", "onTap": #selector(Details.flipText)])
//    ])
    if state.text == "hi" {
      return Element(ElementType.text, ["text": "foo", "onTap": #selector(Details.flipText)])
    } else {
      return Element(ElementType.image, ["url": URL(string: "https://farm9.staticflickr.com/8520/28696528773_0d0e2f08fb_m_d.jpg")!, "width": Float(100), "height": Float(100), "onTap": #selector(Details.flipText)])
    }
  }

  @objc func flipText() {
    updateComponentState { state in
      state.bg = .blue
      state.text = "blue!"
    }
  }
}

extension Details: PropertyTypeProvider {
  static var propertyTypes: [String : ValidationType] {
    return ["backgroundColor": Validation.color]
  }
}
