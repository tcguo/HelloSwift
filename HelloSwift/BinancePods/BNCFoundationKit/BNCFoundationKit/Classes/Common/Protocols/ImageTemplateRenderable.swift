// Copyright © 2021 Binance. All rights reserved.

#if !os(watchOS)
public protocol ImageTemplateRender {
    func renderImage(_ name: String?, enableTintColor: Bool) -> UIImage?
}
#endif

public protocol ImageTemplateRenderable {
    var renderImageName: String? { get }
    var enableTintColor: Bool { get }
}

#if !os(watchOS)
extension ImageTemplateRenderable {
    public var renderImage: UIImage? {
        if let render = self as? ImageTemplateRender {
            return render.renderImage(renderImageName, enableTintColor: enableTintColor)
        } else {
            return nil
        }
    }
}
#endif
