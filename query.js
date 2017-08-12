var listRoute = `
Select route_name from route
Group By route_name;
`

var listBusNo = `
Select bus_no from bus b
WHERE b.route_name_ = ?
GROUP BY bus_no;
`

var listStop = `
Select l.location_name
FROM route r
INNER JOIN location l
ON r.current_stop = l.location_position
LEFT JOIN bus b
ON b.route_name_= r.route_name
WHERE r.route_name = ?;
`

var listStation = `
select location_name from location
`

var getLatLong = `
select latitude,longitude from location WHERE location_name=?
`

var getBusLoc = `
SELECT latitude,longitude from bus_location WHERE bus_no=?
`

var searchBus = `
SELECT SUM(bus_time) as est, e.bus_location, e.bus_no , e.RouteStart, e.RouteEnd FROM (
SELECT r.route_id,  r.current_stop ,r.route_start,r.route_end, r.next_stop, r.bus_time, c.current_position,b.bus_location,b.bus_no, l1.location_name as "RouteStart",l2.location_name as "RouteEnd"
FROM route r 
LEFT JOIN client c
ON r.next_stop <= c.current_position
LEFT JOIN bus b
ON b.bus_location <= r.current_stop and b.bus_route = 2
LEFT JOIN location l1 
ON l1.location_position = r.route_start
LEFT JOIN location l2 
ON l2.location_position = r.route_end
where c.client_id = 5 /*  */
) AS e 
WHERE e.bus_no = ? and e.route_id = 2 and not e.current_stop in (0);
`

var information = `
select b.bus_no, locstart.location_name as "Current Stop", r.bus_time,locend.location_name as "Next Stop"
FROM route r
LEFT JOIN bus b
on b.route_name_ = r.route_name
LEFT JOIN location locstart
on r.current_stop = locstart.location_position
LEFT JOIN location locend
ON r.next_stop = locend.location_position
where bus_plate_no = "AJK9217" and bus_no = "AJ04" and route_name_ = "Building 2, UTP -> Chancellor Hall, UTP";
`



////////////////////////////////USER interface/////////////////////////////////////////
var updateUserLocationAndGetNearestStation = `
ALTER TABLE client AUTO_INCREMENT = 1;
INSERT INTO client (latitude, longitude)
VALUES (?, ?);

select @LONGITUDE :=  longitude, @LATITUDE := latitude from client
WHERE client_id=( SELECT max(client_id) FROM client); 

SELECT l1.location_name FROM (SELECT location_name, (((@LATITUDE - latitude)*(@LATITUDE - latitude)) + ((@LONGITUDE - longitude)*(@LONGITUDE - longitude)))
as distance
from location
ORDER BY distance
LIMIT 1) as l1;

ALTER TABLE client;
UPDATE client
SET current_position = (SELECT l1.location_position FROM (SELECT location_position, (((@LATITUDE - latitude)*(@LATITUDE - latitude)) + ((@LONGITUDE - longitude)*(@LONGITUDE - longitude)))
as distance
from location
ORDER BY distance
LIMIT 1) as l1)
order by client_id desc limit 1;
`

var getNearestStation = `
select @LONGITUDE :=  longitude, @LATITUDE := latitude from client
WHERE client_id=( SELECT max(client_id) FROM client); 

SELECT l1.location_name FROM (SELECT location_name, (((@LATITUDE - latitude)*(@LATITUDE - latitude)) + ((@LONGITUDE - longitude)*(@LONGITUDE - longitude)))
as distance
from location
ORDER BY distance
LIMIT 1) as l1;

ALTER TABLE client;
UPDATE client
SET current_position = (SELECT l1.location_position FROM (SELECT location_position, (((@LATITUDE - latitude)*(@LATITUDE - latitude)) + ((@LONGITUDE - longitude)*(@LONGITUDE - longitude)))
as distance
from location
ORDER BY distance
LIMIT 1) as l1)
order by client_id desc limit 1;
`

var getBusNo = `
select @LONGITUDE :=  longitude, @LATITUDE := latitude from client
WHERE client_id=( SELECT max(client_id) FROM client); 

SELECT bus_no from bus
WHERE route_name_ IN 
(SELECT route_name from route 
WHERE current_stop = (SELECT location_position from location where location_name = 
        (SELECT l1.location_name FROM (SELECT location_name, (((@LATITUDE - latitude)*(@LATITUDE - latitude)) + ((@LONGITUDE - longitude)*(@LONGITUDE - longitude))) as distance from location

ORDER BY distance
LIMIT 1) as l1)) 
or next_stop = (SELECT location_position from location where location_name = 
        (SELECT l1.location_name FROM (SELECT location_name, (((@LATITUDE - latitude)*(@LATITUDE - latitude)) + ((@LONGITUDE - longitude)*(@LONGITUDE - longitude))) as distance from location

ORDER BY distance
LIMIT 1) as l1)))GROUP BY bus_no;
`

getBus = `
select SUM(bus_time), l2.location_name, l3.location_name, l.location_name from route r INNER JOIN bus b ON r.route_name = b.route_name_ INNER JOIN location l ON r.current_stop = l.location_position INNER JOIN location l2 ON r.route_start = l2.location_position INNER JOIN location l3 ON r.route_end = l3.location_position where r.current_stop >= 33 and r.current_stop <= 35 and b.bus_no = "AJ04"
`

getRoute = `
select b.bus_no, locstart.location_name as "Current Stop", r.bus_time,locend.location_name as "Next Stop"
FROM route r
LEFT JOIN bus b
on b.route_name_ = r.route_name
LEFT JOIN location locstart
on r.current_stop = locstart.location_position
LEFT JOIN location locend
ON r.next_stop = locend.location_position
where bus_plate_no = "AJK9217" and bus_no = "AJ04" and route_name_ = "Building 2, UTP -> Chancellor Hall, UTP";

DELETE FROM client
ORDER BY client_id DESC 
LIMIT 1;
`

module.exports = {
  searchBus,
  information,
  listStation,
  getLatLong,
  getBusLoc,

  listRoute,
  listBusNo,
  listStop,


  updateUserLocationAndGetNearestStation,
  getNearestStation,
  getBusNo,
  getBus,
  getRoute
}