--[[----------------------------------------------------------------------------

  Application Name: 02_3dViewer
                                                                                             
  Summary:
  Show the pointcloud that the camera acquired
  
  Description:
  Set up the camera to take live images continuously. React to the "OnNewImage"
  event and show the pointcloud in an 3D viewer
  
  How to run:
  First set this app as main (right-click -> "Set as main").
  Start by running the app (F5) or debugging (F7+F10).
  Set a breakpoint on the first row inside the main function to debug step-by-step.
  See the results in the different image viewer on the DevicePage.

------------------------------------------------------------------------------]]

-- Setup the camera
local camera = Image.Provider.Camera.create()
Image.Provider.Camera.stop(camera)
local cameraModel = Image.Provider.Camera.getInitialCameraModel(camera)

--setup the pointcloud converter
local pointCloudConverter = Image.PointCloudConversion.RadialDistance.create()
pointCloudConverter:setCameraModel(cameraModel)

--setup the  view
local view3D = View.create("3DViewer")

--End of Global Scope-----------------------------------------------------------

local function main()
  Image.Provider.Camera.start(camera)
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

---Callback funtion which is called when a new image is available
---@param image Image Vector which contains all received images
local function handleOnNewImage(image)
  -- Convert to point cloud, first argument is the distance image, second one is the intensity image
  local convert = 
    Image.PointCloudConversion.RadialDistance.toPointCloud(pointCloudConverter, image[1],image[2])
  -- Add the point cloud to the viewer and then present
  View.addPointCloud(view3D, convert)
  View.present(view3D)
end
Image.Provider.Camera.register(camera, 'OnNewImage', handleOnNewImage)
