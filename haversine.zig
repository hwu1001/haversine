const std = @import("std");
const math = std.math;
const testing = std.testing;

// Mean Earth radius - https://en.wikipedia.org/wiki/Earth_radius#Mean_radius
// Estimation by International Union of Geodesy and Geophysics - this value
// is apparently not agreed upon globally per
// https://nssdc.gsfc.nasa.gov/planetary/factsheet/fact_notes.html
const mean_earth_radius = 6371.0088;

pub const LatLng = struct {
    lat: f64,
    lng: f64,

    pub fn validate(self: *const LatLng) !void {
        if (self.lat < -90.0 or self.lat > 90.0) {
            return error.InvalidLatitude;
        }
        if (self.lng < -180.0 or self.lng > 180) {
            return error.InvalidLongitude;
        }

        return;
    }
};

fn degreesToRadians(degrees: f64) f64 {
    return degrees * math.pi / 180.0;
}

pub fn calculateDistance(coord1: LatLng, coord2: LatLng, radius: f64) !f64 {
    if (radius <= 0.0) {
        return error.InvalidRadius;
    }
    try coord1.validate();
    try coord2.validate();

    const lat1 = degreesToRadians(coord1.lat);
    const lng1 = degreesToRadians(coord1.lng);
    const lat2 = degreesToRadians(coord2.lat);
    const lng2 = degreesToRadians(coord2.lng);

    const diff_lat = lat2 - lat1;
    const diff_lng = lng2 - lng1;

    // the square of half the chord length between the points
    const a = math.pow(f64, math.sin(diff_lat / 2.0), 2.0) +
        math.cos(lat1) * math.cos(lat2) *
        math.pow(f64, math.sin(diff_lng / 2.0), 2.0);
    return 2 * radius * math.asin(math.sqrt(a));
}

pub fn calculateEarthDistance(coord1: LatLng, coord2: LatLng) !f64 {
    return try calculateDistance(coord1, coord2, mean_earth_radius);
}
