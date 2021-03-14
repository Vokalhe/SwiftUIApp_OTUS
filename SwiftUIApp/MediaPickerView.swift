//
//  MediaPickerView.swift
//  SwiftUIApp
//
//  Created by Developer on 14.03.2021.
//

import SwiftUI
import Photos
import PhotosUI

public struct MediaPickerView: UIViewControllerRepresentable {
    @Binding var pickedMedia: [UIImage]
    
    public init(pickedMedia: Binding<[UIImage]>) {
        self._pickedMedia = pickedMedia
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<MediaPickerView>) -> some UIViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 10
        
        let imagePicker = PHPickerViewController(configuration: configuration)
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    public func updateUIViewController(_ uiViewController: MediaPickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MediaPickerView>) {}
    
    public func makeCoordinator() -> MediaPickerView.Coordinator {
        return Coordinator(parent: self)
    }
    
    public class Coordinator: NSObject, PHPickerViewControllerDelegate {
        private let parent: MediaPickerView
        private var photos: [UIImage] = []
        
        init(parent: MediaPickerView) {
            self.parent = parent
        }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if results.isEmpty {
                self.parent.pickedMedia = []
                picker.dismiss(animated: true)
            }
            
            let pickedGroup = DispatchGroup()
            
            for item in results {
                let provider = item.itemProvider
                
                pickedGroup.enter()
                if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                    guard provider.canLoadObject(ofClass: UIImage.self) else { pickedGroup.leave(); continue }
                    provider.loadObject(ofClass: UIImage.self) { image, error in
                        pickedGroup.leave()
                        guard let image = image else { return }
                        self.photos.append(image as! UIImage)
                    }
                }
            }
            
            pickedGroup.notify(queue: DispatchQueue.main) {
                self.parent.pickedMedia = self.photos
                picker.dismiss(animated: true)
            }
        }
    }
}
