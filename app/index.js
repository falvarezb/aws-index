const request = require('request');
const config = require('./config');
const startServer = require('./http-server').startServer;

const knex = require('knex')(require('./knexfile')[config.env]);


const ping = function(cityName, cityIp){
	const hrstart = process.hrtime();

	request(`http://${cityIp}:${config.port}`, (err, res, body) => {
	  if (err) { 
	  	console.log(`${cityName} => error: ${err}`); 
	  }
	  else {
	  const hrend = process.hrtime(hrstart)

	  const row = {
	  	origin: config.thisLocation,
	  	destination: cityName,
	  	latency: hrend[0] + hrend[1] / 1000000000
	  };
	  console.log(`row: ${JSON.stringify(row)}`);
	  knex('ping').insert(row)
	  .then(id => console.log(`inserted id ${id}`))
	  .catch(error => console.error(`${cityName} => ${error}`));
	 }
	});
}


startServer();
config.city.forEach((value, key, map) => setInterval(ping,config.intervalInMs,key,value));