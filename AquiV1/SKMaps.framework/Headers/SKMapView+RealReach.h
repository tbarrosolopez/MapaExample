//
//  SKMapView+RealReach.h
//  SKMaps
//
//  Copyright (c) 2016 Skobbler. All rights reserved.
//

#import "SKMapView.h"
#import <CoreLocation/CoreLocation.h>

@class SKRealReachSettings, SKBoundingBox;

/**
 */
@interface SKMapView (RealReach)

/** Adds a RealReach layer on the map.
 @param realReachSettings Contains settings for the RealReach layer.
 */
- (void)displayRealReachWithSettings:(SKRealReachSettings * _Nonnull)realReachSettings;

/** Clears the RealReach layer from the map.
 */
- (void)clearRealReachDisplay;

/** Changes the visible region in order to fit the currently displayed real reach polygon.
 @param duration The duration of the animation in milliseconds. No animation will be performed if the value of this parameter is 0.
 */
- (void)fitRealReachWithDuration:(int)duration;

/** Returns the bounding box of the current real reach area displayed on map.
 @return The bounding box corresponding to the current real reach area. Will return nil if there is no valid real reach displayed.
 */
- (SKBoundingBox * _Nullable)realReachBoundingBox;

/** Verifies is the RealReach layer fits in the specified bounding box.
 @param boundingBox Defines a bounding box on the map.
 @return A boolean value indicating if the RealReach fits in the specified bounding box.
 */
- (BOOL)isRealReachDisplayedInBoundingBox:(SKBoundingBox * _Nonnull)boundingBox;

/** Verifies is a coordinate is inside the RealReach polygon.
 @param coordinate The coordinate to be checked.
 @return A boolean value indicating if the coordinate is inside the rendered RealReach polygon.
 */
- (BOOL)isCoordinateInsideRealReachPolygon:(CLLocationCoordinate2D)coordinate;

@end
