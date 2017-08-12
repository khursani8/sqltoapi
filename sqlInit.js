var mysql = require('mysql');

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'root',
  database : 'bus_tracking',
  // socketPath: '/Applications/MAMP/tmp/mysql/mysql.sock',
  multipleStatements: 'true'
});
connection.connect();

module.exports = connection