//
//  SKMapView+Overlays.h
//  SKMaps
//
//  Copyright (c) 2016 Skobbler. All rights reserved.
//

#import "SKMapView.h"

@class SKPolygon, SKCircle, SKPolyline;

/**
 */
@interface SKMapView (Overlays)

/** Adds a polygon overlay on the map.
 @param polygon Stores all the information about the polygon.
 @return The result of the operation.
 */
- (BOOL)addPolygon:(SKPolygon * _Nonnull)polygon;

/** Adds a polyline overlay on the map.
 @param polyline Stores all the information about the polyline.
 @return The result of the operation.
 */
- (BOOL)addPolyline:(SKPolyline * _Nonnull)polyline;

/** Adds a circle overlay on the map.
 @param circle Stores all the information about the circle.
 @return The result of the operation.
 */
- (BOOL)addCircle:(SKCircle * _Nonnull)circle;

/** Removes an overlay from the map.
 @param overlayID The id of the overlay that needs to be deleted.
 @return Succes/Failure of removing the overlay.
 */
- (BOOL)clearOverlayWithID:(int)overlayID;

/** Removes all overlays from the map.
 */
- (void)clearAllOverlays;

@end
