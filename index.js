var express = require('express');
var mysql = require('mysql');

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'root',
  database : 'bus_tracking',
  socketPath: '/Applications/MAMP/tmp/mysql/mysql.sock'
});
connection.connect();

var mysqltorest  = require('mysql-to-rest');
var app = express();

var api = mysqltorest(app,connection);
//Dont forget to start the server
app.listen(8000,function(){
  console.log('run port 8000')
});

app.get('/',function(req,res){
  
});