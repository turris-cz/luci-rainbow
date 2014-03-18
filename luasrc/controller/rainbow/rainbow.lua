module("luci.controller.rainbow.rainbow", package.seeall);

function index()
	entry({"admin", "system", "rainbow"}, cbi("rainbow/rainbow"), "Rainbow", 10).dependent=false;
end
