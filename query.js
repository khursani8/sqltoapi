var busNo = `
select bus_no as label from bus
group by bus_no;
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

var information = `select b.bus_no, locstart.location_name as "current_Stop", r.bus_time,locend.location_name as "next_Stop"
FROM route r
LEFT JOIN bus b
on b.bus_route = r.route_id
LEFT JOIN location locstart
on locstart.location_position = r.current_stop
LEFT JOIN location locend
on locend.location_position = r.next_stop
where b.bus_no = ? and r.route_id = 1;
`

module.exports = {
  searchBus,
  information,
  busNo,
  listStation,
  getLatLong,
  getBusLoc
}