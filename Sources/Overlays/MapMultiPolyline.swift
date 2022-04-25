//
//  MapMultiPolyline.swift
//  Map
//
//  Created by Paul Kraft on 25.04.22.
//

#if !os(watchOS)

import MapKit
import SwiftUI

public struct MapMultiPolyline: MapOverlay {

    // MARK: Stored Properties

    public let overlay: MKOverlay

    private let fillColor: Color?
    private let nativeFillColor: NativeColor?
    private let lineWidth: CGFloat?
    private let strokeColor: Color?
    private let nativeStrokeColor: NativeColor?

    // MARK: Initialization

    public init(polylines: [MKPolyline], fillColor: NativeColor? = nil, lineWidth: CGFloat? = nil, strokeColor: NativeColor? = nil) {
        self.overlay = MKMultiPolyline(polylines)
        self.fillColor = nil
        self.nativeFillColor = fillColor
        self.lineWidth = lineWidth
        self.strokeColor = nil
        self.nativeStrokeColor = strokeColor
    }

    public init(multiPolyline: MKMultiPolyline, fillColor: NativeColor? = nil, lineWidth: CGFloat? = nil, strokeColor: NativeColor? = nil) {
        self.overlay = multiPolyline
        self.fillColor = nil
        self.nativeFillColor = fillColor
        self.lineWidth = lineWidth
        self.strokeColor = nil
        self.nativeStrokeColor = strokeColor
    }

    @available(iOS 14, macOS 11, tvOS 14, *)
    public init(polylines: [MKPolyline], fillColor: Color?, lineWidth: CGFloat? = nil, strokeColor: Color?) {
        self.overlay = MKMultiPolyline(polylines)
        self.fillColor = fillColor
        self.nativeFillColor = nil
        self.lineWidth = lineWidth
        self.strokeColor = strokeColor
        self.nativeStrokeColor = nil
    }

    @available(iOS 14, macOS 11, tvOS 14, *)
    public init(multiPolyline: MKMultiPolyline, fillColor: Color?, lineWidth: CGFloat? = nil, strokeColor: Color?) {
        self.overlay = multiPolyline
        self.fillColor = fillColor
        self.nativeFillColor = nil
        self.lineWidth = lineWidth
        self.strokeColor = strokeColor
        self.nativeStrokeColor = nil
    }

    // MARK: Methods

    public func renderer(for mapView: MKMapView) -> MKOverlayRenderer {
        let renderer = (overlay as? MKMultiPolyline)
            .map { MKMultiPolylineRenderer(multiPolyline: $0) }
            ?? MKMultiPolylineRenderer(overlay: overlay)

        if let fillColor = fillColor, #available(iOS 14, macOS 11, tvOS 14, *) {
            renderer.fillColor = .init(fillColor)
        } else if let fillColor = nativeFillColor {
            renderer.fillColor = fillColor
        }
        if let lineWidth = lineWidth {
            renderer.lineWidth = lineWidth
        }
        if let strokeColor = strokeColor, #available(iOS 14, macOS 11, tvOS 14, *) {
            renderer.strokeColor = .init(strokeColor)
        } else if let strokeColor = nativeStrokeColor {
            renderer.strokeColor = strokeColor
        }

        return renderer
    }

}

#endif
