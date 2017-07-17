var express = require('express');
var mysql = require('mysql');

var mysqltorest  = require('mysql-to-rest');
var app = express();
var query = require('./query')

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'root',
  database : 'bus_tracking',
  socketPath: '/Applications/MAMP/tmp/mysql/mysql.sock'
});
connection.connect();

connection.query(query.information,function(err,results,field){
    if(err) throw err;
    console.log(results)  
    connection.end()
}
)
// var api = mysqltorest(app,connection);
// //Dont forget to start the server
// app.listen(8000,function(){
//   console.log('run port 8000')
// });

// app.get('/',function(req,res){
//   query = 'SELECT SUM(bus_time), e.bus_location, e.bus_no , e.RouteStart, e.RouteEnd FROM (SELECT r.`route_id`,  r.`current_stop` ,r.`route_start`,r.`route_end`, r.`next_stop`, r.`bus_time`, c.`current_position`,b.`bus_location`,b.bus_no, l1.`location_name` as "RouteStart",l2.`location_name` as "RouteEnd" FROM route r LEFT JOIN client c ON r.`next_stop` <= c.`current_position` LEFT JOIN bus b ON b.`bus_location` <= r.`current_stop` and b.`bus_route` = 1 LEFT JOIN location l1 ON l1.`location_position` = r.`route_start` LEFT JOIN location l2  ON l2.`location_position` = r.`route_end` where c.`client_id` = 5 /*  */) AS e WHERE e.bus_no = "T304" and e.`route_id` = 1 and not e.`current_stop` in (0);'

//   query1 = "SELECT * from location";

//   connection.query(query1, function (error, results, fields) {
//   if (error) throw error;
//   res.end(results)
//   console.log('The solution is: ', results);
//   });
// });