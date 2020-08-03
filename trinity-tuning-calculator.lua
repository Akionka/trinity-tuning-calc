script_name('Trinity Tuning Calculator')
script_author('Akionka')
script_version('0.0.2')
script_version_number(1)

local sampev = require 'samp.events'
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'UTF-8'
local u8 = encoding.UTF8
local cp = encoding.cp1251

local vehicles = {
  { name = 'Landstalker', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Bravura', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Buffalo', brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { name = 'Linerunner', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Perennial', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Sentinel', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Dumper', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Firetruck', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Trashmaster', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Stretch', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Manana', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Infernus', brake = 0, clutch = 2, exhaust = 3, handbrake = 0, injection = 2, intercooler = 3, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { name = 'Voodoo', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Pony', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Mule', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Cheetah', brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { name = 'Ambulance', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Leviathan', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Moonbeam', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Esperanto', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Taxi cab', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Washington', brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Bobcat', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Whoopee', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'BF Injection', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Hunter', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Premier', brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Enforcer', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Securicar', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Banshee', brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 3, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { name = 'Predator', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Bus', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Rhino', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Barracks', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Hotknife', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Semitrailer', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Previon', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Coach', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Cabbie', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Stallion', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Rumpo', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'RC Bandit', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Romero', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Packer', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Monster', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Admiral', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Squalo', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Seasparrow', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Pizzaboy', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tram', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Dump Trailer', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Turismo', brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 0, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { name = 'Speeder', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Reefer', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tropic', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Flatbed', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Yankee', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Caddy', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Solair', brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Berkley\'s van', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Skimmer', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'PCJ-600', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Faggio', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Freeway', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'RC Baron', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'RC Raider', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Glendale', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Oceanic', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Sanchez', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Sparrow', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Patriot', brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Quad', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Coastguard', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Dinghy', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Hermes', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Sabre', brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Rustler', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'ZR-350', brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { name = 'Walton', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Regina', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Comet', brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { name = 'BMX', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Burrito', brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Camper', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Marquis', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tug', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Dozer', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Maverick', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'News Maverick', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Rancher', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'FBI Rancher', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Virgo', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Greenwood', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Jetmax', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'unusedhotring494', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Sandking', brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { name = 'Blista Compact', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Police Maverick', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'unusedboxv498', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Benson', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Mesa', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'RC Goblin', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Hotring', brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 3, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { name = 'unusedhotring503', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Bloodring Banger', brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'unusedrancher505', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Super GT', brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { name = 'Elegant', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Journey', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Bike', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Mountain Bike', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Beagle', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Cropduster', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Stuntplane', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tanker', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Roadtrain', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Nebula', brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Majestic', brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Buccaneer', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Shamal', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Hydra', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'FCR-900', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'NRG-500', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'HPV-1000', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Cement Truck', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tow Truck', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Fortune', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Cadrona', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'FBI Truck', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Willard', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Forklift', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tractor', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Combine', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Feltzer', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Remington', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Slamvan', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Blade', brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Freight', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Streak', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Vortex', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Vincent', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Bullet', brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 3, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { name = 'Clover', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Sadler', brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Stair Firetruck', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Hustler', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Intruder', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Primo', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Cargobob', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tampa', brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Sunrise', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Merit', brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Utility', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Nevada', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Yosemite', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Windsor', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Monster A', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Monster B', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Uranus', brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Jester', brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { name = 'Sultan', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Stratum', brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Elegy', brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { name = 'Raindance', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'RC Tiger', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Flash', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Tahoma', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Savanna', brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Bandito', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Freight Flat', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Streak Carriage', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Kart', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Mower', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Dune', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Sweeper', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Broadway', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Tornado', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'AT-400', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'DFT-30', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Huntley', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Stafford', brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'BF-400', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'News Van', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'unusedtug', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Petrol Trailer', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Emperor', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Wayfarer', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Euros', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Hotdog', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Club', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Freight Box', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Refrigerator Trailer', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Andromada', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Dodo', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'RC Cam', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Launch', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Police US', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Police AF', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Police RC', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Police Ranger', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Picador', brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'S.W.A.T', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Alpha', brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Phoenix', brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Glendale Shit', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Sadler Shit', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Baggage A', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Baggage B', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Stairs', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Boxville', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Farm Trailer', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Field Kitchen', brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
}

local modifications = {
  {
    key = 'brake',
    name = 'Тормоз',
    hasManyLevels = true,
    price = { 5000, 10000, 15000 },
    dependsOn = {},
  }, {
    key = 'handbrake',
    name = 'Ручной тормоз',
    hasManyLevels = false,
    price = { 10000 },
    dependsOn = {},
  }, {
    key = 'suspension',
    name = 'Подвеска',
    hasManyLevels = true,
    price = { 5000, 10000, 15000 },
    dependsOn = {},
  }, {
    key = 'clutch',
    name = 'Сцепление',
    hasManyLevels = true,
    price = { 5000, 10000, 15000 },
    dependsOn = {},
  }, {
    key = 'intercooler',
    name = 'Интеркулер',
    hasManyLevels = true,
    price = { 3000, 5000, 7000 },
    dependsOn = {},
  }, {
    key = 'exhaust',
    name = 'Выхлоп',
    hasManyLevels = true,
    price = { 3000, 5000, 7000 },
    dependsOn = {},
  }, {
    key = 'piston',
    name = 'Поршни',
    hasManyLevels = true,
    price = { 3000, 5000, 7000 },
    dependsOn = {},
  }, {
    key = 'injection',
    name = 'Впрыск',
    hasManyLevels = true,
    price = { 5000, 10000, 15000 },
    dependsOn = {'piston', 'exhaust'},
  }, {
    key = 'turbocharging',
    name = 'Турбонаддув',
    hasManyLevels = true,
    price = { 10000, 20000, 30000 },
    dependsOn = {'injection', 'piston', 'exhaust', 'intercooler', 'clutch'},
  },
}

local parsedMods = {brake = false, clutch = false, exhaust = false, handbrake = false, injection = false, intercooler = false, piston = false, suspension = false, turbocharging = false}
local price = 0

local mainWindowState = imgui.ImBool(false)
local selectedVehicle = -1
local vehiclesList = {}
local currentItems = {brake = imgui.ImInt(0), clutch = imgui.ImInt(0), exhaust = imgui.ImInt(0), handbrake = imgui.ImInt(0), injection = imgui.ImInt(0), intercooler = imgui.ImInt(0), piston = imgui.ImInt(0), suspension = imgui.ImInt(0), turbocharging = imgui.ImInt(0)}
local requestedItems = {brake = imgui.ImInt(0), clutch = imgui.ImInt(0), exhaust = imgui.ImInt(0), handbrake = imgui.ImInt(0), injection = imgui.ImInt(0), intercooler = imgui.ImInt(0), piston = imgui.ImInt(0), suspension = imgui.ImInt(0), turbocharging = imgui.ImInt(0)}
local filter = imgui.ImGuiTextFilter()

function imgui.OnDrawFrame()
  if mainWindowState.v then
    if not imgui.Begin('Trinity Tuning Calculator v'..thisScript()['version'], mainWindowState, imgui.WindowFlags.AlwaysAutoResize) then
      imgui.End()
      return
    end
    imgui.BeginGroup()
    imgui.BeginChild('Select Panel', imgui.ImVec2(275, 410), true)
    imgui.PushItemWidth(200)
    filter:Draw('Поиск', imgui.ImVec2(10, 100))
    if imgui.ListBoxHeader('') then
      for i, v in ipairs(vehicles) do
        if filter:PassFilter(v.name) and imgui.Selectable(v.name, selectedVehicle == i) then
          selectedVehicle = i
          setCurrentItems()
        end
      end
      imgui.ListBoxFooter()
    end
    imgui.PopItemWidth()
    if selectedVehicle == -1 then
      imgui.Text('Не выбрано т/с, выберите из списка выше')
    else
      imgui.Text(vehicles[selectedVehicle].isModificationSupported and 'Тюнинг этого т/с поддерживается' or 'Тюнинг этого т/с не поддерживается')
      if vehicles[selectedVehicle].isModificationSupported then
        imgui.Text('Базовая комплектация:')
        for i, v in ipairs(modifications) do
          imgui.BulletText(('%s: %s'):format(v.name, int2letter(vehicles[selectedVehicle][v.key], true)))
          if i % 2 == 1 then imgui.SameLine() end
        end
      end
    end
    imgui.EndChild()
    imgui.SameLine()
    imgui.BeginChild('Current panel', imgui.ImVec2(285, 410), true)
      imgui.PushItemWidth(100)
      imgui.Text('Текущая комплектация')
      for i, v in ipairs(modifications) do
        imgui.Combo(v.name, currentItems[v.key],
          v.hasManyLevels and {'Нет', 'A', 'B', 'C'} or {'Нет', 'Есть'},
          v.hasManyLevels and imgui.ImInt(4) or imgui.ImInt(2)
        )
      end
      if imgui.Button('Взять с ближайшей машины', imgui.ImVec2(250,0)) then
        sampSendChat('/look')
      end
      imgui.SameLine()
      ShowHelpMarker('Будет использована команда /look')
      if imgui.Button('Скопировать в желаемую комплектацию', imgui.ImVec2(250,0)) then
        for k, v in pairs(currentItems) do
          requestedItems[k].v = v.v
        end
      end
      imgui.PopItemWidth()
    imgui.EndChild()
    imgui.SameLine()
    imgui.BeginChild('Upgrade panel', imgui.ImVec2(275, 410), true)
      imgui.PushItemWidth(100)
      imgui.Text('Желаемая комплектация')
      for i1, v1 in ipairs(modifications) do
        if imgui.Combo(v1.name, requestedItems[v1.key],
          v1.hasManyLevels and {'Нет', 'A', 'B', 'C'} or {'Нет', 'Есть'},
          v1.hasManyLevels and imgui.ImInt(4) or imgui.ImInt(2)
        ) then
          -- Проверка, что изменненый объект уровнем не ниже, чем тот объект,
          -- который зависит от выбранного.
          -- При выборе спецления А, если выбран турбо С, турбо станет А
          for i2, v2 in ipairs(modifications) do
            for i3, v3 in ipairs(v2.dependsOn) do
              if v1.key == v3 then
                if requestedItems[v1.key].v < requestedItems[v2.key].v then
                  requestedItems[v2.key].v = requestedItems[v1.key].v
                end
              end
            end
          end
          for i2, v2 in ipairs(v1.dependsOn) do
            if requestedItems[v2].v < requestedItems[v1.key].v then
              requestedItems[v2].v = requestedItems[v1.key].v
            end
          end
        end
      end
      imgui.PopItemWidth()
    imgui.EndChild()
    imgui.SameLine()
    imgui.BeginChild('Price panel', imgui.ImVec2(275, 410), true)
      for i, v in ipairs(modifications) do
        for i = currentItems[v.key].v + 1, requestedItems[v.key].v do
          imgui.Text(('%s%s %s $'):format(
            v.name,
            v.hasManyLevels and ' ' .. int2letter(i, true) or '',
            formatInt(v.price[i])
          ))
        end
      end
      calculateTuningPrice(currentItems, requestedItems)
      imgui.Text('Итог: ' .. formatInt(price) .. ' $')
    imgui.EndChild()
    imgui.EndGroup()
    imgui.End()
  end
end

function ShowHelpMarker(param)
  imgui.TextDisabled('(?)')
  if imgui.IsItemHovered() then
      imgui.BeginTooltip()
      imgui.PushTextWrapPos(imgui.GetFontSize() * 35.0)
      imgui.TextUnformatted(param)
      imgui.PopTextWrapPos()
      imgui.EndTooltip()
  end
end

function applyCustomStyle()
  imgui.SwitchContext()
  local style  = imgui.GetStyle()
  local colors = style.Colors
  local clr    = imgui.Col
  local function ImVec4(color)
    local r = bit.band(bit.rshift(color, 24), 0xFF)
    local g = bit.band(bit.rshift(color, 16), 0xFF)
    local b = bit.band(bit.rshift(color, 8), 0xFF)
    local a = bit.band(color, 0xFF)
    return imgui.ImVec4(r/255, g/255, b/255, a/255)
  end

  style['WindowRounding']      = 10.0
  style['WindowTitleAlign']    = imgui.ImVec2(0.5, 0.5)
  style['ChildWindowRounding'] = 5.0
  style['FrameRounding']       = 5.0
  style['ItemSpacing']         = imgui.ImVec2(5.0, 5.0)
  style['ScrollbarSize']       = 13.0
  style['ScrollbarRounding']   = 5

  colors[clr['Text']]                 = ImVec4(0xFFFFFFFF)
  colors[clr['TextDisabled']]         = ImVec4(0xFFFFFFFF)
  colors[clr['WindowBg']]             = ImVec4(0x212121FF)
  colors[clr['ChildWindowBg']]        = ImVec4(0x21212180)
  colors[clr['PopupBg']]              = ImVec4(0x212121FF)
  colors[clr['Border']]               = ImVec4(0xFFFFFF10)
  colors[clr['BorderShadow']]         = ImVec4(0x21212100)
  colors[clr['FrameBg']]              = ImVec4(0xC3E88D90)
  colors[clr['FrameBgHovered']]       = ImVec4(0xC3E88DFF)
  colors[clr['FrameBgActive']]        = ImVec4(0x61616150)
  colors[clr['TitleBg']]              = ImVec4(0x212121FF)
  colors[clr['TitleBgActive']]        = ImVec4(0x212121FF)
  colors[clr['TitleBgCollapsed']]     = ImVec4(0x212121FF)
  colors[clr['MenuBarBg']]            = ImVec4(0x21212180)
  colors[clr['ScrollbarBg']]          = ImVec4(0x212121FF)
  colors[clr['ScrollbarGrab']]        = ImVec4(0xEEFFFF20)
  colors[clr['ScrollbarGrabHovered']] = ImVec4(0xEEFFFF10)
  colors[clr['ScrollbarGrabActive']]  = ImVec4(0x80CBC4FF)
  colors[clr['ComboBg']]              = colors[clr['PopupBg']]
  colors[clr['CheckMark']]            = ImVec4(0x212121FF)
  colors[clr['SliderGrab']]           = ImVec4(0x212121FF)
  colors[clr['SliderGrabActive']]     = ImVec4(0x80CBC4FF)
  colors[clr['Button']]               = ImVec4(0xC3E88D90)
  colors[clr['ButtonHovered']]        = ImVec4(0xC3E88DFF)
  colors[clr['ButtonActive']]         = ImVec4(0x61616150)
  colors[clr['Header']]               = ImVec4(0x151515FF)
  colors[clr['HeaderHovered']]        = ImVec4(0x252525FF)
  colors[clr['HeaderActive']]         = ImVec4(0x303030FF)
  colors[clr['Separator']]            = colors[clr['Border']]
  colors[clr['SeparatorHovered']]     = ImVec4(0x212121FF)
  colors[clr['SeparatorActive']]      = ImVec4(0x212121FF)
  colors[clr['ResizeGrip']]           = ImVec4(0x212121FF)
  colors[clr['ResizeGripHovered']]    = ImVec4(0x212121FF)
  colors[clr['ResizeGripActive']]     = ImVec4(0x212121FF)
  colors[clr['CloseButton']]          = ImVec4(0x212121FF)
  colors[clr['CloseButtonHovered']]   = ImVec4(0xD41223FF)
  colors[clr['CloseButtonActive']]    = ImVec4(0xD41223FF)
  colors[clr['PlotLines']]            = ImVec4(0x212121FF)
  colors[clr['PlotLinesHovered']]     = ImVec4(0x212121FF)
  colors[clr['PlotHistogram']]        = ImVec4(0x212121FF)
  colors[clr['PlotHistogramHovered']] = ImVec4(0x212121FF)
  colors[clr['TextSelectedBg']]       = ImVec4(0x212121FF)
  colors[clr['ModalWindowDarkening']] = ImVec4(0x21212180)
end

function sampev.onServerMessage(color, text)
  if not mainWindowState.v or color ~= -1 then return end
  if text:find(cp'Перед вами стоит .+ {D8A903}.-{ffffff}') then
    parsedMods = {brake = false, clutch = false, exhaust = false, handbrake = false, injection = false, intercooler = false, piston = false, suspension = false, turbocharging = false}
    local name = text:match(cp'Перед вами стоит .+ {D8A903}(.-){ffffff}')
    for i, v in ipairs(vehicleNames) do
      if v == name then
        selectedVehicle = i - 1
        setCurrentItems()
        return
      end
    end
  end
  if text:find(cp'Модификации:{abcdef}') then
    -- ALARM: SHIT CODE! ALARM: SHIT CODE! ALARM: SHIT CODE! ALARM: SHIT CODE!
    if not parsedMods.brake then
      currentItems.brake.v = letter2int(text:match(cp'[Тт]ормоза #(%w)') or int2letter(vehicles[selectedVehicle].brake))
      parsedMods.brake = text:find(cp'[Тт]ормоза #(%w)')
    end
    if not parsedMods.handbrake then
      currentItems.handbrake.v = text:find(cp'[Гг]оночный ручной тормоз') and 1 or 0
      parsedMods.handbrake = text:find(cp'[Гг]оночный ручной тормоз')
    end
    if not parsedMods.suspension then
      currentItems.suspension.v = letter2int(text:match(cp'[Пп]одвеска #(%w)') or int2letter(vehicles[selectedVehicle].suspension))
      parsedMods.suspension = text:find(cp'[Пп]одвеска #(%w)')
    end
    if not parsedMods.clutch then
      currentItems.clutch.v = letter2int(text:match(cp'[Сс]цепление #(%w)') or int2letter(vehicles[selectedVehicle].clutch))
      parsedMods.clutch = text:find(cp'[Сс]цепление #(%w)')
    end
    if not parsedMods.intercooler then
      currentItems.intercooler.v = letter2int(text:match(cp'[Ии]нтеркулер #(%w)') or int2letter(vehicles[selectedVehicle].intercooler))
      parsedMods.intercooler = text:find(cp'[Ии]нтеркулер #(%w)')
    end
    if not parsedMods.exhaust then
      currentItems.exhaust.v = letter2int(text:match(cp'[Вв]ыхлоп #(%w)') or int2letter(vehicles[selectedVehicle].exhaust))
      parsedMods.exhaust = text:find(cp'[Вв]ыхлоп #(%w)')
    end
    if not parsedMods.piston then
      currentItems.piston.v = letter2int(text:match(cp'[Пп]оршневая #(%w)') or int2letter(vehicles[selectedVehicle].piston))
      parsedMods.piston = text:find(cp'[Пп]оршневая #(%w)')
    end
    if not parsedMods.injection then
      currentItems.injection.v = letter2int(text:match(cp'[Вв]прыск #(%w)') or int2letter(vehicles[selectedVehicle].injection))
      parsedMods.injection = text:find(cp'[Вв]прыск #(%w)')
    end
    if not parsedMods.turbocharging then
      currentItems.turbocharging.v = letter2int(text:match(cp'[Тт]урбонаддув #(%w)') or int2letter(vehicles[selectedVehicle].turbocharging))
      parsedMods.turbocharging = text:find(cp'[Тт]урбонаддув #(%w)')
    end
  end
end

function main()
  if not isSampfuncsLoaded() or not isSampLoaded() then return end
  while not isSampAvailable() do wait(0) end

  applyCustomStyle()

  sampRegisterChatCommand('tcalc', function()
    mainWindowState.v = not mainWindowState.v
  end)

  while true do
    imgui.Process = mainWindowState.v
    wait(0)
  end
end

function calculateTuningPrice(currentItems, selectedItems)
  price = 0
  for k, v in pairs(selectedItems) do
    if currentItems[k].v ~= selectedItems[k].v then
      for i = currentItems[k].v + 1, selectedItems[k].v do
        for _, v in ipairs(modifications) do
          if v.key == k then
            price = price + v.price[i]
          end
        end
      end
    end
  end
end

function int2letter(int, useHash)
  local letters = {
    [0] = 'Нет', [1] = 'A', [2] = 'B', [3] = 'C'
  }
  return (useHash and int ~= 0 and '#' or '' ).. letters[int]
end

function letter2int(letter)
  local letters = {
    ['A'] = 1, ['B'] = 2, ['C'] = 3, ['Нет'] = 0
  }
  return letters[letter or 'Нет']
end

function formatInt(int)
  local formatted = int
  while true do
    formatted, k = string.gsub(formatted, '^(-?%d+)(%d%d%d)', '%1 %2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function setCurrentItems(overrideRequestedItems)
  local v = vehicles[selectedVehicle]
  currentItems = {brake = imgui.ImInt(v.brake), clutch = imgui.ImInt(v.clutch), exhaust = imgui.ImInt(v.exhaust), handbrake = imgui.ImInt(v.handbrake), injection = imgui.ImInt(v.injection), intercooler = imgui.ImInt(v.intercooler), piston = imgui.ImInt(v.piston), suspension = imgui.ImInt(v.suspension), turbocharging = imgui.ImInt(v.turbocharging)}
  if overrideRequestedItems then
    requestedItems = {brake = imgui.ImInt(v.brake), clutch = imgui.ImInt(v.clutch), exhaust = imgui.ImInt(v.exhaust), handbrake = imgui.ImInt(v.handbrake), injection = imgui.ImInt(v.injection), intercooler = imgui.ImInt(v.intercooler), piston = imgui.ImInt(v.piston), suspension = imgui.ImInt(v.suspension), turbocharging = imgui.ImInt(v.turbocharging)}
  end
end
