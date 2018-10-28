module.exports = {
	city: new Map([
		["ireland", process.env.IRELAND_IP || "localhost"],
		["sydney", process.env.SYDNEY_IP || "localhost"],
		["saopaulo", process.env.SAOPAULO_IP || "localhost"],
		["oregon", process.env.OREGON_IP || "localhost"]]),
	intervalInMs: process.env.INTERVAL_IN_MILLS || 5000,
	hostname: "0.0.0.0",
	port: process.env.PORT || 3001,
	thisLocation: process.env.THIS_LOCATION || "localhost",
	env: process.env.NODE_ENV || "development" //posible values: "development", "production"
}