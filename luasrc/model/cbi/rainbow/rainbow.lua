local m, s, o;
m = Map("rainbow", "Rainbow", "Utility Rainbow enables control of LEDs of Turris router.");


s = m:section(NamedSection, "all", "led", "Set status and color of all LEDs");
	--s.addremove = true;

o = s:option(Value, "color", "Color");
	o.default = '33FF33'
	o.optional = false;
	o.rmempty = false;

o = s:option(ListValue, "status", "LEDs status");
	o.default = 'auto'
	o.optional = false;
	o:value('auto');
	o:value('enable');
	o:value('disable');

local led_sections = { pwr = "Power", wifi = "Wi-Fi", lan = "LAN ports", wan = "WAN" };

for k, v in pairs(led_sections) do
	s = m:section(NamedSection, k, "led", "Set status and color of " .. v .. " LED");
		s.addremove = true;

	o = s:option(Value, "color", "Color");
		o.default = '33FF33'
		o.optional = false;
		o.rmempty = false;

	o = s:option(ListValue, "status", "LED status");
		o.default = 'auto'
		o.optional = false;
		o:value('auto');
		o:value('enable');
		o:value('disable');
end

return m;
