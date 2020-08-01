script_name('Trinity Tuning Calculator')
script_author('Akionka')
script_version('0.0.1')
script_version_number(1)

local sampev = require 'samp.events'
local imgui = require 'imgui'
local encoding = require 'encoding'
encoding.default = 'UTF-8'
local u8 = encoding.UTF8
local cp = encoding.cp1251

local vehicles = {
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 2, exhaust = 3, handbrake = 0, injection = 2, intercooler = 3, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 3, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 0, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 3, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 3, piston = 2, suspension = 0, turbocharging = 2, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 2, exhaust = 2, handbrake = 0, injection = 2, intercooler = 2, piston = 2, suspension = 0, turbocharging = 1, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 1, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 1, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 1, exhaust = 2, handbrake = 0, injection = 1, intercooler = 0, piston = 2, suspension = 0, turbocharging = 0, isModificationSupported = true, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
  { brake = 0, clutch = 0, exhaust = 0, handbrake = 0, injection = 0, intercooler = 0, piston = 0, suspension = 0, turbocharging = 0, isModificationSupported = false, },
}

local vehicleNames = {
  "Landstalker",
  "Bravura",
  "Buffalo",
  "Linerunner",
  "Perennial",
  "Sentinel",
  "Dumper",
  "Firetruck",
  "Trashmaster",
  "Stretch",
  "Manana",
  "Infernus",
  "Voodoo",
  "Pony",
  "Mule",
  "Cheetah",
  "Ambulance",
  "Leviathan",
  "Moonbeam",
  "Esperanto",
  "Taxi cab",
  "Washington",
  "Bobcat",
  "Whoopee",
  "BF Injection",
  "Hunter",
  "Premier",
  "Enforcer",
  "Securicar",
  "Banshee",
  "Predator",
  "Bus",
  "Rhino",
  "Barracks",
  "Hotknife",
  "Semitrailer",
  "Previon",
  "Coach",
  "Cabbie",
  "Stallion",
  "Rumpo",
  "RC Bandit",
  "Romero",
  "Packer",
  "Monster",
  "Admiral",
  "Squalo",
  "Seasparrow",
  "Pizzaboy",
  "Tram",
  "Dump Trailer",
  "Turismo",
  "Speeder",
  "Reefer",
  "Tropic",
  "Flatbed",
  "Yankee",
  "Caddy",
  "Solair",
  "Berkley's van",
  "Skimmer",
  "PCJ-600",
  "Faggio",
  "Freeway",
  "RC Baron",
  "RC Raider",
  "Glendale",
  "Oceanic",
  "Sanchez",
  "Sparrow",
  "Patriot",
  "Quad",
  "Coastguard",
  "Dinghy",
  "Hermes",
  "Sabre",
  "Rustler",
  "ZR-350",
  "Walton",
  "Regina",
  "Comet",
  "BMX",
  "Burrito",
  "Camper",
  "Marquis",
  "Tug",
  "Dozer",
  "Maverick",
  "News Maverick",
  "Rancher",
  "FBI Rancher",
  "Virgo",
  "Greenwood",
  "Jetmax",
  "unusedhotring494",
  "Sandking",
  "Blista Compact",
  "Police Maverick",
  "unusedboxv498",
  "Benson",
  "Mesa",
  "RC Goblin",
  "Hotring",
  "unusedhotring503",
  "Bloodring Banger",
  "unusedrancher505",
  "Super GT",
  "Elegant",
  "Journey",
  "Bike",
  "Mountain Bike",
  "Beagle",
  "Cropduster",
  "Stuntplane",
  "Tanker",
  "Roadtrain",
  "Nebula",
  "Majestic",
  "Buccaneer",
  "Shamal",
  "Hydra",
  "FCR-900",
  "NRG-500",
  "HPV-1000",
  "Cement Truck",
  "Tow Truck",
  "Fortune",
  "Cadrona",
  "FBI Truck",
  "Willard",
  "Forklift",
  "Tractor",
  "Combine",
  "Feltzer",
  "Remington",
  "Slamvan",
  "Blade",
  "Freight",
  "Streak",
  "Vortex",
  "Vincent",
  "Bullet",
  "Clover",
  "Sadler",
  "Stair Firetruck",
  "Hustler",
  "Intruder",
  "Primo",
  "Cargobob",
  "Tampa",
  "Sunrise",
  "Merit",
  "Utility",
  "Nevada",
  "Yosemite",
  "Windsor",
  "Monster A",
  "Monster B",
  "Uranus",
  "Jester",
  "Sultan",
  "Stratum",
  "Elegy",
  "Raindance",
  "RC Tiger",
  "Flash",
  "Tahoma",
  "Savanna",
  "Bandito",
  "Freight Flat",
  "Streak Carriage",
  "Kart",
  "Mower",
  "Dune",
  "Sweeper",
  "Broadway",
  "Tornado",
  "AT-400",
  "DFT-30",
  "Huntley",
  "Stafford",
  "BF-400",
  "News Van",
  "unusedtug",
  "Petrol Trailer",
  "Emperor",
  "Wayfarer",
  "Euros",
  "Hotdog",
  "Club",
  "Freight Box",
  "Refrigerator Trailer",
  "Andromada",
  "Dodo",
  "RC Cam",
  "Launch",
  "Police US",
  "Police AF",
  "Police RC",
  "Police Ranger",
  "Picador",
  "S.W.A.T",
  "Alpha",
  "Phoenix",
  "Glendale Shit",
  "Sadler Shit",
  "Baggage A",
  "Baggage B",
  "Stairs",
  "Boxville",
  "Farm Trailer",
  "Field Kitchen",
}

