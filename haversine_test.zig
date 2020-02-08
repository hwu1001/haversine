const haversine = @import("haversine.zig");
const std = @import("std");
const math = std.math;
const testing = std.testing;

test "Miami, FL to New York, NY" {
    var miami = haversine.LatLng{
        .lat = 25.761681,
        .lng = -80.191788,
    };
    var ny = haversine.LatLng{
        .lat = 40.730610,
        .lng = -73.935242,
    };
    const dist = try haversine.calculateEarthDistance(miami, ny);
    testing.expect(math.approxEq(f64, dist, 1761.9483035850824, 0.000001));
}
