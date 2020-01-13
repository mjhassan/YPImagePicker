//
//  PHAsset+URL.swift
//  Pods-Tranquillizer
//
//  Created by MacUser2 on 1/13/20.
//

import Photos

extension PHAsset {
    func getURL(_ completion: @escaping (_ videoURL: URL?) -> Void) {
        if self.mediaType == .image {
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return true
            }
            self.requestContentEditingInput(with: options, completionHandler: {(contentEditingInput: PHContentEditingInput?, info: [AnyHashable : Any]) -> Void in
                completion(contentEditingInput!.fullSizeImageURL as URL?)
            })
        }
        else if self.mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
                if let urlAsset = asset as? AVURLAsset {
                    let localVideoUrl: URL = urlAsset.url as URL
                    completion(localVideoUrl)
                } else {
                    completion(nil)
                }
            })
        }

    }
}