local modNames = {
  brake = 'Тормоз',
  handbrake = 'Ручной тормоз',
  suspension = 'Подвеска',
  clutch = 'Сцепление',
  intercooler = 'Интеркулер',
  exhaust = 'Выхлоп',
  piston = 'Поршни',
  injection = 'Впрыск',
  turbocharging = 'Турбонаддув',
}

local prices = {
  brake = { 5000, 10000, 15000 },
  clutch = { 5000, 10000, 15000 },
  exhaust = { 3000, 5000, 7000 },
  handbrake = { 10000 },
  injection = { 3000, 5000, 7000 },
  intercooler = { 5000, 10000, 15000 },
  piston = { 3000, 5000, 7000 },
  intercooler = { 5000, 10000, 15000 },
  suspension = { 5000, 10000, 15000 },
  turbocharging = { 10000, 20000, 30000 },
}

local parsedMods = {brake = false, clutch = false, exhaust = false, handbrake = false, injection = false, intercooler = false, piston = false, suspension = false, turbocharging = false}

local mainWindowState = imgui.ImBool(false)
local selectedVehicle = imgui.ImInt(-1)
local vehiclesList = {}
local currentItems = {brake = imgui.ImInt(0), clutch = imgui.ImInt(0), exhaust = imgui.ImInt(0), handbrake = imgui.ImInt(0), injection = imgui.ImInt(0), intercooler = imgui.ImInt(0), piston = imgui.ImInt(0), suspension = imgui.ImInt(0), turbocharging = imgui.ImInt(0)}
local requestedItems = {brake = imgui.ImInt(0), clutch = imgui.ImInt(0), exhaust = imgui.ImInt(0), handbrake = imgui.ImInt(0), injection = imgui.ImInt(0), intercooler = imgui.ImInt(0), piston = imgui.ImInt(0), suspension = imgui.ImInt(0), turbocharging = imgui.ImInt(0)}

