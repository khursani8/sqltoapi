var express = require('express');

var mysqltorest  = require('mysql-to-rest');
var app = express();
var query = require('./query')
var connection = require('./sqlInit')
var api = mysqltorest(app,connection);


// connection.query(query.busSearch,function(err,results,field){
//     if(err) throw err;
//     console.log(results)
// })

// connection.query(query.information,function(err,results,field){
//     if(err) throw err;
//     console.log(results)
// })


//////// server code //////////////
//Dont forget to start the server

app.listen(8000,function(){
  console.log('http://localhost:8000')
});

app.get('/listBusNo/:route',function(req,res){
  connection.query(query.listBusNo,[req.params.route],function(err,results,field){
    if(err) throw err;
    console.log(results[0]);
    res.send(results)
})
})

app.get('/listStop/:route',function(req,res){
  connection.query(query.listBusNo,[req.params.route],function(err,results,field){
    if(err) throw err;
    console.log(results[0]);
    res.send(results)
})
})

app.get('/listRoute',function(req,res){
  connection.query(query.listRoute,function(err,results,field){
    if(err) throw err;
    console.log(results[0]);
    res.send(results)
})
})

app.get('/listStation',function(req,res){
  connection.query(query.listStation,function(err,results,field){
    if(err) throw err;
    console.log(results[0]);
    res.send(results)
})
})

app.get('/getLatLong/:location_name',function(req,res){
  connection.query(query.getLatLong,[req.params.location_name],function(err,results,field){
    if(err) throw err;
    console.log(results[0]);
    res.send(results)
})
})

app.get('/getBusLoc/:no',function(req,res){
  connection.query(query.getBusLoc,[req.params.no],function(err,results,field){
    if(err) throw err;
    console.log(results[0]);
    res.send(results)
})
})

app.get('/searchBus/:id',function(req,res){
  connection.query(query.searchBus,[req.params.id],function(err,results,field){
    if(err) throw err;
    res.send(results)
})
})

app.get('/information/:id',function(req,res){
  connection.query(query.information,[req.params.id],function(err,results,field){
    if(err) throw err;
    res.send({
      // query:query.information,
      res:results
    })
})
})

app.get('/updateUserLocation/',function(req,res){
  connection.query(query.updateUserLocation,[req.query.latitude,req.query.longitude],function(err,results,field){
    if(err) throw err;
    res.send({
      // query:query.information,
      res:results
    })
})
})

app.get('/getNearestStation/',function(req,res){
  connection.query(query.getNearestStation,function(err,results,field){
    if(err) throw err;
    res.send({
      // query:query.information,
      res:results
    })
})
})