var http = require('http');
var mockserver = require('mockserver');

http.createServer(mockserver('app/__mockserver__/__mocks__')).listen(3000);
