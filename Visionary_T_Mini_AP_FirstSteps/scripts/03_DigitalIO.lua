--[[----------------------------------------------------------------------------

  Application Name: 03_DigitalIO

  Summary:
  Set one port to digital in and one to digital out

  Description:
  The bidirectional digital ports can be defined as input or output.
  All the basics for using the ports are shown in this application.
  Setting a port to be input, setting a port to be output and registering
  a function to a change in the signal

  How to run:
  First set this app as main (right-click -> "Set as main").
  Start by running the app (F5) or debugging (F7+F10).
  Set a breakpoint on the first row inside the main function to debug step-by-step.
  See the results in the viewer on the DevicePage.

------------------------------------------------------------------------------]]
--Start of Global Scope---------------------------------------------------------

--luacheck: globals gTimer
--luacheck: globals din_1

local currentDout2State = false

-- Some digital ports are input only, while others are
-- bidirectional. The direction of a bidirectional digital
-- port is set by using different create() methods.

-- Initialize digital in/out 1 to be an input
din_1 = Connector.DigitalIn.create('DI1')

-- Initialize digital in/out 2 to be an output
local dout_2 = Connector.DigitalOut.create('DO2')

-- Add a timer which changes the state of dout_2 once a second
gTimer = Timer.create()
Timer.setPeriodic(gTimer, true)
Timer.setExpirationTime(gTimer, 1000)
Timer.start(gTimer)

-- Timer is started in the global scope. After each expiration
-- the state of dout_2 is changed

local function toggleDout2State()
  currentDout2State = not currentDout2State
  Connector.DigitalOut.set(dout_2, currentDout2State)
  print('Digital I/O 2 changed state to ' .. tostring(currentDout2State))
end

Timer.register(gTimer, 'OnExpired', toggleDout2State)

---To track the changing value of an input, register a handler on
---the OnChange signal.
---@param newState bool new State of the IO
local function printDin1State(newState)
  print('Digital I/O 1 changed state to ' .. tostring(newState))
end
Connector.DigitalIn.register(din_1, 'OnChange', printDin1State)
