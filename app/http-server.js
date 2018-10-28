const http = require('http');
const config = require('./config');

const hostname = config.hostname;
const port = config.port;

exports.startServer = () => {
	const server = http.createServer((req, res) => {
	  res.statusCode = 204;
	  res.end();
	});

	server.listen(port, hostname, () => {
	  console.log(`Server running at http://${hostname}:${port}/`);
	});
};
