--[[----------------------------------------------------------------------------

  Application Name: 05_PowerSaveMode
                                                                                                                                                                                                 
  Summary:
  Show the trigger of power save mode
  
  Description:
  Activate power save mode first and then deactivate it. As an indicator whether 
  the power save mode is activated or not, we set up two views to show the distance
  and intensity image. The power save mode is activated by raising an event and 
  deactivated by releasing the event.

  More information regarding the usage of views,
  please refer to 01_2dViewer.lua and 02_3dViewer.lua.
  
  How to run:
  First set this app as main (right-click -> "Set as main").
  Start by running the app (F5) or debugging (F7+F10).
  Set a breakpoint on the first row inside the main function to debug step-by-step.
  See the results in the viewer on the DevicePage.
  
  More Information:
  See the tutorial Visionary-T AP FirstSteps

------------------------------------------------------------------------------]]

-- This function activates or deactivates the power save function
-- Parameter: state true activates the power save mode, false deactivates it
local function activatePowerSaveMode(state)
  if state then
    Log.info("Activate power save mode")
    supCrown:raiseEvent('Powersave')
  else
    Log.info("Deactivate power save mode")
    supCrown:releaseEvent('Powersave')
  end
end

-- Setup the camera
local camera = Image.Provider.Camera.create()
Image.Provider.Camera.stop(camera)

-- Setup the different views
local viewDistance = View.create('distanceViewer')
local viewIntensity = View.create('intensityViewer')

local function main()
  Image.Provider.Camera.start(camera)

  -- Add event for power save
  supCrown = SupervisorCrown.create()
  supCrown:addEvent("Powersave")

  -- Activate power save mode by raising event
  activatePowerSaveMode(true)

  Script.sleep(5000)

  -- Deactivate power save mode by raising event
  activatePowerSaveMode(false)

  Script.sleep(5000)
end

--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

--@handleOnNewImage(image:Image,sensordata:SensorData)
local function handleOnNewImage(image)
  View.addImage(viewDistance, image[1], decoration) --distance image is first element of the image table
  View.addImage(viewIntensity, image[2], decoration) --intensity image is second element of the image table

  --present the added images
  View.present(viewDistance)
  View.present(viewIntensity)

end

Image.Provider.Camera.register(camera, 'OnNewImage', handleOnNewImage)
--End of Function and Event Scope-----------------------------------------------

