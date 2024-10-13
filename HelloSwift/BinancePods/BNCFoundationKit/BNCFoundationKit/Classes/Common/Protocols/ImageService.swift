// Copyright © 2020 Binance. All rights reserved.

#if !os(watchOS)
extension Binance {
    public typealias ImageResult = (Result<UIImage, Error>) -> Void

    public typealias DownloadProgressBlock = (_ receivedSize: Int64, _ totalSize: Int64) -> Void

    public static var imageService: ImageService? {
        Binance.default as? ImageService
    }
}

public protocol ImageService {
    var diskStorageDirectoryPath: String { get }

    func clearMemoryCache()

    func clearDiskCache()

    func setImage(
        target: UIButton,
        url: URL?,
        placeholder: UIImage?,
        for state: UIControl.State,
        imageScale: CGFloat?,
        size: CGSize?,
        progressBlock: Binance.DownloadProgressBlock?,
        completionHandler: Binance.ImageResult?
    )

    func setImage(
        target: UIImageView,
        url: URL?,
        placeholder: UIImage?,
        imageScale: CGFloat?,
        size: CGSize?,
        progressBlock: Binance.DownloadProgressBlock?,
        completionHandler: Binance.ImageResult?
    )

    /// Returns normalized image for current image.
    /// This method will try to redraw an image with orientation and scale considered.
    func normalized(_ image: UIImage) -> UIImage
}
#endif
