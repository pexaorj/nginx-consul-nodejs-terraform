var express = require('express');
var app = express();
var hostname = require('os').hostname();


//Register at consul
var Consul = require('consul-node');
var consul = new Consul({
  host: 'localhost',
  port: 8300,
});

//Constants
const PORT = 3000;
const HOST = '0.0.0.0';

var requestTime = function (req, res, next) {
  req.requestTime = Date.now();
  next();
};

app.use(requestTime);

app.get('/', function (req, res) {
  var responseText = 'Resp 200 from Node: ';
  var a = new Date(req.requestTime);
  responseText += hostname + ' Requested at: ' + a.toJSON() + '\n';
  res.send(responseText);
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
