local m, s, o;
m = Map("rainbow", "Rainbow", translate("Utility Rainbow enables control of Omnia's LEDs."));

-- Define values for form
local led_sections = {
	{"power", "Power"},
	{"lan_0", "LAN 0"},
	{"lan_1", "LAN 1"},
	{"lan_2", "LAN 2"},
	{"lan_3", "LAN 3"},
	{"lan_4", "LAN 4"},
	{"wan", "WAN"},
	{"wlan_1", "PCI 1"},
	{"wlan_2", "PCI 2"},
	{"wlan_3", "PCI 3"},
	{"indicator_1", "User 1"},
	{"indicator_2", "User 2"}
};

local colors = {
	red = translatef("Red %s", "(FF0000)"),
	green = translatef("Green %s", "(00FF00)"),
	blue = translatef("Blue %s", "(0000FF)"),
	yellow = translatef("Yellow %s", "(FFFF00)"),
	cyan = translatef("Cyan %s", "(00FFFF)"),
	magenta = translatef("Magenta %s", "(FF00FF)"),
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

m.on_after_apply = function()
	luci.sys.call("/etc/init.d/rainbow restart");
end
m.apply_on_parse = false

return m;