function imgui.OnDrawFrame()
  if mainWindowState.v then
    if not imgui.Begin('Trinity Tuning Calculator v'..thisScript()['version'], mainWindowState, imgui.WindowFlags.AlwaysAutoResize) then
      imgui.End()
      return
    end
    imgui.BeginGroup()
    imgui.BeginChild('Select Panel', imgui.ImVec2(275, 400), true)
    imgui.PushItemWidth(200)
    if imgui.ListBox('', selectedVehicle, vehicleNames, imgui.ImInt(211), -1) then
      setCurrentItems()
    end
    imgui.PopItemWidth()
    if selectedVehicle.v == -1 then
      imgui.Text('Не выбрано т/с, выберите из списка выше')
    else
      imgui.Text(vehicles[selectedVehicle.v + 1].isModificationSupported and 'Тюнинг этого т/с поддерживается' or 'Тюнинг этого т/с не поддерживается')
      if vehicles[selectedVehicle.v + 1].isModificationSupported then
        imgui.Text('Базовая комплектация:')
        imgui.BulletText('Тормоза: ' .. int2letter(vehicles[selectedVehicle.v + 1].brake, true))
        imgui.SameLine()
        imgui.BulletText('Ручной тормоз: ' .. int2letter(vehicles[selectedVehicle.v + 1].handbrake, true))
        imgui.BulletText('Подвеска: ' .. int2letter(vehicles[selectedVehicle.v + 1].suspension, true))
        imgui.SameLine()
        imgui.BulletText('Сцепление: ' .. int2letter(vehicles[selectedVehicle.v + 1].clutch, true))
        imgui.BulletText('Интеркулер: ' .. int2letter(vehicles[selectedVehicle.v + 1].intercooler, true))
        imgui.SameLine()
        imgui.BulletText('Выхлоп: ' .. int2letter(vehicles[selectedVehicle.v + 1].exhaust, true))
        imgui.BulletText('Поршни: ' .. int2letter(vehicles[selectedVehicle.v + 1].piston, true))
        imgui.SameLine()
        imgui.BulletText('Впрыск: ' .. int2letter(vehicles[selectedVehicle.v + 1].injection, true))
        imgui.BulletText('Турбонаддув: ' .. int2letter(vehicles[selectedVehicle.v + 1].turbocharging, true))
      end
    end
    imgui.EndChild()
    imgui.SameLine()
    imgui.BeginChild('Current panel', imgui.ImVec2(285, 400), true)
      imgui.PushItemWidth(100)
      imgui.Text('Текущая комплектация')
      imgui.Combo('Тормоза', currentItems.brake, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4))
      imgui.Combo('Ручной тормоз', currentItems.handbrake, {'Нет', 'Есть'}, imgui.ImInt(2))
      imgui.Combo('Подвеска', currentItems.suspension, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4))
      imgui.Combo('Сцепление', currentItems.clutch, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4))
      imgui.Combo('Интеркулер', currentItems.intercooler, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4))
      imgui.Combo('Выхлоп', currentItems.exhaust, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4))
      imgui.Combo('Поршни', currentItems.piston, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4))
      imgui.Combo('Впрыск', currentItems.injection, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4))
      imgui.Combo('Турбонаддув', currentItems.turbocharging, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4))
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
    imgui.BeginChild('Upgrade panel', imgui.ImVec2(275, 400), true)
      imgui.PushItemWidth(100)
      imgui.Text('Желаемая комплектация')
      if imgui.Combo('Тормоза', requestedItems.brake, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4)) then
        calculateTuningPrice(currentItems, requestedItems)
      end
      if imgui.Combo('Ручной тормоз', requestedItems.handbrake, {'Нет', 'Есть'}, imgui.ImInt(2)) then
        calculateTuningPrice(currentItems, requestedItems)
      end
      if imgui.Combo('Подвеска', requestedItems.suspension, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4)) then
        calculateTuningPrice(currentItems, requestedItems)
      end
      if imgui.Combo('Сцепление', requestedItems.clutch, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4)) then
        if requestedItems.clutch.v < requestedItems.turbocharging.v then
          requestedItems.turbocharging.v = requestedItems.clutch.v
        end
        calculateTuningPrice(currentItems, requestedItems)
      end
      if imgui.Combo('Интеркулер', requestedItems.intercooler, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4)) then
        if requestedItems.intercooler.v < requestedItems.turbocharging.v then
          requestedItems.turbocharging.v = requestedItems.intercooler.v
        end
        calculateTuningPrice(currentItems, requestedItems)
      end
      if imgui.Combo('Выхлоп', requestedItems.exhaust, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4)) then
        if requestedItems.exhaust.v < requestedItems.turbocharging.v then
          requestedItems.turbocharging.v = requestedItems.exhaust.v
        end
        if requestedItems.exhaust.v < requestedItems.injection.v then
          requestedItems.injection.v = requestedItems.exhaust.v
        end
        calculateTuningPrice(currentItems, requestedItems)
      end
      if imgui.Combo('Поршни', requestedItems.piston, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4)) then
        if requestedItems.piston.v < requestedItems.turbocharging.v then
          requestedItems.turbocharging.v = requestedItems.piston.v
        end
        if requestedItems.piston.v < requestedItems.injection.v then
          requestedItems.injection.v = requestedItems.piston.v
        end
        calculateTuningPrice(currentItems, requestedItems)
      end
      if imgui.Combo('Впрыск', requestedItems.injection, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4)) then
        if requestedItems.injection.v < requestedItems.turbocharging.v then
          requestedItems.turbocharging.v = requestedItems.injection.v
        end
        if requestedItems.piston.v < requestedItems.injection.v then
          requestedItems.piston.v = requestedItems.injection.v
        end
        if requestedItems.exhaust.v < requestedItems.injection.v then
          requestedItems.exhaust.v = requestedItems.injection.v
        end
        calculateTuningPrice(currentItems, requestedItems)
      end
      if imgui.Combo('Турбонаддув', requestedItems.turbocharging, {'Нет', 'A', 'B', 'C'}, imgui.ImInt(4)) then
        if requestedItems.clutch.v < requestedItems.turbocharging.v then
          requestedItems.clutch.v = requestedItems.turbocharging.v
        end
        if requestedItems.intercooler.v < requestedItems.turbocharging.v then
          requestedItems.intercooler.v = requestedItems.turbocharging.v
        end
        if requestedItems.exhaust.v < requestedItems.turbocharging.v then
          requestedItems.exhaust.v = requestedItems.turbocharging.v
        end
        if requestedItems.piston.v < requestedItems.turbocharging.v then
          requestedItems.piston.v = requestedItems.turbocharging.v
        end
        if requestedItems.injection.v < requestedItems.turbocharging.v then
          requestedItems.injection.v = requestedItems.turbocharging.v
        end
        calculateTuningPrice(currentItems, requestedItems)
      end
      imgui.PopItemWidth()
    imgui.EndChild()
    imgui.SameLine()
    imgui.BeginChild('Price panel', imgui.ImVec2(275, 400), true)
      for i, v in ipairs({'brake', 'handbrake', 'suspension', 'clutch', 'intercooler', 'exhaust', 'piston', 'injection', 'turbocharging'}) do
        for i = currentItems[v].v + 1, requestedItems[v].v do
          imgui.Text(modNames[v] .. (v ~= 'handbrake' and ' ' .. int2letter(i, true) or '') .. ' +' .. formatInt(prices[v][i]) .. ' $')
        end
      end
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
        selectedVehicle.v = i - 1
        setCurrentItems()
        return
      end
    end
  end
  if text:find(cp'Модификации:{abcdef}') then
    -- ALARM: SHIT CODE! ALARM: SHIT CODE! ALARM: SHIT CODE! ALARM: SHIT CODE!
    if not parsedMods.brake then
      currentItems.brake.v = letter2int(text:match(cp'[Тт]ормоза #(%w)') or int2letter(vehicles[selectedVehicle.v + 1].brake))
      parsedMods.brake = text:find(cp'[Тт]ормоза #(%w)')
    end
    if not parsedMods.handbrake then
      currentItems.handbrake.v = text:find(cp'[Гг]оночный ручной тормоз') and 1 or 0
      parsedMods.handbrake = text:find(cp'[Гг]оночный ручной тормоз')
    end
    if not parsedMods.suspension then
      currentItems.suspension.v = letter2int(text:match(cp'[Пп]одвеска #(%w)') or int2letter(vehicles[selectedVehicle.v + 1].suspension))
      parsedMods.suspension = text:find(cp'[Пп]одвеска #(%w)')
    end
    if not parsedMods.clutch then
      currentItems.clutch.v = letter2int(text:match(cp'[Сс]цепление #(%w)') or int2letter(vehicles[selectedVehicle.v + 1].clutch))
      parsedMods.clutch = text:find(cp'[Сс]цепление #(%w)')
    end
    if not parsedMods.intercooler then
      currentItems.intercooler.v = letter2int(text:match(cp'[Ии]нтеркулер #(%w)') or int2letter(vehicles[selectedVehicle.v + 1].intercooler))
      parsedMods.intercooler = text:find(cp'[Ии]нтеркулер #(%w)')
    end
    if not parsedMods.exhaust then
      currentItems.exhaust.v = letter2int(text:match(cp'[Вв]ыхлоп #(%w)') or int2letter(vehicles[selectedVehicle.v + 1].exhaust))
      parsedMods.exhaust = text:find(cp'[Вв]ыхлоп #(%w)')
    end
    if not parsedMods.piston then
      currentItems.piston.v = letter2int(text:match(cp'[Пп]оршневая #(%w)') or int2letter(vehicles[selectedVehicle.v + 1].piston))
      parsedMods.piston = text:find(cp'[Пп]оршневая #(%w)')
    end
    if not parsedMods.injection then
      currentItems.injection.v = letter2int(text:match(cp'[Вв]прыск #(%w)') or int2letter(vehicles[selectedVehicle.v + 1].injection))
      parsedMods.injection = text:find(cp'[Вв]прыск #(%w)')
    end
    if not parsedMods.turbocharging then
      currentItems.turbocharging.v = letter2int(text:match(cp'[Тт]урбонаддув #(%w)') or int2letter(vehicles[selectedVehicle.v + 1].turbocharging))
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
  local price = 0
  for k, v in pairs(selectedItems) do
    if currentItems[k].v ~= selectedItems[k].v then
      for i = currentItems[k].v + 1, selectedItems[k].v do
        price = price + prices[k][i]
      end
    end
  end
  return price
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
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1 %2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function setCurrentItems(overrideRequestedItems)
  local v = vehicles[selectedVehicle.v + 1]
  currentItems = {brake = imgui.ImInt(v.brake), clutch = imgui.ImInt(v.clutch), exhaust = imgui.ImInt(v.exhaust), handbrake = imgui.ImInt(v.handbrake), injection = imgui.ImInt(v.injection), intercooler = imgui.ImInt(v.intercooler), piston = imgui.ImInt(v.piston), suspension = imgui.ImInt(v.suspension), turbocharging = imgui.ImInt(v.turbocharging)}
  if overrideRequestedItems then
    requestedItems = {brake = imgui.ImInt(v.brake), clutch = imgui.ImInt(v.clutch), exhaust = imgui.ImInt(v.exhaust), handbrake = imgui.ImInt(v.handbrake), injection = imgui.ImInt(v.injection), intercooler = imgui.ImInt(v.intercooler), piston = imgui.ImInt(v.piston), suspension = imgui.ImInt(v.suspension), turbocharging = imgui.ImInt(v.turbocharging)}
  end
end
