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