--[[----------------------------------------------------------------------------

  Application Name: 04_LED
                                                                                                                                                                                                 
  Summary:
  Show the basic controls for the LED on the device
  
  Description:
  All basic controls of the LED are shown in this script.
  Set the color of the led, light it up and let it blink. Also the led
  is blinking even when the script sleeps.
  
  How to run:
  First set this app as main (right-click -> "Set as main").
  Start by running the app (F5) or debugging (F7+F10).
  Set a breakpoint on the first row inside the main function to debug step-by-step.
  See the results in the viewer on the DevicePage.
  Supported LED colors are: red, yellow, green, white, aqua, fuchsia and blue

------------------------------------------------------------------------------]]

-- The application LED is the LED on the right side
-- Device LED is not controllable from the application
local appLED = LED.create('APPLICATION_LED')
-- Set the color of the LED before activating it
LED.setColor(appLED, 'blue')

local function main()
  -- Activating a LED will turn it on with a constant light
  LED.activate(appLED)
  Script.sleep(5000)

  -- The LED can also be set to blink at a specific rate
  LED.blink(appLED, 500, 200)
  -- The LED keeps blinking even when the script pauses
  Script.sleep(5000)

  -- The LED color can be set at any time
  LED.setColor(appLED, 'green')
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)
