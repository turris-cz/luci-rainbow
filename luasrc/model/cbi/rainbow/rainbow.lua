local m, s, o;
m = Map("rainbow", "Rainbow", "Utility Rainbow enables control of LEDs of Turris router.");

function m.on_after_commit(self)
	luci.sys.call("/etc/init.d/rainbow restart");
end

local led_sections = { pwr = "Power", wifi = "Wi-Fi", lan = "LAN ports", wan = "WAN" };
local colors = { red = "Red (FF0000)", green = "Green (00FF00)", blue = "Blue (0000FF)", white = "White (FFFFFF)", black = "Black (000000)" };
colors["33FF33"] = "Real white (33FF33)"; --How can I do it better in lua?
local status_opts = { auto = "Auto", enable = "Enable", disable = "Disable" };

s = m:section(NamedSection, "all", "led", "Set status and color of all LEDs");
	--s.addremove = true;

o = s:option(Value, "color", "Color");
	o.default = '33FF33'
	o.optional = false;
	o.rmempty = false;
	for k, v in pairs(colors) do
		o:value(k, v);
	end

o = s:option(ListValue, "status", "LEDs status");
	o.default = 'auto'
	o.optional = false;
	o.rmempty = false;
	for k, v in pairs(status_opts) do
		o:value(k, v);
	end

for k, v in pairs(led_sections) do
	s = m:section(NamedSection, k, "led", "Set status and color of " .. v .. " LED");
		s.addremove = true;

	o = s:option(Value, "color", "Color");
		o.default = '33FF33'
		o.optional = false;
		o.rmempty = false;
		for k, v in pairs(colors) do
			o:value(k, v);
		end

	o = s:option(ListValue, "status", "LED status");
		o.default = 'auto';
		o.optional = false;
		o.rmempty = false;
		for k, v in pairs(status_opts) do
			o:value(k, v);
		end
end

return m;
