script_name('Trinity Tuning Calculator')
script_author('Akionka')
script_version('0.0.3')
script_version_number(4)

local sampev = require 'samp.events'
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'UTF-8'
local u8 = encoding.UTF8
local cp = encoding.cp1251

local vehicles = {
  { name = 'Landstalker', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Bravura', saloonPrice = 6000, dealerPrice = 5100, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Buffalo', saloonPrice = 250000, dealerPrice = 212500, brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { name = 'Linerunner', saloonPrice = 50000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Perennial', saloonPrice = 6000, dealerPrice = 5100, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Sentinel', saloonPrice = 70000, dealerPrice = 59500, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Dumper', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Firetruck', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Trashmaster', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Stretch', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Manana', saloonPrice = 6000, dealerPrice = 5100, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Infernus', saloonPrice = 600000, dealerPrice = 510000, brake = 0, clutch = 2, exhaust = 3, handbrake = 0, injection = 2, intercooler = 3, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { name = 'Voodoo', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Pony', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Mule', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Cheetah', saloonPrice = 300000, dealerPrice = 255000, brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { name = 'Ambulance', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Leviathan', saloonPrice = 700000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Moonbeam', saloonPrice = 8000, dealerPrice = 6800, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Esperanto', saloonPrice = 30000, dealerPrice = 25500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Taxi cab', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Washington', saloonPrice = 60000, dealerPrice = 51000, brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Bobcat', saloonPrice = 10000, dealerPrice = 8500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Whoopee', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'BF Injection', saloonPrice = 90000, dealerPrice = 76500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Hunter', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Premier', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Enforcer', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Securicar', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Banshee', saloonPrice = 250000, dealerPrice = 212500, brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 3, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { name = 'Predator', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Bus', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Rhino', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Barracks', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Hotknife', saloonPrice = 300000, dealerPrice = 255000, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Semitrailer', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Previon', saloonPrice = 5000, dealerPrice = 4250, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Coach', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Cabbie', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Stallion', saloonPrice = 20000, dealerPrice = 17000, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Rumpo', saloonPrice = 30000, dealerPrice = 25500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'RC Bandit', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Romero', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Packer', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Monster', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Admiral', saloonPrice = 50000, dealerPrice = 42500, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Squalo', saloonPrice = 350000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Seasparrow', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Pizzaboy', saloonPrice = 1000, dealerPrice = 850, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tram', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Dump Trailer', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Turismo', saloonPrice = 450000, dealerPrice = 382500, brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 0, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { name = 'Speeder', saloonPrice = 270000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Reefer', saloonPrice = 400000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tropic', saloonPrice = 1500000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Flatbed', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Yankee', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Caddy', saloonPrice = 20000, dealerPrice = 17000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Solair', saloonPrice = 6000, dealerPrice = 5100, brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Berkley\'s van', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Skimmer', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'PCJ-600', saloonPrice = 90000, dealerPrice = 76500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Faggio', saloonPrice = 1000, dealerPrice = 850, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Freeway', saloonPrice = 30000, dealerPrice = 25500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'RC Baron', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'RC Raider', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Glendale', saloonPrice = 50000, dealerPrice = 42500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Oceanic', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Sanchez', saloonPrice = 80000, dealerPrice = 68000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Sparrow', saloonPrice = 500000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Patriot', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Quad', saloonPrice = 20000, dealerPrice = 17000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Coastguard', saloonPrice = 350000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Dinghy', saloonPrice = 40000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Hermes', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Sabre', saloonPrice = 20000, dealerPrice = 17000, brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Rustler', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'ZR-350', saloonPrice = 200000, dealerPrice = 170000, brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { name = 'Walton', saloonPrice = 5000, dealerPrice = 4250, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Regina', saloonPrice = 5000, dealerPrice = 4250, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Comet', saloonPrice = 200000, dealerPrice = 170000, brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { name = 'BMX', saloonPrice = 700, dealerPrice = 595, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Burrito', saloonPrice = 60000, dealerPrice = 51000, brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Camper', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Marquis', saloonPrice = 800000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tug', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Dozer', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Maverick', saloonPrice = 900000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'News Maverick', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Rancher', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'FBI Rancher', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Virgo', saloonPrice = 30000, dealerPrice = 25500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Greenwood', saloonPrice = 50000, dealerPrice = 42500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Jetmax', saloonPrice = 300000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'unusedhotring494', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Sandking', saloonPrice = 400000, dealerPrice = 340000, brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { name = 'Blista Compact', saloonPrice = 30000, dealerPrice = 25500, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Police Maverick', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'unusedboxv498', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Benson', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Mesa', saloonPrice = 50000, dealerPrice = 42500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'RC Goblin', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Hotring', saloonPrice = 400000, dealerPrice = 340000, brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 3, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { name = 'unusedhotring503', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Bloodring Banger', saloonPrice = 90000, dealerPrice = 76500, brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'unusedrancher505', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Super GT', saloonPrice = 200000, dealerPrice = 170000, brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { name = 'Elegant', saloonPrice = 70000, dealerPrice = 59500, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Journey', saloonPrice = 120000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Bike', saloonPrice = 600, dealerPrice = 510, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Mountain Bike', saloonPrice = 1000, dealerPrice = 850, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Beagle', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Cropduster', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Stuntplane', saloonPrice = 200000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tanker', saloonPrice = 100000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Roadtrain', saloonPrice = 150000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Nebula', saloonPrice = 30000, dealerPrice = 25500, brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Majestic', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Buccaneer', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Shamal', saloonPrice = 2000000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Hydra', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'FCR-900', saloonPrice = 90000, dealerPrice = 76500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'NRG-500', saloonPrice = 100000, dealerPrice = 85000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'HPV-1000', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Cement Truck', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tow Truck', saloonPrice = 15000, dealerPrice = 12750, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Fortune', saloonPrice = 8000, dealerPrice = 6800, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Cadrona', saloonPrice = 8000, dealerPrice = 6800, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'FBI Truck', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Willard', saloonPrice = 20000, dealerPrice = 17000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Forklift', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tractor', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Combine', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Feltzer', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Remington', saloonPrice = 60000, dealerPrice = 51000, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Slamvan', saloonPrice = 60000, dealerPrice = 51000, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Blade', saloonPrice = 60000, dealerPrice = 51000, brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Freight', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Streak', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Vortex', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Vincent', saloonPrice = 30000, dealerPrice = 25500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Bullet', saloonPrice = 500000, dealerPrice = 425000, brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 3, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { name = 'Clover', saloonPrice = 4000, dealerPrice = 3400, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Sadler', saloonPrice = 10000, dealerPrice = 8500, brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Stair Firetruck', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Hustler', saloonPrice = 70000, dealerPrice = 59500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Intruder', saloonPrice = 30000, dealerPrice = 25500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Primo', saloonPrice = 30000, dealerPrice = 25500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Cargobob', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Tampa', saloonPrice = 4000, dealerPrice = 3400, brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Sunrise', saloonPrice = 20000, dealerPrice = 17000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Merit', saloonPrice = 50000, dealerPrice = 42500, brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Utility', saloonPrice = 15000, dealerPrice = 12750, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Nevada', saloonPrice = 1200000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Yosemite', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Windsor', saloonPrice = 40000, dealerPrice = 34000, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Monster A', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Monster B', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Uranus', saloonPrice = 100000, dealerPrice = 85000, brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Jester', saloonPrice = 140000, dealerPrice = 119000, brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { name = 'Sultan', saloonPrice = 160000, dealerPrice = 136000, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Stratum', saloonPrice = 90000, dealerPrice = 76500, brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Elegy', saloonPrice = 140000, dealerPrice = 119000, brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { name = 'Raindance', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'RC Tiger', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Flash', saloonPrice = 100000, dealerPrice = 85000, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Tahoma', saloonPrice = 50000, dealerPrice = 42500, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Savanna', saloonPrice = 60000, dealerPrice = 51000, brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Bandito', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Freight Flat', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Streak Carriage', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Kart', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Mower', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Dune', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Sweeper', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Broadway', saloonPrice = 60000, dealerPrice = 51000, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Tornado', saloonPrice = 50000, dealerPrice = 42500, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'AT-400', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'DFT-30', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Huntley', saloonPrice = 70000, dealerPrice = 59500, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Stafford', saloonPrice = 70000, dealerPrice = 59500, brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'BF-400', saloonPrice = 95000, dealerPrice = 80750, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'News Van', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'unusedtug', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Petrol Trailer', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Emperor', saloonPrice = 20000, dealerPrice = 17000, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Wayfarer', saloonPrice = 30000, dealerPrice = 25500, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Euros', saloonPrice = 30000, dealerPrice = 25500, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Hotdog', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Club', saloonPrice = 20000, dealerPrice = 17000, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Freight Box', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Refrigerator Trailer', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Andromada', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Dodo', saloonPrice = 350000, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'RC Cam', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Launch', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Police US', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Police AF', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Police RC', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Police Ranger', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Picador', saloonPrice = 8000, dealerPrice = 6800, brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'S.W.A.T', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Alpha', saloonPrice = 30000, dealerPrice = 25500, brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Phoenix', saloonPrice = 20000, dealerPrice = 17000, brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { name = 'Glendale Shit', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Sadler Shit', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Baggage A', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Baggage B', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Stairs', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Boxville', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Farm Trailer', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { name = 'Field Kitchen', saloonPrice = 0, dealerPrice = 0, brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
}

local modifications = {
  {
    key = 'brake',
    name = 'Тормоза',
    hasManyLevels = true,
    price = { 5000, 10000, 15000 },
    dependsOn = {},
  }, {
    key = 'handbrake',
    name = 'Гоночный ручной тормоз',
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
    name = 'Поршневая',
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
    if not imgui.Begin('Trinity Tuning Calculator v'..thisScript().version, mainWindowState, imgui.WindowFlags.AlwaysAutoResize) then
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
    if imgui.Button('Очистить выбор') then
      selectedVehicle = -1
    end
    imgui.PopItemWidth()
    if selectedVehicle == -1 then
      imgui.Text('Не выбрано т/с, выберите из списка выше')
    else
      imgui.Text(vehicles[selectedVehicle].isModificationSupported and 'Тюнинг этого т/с поддерживается' or 'Тюнинг этого т/с не поддерживается')
      imgui.Text(('Цена в салоне: %s$\nЦена у автодилера 5 разряда: %s$'):format(
        formatInt((selectedVehicle >= 0 and selectedVehicle <= 412) and vehicles[selectedVehicle].saloonPrice or 0),
        formatInt((selectedVehicle >= 0 and selectedVehicle <= 412) and vehicles[selectedVehicle].dealerPrice or 0)
      ))
      if vehicles[selectedVehicle].isModificationSupported then
        imgui.Text('Базовая комплектация:')
        for i, v in ipairs(modifications) do
          imgui.BulletText(('%s: %s'):format(v.name, int2letter(vehicles[selectedVehicle][v.key], true)))
          if i % 2 == 1 and i ~= 1 then imgui.SameLine() end
        end
      end
    end
    imgui.EndChild()
    imgui.SameLine()
    imgui.BeginChild('Current panel', imgui.ImVec2(285, 410), true)
      imgui.PushItemWidth(100)
      imgui.Text('Текущая комплектация')
      for i, v in ipairs(modifications) do
        if imgui.Combo(v.name, currentItems[v.key],
          v.hasManyLevels and {'Нет', 'A', 'B', 'C'} or {'Нет', 'Есть'},
          v.hasManyLevels and imgui.ImInt(4) or imgui.ImInt(2)
        ) then
          if selectedVehicle ~= -1 then
            currentItems[v.key].v = math.max(currentItems[v.key].v, vehicles[selectedVehicle][v.key])
          end
          satisfyDependencies(v, currentItems)
        end
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
      imgui.Text((selectedVehicle == -1 or vehicles[selectedVehicle].isModificationSupported) and 'Желаемая комплектация' or 'Модификация не поддерживается')
      for _, v in ipairs(modifications) do
        if (selectedVehicle == -1 or vehicles[selectedVehicle].isModificationSupported) and imgui.Combo(v.name, requestedItems[v.key],
          v.hasManyLevels and {'Нет', 'A', 'B', 'C'} or {'Нет', 'Есть'},
          v.hasManyLevels and imgui.ImInt(4) or imgui.ImInt(2)
        ) then
          requestedItems[v.key].v = math.max(requestedItems[v.key].v, currentItems[v.key].v)
          satisfyDependencies(v, requestedItems)
        end
      end
      imgui.PopItemWidth()
    imgui.EndChild()
    imgui.SameLine()
    imgui.BeginChild('Price panel', imgui.ImVec2(275, 410), true)
      for i, v in ipairs(modifications) do
        for i = currentItems[v.key].v + 1, requestedItems[v.key].v do
          imgui.Text(('%s%s %s$'):format(
            v.name,
            v.hasManyLevels and ' ' .. int2letter(i, true) or '',
            formatInt(v.price[i])
          ))
        end
      end
      calculateTuningPrice(currentItems, requestedItems)
      imgui.Text(('Итог:\nМодификации: %s$\nС учётом машины с салона:%s$\nС учётом машины у автодилера: %s$'):format(
        formatInt(price),
        formatInt(price+((selectedVehicle >= 0 and selectedVehicle <= 412) and vehicles[selectedVehicle].saloonPrice or 0)),
        formatInt(price+((selectedVehicle >= 0 and selectedVehicle <= 412) and vehicles[selectedVehicle].dealerPrice or 0))
      ))
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
  local style = imgui.GetStyle()
  local colors = style.Colors
  local clr = imgui.Col
  local function ImVec4(color)
    local r = bit.band(bit.rshift(color, 24), 0xFF)
    local g = bit.band(bit.rshift(color, 16), 0xFF)
    local b = bit.band(bit.rshift(color, 8), 0xFF)
    local a = bit.band(color, 0xFF)
    return imgui.ImVec4(r/255, g/255, b/255, a/255)
  end

  style.WindowRounding = 10.0
  style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
  style.ChildWindowRounding = 5.0
  style.FrameRounding = 5.0
  style.ItemSpacing = imgui.ImVec2(5.0, 5.0)
  style.ScrollbarSize = 13.0
  style.ScrollbarRounding = 5

  colors[clr.Text] = ImVec4(0xFFFFFFFF)
  colors[clr.TextDisabled] = ImVec4(0xFFFFFFFF)
  colors[clr.WindowBg] = ImVec4(0x212121FF)
  colors[clr.ChildWindowBg] = ImVec4(0x21212180)
  colors[clr.PopupBg] = ImVec4(0x212121FF)
  colors[clr.Border] = ImVec4(0xFFFFFF10)
  colors[clr.BorderShadow] = ImVec4(0x21212100)
  colors[clr.FrameBg] = ImVec4(0xC3E88D90)
  colors[clr.FrameBgHovered] = ImVec4(0xC3E88DFF)
  colors[clr.FrameBgActive] = ImVec4(0x61616150)
  colors[clr.TitleBg] = ImVec4(0x212121FF)
  colors[clr.TitleBgActive] = ImVec4(0x212121FF)
  colors[clr.TitleBgCollapsed] = ImVec4(0x212121FF)
  colors[clr.MenuBarBg] = ImVec4(0x21212180)
  colors[clr.ScrollbarBg] = ImVec4(0x212121FF)
  colors[clr.ScrollbarGrab] = ImVec4(0xEEFFFF20)
  colors[clr.ScrollbarGrabHovered] = ImVec4(0xEEFFFF10)
  colors[clr.ScrollbarGrabActive] = ImVec4(0x80CBC4FF)
  colors[clr.ComboBg] = colors[clr.PopupBg]
  colors[clr.CheckMark] = ImVec4(0x212121FF)
  colors[clr.SliderGrab] = ImVec4(0x212121FF)
  colors[clr.SliderGrabActive] = ImVec4(0x80CBC4FF)
  colors[clr.Button] = ImVec4(0xC3E88D90)
  colors[clr.ButtonHovered] = ImVec4(0xC3E88DFF)
  colors[clr.ButtonActive] = ImVec4(0x61616150)
  colors[clr.Header] = ImVec4(0x151515FF)
  colors[clr.HeaderHovered] = ImVec4(0x252525FF)
  colors[clr.HeaderActive] = ImVec4(0x303030FF)
  colors[clr.Separator] = colors[clr.Border]
  colors[clr.SeparatorHovered] = ImVec4(0x212121FF)
  colors[clr.SeparatorActive] = ImVec4(0x212121FF)
  colors[clr.ResizeGrip] = ImVec4(0x212121FF)
  colors[clr.ResizeGripHovered] = ImVec4(0x212121FF)
  colors[clr.ResizeGripActive] = ImVec4(0x212121FF)
  colors[clr.CloseButton] = ImVec4(0x212121FF)
  colors[clr.CloseButtonHovered] = ImVec4(0xD41223FF)
  colors[clr.CloseButtonActive] = ImVec4(0xD41223FF)
  colors[clr.PlotLines] = ImVec4(0x212121FF)
  colors[clr.PlotLinesHovered] = ImVec4(0x212121FF)
  colors[clr.PlotHistogram] = ImVec4(0x212121FF)
  colors[clr.PlotHistogramHovered] = ImVec4(0x212121FF)
  colors[clr.TextSelectedBg] = ImVec4(0x212121FF)
  colors[clr.ModalWindowDarkening] = ImVec4(0x21212180)
end

function sampev.onServerMessage(color, text)
  if not mainWindowState.v or color ~= -1 then return end
  if text:find(cp'Перед вами стоит .+ {D8A903}.-{ffffff}') then
    parsedMods = {brake = false, clutch = false, exhaust = false, handbrake = false, injection = false, intercooler = false, piston = false, suspension = false, turbocharging = false}
    local name = text:match(cp'Перед вами стоит .+ {D8A903}(.-){ffffff}')
    for i, v in ipairs(vehicles) do
      if v.name == name then
        selectedVehicle = i
        setCurrentItems()
        return
      end
    end
  end
  if text:find(cp'Модификации:{abcdef}') then
    for k, v in pairs(parsedMods) do
      if not v then
        for i, v in ipairs(modifications) do
          if v.key == k then
            local name = cp:encode(v.name)
            if v.hasManyLevels then
              local pattern = ('[%s%s]%s #(%%w)'):format(name:sub(1, 1), stringToLower(name:sub(1, 1)), name:sub(2, #name))
              currentItems[k].v = letter2int(text:match(pattern) or int2letter(vehicles[selectedVehicle][k]))
              parsedMods[k] = not not text:find(pattern)
            else
              local pattern = ('[%s%s]%s'):format(name:sub(1, 1), stringToLower(name:sub(1, 1)), name:sub(2, #name))
              currentItems[k].v = text:find(pattern) and 1 or 0
              parsedMods[k] = not not text:find(cp'[Гг]оночный ручной тормоз')
            end
          end
        end
      end
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

function stringToLower(s)
  for i = 192, 223 do
    s = s:gsub(string.char(i), string.char(i + 32))
  end
  s = s:gsub(string.char(168), string.char(184))
  return s:lower()
end

function satisfyDependencies(modification, itemsList)
  for i2, v1 in ipairs(modifications) do
    for i3, v2 in ipairs(v1.dependsOn) do
      if modification.key == v2 then
        if itemsList[modification.key].v < itemsList[v1.key].v then
          itemsList[v1.key].v = itemsList[modification.key].v
        end
      end
    end
  end
  for i2, v1 in ipairs(modification.dependsOn) do
    if itemsList[v1].v < itemsList[modification.key].v then
      itemsList[v1].v = itemsList[modification.key].v
    end
  end
end