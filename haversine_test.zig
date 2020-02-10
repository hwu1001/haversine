const haversine = @import("haversine.zig");
const std = @import("std");
const math = std.math;
const testing = std.testing;

const epsilon = 0.000001;

test "Miami, FL to New York, NY" {
    const miami = haversine.LatLng{
        .lat = 25.761681,
        .lng = -80.191788,
    };
    const ny = haversine.LatLng{
        .lat = 40.730610,
        .lng = -73.935242,
    };
    const dist = try haversine.calculateEarthDistance(miami, ny);
    testing.expect(math.approxEq(f64, dist, 1761.9483035850824, epsilon));
}

test "Oxford, UK to Paris, France" {
    const oxford = haversine.LatLng{
        .lat = 51.752022,
        .lng = -1.257677,
    };
    const paris = haversine.LatLng{
        .lat = 48.864716,
        .lng = 2.349014,
    };
    const dist = try haversine.calculateEarthDistance(oxford, paris);
    testing.expect(math.approxEq(f64, dist, 410.59884571460276, epsilon));
}

test "Copenhagen, Denmark to Berlin, Germany" {
    const copenhagen = haversine.LatLng{
        .lat = 55.676098,
        .lng = 12.568337,
    };
    const berlin = haversine.LatLng{
        .lat = 52.520008,
        .lng = 13.404954,
    };
    const dist = try haversine.calculateEarthDistance(copenhagen, berlin);
    testing.expect(math.approxEq(f64, dist, 355.1490195853771, epsilon));
}

test "Tokyo, Japan to Sydney, Australia" {
    const tokyo = haversine.LatLng{
        .lat = 35.652832,
        .lng = 139.839478,
    };
    const sydney = haversine.LatLng{
        .lat = -33.865143,
        .lng = 151.209900,
    };
    const dist = try haversine.calculateEarthDistance(tokyo, sydney);
    testing.expect(math.approxEq(f64, dist, 7819.885147555453, epsilon));
}

test "Johannesburg, South Africa to Jakarta, Indonesia" {
    const johannesburg = haversine.LatLng{
        .lat = -26.195246,
        .lng = 28.034088,
    };
    const jakarta = haversine.LatLng{
        .lat = -6.200000,
        .lng = 106.816666,
    };
    const dist = try haversine.calculateEarthDistance(johannesburg, jakarta);
    testing.expect(math.approxEq(f64, dist, 8586.494573575452, epsilon));
}

test "Error on invalid radius" {
    const coord1 = haversine.LatLng{
        .lat = 5.0,
        .lng = 5.0,
    };
    const coord2 = haversine.LatLng{
        .lat = 0.0,
        .lng = 0.0,
    };
    testing.expectError(error.InvalidRadius, haversine.calculateDistance(coord1, coord2, -1.0));
}

test "Invalid latitude on coordinate 1" {
    const coord1 = haversine.LatLng{
        .lat = -100.0,
        .lng = 5.0,
    };
    const coord2 = haversine.LatLng{
        .lat = 0.0,
        .lng = 0.0,
    };
    testing.expectError(error.InvalidLatitude, haversine.calculateEarthDistance(coord1, coord2));
}

test "Invalid longitude on coordinate 1" {
    const coord1 = haversine.LatLng{
        .lat = 5.0,
        .lng = 200.0,
    };
    const coord2 = haversine.LatLng{
        .lat = 0.0,
        .lng = 0.0,
    };
    testing.expectError(error.InvalidLongitude, haversine.calculateEarthDistance(coord1, coord2));
}
