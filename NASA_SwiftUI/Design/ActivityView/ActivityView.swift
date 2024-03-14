//
//  ActivityView.swift
//  ComponentsKit
//
//  Created by Ульяна Гритчина on 22.02.2024.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    
    @Binding var activityItems: [Any]
    var excludedActivityTypes: [UIActivity.ActivityType]? = nil
    
    public init(activityItems: Binding<[Any]>, excludedActivityTypes: [UIActivity.ActivityType]? = nil) {
        _activityItems = activityItems
        self.excludedActivityTypes = excludedActivityTypes
    }
    
    public func makeUIViewController(
        context: UIViewControllerRepresentableContext<ActivityView>
    ) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            controller.popoverPresentationController?.sourceView = UIView()
        }
        
        controller.excludedActivityTypes = excludedActivityTypes
        
        return controller
    }
    
    public func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: UIViewControllerRepresentableContext<ActivityView>)
    {}
}
