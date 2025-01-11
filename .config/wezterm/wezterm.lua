-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- change config now
config.default_domain = 'WSL:Debian'

config.wsl_domains = {
  {
    -- The name of this specific domain.  Must be unique amonst all types
    -- of domain in the configuration file.
    name = 'WSL:Debian',

    -- The name of the distribution.  This identifies the WSL distribution.
    -- It must match a valid distribution from your `wsl -l -v` output in
    -- order for the domain to be useful.
    distribution = 'Debian',
  },
}
config.default_domain = 'WSL:Debian'

-- For example, changing the color scheme:
config.color_scheme = 'GruvboxDarkHard'

-- and finally, return the configuration to wezterm
return config