local m, s, o;
m = Map("rainbow", "Rainbow", translate("Utility Rainbow enables control of Omnia's LEDs."));

-- Define callback function
function m.on_after_commit(self)
	luci.sys.call("/etc/init.d/rainbow restart");
end

-- Define values for form
local led_sections = {
	{"pwr", "Power"},
	{"lan", "LAN ports"},
	{"lan0", "LAN 0"},
	{"lan1", "LAN 1"},
	{"lan2", "LAN 2"},
	{"lan3", "LAN 3"},
	{"lan4", "LAN 4"},
	{"wan", "WAN"},
	{"pci1", "PCI 1"},
	{"pci2", "PCI 2"},
	{"pci3", "PCI 3"},
	{"usr1", "User 1"},
	{"usr2", "User 2"}
};

local colors = {
	red = translatef("Red %s", "(FF0000)"),
	green = translatef("Green %s", "(00FF00)"),
	blue = translatef("Blue %s", "(0000FF)"),
	white = translatef("White %s", "(FFFFFF)"),
	black = translatef("Black %s", "(000000)")
};

local status_opts = {
	auto = translate("Auto"),
	enable = translate("On"),
	disable = translate("Off")
};


-- Start to build form and page
s = m:section(NamedSection, "all", "led", translate("Color and status of all LEDs"));
	s.addremove = false;

o = s:option(Value, "color", translate("Color"));
	o.default = 'white'
	o.optional = false;
	o.rmempty = false;
	for k, v in pairs(colors) do
		o:value(k, v);
	end

o = s:option(ListValue, "status", translate("Status"));
	o.default = 'auto'
	o.optional = false;
	o.rmempty = false;
	for k, v in pairs(status_opts) do
		o:value(k, v);
	end

for _, item in ipairs(led_sections) do
	k, v = item[1], item[2];
	s = m:section(NamedSection, k, "led", translatef("Color and status of %s", v));
		s.addremove = true;

	o = s:option(Value, "color", translate("Color"));
		o.default = 'white'
		o.optional = false;
		o.rmempty = false;
		for k, v in pairs(colors) do
			o:value(k, v);
		end

	o = s:option(ListValue, "status", translate("Status"));
		o.default = 'auto';
		o.optional = false;
		o.rmempty = false;
		for k, v in pairs(status_opts) do
			o:value(k, v);
		end
end

return m;
