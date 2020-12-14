local m, s, o;
m = Map("rainbow", "Rainbow", translate("Utility Rainbow enables control of LEDs of Turris router."));

-- Define values for form
local led_sections = {
	pwr = "Power",
	wifi = "Wi-Fi",
	lan = "LAN ports",
	wan = "WAN"
};

local colors = {
	red = translatef("Red %s", "(FF0000)"),
	green = translatef("Green %s", "(00FF00)"),
	blue = translatef("Blue %s", "(0000FF)"),
	white = translatef("White %s", "(FFFFFF)"),
	black = translatef("Black %s", "(000000)")
};
colors["33FF33"] = translatef("Real white %s", "(33FF33)"); --How can I do it better in lua?

local status_opts = {
	auto = translate("Auto"),
	enable = translate("On"),
	disable = translate("Off")
};


-- Start to build form and page
s = m:section(NamedSection, "all", "led", translate("Color and status of all LEDs"));
	s.addremove = false;

o = s:option(Value, "color", translate("Color"));
	o.default = '33FF33'
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

for k, v in pairs(led_sections) do
	s = m:section(NamedSection, k, "led", translatef("Color and status of %s LED", v));
		s.addremove = true;

	o = s:option(Value, "color", translate("Color"));
		o.default = '33FF33'
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
