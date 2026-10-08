--!optimize 2
--[[
	patchma hub by rqz
	MyWorld was here
	
	var

	Find rigs in Genesis Foundation (roblox.com/games/14133411956), most old patchma rigs should also work
	
	IDs of free accessories:
	3033910400,3409612660,3438342658,3398308134,4324158403,3822880197,4154538250,3443038622,4819740796

	accessories for Immortality Lord:
	head: 17375337078 or 17270164442 or 105058659622112
	body: 121668589285446,80629770394501,127671621543010,76687571475377,120230112701079
	or 132908702618809,122975605535029,115313441748457,127208207296576,131203955709755
	or 17270178857,17270001635,17269952801,17269983359,17269998373
	wings: 17270231731,17270225913
	sword: 17326812233,17326800544
]]

--no need to get and index the library tables with function names every time the script uses them
local osclock=os.clock
local tspawn=task.spawn
local tdelay=task.delay
local twait=task.wait
local schar=string.char
local ssub=string.sub
local sfind=string.find
local supper=string.upper
local mrandom=math.random
local sin=math.sin
local cos=math.cos
local abs=math.abs
local min=math.min
local sqrt=math.sqrt
local clamp=math.clamp
local tinsert=table.insert
local tclear=table.clear
local tclone=table.clone
local tfind=table.find
local cyield=coroutine.yield
local cresume=coroutine.resume
local crunning=coroutine.running
local vmagnitude=vector.magnitude --faster than indexing with Magnitude
local vnormalize=vector.normalize --faster than indexing with Unit

--the script doesnt have to read global varaibles every time to get them
--why not have them saved in local varaibles for faster access times
local next=next
local pcall=pcall
local xpcall=xpcall
local type=type
local typeof=typeof
local game=game
local sethiddenproperty=sethiddenproperty or set_hidden_property or sethiddenprop
local setscriptable=setscriptable or set_scriptable
local replicatesignal=replicatesignal or replicate_signal

local i=Instance.new 
local v2=Vector2.new 
local v3=Vector3.new
local c3=Color3.new 
local cf=CFrame.new
local cfl=CFrame.lookAt
local angles=CFrame.fromEulerAngles --faster than .Angles
local u2=UDim2.new 
local e=Enum 
local rp=RaycastParams.new 
local cs=ColorSequence.new 
local csk=ColorSequenceKeypoint.new 

local sine=osclock()
local deltaTime=0
local v3_0=v3()
local v3_101=v3(1,0,1)
local v3_010=v3(0,1,0)
local cf_0=cf()
local v3_xz=v3_101*10
local v3_xzL=v3_101*250.1
local v3_net=v3_010*25.01

local enumphysics=e.HumanoidStateType.Physics
local enumragdoll=e.HumanoidStateType.Ragdoll
local enumrunning=e.HumanoidStateType.Running
local enumseated=e.HumanoidStateType.Seated
local enumMD=e.MouseBehavior.Default

local sm=v3_010/2
local dense=PhysicalProperties.new(100,0,0,100,100)
local light=PhysicalProperties.new(0.0001,0,0,100,100)
local humstatesbl=e.HumanoidStateType:GetEnumItems()
table.remove(humstatesbl,tfind(humstatesbl,enumrunning))
table.remove(humstatesbl,tfind(humstatesbl,e.HumanoidStateType.None))

--not "local function rs" to not assign debug names
local rs=function()
	local s=""
	for i=1,mrandom(8,15) do
		if mrandom(2)==2 then
			s=s..schar(mrandom(65,90))
		else
			s=s..schar(mrandom(97,122))
		end
	end
	return s
end

--it runs even faster if u call __index and __newindex metamethods directly
local getMetamethodFromErrorStack=function(userdata,f,test)
	local ret=nil
	xpcall(f,function()
		ret=debug.info(2,"f")
	end,userdata,nil,0)
	if (type(ret)~="function") or not test(ret) then
		return f
	end
	return ret
end
local insSet=getMetamethodFromErrorStack(game,function(a,b,c) a[b]=c end,function(f) local a=i("Folder") local b=rs() f(a,"Name",b) return a.Name==b end)
local insGet=getMetamethodFromErrorStack(game,function(a,b) return a[b] end,function(f) local a=i("Folder") local b=rs() a.Name=b return f(a,"Name")==b end)
local cfGet=getMetamethodFromErrorStack(cf_0,function(a,b) return a[b] end,function(f) return f(cf(1,2,3),"Position")==v3(1,2,3) end)
local cfMul=getMetamethodFromErrorStack(cf_0,function(a,b) return a*b end,function(f) return angles(1,2,3)*angles(1,2,3)==f(angles(1,2,3),angles(1,2,3)) end)
local cfAdd=getMetamethodFromErrorStack(cf_0,function(a,b) return a+b end,function(f) return cf(1,2,3)+v3(1,2,3)==f(cf(1,2,3),v3(1,2,3)) end)
local v3Get=getMetamethodFromErrorStack(v3_0,function(a,b) return a[b] end,function(f) return v3(1,2,3).Unit==f(v3(1,2,3),"Unit") end)
local v2Get=getMetamethodFromErrorStack(v2(),function(a,b) return a[b] end,function(f) return f(v2(1,2),"Y")==2 end)
--multiplying and adding vector3 is faster if you use the * and + operators
--its faster to multiply X and Y of vector2 than to multiply vector2 and then get X and Y from it

--no need to index instances every time to call their functions
local Clone=insGet(game,"Clone")
local ClearAllChildren=insGet(game,"ClearAllChildren")
local Destroy=insGet(game,"Destroy")
local IsA=insGet(game,"IsA")
local FindFirstChildOfClass=insGet(game,"FindFirstChildOfClass")
local FindFirstChildWhichIsA=insGet(game,"FindFirstChildWhichIsA")
local GetChildren=insGet(game,"GetChildren")
local IsDescendantOf=insGet(game,"IsDescendantOf")
local QueryDescendants=insGet(game,"QueryDescendants")
local GetPropertyChangedSignal=insGet(game,"GetPropertyChangedSignal")

--findfirstchildofclass faster than getservice
local plrs=FindFirstChildOfClass(game,"Players")
local rus=FindFirstChildOfClass(game,"RunService")
local ws=FindFirstChildOfClass(game,"Workspace")
local uis=FindFirstChildOfClass(game,"UserInputService")
local gs=FindFirstChildOfClass(game,"GuiService")
local sg=FindFirstChildOfClass(game,"StarterGui")
local lp=insGet(plrs,"LocalPlayer")
local pg=FindFirstChildOfClass(lp,"PlayerGui")
local mouse=insGet(lp,"GetMouse")(lp)
local preanimation=insGet(rus,"PreAnimation")
local stepped=insGet(rus,"Stepped")
local heartbeat=insGet(rus,"Heartbeat")
local renderstepped=insGet(rus,"RenderStepped")

local GetPlayers=insGet(plrs,"GetPlayers")
local BreakJoints=insGet(i("Model"),"BreakJoints")
local ChangeState=insGet(i("Humanoid"),"ChangeState")
local SetStateEnabled=insGet(i("Humanoid"),"SetStateEnabled")
local GetJoints=insGet(insGet(ws,"Terrain"),"GetJoints")
local SetCoreGuiEnabled=insGet(sg,"SetCoreGuiEnabled")
local GetCoreGuiEnabled=insGet(sg,"GetCoreGuiEnabled")
local Raycast=insGet(ws,"Raycast")
local Connect=heartbeat.Connect
local Disconnect=Connect(GetPropertyChangedSignal(game,"CreatorId"),type).Disconnect
local Wait=heartbeat.Wait
local GetMouseLocation=insGet(uis,"GetMouseLocation")
local GetFocusedTextBox=insGet(uis,"GetFocusedTextBox")
local GetMouseDelta=insGet(uis,"GetMouseDelta")
local IsMouseButtonPressed=insGet(uis,"IsMouseButtonPressed")
local IsKeyDown=insGet(uis,"IsKeyDown")

local Inverse=cfGet(cf_0,"Inverse")
local Lerp=cfGet(cf_0,"Lerp")

local guiTheme={
	guiTitle="patchma hub v61",
	windowTitleColor=c3(1,0,0),
	windowTopColor=c3(0,0,0),
	windowBottomColor=c3(0.584314,0,0),
	windowMinimizedSize={X=220,Y=22},
	windowRegularSize={X=220,Y=290},
	buttonsTextColor=c3(1,0,0),
	labelsTextColor=c3(0.560784,0.560784,0.560784),
	listTopColor=c3(0,0,0),
	listBottomColor=c3(0.0705882,0.0705882,0.0705882)
}

--[[ Old myworld gui blue theme, uncomment to restore blue patchma
local guiTheme={
	guiTitle="patchma hub v61",
	windowTitleColor=c3(0,0,1),
	windowTopColor=c3(0,0,0),
	windowBottomColor=c3(0,0,0.584314),
	windowMinimizedSize={X=220,Y=22},
	windowRegularSize={X=220,Y=290},
	buttonsTextColor=c3(0.0941177,0.317647,0.878431),
	labelsTextColor=c3(0.560784,0.560784,0.560784),
	listTopColor=c3(0,0,0),
	listBottomColor=c3(0.0705882,0.0705882,0.0705882)
}
]]

local aligns={
	--[[
		example: 
		{PartName="Right Arm",meshid="123456789",textureid="123456789",AccessoryName="Name",C0=cf(1,2,3)*angles(1,2,3)},

		PartName (required) - the name of the body part you want to align the hat to
		meshid (optional) - mesh id of the mesh of the accessory you want to align
		textureid (optional) - texture id of the mesh of the accessory you want to align
		AccessoryName (optional) - instance name of the accessory you want to align 
		C0 (optional) - offset from the target body part to the accessory (defaults to cf(0,0,0) if unspecified)
		
		accessories will align to the first entry whose criteria they match
		(unspecified meshid/textureid/accessoryname accepts all accessories)
		
		each entry aligns one accessory at most
	]]

	-- unknown head
	{PartName="Head",meshid="11601535857",C0=angles(0,3.141592653589793,0)},

	-- patchma gear arms
	{PartName="Left Arm",meshid="13831073174",C0=cfMul(cf(0.017,0,-0.23),angles(-1.4835298641951802,-0.15707963267948966,2.199114857512855))},
	{PartName="Right Arm",meshid="13839903766",C0=cfMul(cf(0,-0.62,-0.01),angles(1.6580627893946132,0.15707963267948966,-2.199114857512855))},

	-- patchma yellow leg
	{PartName="Left Leg",meshid="11159370334",textureid="11159285454",C0=angles(1.5707963267948966,0,1.5707963267948966)},

	-- patchma lego piece leg
	{PartName="Right Leg",meshid="12652772399",textureid="12652775021",C0=cf(0,-0.125,0)},

	-- offsale white rig
	-- a ton of offsaled black torso's
	{PartName="Torso",meshid="14768666349"},
	{PartName="Torso",meshid="14241018198"},
	{PartName="Torso",meshid="13421774668"},
	{PartName="Left Leg",meshid="14255522247",C0=angles(1.5707963267948966,0,1.5707963267948966)},
	{PartName="Right Leg",meshid="14255522247",C0=angles(-1.5707963267948966,0,1.5707963267948966)},
	{PartName="Left Arm",meshid="14768684979",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Arm",meshid="14768684979",C0=angles(0,0,1.5707963267948966)},

	-- og fur body, r15 arms, smiley legs rig
	{PartName="Head",meshid="13953154391"},
	{PartName="Torso",meshid="13778226115"},
	{PartName="Left Leg",meshid="11159370334",textureid="11159284657",C0=angles(1.5707963267948966,0,1.5707963267948966)},
	{PartName="Right Leg",meshid="11263221350",textureid="11263219250",C0=angles(-1.5707963267948966,0,1.5707963267948966)},
	{PartName="Left Arm",meshid="12344207333",C0=angles(2,0,0)},
	{PartName="Right Arm",meshid="12344206657",C0=angles(2,0,0)},

	-- torso for both "white limbs black torso rig" and "black rig"
	{PartName="Torso",meshid="110684113028749"},
	-- white limbs black torso rig
	{PartName="Head",meshid="13058343355",C0=angles(0,3.141592653589793,0)},
	{PartName="Left Leg",meshid="139733645770094",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Leg",meshid="99608462237958",C0=angles(0,0,1.5707963267948966)},
	{PartName="Left Arm",meshid="90736849096372",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Arm",meshid="105141400603933",C0=angles(0,0,1.5707963267948966)},
	-- head for black rigs
	{PartName="Head",meshid="13953153289"},
	-- lay offsale black rig
	{PartName="Left Leg",meshid="17387586286",C0=angles(1.5707963267948966,0,1.5707963267948966)},
	{PartName="Right Leg",meshid="17387586286",C0=angles(-1.5707963267948966,0,1.5707963267948966)},
	{PartName="Left Arm",meshid="17374767929",C0=angles(1.5707963267948966,0,1.5707963267948966)},
	{PartName="Right Arm",meshid="17374767929",C0=angles(-1.5707963267948966,0,1.5707963267948966)},
	-- 7ws offsale black rig
	{PartName="Left Leg",meshid="125405780718494",C0=angles(1.5707963267948966,0,1.5707963267948966)},
	{PartName="Right Leg",meshid="125405780718494",C0=angles(-1.5707963267948966,0,1.5707963267948966)},
	{PartName="Left Arm",meshid="125405780718494",C0=angles(1.5707963267948966,0,1.5707963267948966)},
	{PartName="Right Arm",meshid="125405780718494",C0=angles(-1.5707963267948966,0,1.5707963267948966)},

	-- meshless rig
	{PartName="Head",meshid="13953094351"},
	{PartName="Torso",meshid="127552124837034",C0=angles(0,0,1.5707963267948966)},
	{PartName="Left Leg",meshid="121304376791439"},
	{PartName="Right Leg",meshid="121304376791439"},
	{PartName="Left Arm",meshid="117287001096396"},
	{PartName="Right Arm",meshid="117287001096396"},

	-- head for noob rig
	{PartName="Head",meshid="13058309233",C0=angles(0,3.141592653589793,0)},
	-- lay offsale noob rig
	{PartName="Torso",meshid="18640899369"},
	{PartName="Left Leg",meshid="18640901641"},
	{PartName="Right Leg",meshid="18640901641"},
	{PartName="Left Arm",meshid="18640914129"},
	{PartName="Right Arm",meshid="18640914129"},
	-- 7ws offsale noob rig
	{PartName="Torso",meshid="126825022897778"},
	{PartName="Left Leg",textureid="73798034827573",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Leg",textureid="73798034827573",C0=angles(0,0,1.5707963267948966)},
	{PartName="Left Arm",textureid="135650240593878",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Arm",textureid="135650240593878",C0=angles(0,0,1.5707963267948966)},

	-- white torso
	{PartName="Torso",meshid="126825022897778"},

	-- lay onsale gray torso white arm black leg rig
	{PartName="Torso",meshid="139792224823925"},
	{PartName="Left Leg",meshid="83395427313429",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Leg",meshid="83395427313429",C0=angles(0,0,1.5707963267948966)},
	{PartName="Left Arm",meshid="105263225400272",C0=angles(0,0,1.5707963267948966)},
	{PartName="Right Arm",meshid="105263225400272",C0=angles(0,0,1.5707963267948966)},

	-- shownape/geecee auto rig
	{PartName="Head",AccessoryName="Accessory (autorig_Head)"},
	{PartName="Torso",AccessoryName="Accessory (autorig_Torso)"},
	{PartName="Left Leg",AccessoryName="Accessory (autorig_LeftLeg)"},
	{PartName="Right Leg",AccessoryName="Accessory (autorig_RightLeg)"},
	{PartName="Left Arm",AccessoryName="Accessory (autorig_LeftArm)"},
	{PartName="Right Arm",AccessoryName="Accessory (autorig_RightArm)"},

	-- free rig
	{PartName="Left Arm",meshid="4324138105",textureid="4324138210",C0=angles(-1.6144295580947547,1.5707963267948966,0)*cf(-0.125,0.3,0)},
	{PartName="Left Arm",meshid="4154474745",textureid="4154474807",C0=angles(1.5271630954950384,-1.5707963267948966,0)*cf(-0.125,-0.3,0)},
	{PartName="Right Arm",meshid="3030546036",textureid="3650191503",C0=angles(1.5271630954950384,1.5707963267948966,0)*cf(0.125,-0.3,0)},
	{PartName="Right Arm",meshid="3030546036",textureid="3443321249",C0=angles(-1.6144295580947547,-1.5707963267948966,0)*cf(0.125,0.3,0)},
	{PartName="Left Leg",meshid="3030546036",textureid="3360974849",C0=angles(1.5271630954950384,1.5707963267948966,0)*cf(-0.125,-0.35,0)},
	{PartName="Left Leg",meshid="3030546036",textureid="3360978739",C0=angles(-1.6144295580947547,-1.5707963267948966,0)*cf(-0.125,0.3,0)},
	{PartName="Right Leg",meshid="3030546036",textureid="3033898741",C0=angles(1.5271630954950384,-1.5707963267948966,0)*cf(0.125,-0.35,0)},
	{PartName="Right Leg",meshid="3030546036",textureid="3409604993",C0=angles(-1.6144295580947547,1.5707963267948966,0)*cf(0.125,0.3,0)},
	{PartName="Torso",meshid="4819720316",textureid="4819722776",C0=angles(0,0,0.2617993877991494)}
}

local makeplaceholder=function(v)
	if not insGet(v,"Archivable") then
		insSet(v,"Archivable",true)
	end
	v=Clone(v)
	local mesh=FindFirstChildOfClass(v,"SpecialMesh")
	if mesh then
		insSet(mesh,"Parent",nil)
		ClearAllChildren(v)
		ClearAllChildren(mesh)
		insSet(mesh,"Name",rs())
		insSet(mesh,"Parent",v)
	else
		ClearAllChildren(v)
	end
	insSet(v,"Name",rs())
	insSet(v,"Anchored",true)
	insSet(v,"CanCollide",false)
	insSet(v,"Transparency",0.25)
	return v
end
local emptyfunction=function() end

local i1=i("Frame") 
local i2=i("Frame") 
local i3=i("Frame") 
local i4=i("ScrollingFrame") 
local i5=i("UIListLayout") 
local i6=i("UIGradient") 
local i7=i("TextBox") 
local i8=i("TextButton") 
local i9=i("UIGradient") 
local i10=i("ScreenGui") 
insSet(i1,"AnchorPoint",v2(0.5,0))
insSet(i1,"Active",true)
insSet(i1,"BorderSizePixel",0)
insSet(i1,"ClipsDescendants",true)
insSet(i1,"Position",u2(0.5,0,0.5,guiTheme.windowRegularSize.Y/-2))
insSet(i1,"Size",u2(0,guiTheme.windowRegularSize.X,0,guiTheme.windowRegularSize.Y))
insSet(i1,"Name",rs())
insSet(i1,"Parent",i10)
insSet(i2,"BackgroundColor3",c3(1,1,1))
insSet(i2,"BorderSizePixel",0)
insSet(i2,"Size",u2(0,guiTheme.windowRegularSize.X,0,guiTheme.windowRegularSize.Y))
insSet(i2,"Name",rs())
insSet(i2,"Parent",i1)
insSet(i3,"BackgroundColor3",c3(1,1,1))
insSet(i3,"BorderSizePixel",0)
insSet(i3,"Position",u2(0,5,0,guiTheme.windowMinimizedSize.Y-2))
insSet(i3,"Size",u2(1,-10,0,guiTheme.windowRegularSize.Y-guiTheme.windowMinimizedSize.Y-3))
insSet(i3,"Name",rs())
insSet(i3,"Parent",i2)
insSet(i4,"Active",true)
insSet(i4,"BackgroundTransparency",1)
insSet(i4,"BorderSizePixel",0)
insSet(i4,"Size",u2(1,-3,1,0))
insSet(i4,"AutomaticCanvasSize",e.AutomaticSize.Y)
insSet(i4,"CanvasSize",u2(0,0,0,0))
insSet(i4,"ScrollBarThickness",7)
insSet(i4,"Name",rs())
insSet(i4,"Parent",i3)
insSet(i5,"Name",rs())
insSet(i5,"Parent",i4)
insSet(i5,"SortOrder",e.SortOrder.LayoutOrder)
insSet(i6,"Name",rs())
insSet(i6,"Parent",i3)
insSet(i6,"Color",cs({csk(0,guiTheme.listTopColor),csk(1,guiTheme.listBottomColor)}))
insSet(i6,"Rotation",90)
insSet(i7,"Font",e.Font.SourceSans)
insSet(i7,"FontSize",e.FontSize.Size18)
insSet(i7,"ClearTextOnFocus",false)
insSet(i7,"Text",guiTheme.guiTitle)
insSet(i7,"TextColor3",guiTheme.windowTitleColor)
insSet(i7,"TextSize",16)
insSet(i7,"AnchorPoint",v2(0.5,0))
insSet(i7,"BackgroundTransparency",1)
insSet(i7,"Position",u2(0.5,0,0,guiTheme.windowMinimizedSize.Y/2))
insSet(i7,"Name",rs())
insSet(i7,"Parent",i2)
insSet(i8,"AnchorPoint",v2(1,0))
insSet(i8,"BackgroundTransparency",1)
insSet(i8,"Position",u2(1,0,0,0))
insSet(i8,"Size",u2(0,40,0,guiTheme.windowMinimizedSize.Y))
insSet(i8,"Name",rs())
insSet(i8,"Parent",i2)
insSet(i8,"Font",e.Font.SourceSans)
insSet(i8,"FontSize",e.FontSize.Size18)
insSet(i8,"Text","-")
insSet(i8,"TextColor3",c3(1,1,1))
insSet(i8,"TextSize",16)
insSet(i9,"Name",rs())
insSet(i9,"Parent",i2)
insSet(i9,"Color",cs({csk(0,guiTheme.windowTopColor),csk(1,guiTheme.windowBottomColor)}))
insSet(i9,"Rotation",90)
insSet(i10,"ZIndexBehavior",e.ZIndexBehavior.Sibling)
insSet(i10,"IgnoreGuiInset",true)
insSet(i10,"ResetOnSpawn",false)
insSet(i10,"DisplayOrder",2147483647)
insSet(i10,"Name",rs())
local guimin=false
local minloop=false
local i1X=guiTheme.windowRegularSize.X
local i1Y=guiTheme.windowRegularSize.Y
local i1Xdest=i1X
local i1Ydest=i1Y
Connect(insGet(i8,"MouseButton1Click"),function()
	guimin=not guimin
	if guimin then
		i1Xdest=guiTheme.windowMinimizedSize.X
		i1Ydest=guiTheme.windowMinimizedSize.Y
	else
		i1Xdest=guiTheme.windowRegularSize.X
		i1Ydest=guiTheme.windowRegularSize.Y
	end
	if minloop then
		return
	end
	minloop=true
	insSet(i3,"Visible",true) 
	sine=osclock()
	local lastsine=sine
	while true do
		sine=osclock()
		local deltaTime=(sine-lastsine)*10
		lastsine=sine
		local difX=i1Xdest-i1X
		local difY=i1Ydest-i1Y
		if (abs(difY)<=1) and (abs(difX)<=1) then
			i1X=i1Xdest
			i1Y=i1Ydest
			insSet(i1,"Size",u2(0,i1X,0,i1Y))
			insSet(i3,"Visible",not guimin) 
			minloop=false
			return
		end
		i1X=i1X+difX*deltaTime
		i1Y=i1Y+difY*deltaTime
		insSet(i1,"Size",u2(0,i1X,0,i1Y))
		twait()
	end
	insSet(i3,"Visible",not guimin) 
	minloop=false
end)
local Draggable=function(window,obj)
	local MB1enum=e.UserInputType.MouseButton1
	local TOUCHenum=e.UserInputType.Touch
	obj=obj or window
	local activeEntered=0
	local mouseStart=nil
	local dragStart=nil
	local inputbegancon=nil
	local rendersteppedcon=nil
	local inputendedcon=nil
	local inputendedf=function(a)
		a=insGet(a,"UserInputType")
		if (a==MB1enum) or (a==TOUCHenum) then
			Disconnect(rendersteppedcon)
			Disconnect(inputendedcon)
		end
	end
	local rendersteppedf=function()
		local off=GetMouseLocation(uis)-mouseStart
		insSet(window,"Position",dragStart+u2(0,v2Get(off,"X"),0,v2Get(off,"Y")))
	end
	local inputbeganf=function(a)
		a=insGet(a,"UserInputType")
		if ((a==MB1enum) or (a==TOUCHenum)) and (activeEntered==0) and not GetFocusedTextBox(uis) then
			mouseStart=GetMouseLocation(uis)
			dragStart=insGet(window,"Position")
			if rendersteppedcon then Disconnect(rendersteppedcon) end
			rendersteppedcon=Connect(renderstepped,rendersteppedf)
			if inputendedcon then Disconnect(inputendedcon) end
			inputendedcon=Connect(insGet(uis,"InputEnded"),inputendedf)
		end
	end
	Connect(insGet(obj,"MouseEnter"),function()
		if inputbegancon then Disconnect(inputbegancon) end
		inputbegancon=Connect(insGet(uis,"InputBegan"),inputbeganf)
	end)
	Connect(insGet(obj,"MouseLeave"),function()
		Disconnect(inputbegancon)
	end)
	local ondes=function(d)
		if IsA(d,"GuiObject") then
			local thisEntered=false
			local thisAdded=false
			local con0=Connect(insGet(d,"MouseEnter"),function()
				thisEntered=true
				if (not thisAdded) and insGet(d,"Active") then
					activeEntered=activeEntered+1
					thisAdded=true
				end
			end)
			local con1=Connect(insGet(d,"MouseLeave"),function()
				thisEntered=false
				if thisAdded then
					activeEntered=activeEntered-1
					thisAdded=false
				end
			end)
			local con2=Connect(GetPropertyChangedSignal(d,"Active"),function()
				if thisEntered then
					if thisAdded and not insGet(d,"Active") then
						activeEntered=activeEntered-1
						thisAdded=false
					elseif insGet(d,"Active") and not thisAdded then
						activeEntered=activeEntered+1
						thisAdded=true
					end
				end
			end)
			local con3=nil
			con3=Connect(insGet(d,"AncestryChanged"),function()
				if not IsDescendantOf(d,window) then
					if thisAdded then
						activeEntered=activeEntered-1
					end
					Disconnect(con0)
					Disconnect(con1)
					Disconnect(con2)
					Disconnect(con3)
				end
			end)
		end
	end
	Connect(insGet(window,"DescendantAdded"),ondes)
	for i,v in next,QueryDescendants(window,"GuiObject") do 
		ondes(v)
	end
end
local btn=function(txt,f)
	local i1=i("TextBox") 
	local i2=i("TextButton")
	insSet(i1,"Font",e.Font.SourceSans)
	insSet(i1,"FontSize",e.FontSize.Size14)
	insSet(i1,"Text",txt)
	insSet(i1,"ClearTextOnFocus",false)
	insSet(i1,"Position",u2(0.5,0,0.5,0))
	insSet(i1,"TextColor3",guiTheme.buttonsTextColor)
	insSet(i1,"Name",rs())
	insSet(i1,"Parent",i2)
	insSet(i2,"BackgroundTransparency",1)
	insSet(i2,"TextTransparency",1)
	insSet(i2,"Size",u2(1,0,0,14))
	insSet(i2,"Name",rs())
	if f then 
		Connect(insGet(i2,"MouseButton1Click"),f) 
	end 
	insSet(i2,"Parent",i4)
	return i1
end
local lbl=function(txt)
	local i1=i("TextBox") 
	local i2=i("Frame") 
	insSet(i1,"Font",e.Font.SourceSans)
	insSet(i1,"FontSize",e.FontSize.Size14)
	insSet(i1,"Text",txt)
	insSet(i1,"ClearTextOnFocus",false)
	insSet(i1,"TextColor3",guiTheme.labelsTextColor)
	insSet(i1,"Position",u2(0.5,0,0.5))
	insSet(i1,"BackgroundTransparency",1)
	insSet(i1,"Name",rs())
	insSet(i1,"Parent",i2)
	insSet(i2,"Size",u2(1,0,0,14))
	insSet(i2,"BackgroundTransparency",1)
	insSet(i2,"Name",rs())
	insSet(i2,"Parent",i4)
	return i1
end
local swtc=function(txt,options,onchanged)
	local current=0
	local swtcbtn=nil
	local btnpressed=function()
		current=current+1
		if current>#options then
			current=1
		end
		local option=options[current]
		insSet(swtcbtn,"Text",txt..": "..option.text)
		onchanged(option.value)
	end
	swtcbtn=btn(txt,btnpressed)
	btnpressed()
	return swtcbtn
end

Draggable(i1)

lbl("by rqz")
lbl("MyWorld was here")
lbl("discord.gg/QMy5f6DrbH")

local allowshiftlock=nil
local ctrltp=nil
local placeholders=nil
local clickfling=nil
local flingoffset=nil
local flingvel=nil
local flingrotvel=nil
local flingtargetting=nil
local highlightflingtargets=nil
local discharscripts=nil
local flingchangestate=nil
local respawntp=nil
local disguiscripts=nil
local breakjointsmethod=nil
local simrad=false
local hidedeatheffect=nil

local c=nil
local cons={}
local cframes={}
local hrpcon0=nil
local hrpcon1=nil
local flingtable={}
local plrcleanups={}
local onnewcamera=nil
local stopreanimate=function() 
	if c then
		c=nil
		for i,v in next,cframes do
			local p=i.v
			if p then
				Destroy(p)
			end
		end
		tclear(cframes)
		if hrpcon0 then
			Disconnect(hrpcon0)
			Disconnect(hrpcon1)
			hrpcon0=nil
		end
		for i,v in next,flingtable do
			if v then --it could be false
				Destroy(v)
			end
		end
		tclear(flingtable)
		for i,v in next,cons do
			Disconnect(v)
		end
		tclear(cons)
		for i,cleanupfunc in next,plrcleanups do
			cleanupfunc()
		end
		tclear(plrcleanups)
		insSet(uis,"MouseBehavior",enumMD)
		onnewcamera()
		return true
	end
	return false
end
local reanimate=function()
	--[[
		FDless reanimate by MyWorld continued by rqz
		optimize the optimized
	]]
	local novoid=true --prevents parts from going under workspace.FallenPartsDestroyHeight if you control them
	local speedlimit=3000 --makes your parts move slower if the magnitude of their velocity is higher than this
	local retVelTime=0.51 --time that claimed parts have velocity to reclaim in case u lose them
	local walkSpeed=16 --your walkspeed (can be changed at runtime)
	local jumpPower=50 --your jump power (can be changed at runtime)
	local gravity=196.2 --how fast the characters velocity decreases while falling (can be changed at runtime)
	local ctrlclicktp=ctrltp --makes you teleport where u point ur mouse cursor at when click and hold ctrl down

	if stopreanimate() then return end

	local cam=nil
	--theres a way to have ws.currentcamera nil on heartbeat and still have the game run normally
	local refcam=function()
		local newcam=insGet(ws,"CurrentCamera")
		while not newcam do
			Wait(GetPropertyChangedSignal(ws,"CurrentCamera"))
			newcam=insGet(ws,"CurrentCamera")
		end
		cam=newcam
	end
	refcam()
	local camcf=insGet(cam,"CFrame")
	local enumCamS=e.CameraType.Scriptable
	local camt=insGet(cam,"CameraType")
	local camcon0=nil
	local camcon1=nil
	local camcon2=nil
	onnewcamera=function()
		refcam()
		if camcon0 then 
			Disconnect(camcon0)
			Disconnect(camcon1)
			camcon0=nil
		end
		if not c then 
			if insGet(cam,"CameraType")==enumCamS then
				insSet(cam,"CameraType",camt)
			end
			return Disconnect(camcon2) 
		end
		camcon0=Connect(GetPropertyChangedSignal(cam,"CFrame"),function()
			if insGet(cam,"CFrame")~=camcf then
				insSet(cam,"CFrame",camcf)
			end
		end)
		camcon1=Connect(GetPropertyChangedSignal(cam,"CameraType"),function()
			if insGet(cam,"CameraType")~=enumCamS then
				insSet(cam,"CameraType",enumCamS)
			end
		end)
		if insGet(cam,"CameraType")~=enumCamS then
			insSet(cam,"CameraType",enumCamS)
		end
		if insGet(cam,"CFrame")~=camcf then
			insSet(cam,"CFrame",camcf)
		end
	end
	camcon2=Connect(GetPropertyChangedSignal(ws,"CurrentCamera"),onnewcamera)

	local wsGravity=insGet(ws,"Gravity")
	tinsert(cons,Connect(GetPropertyChangedSignal(ws,"Gravity"),function()
		wsGravity=insGet(ws,"Gravity")
	end))

	local fpdh=insGet(ws,"FallenPartsDestroyHeight")
	novoid=novoid and (fpdh+1)

	local cfr=nil
	c=insGet(lp,"Character")
	if c and IsDescendantOf(c,ws) then
		cfr=QueryDescendants(c,">BasePart#HumanoidRootPart")[1] or QueryDescendants(c,">BasePart#Torso")[1] or QueryDescendants(c,">BasePart#UpperTorso")[1] or FindFirstChildWhichIsA(c,"BasePart")
		if cfr then
			cfr=insGet(cfr,"CFrame")
		else
			cfr=cfMul(insGet(cam,"Focus"),cf(0,-1.5,0))
		end
	else
		c=true
		cfr=cfMul(insGet(cam,"Focus"),cf(0,-1.5,0))
	end

	onnewcamera()

	local Yvel=0
	local pos=cfGet(cfr,"Position")
	cfr=cfl(pos,pos+cfGet(cfr,"LookVector")*v3_101)
	local primarypart=nil
	local shiftlock=false
	local firstperson=false
	local xzvel=v3_0
	local v3_0150=v3_010*1.5
	local camcfLV=cfGet(camcf,"LookVector")
	local camrot=cfl(v3_0,camcfLV)
	local camrotX,camrotY=cfGet(camrot,"ToEulerAnglesYXZ")(camrot)
	local camcfRV=cfGet(camrot,"RightVector")
	local cammag=-vmagnitude((cfGet(camcf,"Position")-(pos+v3_0150)))
	
	local R6parts={ 
		head={Name="Head"},
		torso={Name="Torso"},
		root={Name="HumanoidRootPart"},
		leftArm={Name="Left Arm"},
		rightArm={Name="Right Arm"},
		leftLeg={Name="Left Leg"},
		rightLeg={Name="Right Leg"}
	}
	local rootpart=R6parts.root
	for i,v in next,R6parts do
		cframes[v]=cfr
	end
	local joints={
		{
			Name="Neck",
			Part0=R6parts.torso,Part1=R6parts.head,
			C0=cf(0,1,0,-1,0,0,0,0,1,0,1,-0),
			C1=cf(0,-0.5,0,-1,0,0,0,0,1,0,1,-0)
		},
		{
			Name="RootJoint",
			Part0=rootpart,Part1=R6parts.torso,
			C0=cf(0,0,0,-1,0,0,0,0,1,0,1,-0),
			C1=cf(0,0,0,-1,0,0,0,0,1,0,1,-0)
		},
		{
			Name="Right Shoulder",
			Part0=R6parts.torso,Part1=R6parts.rightArm,
			C0=cf(1,0.5,0,0,0,1,0,1,-0,-1,0,0),
			C1=cf(-0.5,0.5,0,0,0,1,0,1,-0,-1,0,0)
		},
		{
			Name="Left Shoulder",
			Part0=R6parts.torso,Part1=R6parts.leftArm,
			C0=cf(-1,0.5,0,0,0,-1,0,1,0,1,0,0),
			C1=cf(0.5,0.5,0,0,0,-1,0,1,0,1,0,0)
		},
		{
			Name="Right Hip",
			Part0=R6parts.torso,Part1=R6parts.rightLeg,
			C0=cf(1,-1,0,0,0,1,0,1,-0,-1,0,0),
			C1=cf(0.5,1,0,0,0,1,0,1,-0,-1,0,0)
		},
		{
			Name="Left Hip",
			Part0=R6parts.torso,Part1=R6parts.leftLeg,
			C0=cf(-1,-1,0,0,0,-1,0,1,0,1,0,0),
			C1=cf(-0.5,1,0,0,0,-1,0,1,0,1,0,0)
		}
	}

	local refreshedjoints={}
	local refreshjointsI=nil
	refreshjointsI=function(part)
		refreshedjoints[part]=true
		for i,v in next,joints do
			local part0=v.Part0
			local part1=v.Part1
			if part1 and (part0==part) then
				cframes[part1]=cfMul(cframes[part],cfMul(v.C0,Inverse(v.C1)))
				if not refreshedjoints[part1] then
					refreshjointsI(part1)
				end
			elseif part0 and (part1==part) then
				cframes[part0]=cfMul(cframes[part],cfMul(v.C1,Inverse(v.C0)))
				if not refreshedjoints[part0] then
					refreshjointsI(part0)
				end
			end
		end
	end
	refreshjointsI(rootpart)
	tclear(refreshedjoints)

	local attachments={
		RightShoulderAttachment={R6parts.rightArm,cf(0,1,0,1,0,0,0,1,0,0,0,1)},
		RightGripAttachment={R6parts.rightArm,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		LeftFootAttachment={R6parts.leftLeg,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		LeftShoulderAttachment={R6parts.leftArm,cf(0,1,0,1,0,0,0,1,0,0,0,1)},
		LeftGripAttachment={R6parts.leftArm,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		RootAttachment={rootpart,cf(0,0,0,1,0,0,0,1,0,0,0,1)},
		RightFootAttachment={R6parts.rightLeg,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		NeckAttachment={R6parts.torso,cf(0,1,0,1,0,0,0,1,0,0,0,1)},
		BodyFrontAttachment={R6parts.torso,cf(0,0,-0.5,1,0,0,0,1,0,0,0,1)},
		BodyBackAttachment={R6parts.torso,cf(0,0,0.5,1,0,0,0,1,0,0,0,1)},
		LeftCollarAttachment={R6parts.torso,cf(-1,1,0,1,0,0,0,1,0,0,0,1)},
		RightCollarAttachment={R6parts.torso,cf(1,1,0,1,0,0,0,1,0,0,0,1)},
		WaistFrontAttachment={R6parts.torso,cf(0,-1,-0.5,1,0,0,0,1,0,0,0,1)},
		WaistCenterAttachment={R6parts.torso,cf(0,-1,0,1,0,0,0,1,0,0,0,1)},
		WaistBackAttachment={R6parts.torso,cf(0,-1,0.5,1,0,0,0,1,0,0,0,1)},
		HairAttachment={R6parts.head,cf(0,0.6,0,1,0,0,0,1,0,0,0,1)},
		HatAttachment={R6parts.head,cf(0,0.6,0,1,0,0,0,1,0,0,0,1)},
		FaceFrontAttachment={R6parts.head,cf(0,0,-0.6,1,0,0,0,1,0,0,0,1)},
		FaceCenterAttachment={R6parts.head,cf(0,0,0,1,0,0,0,1,0,0,0,1)}
	}

	local getPart=function(name,blacklist)
		if blacklist then
			for i,v in next,cframes do
				if (i.Name==name) and not tfind(blacklist,i) then
					return i
				end
			end
		else
			for i,v in next,cframes do
				if i.Name==name then
					return i
				end
			end
		end
		return nil
	end

	local getJoint=function(name)
		for i,v in next,joints do
			if v.Name==name then
				return v
			end
		end
		return {C0=cf_0,C1=cf_0}
	end

	local getPartFromMesh=function(m,t,blacklist)
		if blacklist then
			for v,_ in next,cframes do
				if v.m and (not tfind(blacklist,v)) and sfind(v.m,m) and sfind(v.t,t) then
					return v
				end
			end
		else
			for v,_ in next,cframes do
				if v.m and sfind(v.m,m) and sfind(v.t,t) then
					return v
				end
			end
		end
		local p={m=m,t=t}
		cframes[p]=cfr
		local j={C0=cf_0,C1=cf_0,Part0=p}
		p.j=j
		return p
	end
	local getPartJoint=function(p)
		if cframes[p] then
			local j=p.j
			if j then
				return j
			end
			for i,v in next,joints do
				if v.Part0==p then
					return v
				end
			end
			for i,v in next,joints do
				if v.Part1==p then
					return v
				end
			end
		end
		return nil
	end

	local getAccWeldFromMesh=function(m,t)
		return getPartJoint(getPartFromMesh(m,t))
	end

	local raycastparams=rp()
	raycastparams.FilterType=e.RaycastFilterType.Exclude
	raycastparams.RespectCanCollide=true
	local rayfilter={}
	local characters={}
	local refreshrayfilter=function()
		tclear(rayfilter)
		for i,v in next,characters do
			tinsert(rayfilter,v)
		end
		raycastparams.FilterDescendantsInstances=rayfilter
	end
	local rootparts={}
	for i,v in next,aligns do
		v.p=getPart(v.PartName)
		if not v.meshid then
			v.meshid=""
		end 
		if not v.textureid then
			v.textureid=""
		end 
	end
	local makePartCons=function(p,t)
		if (t.p==p) and insGet(p,"Anchored") then
			t.p=nil
		end
		local con0=Connect(GetPropertyChangedSignal(p,"Anchored"),function()
			if insGet(p,"Anchored") then
				if t.p==p then
					t.c=nil
					t.p=nil
				end
			elseif not t.p then
				t.p=p
			end
		end)
		local con1=nil
		con1=Connect(insGet(p,"AncestryChanged"),function()
			if not IsDescendantOf(p,ws) then
				Disconnect(con0)
				Disconnect(con1)
				if t.p==p then
					t.p=nil
				end
			end
		end)
	end
	local ondes=function(v)
		if IsA(v,"Attachment") then
			local v1=attachments[insGet(v,"Name")]
			if v1 then
				local p=insGet(v,"Parent")
				if insGet(p,"Parent")~=c then
					local meshid=nil
					local textureid=nil
					if IsA(p,"MeshPart") then
						meshid=insGet(p,"MeshId")
						textureid=insGet(p,"TextureID")
					elseif IsA(p,"BasePart") then
						local sm=FindFirstChildOfClass(p,"SpecialMesh")
						if sm then
							meshid=insGet(sm,"MeshId")
							textureid=insGet(sm,"TextureId")
						else
							return
						end
					else
						return
					end
					for i,_ in next,cframes do
						if (meshid==i.m) and (textureid==i.t) then
							local p1=i.p
							if p1 then
								if p1==p then
									return
								end
							else
								i.p=p
								makePartCons(p,i)
								return
							end
						else
							local j=i.j
							if j and sfind(meshid,i.m) and sfind(textureid,i.t) then
								i.m=meshid
								i.t=textureid
								i.l=insGet(p,"Position")
								i.p=p
								makePartCons(p,i)
								i.j=nil
								i.Name=insGet(p,"Name")
								j.C0=insGet(v,"CFrame")
								j.C1=v1[2]
								j.Part1=v1[1]
								tinsert(joints,j)
								return
							end
						end
					end
					local n=insGet(insGet(p,"Parent"),"Name")
					for i,l in next,aligns do
						if l.p and sfind(meshid,l.meshid) and sfind(textureid,l.textureid) and ((not l.AccessoryName) or (l.AccessoryName==n)) then
							local t={Name=insGet(p,"Name"),l=insGet(p,"Position"),m=meshid,t=textureid,p=p}
							makePartCons(p,t)
							if placeholders then
								t.v=makeplaceholder(p)
								t.b=false
							end
							cframes[t]=insGet(p,"CFrame")
							tinsert(joints,{Part0=t,Part1=l.p,C0=l.C0 or cf_0,C1=cf_0})
							l.p=nil
							return
						end
					end
					local t={Name=insGet(p,"Name"),l=insGet(p,"Position"),m=meshid,t=textureid,p=p}
					makePartCons(p,t)
					if placeholders then
						t.v=makeplaceholder(p)
						t.b=false
					end
					cframes[t]=insGet(p,"CFrame")
					tinsert(joints,{Part0=t,Part1=v1[1],C0=insGet(v,"CFrame"),C1=v1[2]})
				end
			end
		end
	end
	
	local simradv=1000
	local enumH=e.CoreGuiType.Health
	local onplayer=function(v)
		simradv=simradv+1000
		local lastc=nil
		local con0=nil
		local con1=nil
		local oncharacter=function()
			local newc=insGet(v,"Character")
			if newc and (newc~=lastc) then
				lastc=newc

				if con0 then
					Disconnect(con0)
					Disconnect(con1)
					con0=nil
				end

				characters[v]=newc
				refreshrayfilter()

				local hrp=QueryDescendants(newc,">BasePart#HumanoidRootPart")[1]
				if hrp then
					rootparts[v]=hrp
				else
					local refresh=true					
					local threshold=false
					tdelay(0.5,function()
						refresh=true
						threshold=true
					end)
					con0=Connect(preanimation,function()
						if refresh then
							if threshold then
								hrp=QueryDescendants(newc,">BasePart#HumanoidRootPart")[1] or QueryDescendants(newc,">BasePart#Torso")[1] or QueryDescendants(newc,">BasePart#UpperTorso")[1] or FindFirstChildWhichIsA(newc,"BasePart")
							else
								hrp=QueryDescendants(newc,">BasePart#HumanoidRootPart")[1]
							end
							if hrp then
								rootparts[v]=hrp
								Disconnect(con0)
								Disconnect(con1)
								con0=nil
								return
							end
							refresh=false
						end
					end)
					con1=Connect(insGet(newc,"ChildAdded"),function()
						refresh=true
					end)
				end
			end
		end

		local charcon=Connect(GetPropertyChangedSignal(v,"Character"),oncharacter)
		oncharacter()
		plrcleanups[v]=function()
			simradv=simradv-1000
			characters[v]=nil
			rootparts[v]=nil
			if con0 then
				Disconnect(con0)
				Disconnect(con1)
				con0=nil
			end
			Disconnect(charcon)
		end
	end
	tinsert(cons,Connect(insGet(plrs,"PlayerRemoving"),function(v)
		local cleanup=plrcleanups[v]
		if cleanup then
			cleanup()
			plrcleanups[v]=nil
		end
	end))
	for i,v in next,GetPlayers(plrs) do simradv=simradv+1000 if v~=lp then tspawn(onplayer,v) end end
	tinsert(cons,Connect(insGet(plrs,"PlayerAdded"),onplayer))
	if disguiscripts then
		tinsert(cons,Connect(insGet(pg,"DescendantAdded"),function(v)
			if IsA(v,"Script") then --mind Enum.RunContext.Client
				insSet(v,"Disabled",true) 
			end
		end))
	end

	local lastc=nil
	local oncharacter=function()
		local newc=insGet(lp,"Character")
		if newc and (newc~=lastc) then
			lastc=newc

			if hrpcon0 then
				Disconnect(hrpcon0)
				Disconnect(hrpcon1)
				hrpcon0=nil
			end

			if discharscripts then
				Connect(insGet(newc,"DescendantAdded"),discharscripts)
				for i,v in next,QueryDescendants(newc,"Script") do
					insSet(v,"Disabled",true)
				end
			end

			characters[lp]=newc
			refreshrayfilter()
			
			local hrp=QueryDescendants(newc,">BasePart#HumanoidRootPart")[1]
			if not hrp then
				local refresh=true
				local threshold=false
				tdelay(0.5,function()
					refresh=true
					threshold=true
				end)
				local thread=crunning()
				hrpcon1=Connect(preanimation,function()
					if refresh then
						if threshold then
							hrp=QueryDescendants(newc,">BasePart#HumanoidRootPart")[1] or QueryDescendants(newc,">BasePart#Torso")[1] or QueryDescendants(newc,">BasePart#UpperTorso")[1] or FindFirstChildWhichIsA(newc,"BasePart")
						else
							hrp=QueryDescendants(newc,">BasePart#HumanoidRootPart")[1]
						end
						if hrp then
							Disconnect(hrpcon0)
							Disconnect(hrpcon1)
							hrpcon0=nil
							cresume(thread)
							return
						end
						refresh=false
					end
				end)
				hrpcon0=Connect(insGet(newc,"ChildAdded"),function()
					refresh=true
				end)
				cyield()
				Wait(stepped)
			end
			
			c=newc
			if next(flingtable) then
				local hum=FindFirstChildOfClass(c,"Humanoid")
				if hum then
					if flingchangestate==3 then
						ChangeState(hum,enumphysics)
						SetStateEnabled(hum,enumseated,false)
					elseif flingchangestate==1 then
						ChangeState(hum,enumphysics)
					else
						if flingchangestate==2 then
							SetStateEnabled(hum,enumseated,false)
						end
						if flingtargetting~=0 then
							ChangeState(hum,enumragdoll)
							SetStateEnabled(hum,enumrunning,false)
						end
					end
				end
				twait(0.25)
				for i1,v in next,tclone(flingtable) do
					if not c then
						return
					end
					if flingtargetting==3 then
						sethiddenproperty(hrp,"PhysicsRepRootPart",i1)
					elseif flingtargetting==2 then
						setscriptable(hrp,"PhysicsRepRootPart",true)
						insSet(hrp,"PhysicsRepRootPart",i1)
						setscriptable(hrp,"PhysicsRepRootPart",false)
					elseif flingtargetting==1 then
						local hrpcpp=insGet(hrp,"CustomPhysicalProperties")
						local tparent=insGet(i1,"Parent")
						local tcfr=insGet(i1,"CFrame")

						local model=i("Model")
						local hum=i("Humanoid",model)
						for i,v in next,humstatesbl do
							SetStateEnabled(hum,v,false)
						end

						local restorejoints={}
						for i,v in next,GetJoints(hrp) do
							restorejoints[v]=insGet(v,"Parent")
							insSet(v,"Parent",nil)
						end
						for i,v in next,GetJoints(i1) do
							restorejoints[v]=insGet(v,"Parent")
							insSet(v,"Parent",nil)
						end

						local tcfr1=cf(cfGet(tcfr,"Position")+v3_010*mrandom(10000,20000))
						insSet(i1,"Parent",ws)
						insSet(i1,"CFrame",tcfr1)
						insSet(hrp,"Parent",model)
						insSet(hrp,"CFrame",tcfr1+(insGet(hrp,"Size")+insGet(i1,"Size"))*sm)
						insSet(i1,"CustomPhysicalProperties",dense)
						insSet(hrp,"CustomPhysicalProperties",light)
						insSet(model,"Parent",ws)
						ChangeState(hum,enumrunning)
						if not insGet(i1,"CanCollide") then
							insSet(i1,"CanCollide",true)
						end
						Wait(stepped)
						for i,v in next,restorejoints do
							insSet(i,"Parent",v)
						end
						insSet(i1,"CFrame",tcfr)
						insSet(i1,"Parent",tparent)
						insSet(hrp,"CustomPhysicalProperties",hrpcpp)
						insSet(hrp,"Parent",newc)
						Destroy(model)
					end
					local startpos=insGet(i1,"Position")
					local stoptime=sine+(((flingtargetting~=0) and 0.1) or 3)
					while true do
						if insGet(i1,"Anchored") or not IsDescendantOf(i1,ws) then
							break
						end
						if vmagnitude(startpos-insGet(i1,"Position"))>200 then
							break
						end
						if flingtargetting~=0 then
							local tcf=cfAdd(insGet(i1,"CFrame"),flingoffset)
							if novoid and (cfGet(tcf,"Y")<novoid) then
								tcf=cfAdd(tcf,v3_010*(novoid-cfGet(tcf,"Y")))
							end
							insSet(hrp,"CFrame",tcf)
							insSet(hrp,"AssemblyLinearVelocity",flingvel)
						else
							local tcf=cfAdd(insGet(i1,"CFrame"),insGet(i1,"AssemblyLinearVelocity")*(sin(sine*15)+1)+flingoffset)
							if novoid and (cfGet(tcf,"Y")<novoid) then
								tcf=cfAdd(tcf,v3_010*(novoid-cfGet(tcf,"Y")))
							end
							insSet(hrp,"CFrame",tcf)
							insSet(hrp,"AssemblyLinearVelocity",insGet(i1,"AssemblyLinearVelocity")*v3_101*75)
						end
						insSet(hrp,"AssemblyAngularVelocity",flingrotvel)
						if sine>stoptime then
							break
						end
						twait()
					end
					if v then
						Destroy(v)
					end
					flingtable[i1]=nil
				end
				if flingtargetting==3 then
					sethiddenproperty(hrp,"PhysicsRepRootPart",nil)
				elseif flingtargetting==2 then
					setscriptable(hrp,"PhysicsRepRootPart",true)
					insSet(hrp,"PhysicsRepRootPart",nil)
					setscriptable(hrp,"PhysicsRepRootPart",false)
				elseif flingtargetting==1 then
					SetStateEnabled(hum,enumrunning,true)
					ChangeState(hum,enumrunning)
				end
				if respawntp==0 then
					insSet(hrp,"AssemblyLinearVelocity",v3_0)
					insSet(hrp,"AssemblyAngularVelocity",v3_0)
					insSet(hrp,"CFrame",cfr)
					twait(0.3)
				end
			end
			if respawntp==0 then
				twait()
			elseif respawntp==1 then
				local startpos=pos+v3(mrandom(-32,32),0,mrandom(-32,32))
				local dir=nil
				local poscheck=true
				while poscheck do
					poscheck=false
					for i,v in next,rootparts do
						local diff=(startpos-insGet(v,"Position"))*v3_101
						if vmagnitude(diff)<10 then
							poscheck=true
							dir=dir or (vnormalize(diff)*3)
							startpos=startpos+dir
						end
					end
					local diff=(startpos-pos)*v3_101
					if vmagnitude(diff)<10 then
						poscheck=true
						dir=dir or (vnormalize(diff)*3)
						startpos=startpos+dir
					end
				end
				startpos=cfAdd(cfGet(cfr,"Rotation"),startpos)
				insSet(hrp,"CFrame",startpos)
				insSet(hrp,"AssemblyLinearVelocity",v3_0)
				insSet(hrp,"AssemblyAngularVelocity",v3_0)
				twait(0.3)
			elseif respawntp==2 then
				insSet(hrp,"CFrame",cfAdd(cfr,cfGet(cfr,"RightVector")*3.5-cfGet(cfr,"LookVector")*3.5))
				insSet(hrp,"AssemblyLinearVelocity",v3_0)
				insSet(hrp,"AssemblyAngularVelocity",v3_0)
				twait(0.3)
			elseif respawntp==3 then
				local t=osclock()+0.3
				local startcf=cfAdd(cfMul(cfGet(cfr,"Rotation"),angles(1.5707963267948966,0,0)),pos*v3_101+v3_010*min(fpdh+30,v3Get(pos,"Y")-5))
				while twait() do
					insSet(hrp,"CFrame",startcf)
					insSet(hrp,"AssemblyLinearVelocity",v3_0)
					insSet(hrp,"AssemblyAngularVelocity",v3_0)
					if osclock()>t then
						break
					end
				end
			end
			if newc~=c then
				return
			end
			primarypart=insGet(newc,"PrimaryPart") or hrp
			if hidedeatheffect and GetCoreGuiEnabled(sg,enumH) then
				SetCoreGuiEnabled(sg,enumH,false)
			end
			if breakjointsmethod==4 then
				local h=FindFirstChildOfClass(newc,"Humanoid")
				if h then
					replicatesignal(insGet(h,"ServerBreakJoints"))
				else
					BreakJoints(newc)
				end
			elseif breakjointsmethod==1 then
				BreakJoints(newc)
				local h=FindFirstChildOfClass(newc,"Humanoid")
				if h then
					insSet(h,"Health",0)
				end
			elseif breakjointsmethod==2 then
				local h=FindFirstChildOfClass(newc,"Humanoid")
				if h then
					insSet(h,"Health",0)
				else
					BreakJoints(newc)
				end
			else
				BreakJoints(newc)
			end
			cons.ondes=Connect(insGet(newc,"DescendantAdded"),ondes)
			for i,v in next,QueryDescendants(newc,"Attachment") do
				ondes(v)
			end
		end
	end
	tinsert(cons,Connect(GetPropertyChangedSignal(lp,"Character"),oncharacter))
	oncharacter()
	
	local setsimrad=emptyfunction
	if simrad then
		setsimrad=function()
			if pcall(insSet,lp,"SimulationRadius",simradv) then
				setsimrad=function()
					insSet(lp,"SimulationRadius",simradv)
				end
			else
				setsimrad=emptyfunction
			end
		end
	end

	local mradN05=-0.008726646259971648
	local pi2=math.pi/2-0.0001
	local npi2=-pi2
	local KeyCode=e.KeyCode
	local enumYXZ=e.RotationOrder.YXZ
	local enumMB2=e.UserInputType.MouseButton2
	local enumMLCP=e.MouseBehavior.LockCurrentPosition
	local enumMLC=(insGet(uis,"TouchEnabled") and enumMLCP) or e.MouseBehavior.LockCenter 
	local enumMW=e.UserInputType.MouseWheel
	local enumMM=e.UserInputType.MouseMovement

	local mouseBehavior=insGet(uis,"MouseBehavior")
	tinsert(cons,Connect(GetPropertyChangedSignal(uis,"MouseBehavior"),function()
		if insGet(uis,"MouseBehavior")~=mouseBehavior then
			insSet(uis,"MouseBehavior",mouseBehavior)
		end
	end))

	local mode="default"
	local defaultmode={}
	local modes={default=defaultmode}

	local lerpsIdle=emptyfunction
	local lerpsWalk=emptyfunction
	local lerpsJump=emptyfunction
	local lerpsFall=emptyfunction

	local addmode=function(key,mode)
		if (type(key)~="string") or (type(mode)~="table") then
			return
		end
		for i,v in next,mode do
			if type(v)~="function" then
				mode[i]=nil
			end
		end
		if key=="default" then
			defaultmode=mode
			modes.default=mode
			lerpsIdle=mode.idle or emptyfunction
			lerpsWalk=mode.walk or emptyfunction
			lerpsJump=mode.jump or emptyfunction
			lerpsFall=mode.fall or emptyfunction
			if mode.modeEntered then
				mode.modeEntered()
			end
		elseif #key==1 then
			key=KeyCode[supper(ssub(key,1,1))]
			modes[key]=mode
		end
	end

	local keyW=KeyCode.W
	local Wpressed=IsKeyDown(uis,keyW)
	local keyA=KeyCode.A
	local Apressed=IsKeyDown(uis,keyA)
	local keyS=KeyCode.S
	local Spressed=IsKeyDown(uis,keyS)
	local keyD=KeyCode.D
	local Dpressed=IsKeyDown(uis,keyD)
	local keySpace=KeyCode.Space
	local jumpingInput=IsKeyDown(uis,keySpace)

	local FWmovement=0
	local RTmovement=0
	local isWalking=false
	local refreshKeyboardMovement=function()
		if Wpressed then if Spressed then if Dpressed then if Apressed then isWalking=false else FWmovement=0 RTmovement=1 isWalking=true end else if Apressed then FWmovement=0 RTmovement=-1 isWalking=true else isWalking=false end end else FWmovement=1 if Dpressed then if Apressed then RTmovement=0 else RTmovement=1 end else if Apressed then RTmovement=-1 else RTmovement=0 end end isWalking=true end else if Spressed then FWmovement=-1 if Dpressed then if Apressed then RTmovement=0 else RTmovement=1 end else if Apressed then RTmovement=-1 else RTmovement=0 end end isWalking=true else if Dpressed then if Apressed then isWalking=false else FWmovement=0 RTmovement=1 isWalking=true end else if Apressed then FWmovement=0 RTmovement=-1 isWalking=true else isWalking=false end end end end
	end
	refreshKeyboardMovement()

	local keyShift=KeyCode.LeftShift
	tinsert(cons,Connect(insGet(uis,"InputBegan"),function(a)
		if insGet(gs,"MenuIsOpen") or GetFocusedTextBox(uis) then
			return
		end
		a=insGet(a,"KeyCode")
		if a==keyW then
			Wpressed=true
			refreshKeyboardMovement()
		elseif a==keyA then
			Apressed=true
			refreshKeyboardMovement()
		elseif a==keyS then
			Spressed=true
			refreshKeyboardMovement()
		elseif a==keyD then
			Dpressed=true
			refreshKeyboardMovement()
		elseif a==keySpace then
			jumpingInput=true
		elseif a==keyShift then
			shiftlock=allowshiftlock and not shiftlock
		elseif modes[a] then
			local modeLeft=modes[mode].modeLeft
			if modeLeft then
				modeLeft()
			end
			if mode==a then
				mode="default"
			else
				mode=a
			end
			local modet=modes[mode]
			lerpsIdle=modet.idle or defaultmode.idle or emptyfunction
			lerpsWalk=modet.walk or defaultmode.walk or emptyfunction
			lerpsJump=modet.jump or defaultmode.jump or emptyfunction
			lerpsFall=modet.fall or defaultmode.fall or emptyfunction
			if modes[mode].modeEntered then
				modes[mode].modeEntered()
			end
		end
	end))
	tinsert(cons,Connect(insGet(uis,"InputEnded"),function(a)
		a=insGet(a,"KeyCode")
		if a==keyW then
			Wpressed=false
			refreshKeyboardMovement()
		elseif a==keyA then
			Apressed=false
			refreshKeyboardMovement()
		elseif a==keyS then
			Spressed=false
			refreshKeyboardMovement()
		elseif a==keyD then
			Dpressed=false
			refreshKeyboardMovement()
		elseif a==keySpace then
			jumpingInput=false
		end
	end))

	local thumbstickEndX=0
	local thumbstickStartY=0

	local thumbstickSizeMultiplier=0

	local jumpStartX=0
	local jumpStartY=0
	local jumpEndX=0
	local jumpEndY=0

	local thumbstickInputObject=nil
	local jumpInputObject=nil
	local cameraRotateInputObject=nil
	local cameraZoomInputObject=nil

	local thumbstickTouchStart=v3_0
	local cameraZoomInputMagnitude=0

	tinsert(cons,Connect(insGet(uis,"TouchStarted"),function(inputObject)
		if insGet(gs,"MenuIsOpen") or GetFocusedTextBox(uis) then
			return
		end

		local touchPos=insGet(inputObject,"Position")
		local touchX=v3Get(touchPos,"X")
		local touchY=v3Get(touchPos,"Y")

		if (not thumbstickInputObject) and touchX<thumbstickEndX and touchY>thumbstickStartY then
			thumbstickInputObject=inputObject
			thumbstickTouchStart=insGet(inputObject,"Position")
			isWalking=false
		elseif (not jumpInputObject) and touchY>jumpStartY and touchX>jumpStartX and touchX<jumpEndX and touchY<jumpEndY then
			jumpInputObject=inputObject
			jumpingInput=true
		elseif not cameraRotateInputObject then
			cameraRotateInputObject=inputObject
		else
			cameraZoomInputObject=inputObject
			cameraZoomInputMagnitude=vmagnitude(insGet(cameraRotateInputObject,"Position")-insGet(cameraZoomInputObject,"Position"))
		end
	end))
	tinsert(cons,Connect(insGet(uis,"TouchMoved"),function(inputObject)
		local touchPos=insGet(inputObject,"Position")
		local touchX=v3Get(touchPos,"X")
		local touchY=v3Get(touchPos,"Y")
		if inputObject==thumbstickInputObject then
			local direction=insGet(inputObject,"Position")-thumbstickTouchStart
			local directionMag=vmagnitude(direction)/thumbstickSizeMultiplier
			if directionMag>0.05 then
				isWalking=true
				direction=vnormalize(direction)*min(1,(directionMag-0.05)/0.95) 
				FWmovement=-v3Get(direction,"Y")
				RTmovement=v3Get(direction,"X")
			else
				isWalking=false
			end
		elseif inputObject==jumpInputObject then
			jumpingInput=touchY>jumpStartY and touchX>jumpStartX and touchX<jumpEndX and touchY<jumpEndY
		else
			if cameraZoomInputObject then
				local newMagnitude=vmagnitude(insGet(cameraRotateInputObject,"Position")-insGet(cameraZoomInputObject,"Position"))
				cammag=cammag+(newMagnitude-cameraZoomInputMagnitude)*0.04*(0.75-cammag/4)
				cameraZoomInputMagnitude=newMagnitude
				if cammag<0 then
					firstperson=false
				else
					cammag=0
					firstperson=true
				end
			elseif inputObject==cameraRotateInputObject then
				local rotation=GetMouseDelta(uis)
				camrotX=clamp(v2Get(rotation,"Y")*mradN05+camrotX,npi2,pi2)
				camrotY=v2Get(rotation,"X")*mradN05+camrotY
				camrot=angles(camrotX,camrotY,0,enumYXZ)
				camcfLV=cfGet(camrot,"LookVector")
				camcfRV=cfGet(camrot,"RightVector")
			end
		end
	end))
	tinsert(cons,Connect(insGet(uis,"TouchEnded"),function(inputObject)
		if inputObject==thumbstickInputObject then
			thumbstickInputObject=nil
			isWalking=false
		elseif inputObject==jumpInputObject then
			jumpInputObject=nil
			jumpingInput=false
		elseif inputObject==cameraRotateInputObject then
			cameraRotateInputObject=nil
			cameraZoomInputObject=nil
		elseif inputObject==cameraZoomInputObject then
			cameraZoomInputObject=nil
		end
	end))

	local refreshTouchRegions=function()
		local sX=insGet(mouse,"ViewSizeX")
		local sY=insGet(mouse,"ViewSizeY")
		local isSmallScreen=min(sX,sY)<=500

		sY=sY+insGet(gs,"TopbarInset").Height

		thumbstickEndX=sX*0.4
		thumbstickStartY=(sY+0)*0.333

		if isSmallScreen then
			thumbstickSizeMultiplier=35
			jumpStartX=sX-95
			jumpStartY=sY-90
			jumpEndX=jumpStartX+70
			jumpEndY=jumpStartY+70
		else
			thumbstickSizeMultiplier=60
			jumpStartX=sX-170
			jumpStartY=sY-210
			jumpEndX=jumpStartX+120
			jumpEndY=jumpStartY+120
		end
	end
	tinsert(cons,Connect(GetPropertyChangedSignal(mouse,"ViewSizeX"),refreshTouchRegions))
	tinsert(cons,Connect(GetPropertyChangedSignal(mouse,"ViewSizeY"),refreshTouchRegions))
	tinsert(cons,Connect(GetPropertyChangedSignal(gs,"TopbarInset"),refreshTouchRegions))
	refreshTouchRegions()

	local mouseCameraMove=false
	tinsert(cons,Connect(insGet(uis,"InputChanged"),function(a,b)
		if b then return end
		local inputType=insGet(a,"UserInputType")
		if mouseCameraMove and inputType==enumMM then
			local rotation=GetMouseDelta(uis)
			camrotX=clamp(v2Get(rotation,"Y")*mradN05+camrotX,npi2,pi2)
			camrotY=v2Get(rotation,"X")*mradN05+camrotY
			camrot=angles(camrotX,camrotY,0,enumYXZ)
			camcfLV=cfGet(camrot,"LookVector")
			camcfRV=cfGet(camrot,"RightVector")
		elseif inputType==enumMW then
			cammag=cammag+v3Get(insGet(a,"Position"),"Z")*(0.75-cammag/4)
			if cammag<0 then
				firstperson=false
			else
				cammag=0
				firstperson=true
			end
		end
	end))

	local fling=function(target)
		if typeof(target)~="Instance" then 
			target=insGet(mouse,"Target")
			if not target then
				return false
			end
		end
		if not IsDescendantOf(target,ws) then
			return false
		end
		if IsA(target,"BasePart") or IsA(target,"Humanoid") then 
			target=insGet(target,"Parent") 
			if IsA(target,"Accoutrement") then
				target=insGet(target,"Parent")
			end
		end
		if (not IsA(target,"Model")) or (target==c) then
			return false
		end
		local targetpart=QueryDescendants(target,">BasePart#Torso")[1] or QueryDescendants(target,">BasePart#UpperTorso")[1]
		if (not targetpart) or (flingtable[targetpart]~=nil) then
			return false
		end
		if highlightflingtargets then
			local h=i("Highlight")
			insSet(h,"Name",rs())
			insSet(h,"Adornee",target)
			insSet(h,"OutlineColor",c3(1,0,0))
			insSet(h,"Parent",i10)
			flingtable[targetpart]=h
		else
			flingtable[targetpart]=false
		end
		return true
	end

	if ctrlclicktp then
		ctrlclicktp=KeyCode.LeftControl
		local tpoff=v3_010*3
		if clickfling then
			tinsert(cons,Connect(insGet(mouse,"Button1Down"),function()
				if insGet(mouse,"Target") then
					if IsKeyDown(uis,ctrlclicktp) then
						pos=cfGet(insGet(mouse,"Hit"),"Position")+tpoff
						cfr=cfl(pos,pos+camcfLV*v3_101)
						xzvel=v3_0
						Yvel=0
					else
						fling()
					end
				end
			end))
		else
			tinsert(cons,Connect(insGet(mouse,"Button1Down"),function()
				if insGet(mouse,"Target") and IsKeyDown(uis,ctrlclicktp) then
					pos=cfGet(insGet(mouse,"Hit"),"Position")+tpoff
					cfr=cfl(pos,pos+camcfLV*v3_101)
					xzvel=v3_0
					Yvel=0
				end
			end))
		end
	elseif clickfling then
		tinsert(cons,Connect(insGet(mouse,"Button1Down"),fling))
	end

	local hhOff=3
	local hhOff1=3.01
	local setHipHeight=function(n)
		hhOff=n+3
		hhOff1=n+3.01
	end

	local noYvelTime=1
	local lastsine=sine
	local mainFunction=function()
		sine=osclock()
		local delta=sine-lastsine
		deltaTime=min(delta*10,1)
		lastsine=sine

		if shiftlock then
			if allowshiftlock then
				if mouseBehavior~=enumMLC then
					mouseBehavior=enumMLC
					insSet(uis,"MouseBehavior",mouseBehavior)
				end
				mouseCameraMove=true
			else
				shiftlock=false
			end
		elseif firstperson then
			if mouseBehavior~=enumMLC then
				mouseBehavior=enumMLC
				insSet(uis,"MouseBehavior",mouseBehavior)
			end
			mouseCameraMove=true
		elseif IsMouseButtonPressed(uis,enumMB2) then
			if mouseBehavior~=enumMLCP then
				mouseBehavior=enumMLCP
				insSet(uis,"MouseBehavior",mouseBehavior)
			end
			mouseCameraMove=true
		else
			if mouseBehavior~=enumMD then
				mouseBehavior=enumMD
				insSet(uis,"MouseBehavior",mouseBehavior)
			end
			mouseCameraMove=false
		end

		local raycastresult=Raycast(ws,pos,v3_010*(fpdh-v3Get(pos,"Y")),raycastparams)
		local onground=nil
		if raycastresult then
			onground=raycastresult.Distance<hhOff1
			if onground then
				Yvel=0
				pos=pos+v3_010*(v3Get(raycastresult.Position,"Y")+hhOff-v3Get(pos,"Y"))*min(delta*20,1)
				if jumpingInput and (jumpPower>0) then
					Yvel=jumpPower
					onground=false
				end
			else
				Yvel=Yvel-gravity*delta
				raycastresult=v3Get(raycastresult.Position,"Y")
				if v3Get(pos,"Y")+Yvel*delta<raycastresult then
					Yvel=0
					pos=pos+v3_010*(raycastresult+hhOff-v3Get(pos,"Y"))
				end
			end
		else
			Yvel=0
			onground=false
		end

		if firstperson then
			if isWalking then
				if walkSpeed==0 then
					xzvel=v3_0
					if onground then
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsIdle()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+v3_010*Yvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+v3_010*Yvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				else
					xzvel=vnormalize(vnormalize(camcfLV*v3_101)*FWmovement+vnormalize(camcfRV*v3_101)*RTmovement)*walkSpeed
					if onground then
						pos=pos+xzvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsWalk()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+(xzvel+v3_010*Yvel)*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else 
						pos=pos+(xzvel+v3_010*Yvel)*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				end
			else
				xzvel=v3_0
				if onground then
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsIdle()
					noYvelTime=min(noYvelTime+delta*0.3,1)
					xzvel=xzvel*(1-noYvelTime)
				elseif Yvel>0 then
					pos=pos+v3_010*Yvel*delta
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsJump()
					noYvelTime=0
				else
					pos=pos+v3_010*Yvel*delta
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsFall()
					noYvelTime=0
				end
			end
		elseif shiftlock then	
			if isWalking then
				if walkSpeed==0 then
					xzvel=v3_0
					if onground then
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsIdle()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+v3_010*Yvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+v3_010*Yvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				else
					xzvel=vnormalize(vnormalize(camcfLV*v3_101)*FWmovement+vnormalize(camcfRV*v3_101)*RTmovement)*walkSpeed
					if onground then
						pos=pos+xzvel*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsWalk()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+(xzvel+v3_010*Yvel)*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+(xzvel+v3_010*Yvel)*delta
						cfr=cfl(pos,pos+camcfLV*v3_101)
						camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				end
			else
				xzvel=v3_0
				if onground then
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsIdle()
					noYvelTime=min(noYvelTime+delta*0.3,1)
					xzvel=xzvel*(1-noYvelTime)
				elseif Yvel>0 then
					pos=pos+v3_010*Yvel*delta
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsJump()
					noYvelTime=0
				else
					pos=pos+v3_010*Yvel*delta
					cfr=cfl(pos,pos+camcfLV*v3_101)
					camcf=cfAdd(camrot,pos+v3_0150+camcfRV*1.75+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsFall()
					noYvelTime=0
				end
			end
		else
			if isWalking then
				if walkSpeed==0 then
					xzvel=v3_0
					if onground then
						cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsIdle()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+v3_010*Yvel*delta
						cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+v3_010*Yvel*delta
						cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				else
					xzvel=vnormalize(vnormalize(camcfLV*v3_101)*FWmovement+vnormalize(camcfRV*v3_101)*RTmovement)*walkSpeed
					if onground then
						pos=pos+xzvel*delta
						cfr=cfAdd(Lerp(cfGet(cfr,"Rotation"),cfl(v3_0,xzvel),deltaTime),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsWalk()
						noYvelTime=min(noYvelTime+delta*0.3,1)
						xzvel=xzvel*(1-noYvelTime)
					elseif Yvel>0 then
						pos=pos+(xzvel+(v3_010*Yvel))*delta
						cfr=cfAdd(Lerp(cfGet(cfr,"Rotation"),cfl(v3_0,xzvel),deltaTime),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsJump()
						noYvelTime=0
					else
						pos=pos+(xzvel+(v3_010*Yvel))*delta
						cfr=cfAdd(Lerp(cfGet(cfr,"Rotation"),cfl(v3_0,xzvel),deltaTime),pos)
						camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
						cframes[rootpart]=cfr
						insSet(cam,"CFrame",camcf)
						lerpsFall()
						noYvelTime=0
					end
				end
			else
				xzvel=v3_0
				if onground then
					cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
					camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsIdle()
					noYvelTime=min(noYvelTime+delta*0.3,1)
					xzvel=xzvel*(1-noYvelTime)
				elseif Yvel>0 then
					pos=pos+v3_010*Yvel*delta
					cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
					camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsJump()
					noYvelTime=0
				else
					pos=pos+v3_010*Yvel*delta
					cfr=cfAdd(cfGet(cfr,"Rotation"),pos)
					camcf=cfAdd(camrot,pos+v3_0150+camcfLV*cammag)
					cframes[rootpart]=cfr
					insSet(cam,"CFrame",camcf)
					lerpsFall()
					noYvelTime=0
				end
			end
		end

		refreshjointsI(rootpart)
		tclear(refreshedjoints)

		local sine15=sine*15
		local idlerv=v3(sin(sine15),sin(sine15+1.0471975511965976),sin(sine15+2.0943951023931953))
		local idleoff=idlerv*0.003910064697265625 --0.0156402587890625/4

		local claimpos=insGet(primarypart,"Position")
		for i,v in next,cframes do
			local part=i.p

			if part then
				if (insGet(part,"ReceiveAge")==0) and not GetJoints(part)[1] then
					local placeholder=i.v
					local vpos=cfGet(v,"Position")
					if novoid and (v3Get(vpos,"Y")<novoid) then
						v=cfAdd(v,v3_010*(novoid-v3Get(vpos,"Y")))
					end
					local lastpos=i.l
					local vel=(vpos-lastpos)/delta
					local mag=vmagnitude(vel)
					if mag<0.11730194091796875 then --0.0156402587890625*15/2
						if placeholder and i.b then
							insSet(placeholder,"Parent",nil)
							i.b=false
						end
						i.l=cfGet(v,"Position")
						v=cfAdd(v,idleoff)
					elseif mag>speedlimit then
						if placeholder then
							insSet(placeholder,"CFrame",v)
							if not i.b then
								insSet(placeholder,"Parent",ws)
								i.b=true
							end
						end
						vel=vnormalize(vel)*speedlimit
						local newpos=lastpos+vel*delta
						v=cfAdd(cfGet(v,"Rotation"),newpos)
						i.l=newpos
					else
						if placeholder and i.b then
							insSet(placeholder,"Parent",nil)
							i.b=false
						end
						i.l=cfGet(v,"Position")
					end
					local claimtime=i.c
					if claimtime then
						if (sine-claimtime)<retVelTime then
							local offsetToPrimaryPart=claimpos-cfGet(v,"Position")
							local a=625.5001+wsGravity*-2*v3Get(offsetToPrimaryPart,"Y")
							if a>0 then --part can reach primary part
								insSet(part,"AssemblyLinearVelocity",v3_net+offsetToPrimaryPart*v3_101/((25.01+sqrt(a))/wsGravity))
							else --part cant reach primary part so at least aim for closest point
								insSet(part,"AssemblyLinearVelocity",v3_net+offsetToPrimaryPart*v3_101/(30.010999900019996/wsGravity))
							end
						else
							local vel1=vel*noYvelTime+xzvel
							if vmagnitude(vel1)>25.01 then
								insSet(part,"AssemblyLinearVelocity",vnormalize(vel1)*v3_xzL+v3_net)
							else
								insSet(part,"AssemblyLinearVelocity",vel1*v3_xz+v3_net)
							end
						end
					else
						i.c=sine
						local vel1=vel*noYvelTime+xzvel
						if vmagnitude(vel1)>25.01 then
							insSet(part,"AssemblyLinearVelocity",vnormalize(vel1)*v3_xzL+v3_net)
						else
							insSet(part,"AssemblyLinearVelocity",vel1*v3_xz+v3_net)
						end
					end
					insSet(part,"CFrame",v)
					insSet(part,"AssemblyAngularVelocity",idlerv)
				else
					i.c=nil
					i.l=insGet(part,"Position")
					local placeholder=i.v
					if placeholder then
						insSet(placeholder,"CFrame",v)
						if not i.b then
							insSet(placeholder,"Parent",ws)
							i.b=true
						end
					end
				end
			else
				local placeholder=i.v
				if placeholder then
					insSet(placeholder,"CFrame",v)
					if not i.b then
						insSet(placeholder,"Parent",ws)
						i.b=true
					end
				end
			end
		end

		setsimrad()
	end

	sine=osclock()
	lastsine=sine
	tinsert(cons,Connect(heartbeat,mainFunction))
	mainFunction()

	local refreshjoints=function(v) --use this on the main part if u have parts that
		refreshjointsI(v) --are connected with each other but arent connected to rootpart
		tclear(refreshedjoints)
	end

	local legcfR=cf(1,-1,0)
	local legcfL=cf(-1,-1,0)
	local raydir=v3_010*-2
	local raycastlegs=function() --this returns 2 values: right leg raycast offset, left leg raycast offset
		local rY=Raycast(ws,cfGet(cfMul(cfr,legcfR),"Position"),raydir,raycastparams)
		local lY=Raycast(ws,cfGet(cfMul(cfr,legcfL),"Position"),raydir,raycastparams)
		if rY then
			if lY then
				return v3Get(rY.Position,"Y")-(v3Get(pos,"Y")-3),v3Get(lY.Position,"Y")-(v3Get(pos,"Y")-3)
			else
				return v3Get(rY.Position,"Y")-(v3Get(pos,"Y")-3),0
			end
		elseif lY then
			return 0,v3Get(lY.Position,"Y")-(v3Get(pos,"Y")-3)
		else
			return 0,0
		end
	end

	local velbycfrvec=function() --this returns 2 values: forward/backwards movement (from -1 to 1), right/left movement (from -1 to 1)
		local fw=cfGet(cfr,"LookVector")*xzvel/walkSpeed
		local rt=cfGet(cfr,"RightVector")*xzvel/walkSpeed
		return v3Get(fw,"X")+v3Get(fw,"Z"),v3Get(rt,"X")+v3Get(rt,"Z")
	end

	local lastvel=v3_0
	local velchg1=v3_0
	local velchgbycfrvec=function() --this returns 2 values: forward/backwards velocity change, right/left velocity change
		velchg1=velchg1+(lastvel-xzvel) --i recommend setting velchg1 to v3_0 when u start using this function or it will look worse
		lastvel=xzvel
		velchg1=velchg1-velchg1*(deltaTime/2)
		local fw=cfGet(cfr,"LookVector")*velchg1/32
		local rt=cfGet(cfr,"RightVector")*velchg1/32
		return v3Get(fw,"X")+v3Get(fw,"Z"),v3Get(rt,"X")+v3Get(rt,"Z")
	end

	local lastYvel=0
	local velYchg1=0
	local velYchg=function() --this returns Y axis velocity change
		velYchg1=clamp(velYchg1+(lastYvel-Yvel),-50,50) --i recommend setting velYchg1 to 0 when u start using this function or it will look worse
		lastYvel=Yvel
		velYchg1=velYchg1-velYchg1*(deltaTime/2)
		return velYchg1
	end

	local rotToMouse=function(alpha) --this rotates ur character towards your mouse hit position
		local pos1=pos*v3_010+cfGet(insGet(mouse,"Hit"),"Position")*v3_101
		if pos~=pos1 then --could make nan rotation
			cfr=Lerp(cfr,cfl(pos,pos1),alpha or deltaTime)
		end
	end

	local glitchJoint=function(joint,targetGlitchTime,delayFrom,delayTo,radiansFrom,radiansTo) 
		if sine>targetGlitchTime then --example usage: local glitchtime=0 addMode("x",{idle=function() glitchtime=glitchJoint(joint,glitchtime,0.2,0.4,-0.1,0.1) end})
			radiansFrom=radiansFrom*100
			radiansTo=radiansTo*100
			joint.C0=cfMul(joint.C0,angles(mrandom(radiansFrom,radiansTo)/100,mrandom(radiansFrom,radiansTo)/100,mrandom(radiansFrom,radiansTo)/100)) 
			return sine+mrandom(delayFrom*100,delayTo*100)/100
		end
		return targetGlitchTime
	end

	local setWalkSpeed=function(n)
		if type(n)~="number" then
			n=16
		end
		walkSpeed=n
	end
	local setJumpPower=function(n)
		if type(n)~="number" then
			n=50
		end
		jumpPower=n
	end
	local setGravity=function(n)
		if type(n)~="number" then
			n=196.2
		end
		gravity=n
	end
	local setCfr=function(v) --sets character cframe
		if typeof(v)=="CFrame" then
			local newpos=cfGet(v,"Position")
			camcf=cfAdd(camcf,newpos-pos)
			insSet(cam,"CFrame",camcf)
			cfr=v
			pos=newpos
		elseif typeof(v)=="Vector3" then
			camcf=cfAdd(camcf,v-pos)
			insSet(cam,"CFrame",camcf)
			cfr=cfAdd(cfGet(cfr,"Rotation"),v)
			pos=v
		end
	end
	local getVel=function() --returns character velocity
		return xzvel+v3_010*Yvel --important: use only in lerps or it might not work
	end
	local getCamCF=function() --returns camera cframe
		return camcf
	end
	local isFirstPerson=function() --returns true if user is in first person camera mode
		return firstperson
	end

	return {
		cframes=cframes,
		joints=joints,
		fling=fling,
		refreshjoints=refreshjoints,
		raycastlegs=raycastlegs,
		velbycfrvec=velbycfrvec,
		velchgbycfrvec=velchgbycfrvec,
		velYchg=velYchg,
		addmode=addmode,
		getPart=getPart,
		getPartFromMesh=getPartFromMesh,
		getAccWeldFromMesh=getAccWeldFromMesh,
		getJoint=getJoint,
		getPartJoint=getPartJoint,
		rotToMouse=rotToMouse,
		glitchJoint=glitchJoint,
		setWalkSpeed=setWalkSpeed,
		setJumpPower=setJumpPower,
		setGravity=setGravity,
		setCfr=setCfr,
		getVel=getVel,
		getCamCF=getCamCF,
		isFirstPerson=isFirstPerson,
		setHipHeight=setHipHeight
	}
end

btn("creepy crawler",function()
	local t=reanimate()
	if type(t)~="table" then return end
	local getJoint=t.getJoint
	local rootJoint=getJoint("RootJoint")
	local rightShoulder=getJoint("Right Shoulder")
	local leftShoulder=getJoint("Left Shoulder")
	local rightHip=getJoint("Right Hip")
	local leftHip=getJoint("Left Hip")
	local neck=getJoint("Neck")

	t.setWalkSpeed(10)

	local jumplerp=function()
		neck.C0 = Lerp(neck.C0,cfMul(cf(0,0,0.5), angles(0,0,3.141592653589793)),deltaTime) 
		rootJoint.C0 = Lerp(rootJoint.C0,cfMul(cf(0,-1.4,0), angles(3.141592653589793,0,-3.141592653589793)),deltaTime) 
		leftShoulder.C0 = Lerp(leftShoulder.C0,cfMul(cf(-1,1.5,0.3), angles(1.7453292519943295,0,-0.17453292519943295)),deltaTime) 
		rightShoulder.C0 = Lerp(rightShoulder.C0,cfMul(cf(1,1.5,0.3), angles(1.7453292519943295,0,0.17453292519943295)),deltaTime) 
		leftHip.C0 = Lerp(leftHip.C0,cfMul(cf(-1,-1.5,0.8), angles(1.3962634015954636,0,-0.17453292519943295)),deltaTime) 
		rightHip.C0 = Lerp(rightHip.C0,cfMul(cf(1,-1.5,0.8), angles(1.3962634015954636,0,0.17453292519943295)),deltaTime)
	end

	t.addmode("default",{
		idle=function()
			local sine=sine*60
			neck.C0 = Lerp(neck.C0,cfMul(cf(0,0,0.5), angles(0.08726646259971647 * sin((sine + 20) * 0.05),0,3.141592653589793 + 0.3490658503988659 * sin((sine + -30) * 0.025))),deltaTime) 
			rootJoint.C0 = Lerp(rootJoint.C0,cfMul(cf(0,-1.5 + 0.1 * sin(sine * 0.05),0), angles(3.141592653589793,0,-3.1590459461097367 + 0.05235987755982989 * sin(sine * 0.025))),deltaTime) 
			leftShoulder.C0 = Lerp(leftShoulder.C0,cfMul(cf(-1,1.5,-0.1 * sin(sine * 0.05)), angles(1.5707963267948966,0,0.08726646259971647 * sin(sine * 0.025))),deltaTime) 
			rightShoulder.C0 = Lerp(rightShoulder.C0,cfMul(cf(1,1.5,-0.1 * sin(sine * 0.05)), angles(1.5707963267948966,0,0.08726646259971647 * sin(sine * 0.025))),deltaTime) 
			leftHip.C0 = Lerp(leftHip.C0,cfMul(cf(-1,-1.5,0.5 + -0.1 * sin((sine + 10) * 0.05)), angles(1.5707963267948966,0,0.08726646259971647 * sin(sine * 0.025))),deltaTime) 
			rightHip.C0 = Lerp(rightHip.C0,cfMul(cf(1,-1.5,0.5 + -0.1 * sin((sine + 10) * 0.05)), angles(1.5707963267948966,0,0.08726646259971647 * sin(sine * 0.025))),deltaTime) 
		end,
		walk=function()
			local sine=sine*60
			neck.C0 = Lerp(neck.C0,cfMul(cf(0,0,0.5), angles(0.17453292519943295,0.03490658503988659 * sin((sine + 2.5) * 0.2),3.141592653589793 + -0.17453292519943295 * sin((sine + -10) * 0.2))),deltaTime) 
			rootJoint.C0 = Lerp(rootJoint.C0,cfMul(cf(0,-1.5,0), angles(3.0543261909900767,0.08726646259971647 * sin((sine + 7.5) * 0.2),-3.1590459461097367 + -0.08726646259971647 * sin(sine * 0.2))),deltaTime) 
			leftShoulder.C0 = Lerp(leftShoulder.C0,cfMul(cf(-1,1.5 + 0.5 * sin((sine + 10) * 0.2),0.3 + 0.2 * sin((sine + -10) * 0.2)), angles(1.6580627893946132 + 0.17453292519943295 * sin((sine + 15) * 0.2),0,-0.08726646259971647 * sin(sine * 0.2))),deltaTime) 
			rightShoulder.C0 = Lerp(rightShoulder.C0,cfMul(cf(1,1.5 + 0.5 * sin((sine + -7.5) * 0.2),0.3 + 0.2 * sin((sine + 5) * 0.2)), angles(1.6580627893946132 + 0.17453292519943295 * sin(sine * 0.2),0,-0.08726646259971647 * sin(sine * 0.2))),deltaTime) 
			leftHip.C0 = Lerp(leftHip.C0,cfMul(cf(-1,-1.5 + 0.5 * sin((sine + -7.5) * 0.2),0.5 + 0.2 * sin((sine + 5) * 0.2)), angles(1.6580627893946132 + 0.17453292519943295 * sin(sine * 0.2),0,-0.08726646259971647 * sin(sine * 0.2))),deltaTime) 
			rightHip.C0 = Lerp(rightHip.C0,cfMul(cf(1,-1.5 + 0.5 * sin((sine + 10) * 0.2),0.5 + 0.2 * sin((sine + -7.5) * 0.2)), angles(1.6580627893946132 + -0.17453292519943295 * sin(sine * 0.2),0,-0.08726646259971647 * sin(sine * 0.2))),deltaTime) 
		end,
		jump=jumplerp,
		fall=jumplerp
	})
end)

btn("nameless animations V8", function()
	local t=reanimate()
	if type(t)~="table" then return end
	local raycastlegs=t.raycastlegs
	local velbycfrvec=t.velbycfrvec
	local addmode=t.addmode
	local getJoint=t.getJoint
	local velYchg=t.velYchg
	local setWalkSpeed=t.setWalkSpeed
	local RootJoint=getJoint("RootJoint")
	local RightShoulder=getJoint("Right Shoulder")
	local LeftShoulder=getJoint("Left Shoulder")
	local RightHip=getJoint("Right Hip")
	local LeftHip=getJoint("Left Hip")
	local Neck=getJoint("Neck")

	addmode("default", {
		idle = function()
			local rY, lY = raycastlegs()

			local Ychg=velYchg()/20

			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.5+0.1*sin((sine - 1)*1.3),0.05 * sin((sine-0.3)*1.3)),angles(0.5235987755982988+0.08726646259971647*sin(sine*1),-1.4835298641951802+0.10471975511965978*sin(sine*1.3),0.5235987755982988)),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.5+0.1*sin((sine - 1)*1.3),0.05 * sin((sine-0.3)*1.3)),angles(0.5235987755982988+0.08726646259971647*sin(sine*1),1.4835298641951802-0.10471975511965978*sin(sine*1.3),-0.5235987755982988)),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1.09-0.1*sin(sine*1.3)+lY-Ychg,lY*-0.5),angles(-0.026179938779914945*sin(sine*1.3),-1.3962634015954636,0)),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1.09-0.1*sin(sine*1.3)+rY-Ychg,rY*-0.5),angles(-0.026179938779914945*sin(sine*1.3),1.3962634015954636,0)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,0.09+0.1*sin(sine*1.3) + Ychg,0.025 * sin(sine*1.3)),angles(-1.5707963267948966+0.026179938779914945*sin(sine*1.3),0,3.141592653589793)),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.53588974175501-0.026179938779914945*sin((sine+1)*1.3),0.05235987755982989*sin((sine-0.6)*0.65),3.141592653589793)),deltaTime) 
			--MW_animatorProgressSave: LeftArm,-1,0,0,1,30,5,0,1,0.5,0.1,-1,1.3,-85,6,0,1.3,0,0.05,-0.3,1.3,30,0,0,1,RightArm,1,0,0,1,30,5,0,1,0.5,0.1,-1,1.3,85,-6,0,1.3,0,0.05,-0.3,1.3,-30,0,0,1,LeftLeg,-1,0,0,1,-0,-1.5,0,1.3,-1.09,-0.1,0,1.3,-80,0,0,1,0,0,0,1,0,0,0,1,CPlusPlusTextbook_Handle,8.658389560878277e-09,0,0,1,0,0,0,1,-0.25,0,0,1,0,0,0,1,-0.0002722442150115967,0,0,1,0,0,0,1,RightLeg,1,0,0,1,0,-1.5,0,1.3,-1.09,-0.1,0,1.3,80,0,0,1,0,0,0,1,0,0,0,1,Torso,0,0,0,1,-90,1.5,0,1.3,0.09,0.1,0,1.3,-0,0,0,1,0,0.025,0,1.3,180,0,0,1,Head,0,0,0,1,-88,-1.5,1,1.3,1,0,0,1,-0,3,-0.6,0.65,0,0,0,1,180,0,0,1
		end,
		walk = function()
			local Vfw, Vrt = velbycfrvec()

			local rY, lY = raycastlegs()

			local Ychg=velYchg()/20

			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.5,0),angles(-0.7853981633974483*sin((sine+0.07)*8)*Vfw,-1.5707963267948966+0.5235987755982988*sin((sine+0.15)*8),0)),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.5,0),angles(0.7853981633974483*sin((sine+0.07)*8)*Vfw,1.5707963267948966+0.5235987755982988*sin((sine+0.15)*8),0)),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1+0.3*sin((sine - 0.15)*8)+rY-Ychg,rY*-0.5),angles(1.5707963267948966-0.9599310885968813*sin(sine*8)*Vfw,1.5707963267948966-0.7853981633974483*sin(sine*8)*Vrt,-1.5707963267948966)),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1+0.3*sin((sine + 0.15)*8)+lY-Ychg,lY*-0.5),angles(1.5707963267948966+0.9599310885968813*sin(sine*8)*Vfw,-1.5707963267948966+0.7853981633974483*sin(sine*8)*Vrt,1.5707963267948966)),deltaTime) 
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.5707963267948966+0.08726646259971647*sin(sine*16),0,3.141592653589793+0.08726646259971647*sin((sine+0.04)*8)-Vrt)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,0.2 * sin((sine+0.1)*16) + Ychg,0),angles(-1.5707963267948966,0,3.141592653589793)),deltaTime) 
			--MW_animatorProgressSave: CPlusPlusTextbook_Handle,8.658389560878277e-09,0,0,8,0,0,0,8,-0.25,0,0,8,0,0,0,8,-0.0002722442150115967,0,0,8,0,0,0,8,LeftArm,-1,0,0,8,-0,-45,0.07,8,0.5,0,0,8,-90,30,0.15,8,0,0,0,8,0,0,0,8,RightArm,1,0,0,8,0,45,0.07,8,0.5,0,0,8,90,30,0.15,8,0,0,0,8,0,0,0,8,RightLeg,1,0,0,8,90,-55,0,8,-1,0.3,-0.15,8,90,-45,0,8,0,0,0,8,-90,0,0,8,LeftLeg,-1,0,0,8,90,55,0,8,-1,0.3,0.15,8,-90,45,0,8,0,0,0,8,90,0,0,8,Head,0,0,0,8,-90,5,0,16,1,0,0,8,-0,0,0,8,0,0,0,8,180,5,0.04,8,Torso,0,0,0,8,-90,0,0,8,0,0.2,0.1,16,-0,0,0,8,0,0,0,8,180,0,0,8
		end,
		jump = function()
			velYchg()
			local Vfw, Vrt = velbycfrvec()
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf_0,angles(-1.4835298641951802 + Vfw * 0.1, Vrt * -0.05, -3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(4.014257279586958 - 0.08726646259971647 * sin((sine + 0.5) * 4), 1.7453292519943295 + 0.08726646259971647 * sin((sine + 0.25) * 4), -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.5) * 4), -1.6580627893946132 + 0.06981317007977318 * sin((sine + 0.25) * 4), 1.5707963267948966)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(4.014257279586958 - 0.08726646259971647 * sin((sine + 0.5) * 4), -1.7453292519943295 - 0.08726646259971647 * sin((sine + 0.25) * 4), 1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.3962634015954636, 0, -3.141592653589793 - Vrt)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.5) * 4), 1.6580627893946132 - 0.06981317007977318 * sin((sine + 0.25) * 4), -1.5707963267948966)),deltaTime) 
			--Torso,0,0,0,4,-85,0,0,4,0,0,0,4,0,0,0,4,0,0,0,4,-180,0,0,4,RightArm,1,0,0,4,230,-5,0.5,4,0.5,0,0,4,100,5,0.25,4,0,0,0,4,-90,0,0,4,LeftLeg,-1,0,0,4,90,-5,0.5,4,-1,0,0,4,-95,4,0.25,4,0,0,0,4,90,0,0,4,LeftArm,-1,0,0,4,230,-5,0.5,4,0.5,0,0,4,-100,-5,0.25,4,0,0,0,4,90,0,0,4,Head,0,0,0,4,-80,0,0.5,4,1,0,0,4,0,0,0.25,4,0,0,0,4,-180,0,0,4,RightLeg,1,0,0,4,90,-5,0.5,4,-1,0,0,4,95,-4,0.25,4,0,0,0,4,-90,0,0,4
		end,
		fall = function()
			velYchg()
			local Vfw, Vrt = velbycfrvec()
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf_0,angles(-1.6580627893946132 + Vfw * 0.1, Vrt * -0.05, -3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(4.014257279586958 - 0.08726646259971647 * sin((sine + 0.5) * 4), 1.7453292519943295 + 0.08726646259971647 * sin((sine + 0.25) * 4), -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.5) * 4), -1.6580627893946132 + 0.06981317007977318 * sin((sine + 0.25) * 4), 1.5707963267948966)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(4.014257279586958 - 0.08726646259971647 * sin((sine + 0.5) * 4), -1.7453292519943295 - 0.08726646259971647 * sin((sine + 0.25) * 4), 1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.7453292519943295, 0, -3.141592653589793 - Vrt)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.5) * 4), 1.6580627893946132 - 0.06981317007977318 * sin((sine + 0.25) * 4), -1.5707963267948966)),deltaTime) 
			--Torso,0,0,0,4,-95,0,0,4,0,0,0,4,0,0,0,4,0,0,0,4,-180,0,0,4,RightArm,1,0,0,4,230,-5,0.5,4,0.5,0,0,4,100,5,0.25,4,0,0,0,4,-90,0,0,4,LeftLeg,-1,0,0,4,90,-5,0.5,4,-1,0,0,4,-95,4,0.25,4,0,0,0,4,90,0,0,4,LeftArm,-1,0,0,4,230,-5,0.5,4,0.5,0,0,4,-100,-5,0.25,4,0,0,0,4,90,0,0,4,Head,0,0,0,4,-100,0,0.5,4,1,0,0,4,0,0,0.25,4,0,0,0,4,-180,0,0,4,RightLeg,1,0,0,4,90,-5,0.5,4,-1,0,0,4,95,-4,0.25,4,0,0,0,4,-90,0,0,4
		end
	})

	addmode("q", {
		idle = function()
			velYchg()
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.75, -0.2),angles(2.705260340591211 - 0.08726646259971647 * sin((sine + 0.1) * 2), -2.792526803190927, -0.6981317007977318)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.75, -0.2),angles(2.705260340591211 - 0.08726646259971647 * sin((sine + 0.1) * 2), 2.792526803190927, 0.6981317007977318)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.9198621771937625 - 0.10471975511965978 * sin((sine + 0.3) * 2), 0, 3.141592653589793)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, -2.45 - 0.05 * sin(sine * 2), 0),angles(0.03490658503988659 * sin(sine * 2), 0, 3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.3962634015954636 - 0.03490658503988659 * sin(sine * 2), 1.3089969389957472, -0.9599310885968813)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.5707963267948966 - 0.03490658503988659 * sin(sine * 2), -1.3089969389957472, 1.5707963267948966)),deltaTime) 
			--LeftArm,-1,0,0,2,155,-5,0.1,2,0.75,0,0,2,-160,0,0,2,-0.2,0,0,2,-40,0,0,2,RightArm,1,0,0,2,155,-5,0.1,2,0.75,0,0,2,160,0,0,2,-0.2,0,0,2,40,0,0,2,Head,0,0,0,2,-110,-6,0.3,2,1,0,0,2,-0,0,0,2,0,0,0,2,180,0,0,2,Torso,0,0,0,2,0,2,0,2,-2.45,-0.05,0,2,-0,0,0,2,0,0,0,2,180,0,0,2,RightLeg,1,0,0,2,80,-2,0,2,-1,0,0,2,75,0,0,2,0,0,0,2,-55,0,0,2,LeftLeg,-1,0,0,2,90,-2,0,2,-1,0,0,2,-75,0,0,2,0,0,0,2,90,0,0,2
		end
	})
	addmode("e", {
		idle = function()
			velYchg()
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.9, 0.4 + 0.1 * sin(sine * 2), 0.3 - 0.15 * sin(sine * 2)),angles(-1.0471975511965976 - 0.12217304763960307 * sin(sine * 2), -1.3962634015954636, -0.6981317007977318)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, -1.85 - 0.1 * sin((sine + 0.2) * 2), 0),angles(-1.3962634015954636 + 0.03490658503988659 * sin(sine * 2), -0.08726646259971647, 3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.4 + 0.1 * sin(sine * 2), 0.2 - 0.15 * sin(sine * 2)),angles(0.6108652381980153 - 0.12217304763960307 * sin(sine * 2), 1.2217304763960306, -0.7853981633974483)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.6580627893946132 - 0.03490658503988659 * sin((sine + 0.6) * 2), 0.10471975511965978 + 0.06981317007977318 * sin(sine * 0.66), 3.141592653589793 + 0.3490658503988659 * sin(sine * 0.66))),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, 0.2 + 0.15 * sin((sine + 0.2) * 2), -0.7 + 0.1 * sin(sine * 2)),angles(1.4835298641951802 + 0.03490658503988659 * sin(sine * 2), 1.4835298641951802, -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.75 + 0.1 * sin((sine + 0.2) * 2), -0.5),angles(1.3962634015954636 - 0.03490658503988659 * sin(sine * 2), -1.6580627893946132, 0)),deltaTime) 
			--LeftArm,-0.9,0,0,2,-60,-7,0,2,0.4,0.1,0,2,-80,0,0,2,0.3,-0.15,0,2,-40,0,0,2,Torso,0,0,0,2,-80,2,0,2,-1.85,-0.1,0.2,2,-5,0,0,2,0,0,0,2,180,0,0,2,RightArm,1,0,0,2,35,-7,0,2,0.4,0.1,0,2,70,0,0,2,0.2,-0.15,0,2,-45,0,0,2,Head,0,0,0,2,-95,-2,0.6,2,1,0,0,2,6,4,0,0.66,0,0,0,2,180,20,0,0.66,RightLeg,1,0,0,2,85,2,0,2,0.2,0.15,0.2,2,85,0,0,2,-0.7,0.1,0,2,-90,0,0,2,LeftLeg,-1,0,0,2,80,-2,0,2,-0.75,0.1,0.2,2,-95,0,0,2,-0.5,0,0,2,0,0,0,2
		end
	})
	addmode("r", {
		idle = function()
			local Ychg=velYchg()/20
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.9 - 0.2 * sin(sine * 2)-Ychg, 0),angles(1.5707963267948966, 1.6580627893946132 - 0.17453292519943295 * sin(sine + 0.8), -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0.3 * sin(sine + 0.8), -0.1 + 0.2 * sin(sine * 2)+Ychg, 0),angles(-1.5707963267948966, 0, -3.141592653589793)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.08726646259971647 * sin((sine - 0.5) * 2), 0.08726646259971647 * sin(sine - 1), -3.141592653589793 + 0.2617993877991494 * sin(sine * 5))),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1 + 0.1 * sin(sine * 7), 0.2 - 0.1 * sin(sine + 0.8), -0.25),angles(1.5707963267948966 + 0.5235987755982988 * sin(sine * 7), -0.6981317007977318, 0.3490658503988659 * sin(sine * 7))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.9 - 0.2 * sin(sine * 2)-Ychg, 0),angles(1.5707963267948966, -1.6580627893946132 - 0.17453292519943295 * sin(sine + 0.8), 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1 + 0.1 * sin(sine * 7), 0.2 + 0.1 * sin(sine + 0.8), -0.25),angles(1.5707963267948966 - 0.5235987755982988 * sin(sine * 7), 0.6981317007977318, 0.3490658503988659 * sin(sine * 7))),deltaTime) 
			--RightLeg,1,0,0,1,90,0,0,1,-0.9,-0.2,0,2,95,-10,0.8,1,0,0,0,1,-90,0,0,1,Torso,0,0.3,0.8,1,-90,0,0,1,-0.1,0.2,0,2,0,0,0,1,0,0,0,1,-180,0,0,1,Head,0,0,0,1,-90,5,-0.5,2,1,0,0,1,0,5,-1,1,0,0,0,1,-180,15,0,5,Fedora_Handle,8.657480066176504e-09,0,0,1,-6,0,0,1,-0.15052366256713867,0,0,1,0,0,0,1,-0.010221302509307861,0,0,1,0,0,0,1,LeftArm,-1,0.1,0,7,90,30,0,7,0.2,-0.1,0.8,1,-40,0,0,1,-0.25,0,0,1,0,20,0,7,LeftLeg,-1,0,0,1,90,0,0,1,-0.9,-0.2,0,2,-95,-10,0.8,1,0,0,0,1,90,0,0,1,RightArm,1,0.1,0,7,90,-30,0,7,0.2,0.1,0.8,1,40,0,0,1,-0.25,0,0,1,-0,20,0,7
		end
	})
	addmode("t", {
		idle = function()
			local Ychg=velYchg()/20
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(1.5707963267948966, -1.6580627893946132 + 0.08726646259971647 * sin((sine - 0.3) * 4), 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1 + 0.15 * sin((sine - 0.4) * 4), 1.42, 0),angles(1.5707963267948966, 1.4835298641951802 - 0.3490658503988659 * sin((sine - 0.4) * 4), 1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.4835298641951802, 0.04363323129985824 - 0.08726646259971647 * sin((sine + 0.1) * 4), -3.141592653589793 + 0.04363323129985824 * sin(sine * 4))),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0.1 * sin(sine * 4), Ychg, 0),angles(-1.5707963267948966, -0.08726646259971647 + 0.08726646259971647 * sin(sine * 4), -3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1.1 + 0.1 * sin(sine * 4)-Ychg, 0),angles(1.5707963267948966, 1.5707963267948966 + 0.08726646259971647 * sin(sine * 4), -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1 - 0.02 * sin(sine * 4), -0.925 - 0.07 * sin(sine * 4)-Ychg, 0),angles(1.5707963267948966, -1.7453292519943295 + 0.08726646259971647 * sin(sine * 4), 1.5707963267948966)),deltaTime) 
			--LeftArm,-1,0,0,4,90,0,0,4,0.5,0,0,4,-95,5,-0.3,4,0,0,0,4,90,0,0,4,RightArm,1,0.15,-0.4,4,90,0,0,4,1.42,0,0,4,85,-20,-0.4,4,0,0,0,4,90,0,0,4,Head,0,0,0,4,-85,0,0,4,1,0,0,4,2.5,-5,0.1,4,0,0,0,4,-180,2.5,0,4,Torso,0,0.1,0,4,-90,0,0,4,0,0,0,4,-5,5,0,4,0,0,0,4,-180,0,0,4,RightLeg,1,0,0,4,90,0,0,4,-1.1,0.1,0,4,90,5,0,4,0,0,0,4,-90,0,0,4,LeftLeg,-1,-0.02,0,4,90,0,0,4,-0.925,-0.07,0,4,-100,5,0,4,0,0,0,4,90,0,0,4
		end
	})
	addmode("y", {
		idle = function()
			local Ychg=velYchg()/20
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1.5, 0.5, 0),angles(-1.7453292519943295, 0.17453292519943295 - 0.04363323129985824 * sin(sine * 2), -1.4835298641951802)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.9000000953674316 - 0.1 * sin(sine * 2)-Ychg, 0),angles(-1.3962634015954636, 1.3962634015954636, 1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1.0000001192092896 - 0.1 * sin(sine * 2)-Ychg, 0),angles(-1.5707963267948966, -1.3962634015954636, -1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-2.0943951023931953 + 0.08726646259971647 * sin((sine - 1) * 2), -0.08726646259971647, 2.792526803190927)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 1.2000000476837158, 0),angles(2.6179938779914944 + 0.08726646259971647 * sin((sine - 1) * 2), 0.6981317007977318, -1.3962634015954636)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 0.1 * sin(sine * 2) + Ychg, 0),angles(-1.6580627893946132, 0.08726646259971647, 3.0543261909900767)),deltaTime) 
			--LeftArm,-1.5,0,0,2,-100,0,0,2,0.5,0,0,2,10,-2.5,0,2,0,0,0,2,-85,0,0,2,RightLeg,1,0,0,2,-80,0,0,2,-0.9000000953674316,-0.1,0,2,80,0,0,2,0,0,0,2,90,0,0,2,LeftLeg,-1,0,0,2,-90,0,0,2,-1.0000001192092896,-0.1,0,2,-80,0,0,2,0,0,0,2,-90,0,0,2,Fedora_Handle,8.657480066176504e-09,0,0,2,-6,0,0,2,-0.15052366256713867,0,0,2,0,0,0,2,-0.010221302509307861,0,0,2,0,0,0,2,Head,0,0,0,2,-120,5,-1,2,1,0,0,2,-5,0,0,2,0,0,0,2,160,0,0,2,RightArm,1,0,0,2,150,5,-1,2,1.2000000476837158,0,0,2,40,0,0,2,0,0,0,2,-80,0,0,2,Torso,0,0,0,2,-95,0,0,2,0,0.1,0,2,5,0,0,2,0,0,0,2,175,0,0,2
		end
	})
	addmode("u", {
		idle = function()
			velYchg()
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 0.75 + 0.25 * sin(sine * 2), 0),angles(-1.5707963267948966, 0, 3.141592653589793)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1.5 - 0.1 * sin((sine + 0.2) * 2), 0),angles(-1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.4) * 2), 0, 3.141592653589793 + 0.3490658503988659 * sin(sine * 0.66))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-0.5 - 1 * sin((sine + 0.2) * 2.2), -0.75 - 0.25 * sin(sine * 2), 1 * sin((sine + 0.95) * 2.2)),angles(0, -1.5707963267948966, 0)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(0.5 + 1 * sin((sine + 0.2) * 2.2), -0.75 - 0.25 * sin(sine * 2), -1 * sin((sine + 0.95) * 2.2)),angles(0, 1.5707963267948966, 0)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(-0.5 - 1.85 * sin(sine * 2), 0.8 - 0.5 * sin(sine * 2), -1.85 * sin((sine + 0.75) * 2)),angles(0, 1.5707963267948966, 0)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(0.5 + 1.85 * sin(sine * 2), 0.8 - 0.5 * sin(sine * 2), 1.85 * sin((sine + 0.75) * 2)),angles(0, -1.5707963267948966, 0)),deltaTime) 
			--Torso,0,0,0,2,-90,0,0,2,0.75,0.25,0,2,-0,0,0,2,0,0,0,2,180,0,0,2,Fedora_Handle,8.657480066176504e-09,0,0,2,-6,0,0,2,-0.15052366256713867,0,0,2,0,0,0,2,-0.010221302509307861,0,0,2,0,0,0,2,Head,0,0,0,2,-90,-5,0.4,2,1.5,-0.1,0.2,2,-0,0,0,2,0,0,0,2,180,20,0,0.66,LeftLeg,-0.5,-1,0.2,2.2,-0,0,0,2,-0.75,-0.25,0,2,-90,0,0,2,0,1,0.95,2.2,0,0,0,2,RightLeg,0.5,1,0.2,2.2,0,0,0,2,-0.75,-0.25,0,2,90,0,0,2,0,-1,0.95,2.2,0,0,0,2,RightArm,-0.5,-1.85,0,2,0,0,0,2,0.8,-0.5,0,2,90,0,0,2,0,-1.85,0.75,2,0,0,0,2,LeftArm,0.5,1.85,0,2,-0,0,0,2,0.8,-0.5,0,2,-90,0,0,2,0,1.85,0.75,2,0,0,0,2
		end
	})
	addmode("i", {
		idle = function()
			local Ychg=velYchg()/20
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.5, 0.5 + 0.1 * sin((sine - 0.4444444444444444) * 9), 0),angles(2.9670597283903604 + 0.17453292519943295 * sin((sine - 0.17777777777777778) * 9), -0.5235987755982988, 1.5707963267948966 + 0.17453292519943295 * sin(sine * 4.5))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.5 + 0.1 * sin((sine + 0.26666666666666666) * 4.5)-Ychg, -0.5),angles(1.7453292519943295 - 1.0471975511965976 * sin(sine * 4.5), -1.5707963267948966 + 0.03490658503988659 * sin(sine * 4.5), 1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, -0.5 + 0.5 * sin((sine + 0.17777777777777778) * 9)+Ychg, 0),angles(-1.3962634015954636 - 0.03490658503988659 * sin((sine + 0.17777777777777778) * 9), -0.05235987755982989 * sin(sine * 4.5), 3.141592653589793 + 0.03490658503988659 * sin(sine * 4.5))),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1 + 0.2 * sin(sine * 9), 0),angles(-1.5707963267948966 + 0.08726646259971647 * sin(sine * 9), 0.08726646259971647 * sin(sine * 4.5), 3.141592653589793 - 0.06981317007977318 * sin(sine * 4.5))),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.5, 0.5 + 0.1 * sin((sine - 0.4444444444444444) * 9), 0),angles(2.9670597283903604 + 0.17453292519943295 * sin((sine - 0.17777777777777778) * 9), 0.5235987755982988, -1.5707963267948966 + 0.17453292519943295 * sin(sine * 4.5))),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.5 + 0.1 * sin((sine - 0.26666666666666666) * 4.5)-Ychg, -0.5),angles(1.7453292519943295 + 1.0471975511965976 * sin(sine * 4.5), 1.5707963267948966 + 0.03490658503988659 * sin(sine * 4.5), -1.5707963267948966)),deltaTime) 
			--LeftArm,-0.5,0,0,4.5,170,10,-0.17777777777777778,9,0.5,0.1,-0.4444444444444444,9,-30,0,0,4.5,0,0,0,4.5,90,10,0,4.5,LeftLeg,-1,0,0,4.5,100,-60,0,4.5,-0.5,0.1,0.26666666666666666,4.5,-90,2,0,4.5,-0.5,0,0,4.5,90,0,0,4.5,Torso,0,0,0,4.5,-80,-2,0.17777777777777778,9,-0.5,0.5,0.17777777777777778,9,-0,-3,0,4.5,0,0,0,4.5,180,2,0,4.5,Head,0,0,0,4.5,-90,5,0,9,1,0.2,0,9,-0,5,0,4.5,0,0,0,4.5,180,-4,0,4.5,RightArm,0.5,0,0,4.5,170,10,-0.17777777777777778,9,0.5,0.1,-0.4444444444444444,9,30,0,0,4.5,0,0,0,4.5,-90,10,0,4.5,RightLeg,1,0,0,4.5,100,60,0,4.5,-0.5,0.1,-0.26666666666666666,4.5,90,2,0,4.5,-0.5,0,0,4.5,-90,0,0,4.5
		end,
	})
	addmode("o", {
		idle = function()
			local Ychg=velYchg()/20
			local rY, lY = raycastlegs()

			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 + lY-Ychg, lY * -0.5),angles(-1.8325957145940461 - 0.08726646259971647 * sin(sine * 2), -1.4835298641951802, -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, Ychg, 0.09 * sin(sine * 2)),angles(-1.3962634015954636 + 0.08726646259971647 * sin(sine * 2), -0.08726646259971647, 3.141592653589793)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(2.9670597283903604 + 0.08726646259971647 * sin(sine * 1), -1.5707963267948966 + 0.08726646259971647 * sin((sine + 0.6) * 1), 1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1.1 + rY-Ychg, rY * -0.5),angles(-1.7453292519943295 - 0.08726646259971647 * sin(sine * 2), 1.5707963267948966, 1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.2217304763960306 - 0.08726646259971647 * sin((sine + 0.3) * 2), -0.2617993877991494 - 0.08726646259971647 * sin(sine * 2), 3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(2.8797932657906435 + 0.08726646259971647 * sin(sine * 1), 1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.6) * 1), -1.5707963267948966)),deltaTime) 
			--LeftLeg,-1,0,0,2,-105,-5,0,2,-1,0,0,2,-85,0,0,2,0,0,0,2,-90,0,0.75,2,Torso,0,0,0,2,-80,5,0,2,0,0,0,2,-5,0,0,2,0,0.09,0,2,180,0,0,2,LeftArm,-1,0,0,2,170,5,0,1,0.5,0,0,2,-90,5,0.6,1,0,0,0,2,90,0,0,2,RightLeg,1,0,0,2,-100,-5,0,2,-1.1,0,0,2,90,0,0,2,0,0,0,2,90,0,0.75,2,Head,0,0,0,2,-70,-5,0.3,2,1,0,0,2,-15,-5,0,2,0,0,0,2,180,0,0,2,RightArm,1,0,0,2,165,5,0,1,0.5,0,0,2,90,-5,0.6,1,0,0,0,2,-90,0,0,2
		end,
		walk = function()
			local Ychg=velYchg()/20
			local Vfw, Vrt = velbycfrvec()

			local rY, lY = raycastlegs()

			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.04363323129985824 * sin(sine * 16), 0, 3.141592653589793 + 0.08726646259971647 * sin(sine * 8) - Vrt)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 - 0.3 * sin((sine + 0.15) * 8) + rY-Ychg, rY * -0.5),angles(-1.5707963267948966 - 0.6981317007977318 * sin(sine * 8) * Vfw, 1.5707963267948966 + 0.6981317007977318 * sin(sine * 8) * Vrt, 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(0.08726646259971647 * sin((sine - 0.05) * 16), 1.5707963267948966 + 0.08726646259971647 * sin(sine * 8) - Vrt/3, 1.5707963267948966)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(0.08726646259971647 * sin((sine - 0.05) * 16), -1.5707963267948966 + 0.08726646259971647 * sin(sine * 8) - Vrt/3, -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 0.1 * sin((sine + 0.1) * 16)+Ychg, 0),angles(-1.5707963267948966, 0, 3.141592653589793 - 0.08726646259971647 * sin(sine * 8))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 + 0.3 * sin((sine + 0.15) * 8) + lY-Ychg, lY * -0.5),angles(1.5707963267948966 + 0.6981317007977318 * sin(sine * 8) * Vfw, -1.5707963267948966 + 0.6981317007977318 * sin(sine * 8) * Vrt, 1.5707963267948966)),deltaTime) 
			--Head,0,0,0,8,-90,2.5,0,16,1,0,0,8,-0,0,0,8,0,0,0,8,180,5,0,8,RightLeg,1,0,0,8,-90,-40,0,8,-1,-0.3,0.15,8,90,40,0,8,0,0,0,8,90,0,0,8,RightArm,1,0,0,8,0,5,-0.05,16,0.5,0,0,8,90,5,0,8,0,0,0,8,90,0,0,8,LeftArm,-1,0,0,8,0,5,-0.05,16,0.5,0,0,8,-90,5,0,8,0,0,0,8,-90,0,0,8,Torso,0,0,0,8,-90,0,0,8,0,0.1,0.1,16,-0,0,0,8,0,0,0,8,180,-5,0,8,LeftLeg,-1,0,0,8,90,40,0,8,-1,0.3,0.15,8,-90,40,0,8,0,0,0,8,90,0,0,8
		end
	})
	addmode("p", {
		idle = function()
			local Ychg=velYchg()/20
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1.5, 0.5, 0),angles(1.5707963267948966, 3.141592653589793, -1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1-Ychg, 0),angles(0, 1.5707963267948966, 0)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1.5, 0.5, 0),angles(1.5707963267948966, 3.141592653589793, 1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1-Ychg, 0),angles(0, -1.5707963267948966, 0)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966, 0, -3.141592653589793)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, Ychg, 0),angles(-1.5707963267948966, 0, -3.141592653589793)),deltaTime) 
			--RightArm,1.5,0,0,1,90,0,0,1,0.5,0,0,1,180,0,0,1,0,0,0,1,-90,0,0,1,RightLeg,1,0,0,1,0,0,0,1,-1,0,0,1,90,0,0,1,0,0,0,1,0,0,0,1,Fedora_Handle,8.657480066176504e-09,0,0,1,-6,0,0,1,-0.15052366256713867,0,0,1,0,0,0,1,-0.010221302509307861,0,0,1,0,0,0,1,LeftArm,-1.5,0,0,1,90,0,0,1,0.5,0,0,1,180,0,0,1,0,0,0,1,90,0,0,1,LeftLeg,-1,0,0,1,-0,0,0,1,-1,0,0,1,-90,0,0,1,0,0,0,1,0,0,0,1,Head,0,0,0,1,-90,0,0,1,1,0,0,1,0,0,0,1,0,0,0,1,-180,0,0,1,Torso,0,0,0,1,-90,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,-180,0,0,1
		end
	})
	addmode("f", {
		modeEntered = function()
			setWalkSpeed(25)
		end,
		idle = function()
			velYchg()
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(-3.0543261909900767 - 0.17453292519943295 * sin((sine + 1.5) * 1), -1.5707963267948966 + 0.08726646259971647 * sin((sine + 0.6) * 1), -1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(3.141592653589793 - 0.08726646259971647 * sin(sine * 1), 0.3490658503988659 + 0.08726646259971647 * sin((sine + 0.3) * 1), -1.9198621771937625 + 0.08726646259971647 * sin((sine + 1) * 1))),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.3089969389957472 - 0.2617993877991494 * sin((sine + 1.2) * 1), 0.08726646259971647 * sin((sine + 0.2) * 0.5), -2.9670597283903604)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 5 - 0.5 * sin((sine - 0.2) * 1), 0.2 * sin((sine - 1.2) * 1)),angles(-0.08726646259971647 + 0.17453292519943295 * sin((sine + 1.2) * 1), 0.08726646259971647 * sin(sine * 0.5), 3.141592653589793)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.3962634015954636 + 0.12217304763960307 * sin((sine + 1.5) * 1), -1.2217304763960306 + 0.08726646259971647 * sin((sine + 0.2) * 0.5), 1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.9198621771937625 + 0.12217304763960307 * sin((sine + 1.5) * 1), 1.2217304763960306 + 0.08726646259971647 * sin((sine + 0.2) * 0.5), -1.5707963267948966)),deltaTime) 
			--LeftArm,-1,0,0,1,-175,-10,1.5,1,0.5,0,0,1,-90,5,0.6,1,0,0,0,1,-90,0,0,1,RightArm,1,0,0,1,180,-5,0,1,0.5,0,0,1,20,5,0.3,1,0,0,0,1,-110,5,1,1,Head,0,0,0,1,-75,-15,1.2,1,1,0,0,1,-0,5,0.2,0.5,0,0,0,1,-170,0,0,1,Torso,0,0,0,1,-5,10,1.2,1,5,-0.5,-0.2,1,-0,5,0,0.5,0,0.2,-1.2,1,180,0,0,1,LeftLeg,-1,0,0,1,80,7,1.5,1,-1,0,0,1,-70,5,0.2,0.5,0,0,0,1,90,0,0,1,RightLeg,1,0,0,1,110,7,1.5,1,-1,0,0,1,70,5,0.2,0.5,0,0,0,1,-90,0,0,1
		end,
		walk = function()
			velYchg()
			local Vfw, Vrt = velbycfrvec()
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(-3.0543261909900767 - 0.17453292519943295 * sin((sine + 1.5) * 1) - Vfw * 0.1, -1.5707963267948966 + 0.08726646259971647 * sin((sine + 0.6) * 1) + Vrt * 0.2, -1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(3.141592653589793 - 0.08726646259971647 * sin(sine * 1), 0.3490658503988659 + 0.08726646259971647 * sin((sine + 0.3) * 1), -1.9198621771937625 + 0.08726646259971647 * sin((sine + 1) * 1))),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.3089969389957472 - 0.2617993877991494 * sin((sine + 1.2) * 1) + Vfw * 0.1, 0.08726646259971647 * sin((sine + 0.2) * 0.5) - Vrt * 0.2, -2.9670597283903604)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 5 - 0.5 * sin((sine - 0.2) * 1), 0.2 * sin((sine - 1.2) * 1)),angles(-0.08726646259971647 + 0.17453292519943295 * sin((sine + 1.2) * 1) - Vfw * 0.2, 0.08726646259971647 * sin(sine * 0.5), 3.141592653589793 - Vrt * 0.2)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.3962634015954636 + 0.12217304763960307 * sin((sine + 1.5) * 1) - Vfw * 0.2, -1.2217304763960306 + 0.08726646259971647 * sin((sine + 0.2) * 0.5), 1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.9198621771937625 + 0.12217304763960307 * sin((sine + 1.5) * 1) - Vfw * 0.2, 1.2217304763960306 + 0.08726646259971647 * sin((sine + 0.2) * 0.5), -1.5707963267948966)),deltaTime) 
			--LeftArm,-1,0,0,1,-175,-10,1.5,1,0.5,0,0,1,-90,5,0.6,1,0,0,0,1,-90,0,0,1,RightArm,1,0,0,1,180,-5,0,1,0.5,0,0,1,20,5,0.3,1,0,0,0,1,-110,5,1,1,Head,0,0,0,1,-75,-15,1.2,1,1,0,0,1,-0,5,0.2,0.5,0,0,0,1,-170,0,0,1,Torso,0,0,0,1,-5,10,1.2,1,5,-0.5,-0.2,1,-0,5,0,0.5,0,0.2,-1.2,1,180,0,0,1,LeftLeg,-1,0,0,1,80,7,1.5,1,-1,0,0,1,-70,5,0.2,0.5,0,0,0,1,90,0,0,1,RightLeg,1,0,0,1,110,7,1.5,1,-1,0,0,1,70,5,0.2,0.5,0,0,0,1,-90,0,0,1
		end,
		modeLeft = function()
			setWalkSpeed(16)
		end,
	})
	addmode("g", {
		idle = function()
			local Ychg=velYchg()/20
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.9 + 0.4 * sin(sine * 8), 0.5, 0.5 * sin((sine + 0.25) * 4)),angles(1.5707963267948966, -1.5707963267948966 + 1.0471975511965976 * sin(sine * 8), 1.5707963267948966 + 0.6981317007977318 * sin((sine + 0.25) * 4))),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0.3 * sin((sine + 0.4) * 8), Ychg, 0),angles(-1.5707963267948966, 0.3490658503988659 * sin(sine * 8), -3.141592653589793)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.061086523819801536 * sin((sine + 0.125) * 16), -0.3839724354387525 * sin(sine * 8), -3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 + 0.4 * sin((sine - 0.01) * 8)-Ychg, 0),angles(1.5707963267948966, 1.7453292519943295 + 0.6981317007977318 * sin(sine * 8), -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 - 0.4 * sin((sine - 0.01) * 8)-Ychg, 0),angles(1.5707963267948966, -1.7453292519943295 + 0.6981317007977318 * sin(sine * 8), 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.9 + 0.4 * sin(sine * 8), 0.5, -0.5 * sin((sine - 0.35) * 4)),angles(1.5707963267948966 + 0.6981317007977318 * sin(sine * 4), 1.5707963267948966 + 1.0471975511965976 * sin(sine * 8), -1.5707963267948966 + 0.17453292519943295 * sin((sine - 0.35) * 4))),deltaTime) 
			--LeftArm,-0.9,0.4,0,8,90,0,0.25,4,0.5,0,0,8,-90,60,0,8,0,0.5,0.25,4,90,40,0.25,4,Torso,0,0.3,0.4,8,-90,0,0,8,0,0,0,4,0,20,0,8,0,0,0,8,-180,0,0,8,Head,0,0,0,8,-90,3.5,0.125,16,1,0,0,8,0,-22,0,8,0,0,0,8,-180,0,0,1.1,RightLeg,1,0,0,8,90,0,0,8,-1,0.4,-0.01,8,100,40,0,8,0,0,0,8,-90,0,0,8,LeftLeg,-1,0,0,8,90,0,0,8,-1,-0.4,-0.01,8,-100,40,0,8,0,0,0,8,90,0,0,8,RightArm,0.9,0.4,0,8,90,40,0,4,0.5,0,0,8,90,60,0,8,0,-0.5,-0.35,4,-90,10,-0.35,4
		end
	})
	addmode("h", {
		idle = function()
			local Ychg=velYchg()/20
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966, -0.4363323129985824 * sin(sine * 8), -3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 + 0.3 * sin(sine * 8)-Ychg, 0),angles(1.5707963267948966, 1.5707963267948966 + 0.5235987755982988 * sin(sine * 8), -1.5707963267948966)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.5, 1, 0),angles(-0.5235987755982988, -1.5707963267948966 - 0.5235987755982988 * sin(sine * 8), 3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.5, 1, 0),angles(-0.5235987755982988, 1.5707963267948966 - 0.5235987755982988 * sin(sine * 8), 3.141592653589793)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(-0.1 * sin(sine * 8), 0.2 * sin((sine + 0.1) * 16)+Ychg, 0),angles(-1.5707963267948966, 0.2617993877991494 * sin(sine * 8), -3.141592653589793)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 - 0.3 * sin(sine * 8)-Ychg, 0),angles(1.5707963267948966, -1.5707963267948966 + 0.5235987755982988 * sin(sine * 8), 1.5707963267948966)),deltaTime) 
			--Head,0,0,0,8,-90,0,0,8,1,0,0,8,0,-25,0,8,0,0,0,8,-180,0,0,8,RightLeg,1,0,0,8,90,0,0,8,-1,0.3,0,8,90,30,0,8,0,0,0,8,-90,0,0,8,LeftArm,-0.5,0,0,8,-30,0,0,8,1,0,0,8,-90,-30,0,8,0,0,0,8,180,0,0,8,RightArm,0.5,0,0,8,-30,0,0,8,1,0,0,16,90,-30,0,8,0,0,0,8,180,0,0,8,Torso,0,-0.1,0,8,-90,0,0,8,0,0.2,0.1,16,0,15,0,8,0,0,0,8,-180,0,0,8,LeftLeg,-1,0,0,8,90,0,0,8,-1,-0.3,0,8,-90,30,0,8,0,0,0,8,90,0,0,8,Fedora_Handle,8.657480066176504e-09,0,0,8,-6,0,0,8,-0.15052366256713867,0,0,8,0,0,0,8,-0.010221302509307861,0,0,8,0,0,0,8
		end
	})
	addmode("j", {
		idle = function()
			local Ychg=velYchg()/20
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-0.8, -1, -0.1),angles(0.17453292519943295, -0.6981317007977318, 0)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1.2, 0.5, 0),angles(-0.3490658503988659 + 0.08726646259971647 * sin((sine + 0.1) * 4), 0, 0.6981317007977318 + 0.08726646259971647 * sin((sine + 0.1) * 4))),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1.1, -1, 0),angles(1.5707963267948966, 1.7453292519943295, -1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.08726646259971647 * sin((sine + 0.1) * 4), 0, 2.792526803190927)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, -1.7 + 0.5 * sin(sine * 4)+Ychg, 0.15 * sin(sine * 4)),angles(3.3161255787892263 + 0.17453292519943295 * sin(sine * 4), 0, 3.6651914291880923)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.8 + 0.4 * sin(sine * 4), 0.6 + 0.1 * sin(sine * 4), 0.4 - 0.25 * sin(sine * 4)),angles(2.9670597283903604, 2.2689280275926285 - 0.17453292519943295 * sin(sine * 4), -1.4835298641951802 - 0.17453292519943295 * sin(sine * 4))),deltaTime) 
			--GalaxyBeautifulHair_Handle,-0.15000000596046448,0,0,1,0,0,0,1,0.10000000149011612,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,LeftLeg,-0.8,0,0,4,10,0,0,4,-1,0,0,4,-40,0,0,4,-0.1,0,0,4,0,0,0,4,LeftArm,-1.2,0,0,4,-20,5,0.1,4,0.5,0,0,4,0,0,0,4,0,0,0,4,40,5,0.1,4,Fedora_Handle,8.657480066176504e-09,0,0,1,-6,0,0,1,-0.15052366256713867,0,0,1,0,0,0,1,-0.010221302509307861,0,0,1,0,0,0,1,ValkyrieHelm_Handle,8.658389560878277e-09,0,0,1,-15,0,0,1,-0.2433757781982422,0,0,1,0,0,0,1,-0.2657628059387207,0,0,1,0,0,0,1,RightLeg,1.1,0,0,4,90,0,0,4,-1,0,0,4,100,0,0,4,0,0,0,4,-90,0,0,4,BlackIronAntlers_Handle,8.658389560878277e-09,0,0,1,0,0,0,1,-0.6500000953674316,0,0,1,0,0,0,1,0.19972775876522064,0,0,1,0,0,0,1,DevAwardsAdurite_Handle,0,0,0,1,0,0,0,1,-0.25,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,SilverthornAntlers_Handle,8.658389560878277e-09,0,0,1,0,0,0,1,-0.6500000953674316,0,0,1,0,0,0,1,0.19972775876522064,0,0,1,0,0,0,1,Head,0,0,0,4,-90,5,0.1,4,1,0,0,4,-0,0,0,4,0,0,0,4,160,0,0,4,Torso,0,0,0,4,190,10,0,4,-1.70,0.5,0,4,-0,0,0,4,0,0.15,0,4,210,0,0,4,RightArm,0.8,0.4,0,4,170,0,0,4,0.6,0.1,0,4,130,-10,0,4,0.4,-0.25,0,4,-85,-10,0,4
		end
	})
	addmode("k", {
		idle = function()
			local Ychg=velYchg()/20
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.6580627893946132 - 0.08726646259971647 * sin((sine + 0.3333333333333333) * 12), -0.08726646259971647 * sin((sine + 0.2) * 6), 3.141592653589793)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.5 - 0.5 * sin((sine + 0.39999999999999997) * 12)-Ychg, -0.5),angles(1.7453292519943295 - 1.0471975511965976 * sin(sine * 6), -1.5707963267948966 + 0.1308996938995747 * sin(sine * 6), 1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.5 - 0.5 * sin((sine + 0.39999999999999997) * 12)-Ychg, -0.5),angles(1.7453292519943295 + 1.0471975511965976 * sin(sine * 6), 1.5707963267948966 + 0.1308996938995747 * sin(sine * 6), -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, -0.5 + 0.3 * sin((sine + 0.16666666666666666) * 12)+Ychg, 0),angles(-1.3962634015954636 + 0.08726646259971647 * sin((sine + 0.3333333333333333) * 12), 0.08726646259971647 * sin((sine + 0.06666666666666667) * 6), 3.141592653589793)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.8 - 0.1 * sin(sine * 6), 0.5 + 0.1 * sin(sine * 6), -0.2),angles(3.141592653589793 - 0.17453292519943295 * sin((sine + 0.39999999999999997) * 12), -0.17453292519943295, 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.8 - 0.1 * sin(sine * 6), 0.5 - 0.1 * sin(sine * 6), -0.2),angles(3.141592653589793 - 0.17453292519943295 * sin((sine + 0.39999999999999997) * 12), 0.17453292519943295, -1.5707963267948966)),deltaTime) 
			--GalaxyBeautifulHair_Handle,-0.15000000596046448,0,0,1.5,0,0,0,1.5,0.10000000149011612,0,0,1.5,0,0,0,1.5,0,0,0,1.5,0,0,0,1.5,Head,0,0,0,6,-95,-5,0.3333333333333333,12,1,0,0,6,-0,-5,0.2,6,0,0,0,6,180,0,0,6,ValkyrieHelm_Handle,8.658389560878277e-09,0,0,1.5,-15,0,0,1.5,-0.2433757781982422,0,0,1.5,0,0,0,1.5,-0.2657628059387207,0,0,1.5,0,0,0,1.5,SilverthornAntlers_Handle,8.658389560878277e-09,0,0,1.5,0,0,0,1.5,-0.6500000953674316,0,0,1.5,0,0,0,1.5,0.19972775876522064,0,0,1.5,0,0,0,1.5,BlackIronAntlers_Handle,8.658389560878277e-09,0,0,1.5,0,0,0,1.5,-0.6500000953674316,0,0,1.5,0,0,0,1.5,0.19972775876522064,0,0,1.5,0,0,0,1.5,Fedora_Handle,8.657480066176504e-09,0,0,1.5,-6,0,0,1.5,-0.15052366256713867,0,0,1.5,0,0,0,1.5,-0.010221302509307861,0,0,1.5,0,0,0,1.5,LeftLeg,-1,0,0,6,100,-60,0,6,-0.5,-0.5,0.39999999999999997,12,-90,7.5,0,6,-0.5,0,0,6,90,0,0,6,EyelessSmileHead_Handle,-0.00043487548828125,0,0,1.5,180,0,0,1.5,0.6000361442565918,0,0,1.5,0,0,0,1.5,0.0003204345703125,0,0,1.5,180,0,0,1.5,RightLeg,1,0,0,6,100,60,0,6,-0.5,-0.5,0.39999999999999997,12,90,7.5,0,6,-0.5,0,0,6,-90,0,0,6,DevAwardsAdurite_Handle,0,0,0,1.5,0,0,0,1.5,-0.25,0,0,1.5,0,0,0,1.5,0,0,0,1.5,0,0,0,1.5,Torso,0,0,0,6,-80,5,0.3333333333333333,12,-0.5,0.3,0.16666666666666666,12,-0,5,0.06666666666666667,6,0,0,0,6,180,0,0,6,LeftArm,-0.8,-0.1,0,6,180,-10,0.39999999999999997,12,0.5,0.1,0,6,-10,0,0,6,-0.2,0,0,6,90,0,0,6,RightArm,0.8,-0.1,0,6,180,-10,0.39999999999999997,12,0.5,-0.1,0,6,10,0,0,6,-0.2,0,0,6,-90,0,0,6
		end
	})
	local idleL=function()
		local Ychg=velYchg()/20
		RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-0.9+0.2*sin((sine - 0.2)*16)-Ychg,0.25),angles(0,0.7853981633974483,0.4363323129985824-1.1344640137963142*sin((sine-0.0875)*8))),deltaTime) 
		RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0.15 * sin((sine-0.1)*8),0.54 * sin(sine*16)+Ychg,0),angles(-1.5707963267948966,-0.08726646259971647*sin((sine-0.0785)*8),3.141592653589793-0.08726646259971647*sin((sine-0.0785)*8))),deltaTime) 
		RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(0.75+0.07*sin((sine - 0.0785)*8),1.3+0.1*sin((sine - 0.0875)*16),0),angles(1.3962634015954636,2.356194490192345-0.06981317007977318*sin((sine-0.0785)*8),1.2217304763960306)),deltaTime) 
		Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.5707963267948966+0.08726646259971647*sin((sine-0.1)*16),0.12217304763960307*sin((sine-0.0785)*8),3.141592653589793)),deltaTime) 
		LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-0.9+0.2*sin((sine - 0.2)*16)-Ychg,0.25),angles(0,-0.7853981633974483,-0.4363323129985824-1.1344640137963142*sin((sine-0.0875)*8))),deltaTime) 
		LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.45+0.05*sin((sine - 0.0875)*16),-0.2),angles(2.0943951023931953+0.17453292519943295*sin((sine-0.0875)*16),-0.5235987755982988,1.5707963267948966+0.17453292519943295*sin((sine-0.0875)*16))),deltaTime) 
		--MW_animatorProgressSave: RightLeg,1,0,0,16,0,0,0,8,-0.9,0.2,-0.2,16,45,0,-0.0875,8,0.25,0,0,16,25,-65,-0.0875,8,Fedora_Handle,8.657480066176504e-09,0,0,2,-6,0,0,2,-0.15052366256713867,0,0,2,0,0,0,2,-0.010221302509307861,0,0,2,0,0,0,2,Torso,0,0.15,-0.1,8,-90,0,0,16,0,0.54,0,16,-0,-5,-0.0785,8,0,0,0,16,180,-5,-0.0785,8,RightArm,0.75,0.07,-0.0785,8,80,0,0,16,1.3,0.1,-0.0875,16,135,-4,-0.0785,8,0,0,0,16,70,0,0,16,Head,0,0,0,16,-90,5,-0.1,16,1,0,0,16,-0,7,-0.0785,8,0,0,0,16,180,0,0,16,LeftLeg,-1,0,0,16,0,0,0,8,-0.9,0.2,-0.2,16,-45,0,0,8,0.25,0,0,16,-25,-65,-0.0875,8,Bandana_Handle,3.9362930692732334e-09,0,0,2,0,0,0,2,0.3000001907348633,0,0,2,0,0,0,2,-0.6002722978591919,0,0,2,0,0,0,2,LeftArm,-1,0,0,16,120,10,-0.0875,16,0.45,0.05,-0.0875,16,-30,0,0,16,-0.2,0,0,16,90,10,-0.0875,16
	end
	addmode("l", {
		modeEntered = function()
			setWalkSpeed(10)
		end,
		idle = idleL,
		walk = idleL,
		modeLeft = function()
			setWalkSpeed(16)
		end
	})
end)

btn("nameless animations V7", function()
	local t=reanimate()
	if type(t)~="table" then return end
	local raycastlegs=t.raycastlegs
	local velbycfrvec=t.velbycfrvec
	local velchgbycfrvec=t.velchgbycfrvec
	local addmode=t.addmode
	local getJoint=t.getJoint
	local RootJoint=getJoint("RootJoint")
	local RightShoulder=getJoint("Right Shoulder")
	local LeftShoulder=getJoint("Left Shoulder")
	local RightHip=getJoint("Right Hip")
	local LeftHip=getJoint("Left Hip")
	local Neck=getJoint("Neck")

	addmode("default", {
		idle = function()
			local rY, lY = raycastlegs()

			local Cfw, Crt = velchgbycfrvec()

			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.3 + 0.1 * sin(sine * 2), -0.1),angles(-0.5235987755982988 + 0.05235987755982989 * sin((sine + 1.5) * 2), 1.0471975511965976 + 0.08726646259971647 * sin((sine + 0.5) * 2), 0.5235987755982988)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.6580627893946132 + 0.08726646259971647 * sin((sine + 0.6) * 2), 0, 3.141592653589793 + 0.2617993877991494 * sin((sine - 1.2) * 1))),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, 0.1 * sin(sine * 2), Cfw * -3),angles(-1.5707963267948966 + 0.08726646259971647 * sin(sine * 2) - Cfw, Crt, 3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 - 0.1 * sin(sine * 2) + rY, 0.1 * sin(sine * 2) - rY * 0.5),angles(-0.6981317007977318 - 0.08726646259971647 * sin(sine * 2), 1.0471975511965976, 0.5235987755982988)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.6 + 0.1 * sin(sine * 2), 0),angles(3.141592653589793 + 0.05235987755982989 * sin((sine + 0.5) * 2), -2.705260340591211 + 0.017453292519943295 * sin((sine + 1.5) * 2), -1.2217304763960306 + 0.05235987755982989 * sin((sine + 1.5) * 2))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 - 0.1 * sin(sine * 2) + lY, 0.1 * sin(sine * 2) - lY * 0.5),angles(-0.3490658503988659 - 0.08726646259971647 * sin(sine * 2), -1.0471975511965976, -0.5235987755982988)),deltaTime) 
			--RightArm,1,0,0,2,-30,3,1.5,2,0.3,0.1,0,2,60,5,0.5,2,-0.1,0,0,2,30,0,0,2,Head,0,0,0,2,-95,5,0.6,2,1,0,0,2,-0,0,0,1,0,0,0,2,180,15,-1.2,1,Torso,0,0,0,2,-90,5,0,2,0,0.1,0,2,-0,0,0,2,0,0,0,2,180,0,0,2,RightLeg,1,0,0,2,-40,-5,0,2,-1,-0.1,0,2,60,0,0,2,0,0.1,0,2,30,0,0,2,Meshes/TrollFaceHeadAccessory_Handle,0.01043701171875,0,0,1,0,0,0,1,0.43610429763793945,0,0,1,0,0,0,1,-0.01102447509765625,0,0,1,0,0,0,1,LeftArm,-1,0,0,2,180,3,0.5,2,0.6,0.1,0,2,-155,1,1.5,2,0,0,0,2,-70,3,1.5,2,LeftLeg,-1,0,0,2,-20,-5,0,2,-1,-0.1,0,2,-60,0,0,2,0,0.1,0,2,-30,0,0,2
		end,
		walk = function()
			local Vfw, Vrt = velbycfrvec()

			local rY, lY = raycastlegs()

			local Cfw, Crt = velchgbycfrvec()

			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, -0.2 + 0.2 * sin(sine * 16), Cfw * -3),angles(-1.6580627893946132 + 0.04363323129985824 * sin(sine * 16) - Vfw * 0.15 - Cfw, 0.03490658503988659 * sin(sine * 8) + Vrt * 0.15 + Crt, -3.141592653589793 - 0.08726646259971647 * sin((sine + 0.25) * 8) - Vrt * 0.1)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.8 + 0.4 * sin((sine + 0.125) * 8) + rY, -0.15 * Vfw + 0.4 * sin((sine + 10) * 8) * Vfw + rY * -0.5),angles(1.3962634015954636 + 0.6981317007977318 * sin(sine * 8)*Vfw, 1.5707963267948966 + 0.6981317007977318 * sin(sine * 8)*Vrt, -1.5707963267948966 + 0.2617993877991494 * sin(sine * 8))),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.35 - 0.1 * sin(sine * 8), 0),angles(0.5235987755982988 * sin(sine * 8)*Vfw, -1.5707963267948966 - 0.5235987755982988 * sin(sine * 8)*Vfw, -0.5235987755982988 * sin(sine * 8)*Vfw)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.35 + 0.1 * sin(sine * 8), 0),angles(-0.5235987755982988 * sin(sine * 8)*Vfw, 1.5707963267948966 - 0.5235987755982988 * sin(sine * 8)*Vfw, -0.5235987755982988 * sin(sine * 8)*Vfw)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.8 - 0.4 * sin((sine + 0.125) * 8) + lY, -0.15 * Vfw - 0.4 * sin((sine + 10) * 8) * Vfw + lY * -0.5),angles(1.3962634015954636 - 0.6981317007977318 * sin(sine * 8)*Vfw, -1.5707963267948966 - 0.6981317007977318 * sin(sine * 8)*Vrt, 1.5707963267948966 + 0.2617993877991494 * sin(sine * 8))),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.08726646259971647 * sin((sine + 10) * 16) + Vfw * 0.15, -0.08726646259971647 * sin(sine * 8) + Vrt * -0.1, 3.141592653589793 - 0.05235987755982989 * sin((sine + 5) * 8) - Vrt * 0.5)),deltaTime) 
			--Torso,0,0,0,8,-95,2.5,0,16,-0.2,0.2,0,16,0,5,0,8,0,0,0,8,-180,-5,0.25,8,RightArm,1,0,0,1,0,-30,0,8,0.35,0.1,0,8,90,-30,0,8,0,0,0,8,0,-30,0,8,RightLeg,1,0,0,8,80,40,0,8,-0.8,0.4,0.125,8,90,40,0,8,-0.15,0.4,10,8,-90,15,0,8,LeftLeg,-1,0,0,8,80,-40,0,8,-0.8,-0.4,0.125,8,-90,-40,0,8,-0.15,-0.4,10,8,90,15,0,8,Head,0,0,0,1,-90,2.5,10,16,1,0,0,1,-0,-5,0,8,0,0,0,1,180,-3,5,8,LeftArm,-1,0,0,1,0,30,0,8,0.35,-0.1,0,8,-90,-30,0,8,0,-0.4,0,8,0,-30,0,8
		end,
		jump = function()
			local Vfw, Vrt = velbycfrvec()

			local Cfw, Crt = velchgbycfrvec()

			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, 0, Cfw * -3),angles(-1.4835298641951802 + Vfw * 0.1 - Cfw, Vrt * -0.05 + Crt, -3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(4.014257279586958 - 0.08726646259971647 * sin((sine + 0.5) * 4), 1.7453292519943295 + 0.08726646259971647 * sin((sine + 0.25) * 4), -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.5) * 4), -1.6580627893946132 + 0.06981317007977318 * sin((sine + 0.25) * 4), 1.5707963267948966)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(4.014257279586958 - 0.08726646259971647 * sin((sine + 0.5) * 4), -1.7453292519943295 - 0.08726646259971647 * sin((sine + 0.25) * 4), 1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.3962634015954636, 0, -3.141592653589793 - Vrt)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.5) * 4), 1.6580627893946132 - 0.06981317007977318 * sin((sine + 0.25) * 4), -1.5707963267948966)),deltaTime) 
			--Torso,0,0,0,4,-85,0,0,4,0,0,0,4,0,0,0,4,0,0,0,4,-180,0,0,4,RightArm,1,0,0,4,230,-5,0.5,4,0.5,0,0,4,100,5,0.25,4,0,0,0,4,-90,0,0,4,LeftLeg,-1,0,0,4,90,-5,0.5,4,-1,0,0,4,-95,4,0.25,4,0,0,0,4,90,0,0,4,LeftArm,-1,0,0,4,230,-5,0.5,4,0.5,0,0,4,-100,-5,0.25,4,0,0,0,4,90,0,0,4,Head,0,0,0,4,-80,0,0.5,4,1,0,0,4,0,0,0.25,4,0,0,0,4,-180,0,0,4,RightLeg,1,0,0,4,90,-5,0.5,4,-1,0,0,4,95,-4,0.25,4,0,0,0,4,-90,0,0,4
		end,
		fall = function()
			local Vfw, Vrt = velbycfrvec()

			local Cfw, Crt = velchgbycfrvec()

			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, 0, Cfw * -3),angles(-1.6580627893946132 + Vfw * 0.1 - Cfw, Vrt * -0.05 + Crt, -3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(4.014257279586958 - 0.08726646259971647 * sin((sine + 0.5) * 4), 1.7453292519943295 + 0.08726646259971647 * sin((sine + 0.25) * 4), -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.5) * 4), -1.6580627893946132 + 0.06981317007977318 * sin((sine + 0.25) * 4), 1.5707963267948966)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(4.014257279586958 - 0.08726646259971647 * sin((sine + 0.5) * 4), -1.7453292519943295 - 0.08726646259971647 * sin((sine + 0.25) * 4), 1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.7453292519943295, 0, -3.141592653589793 - Vrt)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.5) * 4), 1.6580627893946132 - 0.06981317007977318 * sin((sine + 0.25) * 4), -1.5707963267948966)),deltaTime) 
			--Torso,0,0,0,4,-95,0,0,4,0,0,0,4,0,0,0,4,0,0,0,4,-180,0,0,4,RightArm,1,0,0,4,230,-5,0.5,4,0.5,0,0,4,100,5,0.25,4,0,0,0,4,-90,0,0,4,LeftLeg,-1,0,0,4,90,-5,0.5,4,-1,0,0,4,-95,4,0.25,4,0,0,0,4,90,0,0,4,LeftArm,-1,0,0,4,230,-5,0.5,4,0.5,0,0,4,-100,-5,0.25,4,0,0,0,4,90,0,0,4,Head,0,0,0,4,-100,0,0.5,4,1,0,0,4,0,0,0.25,4,0,0,0,4,-180,0,0,4,RightLeg,1,0,0,4,90,-5,0.5,4,-1,0,0,4,95,-4,0.25,4,0,0,0,4,-90,0,0,4
		end
	})

	addmode("q", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.75, -0.2),angles(2.705260340591211 - 0.08726646259971647 * sin((sine + 0.1) * 2), -2.792526803190927, -0.6981317007977318)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.75, -0.2),angles(2.705260340591211 - 0.08726646259971647 * sin((sine + 0.1) * 2), 2.792526803190927, 0.6981317007977318)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.9198621771937625 - 0.10471975511965978 * sin((sine + 0.3) * 2), 0, 3.141592653589793)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, -2.45 - 0.05 * sin(sine * 2), Cfw * -3),angles(0.03490658503988659 * sin(sine * 2) - Cfw, Crt, 3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.3962634015954636 - 0.03490658503988659 * sin(sine * 2), 1.3089969389957472, -0.9599310885968813)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.5707963267948966 - 0.03490658503988659 * sin(sine * 2), -1.3089969389957472, 1.5707963267948966)),deltaTime) 
			--LeftArm,-1,0,0,2,155,-5,0.1,2,0.75,0,0,2,-160,0,0,2,-0.2,0,0,2,-40,0,0,2,RightArm,1,0,0,2,155,-5,0.1,2,0.75,0,0,2,160,0,0,2,-0.2,0,0,2,40,0,0,2,Head,0,0,0,2,-110,-6,0.3,2,1,0,0,2,-0,0,0,2,0,0,0,2,180,0,0,2,Torso,0,0,0,2,0,2,0,2,-2.45,-0.05,0,2,-0,0,0,2,0,0,0,2,180,0,0,2,RightLeg,1,0,0,2,80,-2,0,2,-1,0,0,2,75,0,0,2,0,0,0,2,-55,0,0,2,LeftLeg,-1,0,0,2,90,-2,0,2,-1,0,0,2,-75,0,0,2,0,0,0,2,90,0,0,2
		end
	})
	addmode("e", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.9, 0.4 + 0.1 * sin(sine * 2), 0.3 - 0.15 * sin(sine * 2)),angles(-1.0471975511965976 - 0.12217304763960307 * sin(sine * 2), -1.3962634015954636, -0.6981317007977318)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, -1.85 - 0.1 * sin((sine + 0.2) * 2), Cfw * -3),angles(-1.3962634015954636 + 0.03490658503988659 * sin(sine * 2) - Cfw, -0.08726646259971647 + Crt, 3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.4 + 0.1 * sin(sine * 2), 0.2 - 0.15 * sin(sine * 2)),angles(0.6108652381980153 - 0.12217304763960307 * sin(sine * 2), 1.2217304763960306, -0.7853981633974483)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.6580627893946132 - 0.03490658503988659 * sin((sine + 0.6) * 2), 0.10471975511965978 + 0.06981317007977318 * sin(sine * 0.66), 3.141592653589793 + 0.3490658503988659 * sin(sine * 0.66))),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, 0.2 + 0.15 * sin((sine + 0.2) * 2), -0.7 + 0.1 * sin(sine * 2)),angles(1.4835298641951802 + 0.03490658503988659 * sin(sine * 2), 1.4835298641951802, -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.75 + 0.1 * sin((sine + 0.2) * 2), -0.5),angles(1.3962634015954636 - 0.03490658503988659 * sin(sine * 2), -1.6580627893946132, 0)),deltaTime) 
			--LeftArm,-0.9,0,0,2,-60,-7,0,2,0.4,0.1,0,2,-80,0,0,2,0.3,-0.15,0,2,-40,0,0,2,Torso,0,0,0,2,-80,2,0,2,-1.85,-0.1,0.2,2,-5,0,0,2,0,0,0,2,180,0,0,2,RightArm,1,0,0,2,35,-7,0,2,0.4,0.1,0,2,70,0,0,2,0.2,-0.15,0,2,-45,0,0,2,Head,0,0,0,2,-95,-2,0.6,2,1,0,0,2,6,4,0,0.66,0,0,0,2,180,20,0,0.66,RightLeg,1,0,0,2,85,2,0,2,0.2,0.15,0.2,2,85,0,0,2,-0.7,0.1,0,2,-90,0,0,2,LeftLeg,-1,0,0,2,80,-2,0,2,-0.75,0.1,0.2,2,-95,0,0,2,-0.5,0,0,2,0,0,0,2
		end
	})
	addmode("r", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.9 - 0.2 * sin(sine * 2), 0),angles(1.5707963267948966, 1.6580627893946132 - 0.17453292519943295 * sin(sine + 0.8), -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0.3 * sin(sine + 0.8) + Crt * 3, -0.1 + 0.2 * sin(sine * 2), Cfw * -3),angles(-1.5707963267948966 - Cfw, Crt, -3.141592653589793)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.08726646259971647 * sin((sine - 0.5) * 2), 0.08726646259971647 * sin(sine - 1), -3.141592653589793 + 0.2617993877991494 * sin(sine * 5))),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1 + 0.1 * sin(sine * 7), 0.2 - 0.1 * sin(sine + 0.8), -0.25),angles(1.5707963267948966 + 0.5235987755982988 * sin(sine * 7), -0.6981317007977318, 0.3490658503988659 * sin(sine * 7))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.9 - 0.2 * sin(sine * 2), 0),angles(1.5707963267948966, -1.6580627893946132 - 0.17453292519943295 * sin(sine + 0.8), 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1 + 0.1 * sin(sine * 7), 0.2 + 0.1 * sin(sine + 0.8), -0.25),angles(1.5707963267948966 - 0.5235987755982988 * sin(sine * 7), 0.6981317007977318, 0.3490658503988659 * sin(sine * 7))),deltaTime) 
			--RightLeg,1,0,0,1,90,0,0,1,-0.9,-0.2,0,2,95,-10,0.8,1,0,0,0,1,-90,0,0,1,Torso,0,0.3,0.8,1,-90,0,0,1,-0.1,0.2,0,2,0,0,0,1,0,0,0,1,-180,0,0,1,Head,0,0,0,1,-90,5,-0.5,2,1,0,0,1,0,5,-1,1,0,0,0,1,-180,15,0,5,Fedora_Handle,8.657480066176504e-09,0,0,1,-6,0,0,1,-0.15052366256713867,0,0,1,0,0,0,1,-0.010221302509307861,0,0,1,0,0,0,1,LeftArm,-1,0.1,0,7,90,30,0,7,0.2,-0.1,0.8,1,-40,0,0,1,-0.25,0,0,1,0,20,0,7,LeftLeg,-1,0,0,1,90,0,0,1,-0.9,-0.2,0,2,-95,-10,0.8,1,0,0,0,1,90,0,0,1,RightArm,1,0.1,0,7,90,-30,0,7,0.2,0.1,0.8,1,40,0,0,1,-0.25,0,0,1,-0,20,0,7
		end
	})
	addmode("t", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(1.5707963267948966, -1.6580627893946132 + 0.08726646259971647 * sin((sine - 0.3) * 4), 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1 + 0.15 * sin((sine - 0.4) * 4), 1.42, 0),angles(1.5707963267948966, 1.4835298641951802 - 0.3490658503988659 * sin((sine - 0.4) * 4), 1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.4835298641951802, 0.04363323129985824 - 0.08726646259971647 * sin((sine + 0.1) * 4), -3.141592653589793 + 0.04363323129985824 * sin(sine * 4))),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0.1 * sin(sine * 4) + Crt * 3, 0, Cfw * -3),angles(-1.5707963267948966 - Cfw, -0.08726646259971647 + 0.08726646259971647 * sin(sine * 4) + Crt, -3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1.1 + 0.1 * sin(sine * 4), 0),angles(1.5707963267948966, 1.5707963267948966 + 0.08726646259971647 * sin(sine * 4), -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1 - 0.02 * sin(sine * 4), -0.925 - 0.07 * sin(sine * 4), 0),angles(1.5707963267948966, -1.7453292519943295 + 0.08726646259971647 * sin(sine * 4), 1.5707963267948966)),deltaTime) 
			--LeftArm,-1,0,0,4,90,0,0,4,0.5,0,0,4,-95,5,-0.3,4,0,0,0,4,90,0,0,4,RightArm,1,0.15,-0.4,4,90,0,0,4,1.42,0,0,4,85,-20,-0.4,4,0,0,0,4,90,0,0,4,Head,0,0,0,4,-85,0,0,4,1,0,0,4,2.5,-5,0.1,4,0,0,0,4,-180,2.5,0,4,Torso,0,0.1,0,4,-90,0,0,4,0,0,0,4,-5,5,0,4,0,0,0,4,-180,0,0,4,RightLeg,1,0,0,4,90,0,0,4,-1.1,0.1,0,4,90,5,0,4,0,0,0,4,-90,0,0,4,LeftLeg,-1,-0.02,0,4,90,0,0,4,-0.925,-0.07,0,4,-100,5,0,4,0,0,0,4,90,0,0,4
		end
	})
	addmode("y", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1.5, 0.5, 0),angles(-1.7453292519943295, 0.17453292519943295 - 0.04363323129985824 * sin(sine * 2), -1.4835298641951802)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.9000000953674316 - 0.1 * sin(sine * 2), 0),angles(-1.3962634015954636, 1.3962634015954636, 1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1.0000001192092896 - 0.1 * sin(sine * 2), 0),angles(-1.5707963267948966, -1.3962634015954636, -1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-2.0943951023931953 + 0.08726646259971647 * sin((sine - 1) * 2), -0.08726646259971647, 2.792526803190927)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 1.2000000476837158, 0),angles(2.6179938779914944 + 0.08726646259971647 * sin((sine - 1) * 2), 0.6981317007977318, -1.3962634015954636)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, 0.1 * sin(sine * 2), Cfw * -3),angles(-1.6580627893946132 - Cfw, 0.08726646259971647 + Crt, 3.0543261909900767)),deltaTime) 
			--LeftArm,-1.5,0,0,2,-100,0,0,2,0.5,0,0,2,10,-2.5,0,2,0,0,0,2,-85,0,0,2,RightLeg,1,0,0,2,-80,0,0,2,-0.9000000953674316,-0.1,0,2,80,0,0,2,0,0,0,2,90,0,0,2,LeftLeg,-1,0,0,2,-90,0,0,2,-1.0000001192092896,-0.1,0,2,-80,0,0,2,0,0,0,2,-90,0,0,2,Fedora_Handle,8.657480066176504e-09,0,0,2,-6,0,0,2,-0.15052366256713867,0,0,2,0,0,0,2,-0.010221302509307861,0,0,2,0,0,0,2,Head,0,0,0,2,-120,5,-1,2,1,0,0,2,-5,0,0,2,0,0,0,2,160,0,0,2,RightArm,1,0,0,2,150,5,-1,2,1.2000000476837158,0,0,2,40,0,0,2,0,0,0,2,-80,0,0,2,Torso,0,0,0,2,-95,0,0,2,0,0.1,0,2,5,0,0,2,0,0,0,2,175,0,0,2
		end
	})
	addmode("u", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, 0.75 + 0.25 * sin(sine * 2), Cfw * -3),angles(-1.5707963267948966 - Cfw, Crt, 3.141592653589793)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1.5 - 0.1 * sin((sine + 0.2) * 2), 0),angles(-1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.4) * 2), 0, 3.141592653589793 + 0.3490658503988659 * sin(sine * 0.66))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-0.5 - 1 * sin((sine + 0.2) * 2.2), -0.75 - 0.25 * sin(sine * 2), 1 * sin((sine + 0.95) * 2.2)),angles(0, -1.5707963267948966, 0)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(0.5 + 1 * sin((sine + 0.2) * 2.2), -0.75 - 0.25 * sin(sine * 2), -1 * sin((sine + 0.95) * 2.2)),angles(0, 1.5707963267948966, 0)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(-0.5 - 1.85 * sin(sine * 2), 0.8 - 0.5 * sin(sine * 2), -1.85 * sin((sine + 0.75) * 2)),angles(0, 1.5707963267948966, 0)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(0.5 + 1.85 * sin(sine * 2), 0.8 - 0.5 * sin(sine * 2), 1.85 * sin((sine + 0.75) * 2)),angles(0, -1.5707963267948966, 0)),deltaTime) 
			--Torso,0,0,0,2,-90,0,0,2,0.75,0.25,0,2,-0,0,0,2,0,0,0,2,180,0,0,2,Fedora_Handle,8.657480066176504e-09,0,0,2,-6,0,0,2,-0.15052366256713867,0,0,2,0,0,0,2,-0.010221302509307861,0,0,2,0,0,0,2,Head,0,0,0,2,-90,-5,0.4,2,1.5,-0.1,0.2,2,-0,0,0,2,0,0,0,2,180,20,0,0.66,LeftLeg,-0.5,-1,0.2,2.2,-0,0,0,2,-0.75,-0.25,0,2,-90,0,0,2,0,1,0.95,2.2,0,0,0,2,RightLeg,0.5,1,0.2,2.2,0,0,0,2,-0.75,-0.25,0,2,90,0,0,2,0,-1,0.95,2.2,0,0,0,2,RightArm,-0.5,-1.85,0,2,0,0,0,2,0.8,-0.5,0,2,90,0,0,2,0,-1.85,0.75,2,0,0,0,2,LeftArm,0.5,1.85,0,2,-0,0,0,2,0.8,-0.5,0,2,-90,0,0,2,0,1.85,0.75,2,0,0,0,2
		end
	})
	addmode("i", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.5, 0.5 + 0.1 * sin((sine - 0.4444444444444444) * 9), 0),angles(2.9670597283903604 + 0.17453292519943295 * sin((sine - 0.17777777777777778) * 9), -0.5235987755982988, 1.5707963267948966 + 0.17453292519943295 * sin(sine * 4.5))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.5 + 0.1 * sin((sine + 0.26666666666666666) * 4.5), -0.5),angles(1.7453292519943295 - 1.0471975511965976 * sin(sine * 4.5), -1.5707963267948966 + 0.03490658503988659 * sin(sine * 4.5), 1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, -0.5 + 0.5 * sin((sine + 0.17777777777777778) * 9), Cfw * -3),angles(-1.3962634015954636 - 0.03490658503988659 * sin((sine + 0.17777777777777778) * 9) - Cfw, -0.05235987755982989 * sin(sine * 4.5) + Crt, 3.141592653589793 + 0.03490658503988659 * sin(sine * 4.5))),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1 + 0.2 * sin(sine * 9), 0),angles(-1.5707963267948966 + 0.08726646259971647 * sin(sine * 9), 0.08726646259971647 * sin(sine * 4.5), 3.141592653589793 - 0.06981317007977318 * sin(sine * 4.5))),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.5, 0.5 + 0.1 * sin((sine - 0.4444444444444444) * 9), 0),angles(2.9670597283903604 + 0.17453292519943295 * sin((sine - 0.17777777777777778) * 9), 0.5235987755982988, -1.5707963267948966 + 0.17453292519943295 * sin(sine * 4.5))),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.5 + 0.1 * sin((sine - 0.26666666666666666) * 4.5), -0.5),angles(1.7453292519943295 + 1.0471975511965976 * sin(sine * 4.5), 1.5707963267948966 + 0.03490658503988659 * sin(sine * 4.5), -1.5707963267948966)),deltaTime) 
			--LeftArm,-0.5,0,0,4.5,170,10,-0.17777777777777778,9,0.5,0.1,-0.4444444444444444,9,-30,0,0,4.5,0,0,0,4.5,90,10,0,4.5,LeftLeg,-1,0,0,4.5,100,-60,0,4.5,-0.5,0.1,0.26666666666666666,4.5,-90,2,0,4.5,-0.5,0,0,4.5,90,0,0,4.5,Torso,0,0,0,4.5,-80,-2,0.17777777777777778,9,-0.5,0.5,0.17777777777777778,9,-0,-3,0,4.5,0,0,0,4.5,180,2,0,4.5,Head,0,0,0,4.5,-90,5,0,9,1,0.2,0,9,-0,5,0,4.5,0,0,0,4.5,180,-4,0,4.5,RightArm,0.5,0,0,4.5,170,10,-0.17777777777777778,9,0.5,0.1,-0.4444444444444444,9,30,0,0,4.5,0,0,0,4.5,-90,10,0,4.5,RightLeg,1,0,0,4.5,100,60,0,4.5,-0.5,0.1,-0.26666666666666666,4.5,90,2,0,4.5,-0.5,0,0,4.5,-90,0,0,4.5
		end,
	})
	addmode("o", {
		idle = function()
			local rY, lY = raycastlegs()

			local Cfw, Crt = velchgbycfrvec()

			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 + lY, lY * -0.5),angles(-1.8325957145940461 - 0.08726646259971647 * sin(sine * 2), -1.4835298641951802, -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt, 0, 0.09 * sin(sine * 2) - Cfw * 3),angles(-1.3962634015954636 + 0.08726646259971647 * sin(sine * 2) - Cfw, -0.08726646259971647 + Crt, 3.141592653589793)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(2.9670597283903604 + 0.08726646259971647 * sin(sine * 1), -1.5707963267948966 + 0.08726646259971647 * sin((sine + 0.6) * 1), 1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1.1 + rY, rY * -0.5),angles(-1.7453292519943295 - 0.08726646259971647 * sin(sine * 2), 1.5707963267948966, 1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.2217304763960306 - 0.08726646259971647 * sin((sine + 0.3) * 2), -0.2617993877991494 - 0.08726646259971647 * sin(sine * 2), 3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(2.8797932657906435 + 0.08726646259971647 * sin(sine * 1), 1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.6) * 1), -1.5707963267948966)),deltaTime) 
			--LeftLeg,-1,0,0,2,-105,-5,0,2,-1,0,0,2,-85,0,0,2,0,0,0,2,-90,0,0.75,2,Torso,0,0,0,2,-80,5,0,2,0,0,0,2,-5,0,0,2,0,0.09,0,2,180,0,0,2,LeftArm,-1,0,0,2,170,5,0,1,0.5,0,0,2,-90,5,0.6,1,0,0,0,2,90,0,0,2,RightLeg,1,0,0,2,-100,-5,0,2,-1.1,0,0,2,90,0,0,2,0,0,0,2,90,0,0.75,2,Head,0,0,0,2,-70,-5,0.3,2,1,0,0,2,-15,-5,0,2,0,0,0,2,180,0,0,2,RightArm,1,0,0,2,165,5,0,1,0.5,0,0,2,90,-5,0.6,1,0,0,0,2,-90,0,0,2
		end,
		walk = function()
			local Vfw, Vrt = velbycfrvec()

			local rY, lY = raycastlegs()

			local Cfw, Crt = velchgbycfrvec()

			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.04363323129985824 * sin(sine * 16), 0, 3.141592653589793 + 0.08726646259971647 * sin(sine * 8) - Vrt)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 - 0.3 * sin((sine + 0.15) * 8) + rY, rY * -0.5),angles(-1.5707963267948966 - 0.6981317007977318 * sin(sine * 8) * Vfw, 1.5707963267948966 + 0.6981317007977318 * sin(sine * 8) * Vrt, 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(0.08726646259971647 * sin((sine - 0.05) * 16), 1.5707963267948966 + 0.08726646259971647 * sin(sine * 8) - Vrt/3, 1.5707963267948966)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(0.08726646259971647 * sin((sine - 0.05) * 16), -1.5707963267948966 + 0.08726646259971647 * sin(sine * 8) - Vrt/3, -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, 0.1 * sin((sine + 0.1) * 16), Cfw * -3),angles(-1.5707963267948966 - Cfw, Crt, 3.141592653589793 - 0.08726646259971647 * sin(sine * 8))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 + 0.3 * sin((sine + 0.15) * 8) + lY, lY * -0.5),angles(1.5707963267948966 + 0.6981317007977318 * sin(sine * 8) * Vfw, -1.5707963267948966 + 0.6981317007977318 * sin(sine * 8) * Vrt, 1.5707963267948966)),deltaTime) 
			--Head,0,0,0,8,-90,2.5,0,16,1,0,0,8,-0,0,0,8,0,0,0,8,180,5,0,8,RightLeg,1,0,0,8,-90,-40,0,8,-1,-0.3,0.15,8,90,40,0,8,0,0,0,8,90,0,0,8,RightArm,1,0,0,8,0,5,-0.05,16,0.5,0,0,8,90,5,0,8,0,0,0,8,90,0,0,8,LeftArm,-1,0,0,8,0,5,-0.05,16,0.5,0,0,8,-90,5,0,8,0,0,0,8,-90,0,0,8,Torso,0,0,0,8,-90,0,0,8,0,0.1,0.1,16,-0,0,0,8,0,0,0,8,180,-5,0,8,LeftLeg,-1,0,0,8,90,40,0,8,-1,0.3,0.15,8,-90,40,0,8,0,0,0,8,90,0,0,8
		end
	})
	addmode("p", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1.5, 0.5, 0),angles(1.5707963267948966, 3.141592653589793, -1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(0, 1.5707963267948966, 0)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1.5, 0.5, 0),angles(1.5707963267948966, 3.141592653589793, 1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(0, -1.5707963267948966, 0)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966, 0, -3.141592653589793)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, 0, Cfw * -3),angles(-1.5707963267948966 - Cfw, Crt, -3.141592653589793)),deltaTime) 
			--RightArm,1.5,0,0,1,90,0,0,1,0.5,0,0,1,180,0,0,1,0,0,0,1,-90,0,0,1,RightLeg,1,0,0,1,0,0,0,1,-1,0,0,1,90,0,0,1,0,0,0,1,0,0,0,1,Fedora_Handle,8.657480066176504e-09,0,0,1,-6,0,0,1,-0.15052366256713867,0,0,1,0,0,0,1,-0.010221302509307861,0,0,1,0,0,0,1,LeftArm,-1.5,0,0,1,90,0,0,1,0.5,0,0,1,180,0,0,1,0,0,0,1,90,0,0,1,LeftLeg,-1,0,0,1,-0,0,0,1,-1,0,0,1,-90,0,0,1,0,0,0,1,0,0,0,1,Head,0,0,0,1,-90,0,0,1,1,0,0,1,0,0,0,1,0,0,0,1,-180,0,0,1,Torso,0,0,0,1,-90,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,-180,0,0,1
		end
	})
	addmode("f", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(-3.0543261909900767 - 0.17453292519943295 * sin((sine + 1.5) * 1), -1.5707963267948966 + 0.08726646259971647 * sin((sine + 0.6) * 1), -1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(3.141592653589793 - 0.08726646259971647 * sin(sine * 1), 0.3490658503988659 + 0.08726646259971647 * sin((sine + 0.3) * 1), -1.9198621771937625 + 0.08726646259971647 * sin((sine + 1) * 1))),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.3089969389957472 - 0.2617993877991494 * sin((sine + 1.2) * 1), 0.08726646259971647 * sin((sine + 0.2) * 0.5), -2.9670597283903604)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, 5 - 0.5 * sin((sine - 0.2) * 1), 0.2 * sin((sine - 1.2) * 1) - Cfw * 3),angles(-0.08726646259971647 + 0.17453292519943295 * sin((sine + 1.2) * 1) - Cfw, 0.08726646259971647 * sin(sine * 0.5) + Crt, 3.141592653589793)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.3962634015954636 + 0.12217304763960307 * sin((sine + 1.5) * 1), -1.2217304763960306 + 0.08726646259971647 * sin((sine + 0.2) * 0.5), 1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.9198621771937625 + 0.12217304763960307 * sin((sine + 1.5) * 1), 1.2217304763960306 + 0.08726646259971647 * sin((sine + 0.2) * 0.5), -1.5707963267948966)),deltaTime) 
			--LeftArm,-1,0,0,1,-175,-10,1.5,1,0.5,0,0,1,-90,5,0.6,1,0,0,0,1,-90,0,0,1,RightArm,1,0,0,1,180,-5,0,1,0.5,0,0,1,20,5,0.3,1,0,0,0,1,-110,5,1,1,Head,0,0,0,1,-75,-15,1.2,1,1,0,0,1,-0,5,0.2,0.5,0,0,0,1,-170,0,0,1,Torso,0,0,0,1,-5,10,1.2,1,5,-0.5,-0.2,1,-0,5,0,0.5,0,0.2,-1.2,1,180,0,0,1,LeftLeg,-1,0,0,1,80,7,1.5,1,-1,0,0,1,-70,5,0.2,0.5,0,0,0,1,90,0,0,1,RightLeg,1,0,0,1,110,7,1.5,1,-1,0,0,1,70,5,0.2,0.5,0,0,0,1,-90,0,0,1
		end,
		walk = function()
			local Vfw, Vrt = velbycfrvec()

			local Cfw, Crt = velchgbycfrvec()

			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(-3.0543261909900767 - 0.17453292519943295 * sin((sine + 1.5) * 1) - Vfw * 0.1, -1.5707963267948966 + 0.08726646259971647 * sin((sine + 0.6) * 1) + Vrt * 0.2, -1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(3.141592653589793 - 0.08726646259971647 * sin(sine * 1), 0.3490658503988659 + 0.08726646259971647 * sin((sine + 0.3) * 1), -1.9198621771937625 + 0.08726646259971647 * sin((sine + 1) * 1))),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.3089969389957472 - 0.2617993877991494 * sin((sine + 1.2) * 1) + Vfw * 0.1, 0.08726646259971647 * sin((sine + 0.2) * 0.5) - Vrt * 0.2, -2.9670597283903604)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, 5 - 0.5 * sin((sine - 0.2) * 1), 0.2 * sin((sine - 1.2) * 1) - Cfw * 3),angles(-0.08726646259971647 + 0.17453292519943295 * sin((sine + 1.2) * 1) - Vfw * 0.2 - Cfw, 0.08726646259971647 * sin(sine * 0.5) + Crt, 3.141592653589793 - Vrt * 0.2)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.3962634015954636 + 0.12217304763960307 * sin((sine + 1.5) * 1) - Vfw * 0.2, -1.2217304763960306 + 0.08726646259971647 * sin((sine + 0.2) * 0.5), 1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.9198621771937625 + 0.12217304763960307 * sin((sine + 1.5) * 1) - Vfw * 0.2, 1.2217304763960306 + 0.08726646259971647 * sin((sine + 0.2) * 0.5), -1.5707963267948966)),deltaTime) 
			--LeftArm,-1,0,0,1,-175,-10,1.5,1,0.5,0,0,1,-90,5,0.6,1,0,0,0,1,-90,0,0,1,RightArm,1,0,0,1,180,-5,0,1,0.5,0,0,1,20,5,0.3,1,0,0,0,1,-110,5,1,1,Head,0,0,0,1,-75,-15,1.2,1,1,0,0,1,-0,5,0.2,0.5,0,0,0,1,-170,0,0,1,Torso,0,0,0,1,-5,10,1.2,1,5,-0.5,-0.2,1,-0,5,0,0.5,0,0.2,-1.2,1,180,0,0,1,LeftLeg,-1,0,0,1,80,7,1.5,1,-1,0,0,1,-70,5,0.2,0.5,0,0,0,1,90,0,0,1,RightLeg,1,0,0,1,110,7,1.5,1,-1,0,0,1,70,5,0.2,0.5,0,0,0,1,-90,0,0,1
		end
	})
	addmode("g", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.9 + 0.4 * sin(sine * 8), 0.5, 0.5 * sin((sine + 0.25) * 4)),angles(1.5707963267948966, -1.5707963267948966 + 1.0471975511965976 * sin(sine * 8), 1.5707963267948966 + 0.6981317007977318 * sin((sine + 0.25) * 4))),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0.3 * sin((sine + 0.4) * 8) + Crt * 3, 0, Cfw * -3),angles(-1.5707963267948966 - Cfw, 0.3490658503988659 * sin(sine * 8) + Crt, -3.141592653589793)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.061086523819801536 * sin((sine + 0.125) * 16), -0.3839724354387525 * sin(sine * 8), -3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 + 0.4 * sin((sine - 0.01) * 8), 0),angles(1.5707963267948966, 1.7453292519943295 + 0.6981317007977318 * sin(sine * 8), -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 - 0.4 * sin((sine - 0.01) * 8), 0),angles(1.5707963267948966, -1.7453292519943295 + 0.6981317007977318 * sin(sine * 8), 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.9 + 0.4 * sin(sine * 8), 0.5, -0.5 * sin((sine - 0.35) * 4)),angles(1.5707963267948966 + 0.6981317007977318 * sin(sine * 4), 1.5707963267948966 + 1.0471975511965976 * sin(sine * 8), -1.5707963267948966 + 0.17453292519943295 * sin((sine - 0.35) * 4))),deltaTime) 
			--LeftArm,-0.9,0.4,0,8,90,0,0.25,4,0.5,0,0,8,-90,60,0,8,0,0.5,0.25,4,90,40,0.25,4,Torso,0,0.3,0.4,8,-90,0,0,8,0,0,0,4,0,20,0,8,0,0,0,8,-180,0,0,8,Head,0,0,0,8,-90,3.5,0.125,16,1,0,0,8,0,-22,0,8,0,0,0,8,-180,0,0,1.1,RightLeg,1,0,0,8,90,0,0,8,-1,0.4,-0.01,8,100,40,0,8,0,0,0,8,-90,0,0,8,LeftLeg,-1,0,0,8,90,0,0,8,-1,-0.4,-0.01,8,-100,40,0,8,0,0,0,8,90,0,0,8,RightArm,0.9,0.4,0,8,90,40,0,4,0.5,0,0,8,90,60,0,8,0,-0.5,-0.35,4,-90,10,-0.35,4
		end
	})
	addmode("h", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966, -0.4363323129985824 * sin(sine * 8), -3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 + 0.3 * sin(sine * 8), 0),angles(1.5707963267948966, 1.5707963267948966 + 0.5235987755982988 * sin(sine * 8), -1.5707963267948966)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.5, 1, 0),angles(-0.5235987755982988, -1.5707963267948966 - 0.5235987755982988 * sin(sine * 8), 3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.5, 1, 0),angles(-0.5235987755982988, 1.5707963267948966 - 0.5235987755982988 * sin(sine * 8), 3.141592653589793)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(-0.1 * sin(sine * 8) + Crt * 3, 0.2 * sin((sine + 0.1) * 16), Cfw * -3),angles(-1.5707963267948966 - Cfw, 0.2617993877991494 * sin(sine * 8) + Crt, -3.141592653589793)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 - 0.3 * sin(sine * 8), 0),angles(1.5707963267948966, -1.5707963267948966 + 0.5235987755982988 * sin(sine * 8), 1.5707963267948966)),deltaTime) 
			--Head,0,0,0,8,-90,0,0,8,1,0,0,8,0,-25,0,8,0,0,0,8,-180,0,0,8,RightLeg,1,0,0,8,90,0,0,8,-1,0.3,0,8,90,30,0,8,0,0,0,8,-90,0,0,8,LeftArm,-0.5,0,0,8,-30,0,0,8,1,0,0,8,-90,-30,0,8,0,0,0,8,180,0,0,8,RightArm,0.5,0,0,8,-30,0,0,8,1,0,0,16,90,-30,0,8,0,0,0,8,180,0,0,8,Torso,0,-0.1,0,8,-90,0,0,8,0,0.2,0.1,16,0,15,0,8,0,0,0,8,-180,0,0,8,LeftLeg,-1,0,0,8,90,0,0,8,-1,-0.3,0,8,-90,30,0,8,0,0,0,8,90,0,0,8,Fedora_Handle,8.657480066176504e-09,0,0,8,-6,0,0,8,-0.15052366256713867,0,0,8,0,0,0,8,-0.010221302509307861,0,0,8,0,0,0,8
		end
	})
	addmode("j", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-0.8, -1, -0.1),angles(0.17453292519943295, -0.6981317007977318, 0)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1.2, 0.5, 0),angles(-0.3490658503988659 + 0.08726646259971647 * sin((sine + 0.1) * 4), 0, 0.6981317007977318 + 0.08726646259971647 * sin((sine + 0.1) * 4))),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1.1, -1, 0),angles(1.5707963267948966, 1.7453292519943295, -1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.08726646259971647 * sin((sine + 0.1) * 4), 0, 2.792526803190927)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, -1.7 + 0.5 * sin(sine * 4), 0.15 * sin(sine * 4) - Cfw * 3),angles(3.3161255787892263 + 0.17453292519943295 * sin(sine * 4) - Cfw, Crt, 3.6651914291880923)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.8 + 0.4 * sin(sine * 4), 0.6 + 0.1 * sin(sine * 4), 0.4 - 0.25 * sin(sine * 4)),angles(2.9670597283903604, 2.2689280275926285 - 0.17453292519943295 * sin(sine * 4), -1.4835298641951802 - 0.17453292519943295 * sin(sine * 4))),deltaTime) 
			--GalaxyBeautifulHair_Handle,-0.15000000596046448,0,0,1,0,0,0,1,0.10000000149011612,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,LeftLeg,-0.8,0,0,4,10,0,0,4,-1,0,0,4,-40,0,0,4,-0.1,0,0,4,0,0,0,4,LeftArm,-1.2,0,0,4,-20,5,0.1,4,0.5,0,0,4,0,0,0,4,0,0,0,4,40,5,0.1,4,Fedora_Handle,8.657480066176504e-09,0,0,1,-6,0,0,1,-0.15052366256713867,0,0,1,0,0,0,1,-0.010221302509307861,0,0,1,0,0,0,1,ValkyrieHelm_Handle,8.658389560878277e-09,0,0,1,-15,0,0,1,-0.2433757781982422,0,0,1,0,0,0,1,-0.2657628059387207,0,0,1,0,0,0,1,RightLeg,1.1,0,0,4,90,0,0,4,-1,0,0,4,100,0,0,4,0,0,0,4,-90,0,0,4,BlackIronAntlers_Handle,8.658389560878277e-09,0,0,1,0,0,0,1,-0.6500000953674316,0,0,1,0,0,0,1,0.19972775876522064,0,0,1,0,0,0,1,DevAwardsAdurite_Handle,0,0,0,1,0,0,0,1,-0.25,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,SilverthornAntlers_Handle,8.658389560878277e-09,0,0,1,0,0,0,1,-0.6500000953674316,0,0,1,0,0,0,1,0.19972775876522064,0,0,1,0,0,0,1,Head,0,0,0,4,-90,5,0.1,4,1,0,0,4,-0,0,0,4,0,0,0,4,160,0,0,4,Torso,0,0,0,4,190,10,0,4,-1.70,0.5,0,4,-0,0,0,4,0,0.15,0,4,210,0,0,4,RightArm,0.8,0.4,0,4,170,0,0,4,0.6,0.1,0,4,130,-10,0,4,0.4,-0.25,0,4,-85,-10,0,4
		end
	})
	addmode("k", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.6580627893946132 - 0.08726646259971647 * sin((sine + 0.3333333333333333) * 12), -0.08726646259971647 * sin((sine + 0.2) * 6), 3.141592653589793)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.5 - 0.5 * sin((sine + 0.39999999999999997) * 12), -0.5),angles(1.7453292519943295 - 1.0471975511965976 * sin(sine * 6), -1.5707963267948966 + 0.1308996938995747 * sin(sine * 6), 1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.5 - 0.5 * sin((sine + 0.39999999999999997) * 12), -0.5),angles(1.7453292519943295 + 1.0471975511965976 * sin(sine * 6), 1.5707963267948966 + 0.1308996938995747 * sin(sine * 6), -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, -0.5 + 0.3 * sin((sine + 0.16666666666666666) * 12), Cfw * -3),angles(-1.3962634015954636 + 0.08726646259971647 * sin((sine + 0.3333333333333333) * 12) - Cfw, 0.08726646259971647 * sin((sine + 0.06666666666666667) * 6) + Crt, 3.141592653589793)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.8 - 0.1 * sin(sine * 6), 0.5 + 0.1 * sin(sine * 6), -0.2),angles(3.141592653589793 - 0.17453292519943295 * sin((sine + 0.39999999999999997) * 12), -0.17453292519943295, 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.8 - 0.1 * sin(sine * 6), 0.5 - 0.1 * sin(sine * 6), -0.2),angles(3.141592653589793 - 0.17453292519943295 * sin((sine + 0.39999999999999997) * 12), 0.17453292519943295, -1.5707963267948966)),deltaTime) 
			--GalaxyBeautifulHair_Handle,-0.15000000596046448,0,0,1.5,0,0,0,1.5,0.10000000149011612,0,0,1.5,0,0,0,1.5,0,0,0,1.5,0,0,0,1.5,Head,0,0,0,6,-95,-5,0.3333333333333333,12,1,0,0,6,-0,-5,0.2,6,0,0,0,6,180,0,0,6,ValkyrieHelm_Handle,8.658389560878277e-09,0,0,1.5,-15,0,0,1.5,-0.2433757781982422,0,0,1.5,0,0,0,1.5,-0.2657628059387207,0,0,1.5,0,0,0,1.5,SilverthornAntlers_Handle,8.658389560878277e-09,0,0,1.5,0,0,0,1.5,-0.6500000953674316,0,0,1.5,0,0,0,1.5,0.19972775876522064,0,0,1.5,0,0,0,1.5,BlackIronAntlers_Handle,8.658389560878277e-09,0,0,1.5,0,0,0,1.5,-0.6500000953674316,0,0,1.5,0,0,0,1.5,0.19972775876522064,0,0,1.5,0,0,0,1.5,Fedora_Handle,8.657480066176504e-09,0,0,1.5,-6,0,0,1.5,-0.15052366256713867,0,0,1.5,0,0,0,1.5,-0.010221302509307861,0,0,1.5,0,0,0,1.5,LeftLeg,-1,0,0,6,100,-60,0,6,-0.5,-0.5,0.39999999999999997,12,-90,7.5,0,6,-0.5,0,0,6,90,0,0,6,EyelessSmileHead_Handle,-0.00043487548828125,0,0,1.5,180,0,0,1.5,0.6000361442565918,0,0,1.5,0,0,0,1.5,0.0003204345703125,0,0,1.5,180,0,0,1.5,RightLeg,1,0,0,6,100,60,0,6,-0.5,-0.5,0.39999999999999997,12,90,7.5,0,6,-0.5,0,0,6,-90,0,0,6,DevAwardsAdurite_Handle,0,0,0,1.5,0,0,0,1.5,-0.25,0,0,1.5,0,0,0,1.5,0,0,0,1.5,0,0,0,1.5,Torso,0,0,0,6,-80,5,0.3333333333333333,12,-0.5,0.3,0.16666666666666666,12,-0,5,0.06666666666666667,6,0,0,0,6,180,0,0,6,LeftArm,-0.8,-0.1,0,6,180,-10,0.39999999999999997,12,0.5,0.1,0,6,-10,0,0,6,-0.2,0,0,6,90,0,0,6,RightArm,0.8,-0.1,0,6,180,-10,0.39999999999999997,12,0.5,-0.1,0,6,10,0,0,6,-0.2,0,0,6,-90,0,0,6
		end
	})
	addmode("l", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.04363323129985824 * sin((sine + 0.1) * 1), -0.17453292519943295 * sin((sine + 0.1) * 5), -3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 + 0.2 * sin(sine * 5), -0.2 + 0.2 * sin(sine * 5)),angles(2.181661564992912 - 0.8726646259971648 * sin(sine * 5), 1.9198621771937625 - 0.3490658503988659 * sin(sine * 5), -1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.7, 0.8, 0),angles(1.0471975511965976 + 0.03490658503988659 * sin(sine * 10), 2.0943951023931953 + 0.10471975511965978 * sin((sine + 0.1) * 5), 1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 - 0.2 * sin(sine * 5), -0.2 - 0.2 * sin(sine * 5)),angles(2.181661564992912 + 0.8726646259971648 * sin(sine * 5), -1.9198621771937625 - 0.3490658503988659 * sin(sine * 5), 1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, 0.15 + 0.4 * sin((sine - 0.5) * 10), Cfw * -3),angles(-1.4835298641951802 - Cfw, 0.17453292519943295 * sin(sine * 5) + Crt, -3.141592653589793)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.7, 0.5, -0.3),angles(1.7453292519943295, -0.8726646259971648, 1.5707963267948966)),deltaTime) 
			--Head,0,0,0,5,-90,2.5,0.1,1,1,0,0,4,0,-10,0.1,5,0,0,0,4,-180,0,0,4,RightLeg,1,0,0,4,125,-50,0,5,-1,0.2,0,5,110,-20,0,5,-0.2,0.2,0,5,-90,0,0,4,RightArm,0.7,0,0,4,60,2,0,10,0.8,0,0,4,120,6,0.1,5,0,0,0,4,90,0,0,4,LeftLeg,-1,0,0,4,125,50,0,5,-1,-0.2,0,5,-110,-20,0,5,-0.2,-0.2,0,5,90,0,0,4,Torso,0,0,0,4,-85,0,0,4,0.15,0.4,-0.5,10,0,10,0,5,0,0,0,4,-180,0,0,4,LeftArm,-0.7,0,0,4,100,0,0,4,0.5,0,0,4,-50,0,0,4,-0.3,0,0,4,90,0,0,4
		end
	})

	addmode("x", {
		idle = function()
			local Cfw, Crt = velchgbycfrvec()

			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(0, 1.5707963267948966, 0)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966, 0, 3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(0, 1.5707963267948966, 0)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(0, -1.5707963267948966, 0)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, 0, Cfw * -3),angles(-1.5707963267948966 - Cfw, Crt, 3.141592653589793)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(0, -1.5707963267948966, 0)),deltaTime) 
			--RightArm,1,0,0,1,0,0,0,1,0.5,0,0,1,90,0,0,1,0,0,0,1,0,0,0,1,Fedora_Handle,8.657480066176504e-09,0,0,1,-6,0,0,1,-0.15052366256713867,0,0,1,0,0,0,1,-0.010221302509307861,0,0,1,0,0,0,1,Head,0,0,0,1,-90,0,0,1,1,0,0,1,-0,0,0,1,0,0,0,1,180,0,0,1,RightLeg,1,0,0,1,0,0,0,1,-1,0,0,1,90,0,0,1,0,0,0,1,0,0,0,1,LeftLeg,-1,0,0,1,-0,0,0,1,-1,0,0,1,-90,0,0,1,0,0,0,1,0,0,0,1,Torso,0,0,0,1,-90,0,0,1,0,0,0,1,-0,0,0,1,0,0,0,1,180,0,0,1,LeftArm,-1,0,0,1,-0,0,0,1,0.5,0,0,1,-90,0,0,1,0,0,0,1,0,0,0,1
		end,
		walk = function()
			local Cfw, Crt = velchgbycfrvec()

			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(0, 1.5707963267948966, 0)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966, 0, 3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(0, 1.5707963267948966, 0)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(0, -1.5707963267948966, 0)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(Crt * 3, 0, Cfw * -3),angles(-1.5707963267948966 - Cfw, Crt, 3.141592653589793)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(0, -1.5707963267948966, 0)),deltaTime) 
			--RightArm,1,0,0,1,0,0,0,1,0.5,0,0,1,90,0,0,1,0,0,0,1,0,0,0,1,Fedora_Handle,8.657480066176504e-09,0,0,1,-6,0,0,1,-0.15052366256713867,0,0,1,0,0,0,1,-0.010221302509307861,0,0,1,0,0,0,1,Head,0,0,0,1,-90,0,0,1,1,0,0,1,-0,0,0,1,0,0,0,1,180,0,0,1,RightLeg,1,0,0,1,0,0,0,1,-1,0,0,1,90,0,0,1,0,0,0,1,0,0,0,1,LeftLeg,-1,0,0,1,-0,0,0,1,-1,0,0,1,-90,0,0,1,0,0,0,1,0,0,0,1,Torso,0,0,0,1,-90,0,0,1,0,0,0,1,-0,0,0,1,0,0,0,1,180,0,0,1,LeftArm,-1,0,0,1,-0,0,0,1,0.5,0,0,1,-90,0,0,1,0,0,0,1,0,0,0,1
		end
	})
end)

btn("nameless animations V6", function()
	local t=reanimate()
	if type(t)~="table" then return end
	local raycastlegs=t.raycastlegs
	local velbycfrvec=t.velbycfrvec
	local addmode=t.addmode
	local getJoint=t.getJoint
	local RootJoint=getJoint("RootJoint")
	local RightShoulder=getJoint("Right Shoulder")
	local LeftShoulder=getJoint("Left Shoulder")
	local RightHip=getJoint("Right Hip")
	local LeftHip=getJoint("Left Hip")
	local Neck=getJoint("Neck")
	addmode("default", {
		idle = function()
			local rY, lY = raycastlegs()

			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.3 + 0.1 * sin(sine * 2), -0.1),angles(-0.5235987755982988 + 0.05235987755982989 * sin((sine + 1.5) * 2), 1.0471975511965976 + 0.08726646259971647 * sin((sine + 0.5) * 2), 0.5235987755982988)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.6580627893946132 + 0.08726646259971647 * sin((sine + 0.6) * 2), 0, 3.141592653589793 + 0.2617993877991494 * sin((sine - 1.2) * 1))),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 0.1 * sin(sine * 2), 0),angles(-1.5707963267948966 + 0.08726646259971647 * sin(sine * 2), 0, 3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 - 0.1 * sin(sine * 2) + rY, 0.1 * sin(sine * 2) - rY * 0.5),angles(-0.6981317007977318 - 0.08726646259971647 * sin(sine * 2), 1.0471975511965976, 0.5235987755982988)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.6 + 0.1 * sin(sine * 2), 0),angles(3.141592653589793 + 0.05235987755982989 * sin((sine + 0.5) * 2), -2.705260340591211 + 0.017453292519943295 * sin((sine + 1.5) * 2), -1.2217304763960306 + 0.05235987755982989 * sin((sine + 1.5) * 2))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 - 0.1 * sin(sine * 2) + lY, 0.1 * sin(sine * 2) - lY * 0.5),angles(-0.3490658503988659 - 0.08726646259971647 * sin(sine * 2), -1.0471975511965976, -0.5235987755982988)),deltaTime) 
			--RightArm,1,0,0,2,-30,3,1.5,2,0.3,0.1,0,2,60,5,0.5,2,-0.1,0,0,2,30,0,0,2,Head,0,0,0,2,-95,5,0.6,2,1,0,0,2,-0,0,0,1,0,0,0,2,180,15,-1.2,1,Torso,0,0,0,2,-90,5,0,2,0,0.1,0,2,-0,0,0,2,0,0,0,2,180,0,0,2,RightLeg,1,0,0,2,-40,-5,0,2,-1,-0.1,0,2,60,0,0,2,0,0.1,0,2,30,0,0,2,Meshes/TrollFaceHeadAccessory_Handle,0.01043701171875,0,0,1,0,0,0,1,0.43610429763793945,0,0,1,0,0,0,1,-0.01102447509765625,0,0,1,0,0,0,1,LeftArm,-1,0,0,2,180,3,0.5,2,0.6,0.1,0,2,-155,1,1.5,2,0,0,0,2,-70,3,1.5,2,LeftLeg,-1,0,0,2,-20,-5,0,2,-1,-0.1,0,2,-60,0,0,2,0,0.1,0,2,-30,0,0,2
		end,
		walk = function()
			local fw, rt = velbycfrvec()

			local rY, lY = raycastlegs()

			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, -0.2 + 0.2 * sin(sine * 16), 0),angles(-1.6580627893946132 + 0.04363323129985824 * sin(sine * 16) - fw * 0.15, 0.03490658503988659 * sin(sine * 8) + rt * 0.15, -3.141592653589793 - 0.08726646259971647 * sin((sine + 0.25) * 8) - rt * 0.1)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.8 + 0.4 * sin((sine + 0.125) * 8) + rY, -0.15 * fw + 0.4 * sin((sine + 10) * 8) * fw + rY * -0.5),angles(1.3962634015954636 + 0.6981317007977318 * sin(sine * 8)*fw, 1.5707963267948966 + 0.6981317007977318 * sin(sine * 8)*rt, -1.5707963267948966 + 0.2617993877991494 * sin(sine * 8))),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.35 - 0.1 * sin(sine * 8), 0),angles(0.5235987755982988 * sin(sine * 8)*fw, -1.5707963267948966 - 0.5235987755982988 * sin(sine * 8)*fw, -0.5235987755982988 * sin(sine * 8)*fw)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.35 + 0.1 * sin(sine * 8), 0),angles(-0.5235987755982988 * sin(sine * 8)*fw, 1.5707963267948966 - 0.5235987755982988 * sin(sine * 8)*fw, -0.5235987755982988 * sin(sine * 8)*fw)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.8 - 0.4 * sin((sine + 0.125) * 8) + lY, -0.15 * fw - 0.4 * sin((sine + 10) * 8) * fw + lY * -0.5),angles(1.3962634015954636 - 0.6981317007977318 * sin(sine * 8)*fw, -1.5707963267948966 - 0.6981317007977318 * sin(sine * 8)*rt, 1.5707963267948966 + 0.2617993877991494 * sin(sine * 8))),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.08726646259971647 * sin((sine + 10) * 16) + fw * 0.15, -0.08726646259971647 * sin(sine * 8) + rt * -0.1, 3.141592653589793 - 0.05235987755982989 * sin((sine + 5) * 8) - rt * 0.5)),deltaTime) 
			--Torso,0,0,0,8,-95,2.5,0,16,-0.2,0.2,0,16,0,5,0,8,0,0,0,8,-180,-5,0.25,8,RightArm,1,0,0,1,0,-30,0,8,0.35,0.1,0,8,90,-30,0,8,0,0,0,8,0,-30,0,8,RightLeg,1,0,0,8,80,40,0,8,-0.8,0.4,0.125,8,90,40,0,8,-0.15,0.4,10,8,-90,15,0,8,LeftLeg,-1,0,0,8,80,-40,0,8,-0.8,-0.4,0.125,8,-90,-40,0,8,-0.15,-0.4,10,8,90,15,0,8,Head,0,0,0,1,-90,2.5,10,16,1,0,0,1,-0,-5,0,8,0,0,0,1,180,-3,5,8,LeftArm,-1,0,0,1,0,30,0,8,0.35,-0.1,0,8,-90,-30,0,8,0,-0.4,0,8,0,-30,0,8
		end,
		jump = function()
			local fw, rt = velbycfrvec()

			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf_0,angles(-1.4835298641951802 + fw * 0.1, rt * -0.05, -3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(4.014257279586958 - 0.08726646259971647 * sin((sine + 0.5) * 4), 1.7453292519943295 + 0.08726646259971647 * sin((sine + 0.25) * 4), -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.5) * 4), -1.6580627893946132 + 0.06981317007977318 * sin((sine + 0.25) * 4), 1.5707963267948966)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(4.014257279586958 - 0.08726646259971647 * sin((sine + 0.5) * 4), -1.7453292519943295 - 0.08726646259971647 * sin((sine + 0.25) * 4), 1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.3962634015954636, 0, -3.141592653589793 - rt)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.5) * 4), 1.6580627893946132 - 0.06981317007977318 * sin((sine + 0.25) * 4), -1.5707963267948966)),deltaTime) 
			--Torso,0,0,0,4,-85,0,0,4,0,0,0,4,0,0,0,4,0,0,0,4,-180,0,0,4,RightArm,1,0,0,4,230,-5,0.5,4,0.5,0,0,4,100,5,0.25,4,0,0,0,4,-90,0,0,4,LeftLeg,-1,0,0,4,90,-5,0.5,4,-1,0,0,4,-95,4,0.25,4,0,0,0,4,90,0,0,4,LeftArm,-1,0,0,4,230,-5,0.5,4,0.5,0,0,4,-100,-5,0.25,4,0,0,0,4,90,0,0,4,Head,0,0,0,4,-80,0,0.5,4,1,0,0,4,0,0,0.25,4,0,0,0,4,-180,0,0,4,RightLeg,1,0,0,4,90,-5,0.5,4,-1,0,0,4,95,-4,0.25,4,0,0,0,4,-90,0,0,4
		end,
		fall = function()
			local fw, rt = velbycfrvec()

			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf_0,angles(-1.6580627893946132 + fw * 0.1, rt * -0.05, -3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(4.014257279586958 - 0.08726646259971647 * sin((sine + 0.5) * 4), 1.7453292519943295 + 0.08726646259971647 * sin((sine + 0.25) * 4), -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.5) * 4), -1.6580627893946132 + 0.06981317007977318 * sin((sine + 0.25) * 4), 1.5707963267948966)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(4.014257279586958 - 0.08726646259971647 * sin((sine + 0.5) * 4), -1.7453292519943295 - 0.08726646259971647 * sin((sine + 0.25) * 4), 1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.7453292519943295, 0, -3.141592653589793 - rt)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.5) * 4), 1.6580627893946132 - 0.06981317007977318 * sin((sine + 0.25) * 4), -1.5707963267948966)),deltaTime) 
			--Torso,0,0,0,4,-95,0,0,4,0,0,0,4,0,0,0,4,0,0,0,4,-180,0,0,4,RightArm,1,0,0,4,230,-5,0.5,4,0.5,0,0,4,100,5,0.25,4,0,0,0,4,-90,0,0,4,LeftLeg,-1,0,0,4,90,-5,0.5,4,-1,0,0,4,-95,4,0.25,4,0,0,0,4,90,0,0,4,LeftArm,-1,0,0,4,230,-5,0.5,4,0.5,0,0,4,-100,-5,0.25,4,0,0,0,4,90,0,0,4,Head,0,0,0,4,-100,0,0.5,4,1,0,0,4,0,0,0.25,4,0,0,0,4,-180,0,0,4,RightLeg,1,0,0,4,90,-5,0.5,4,-1,0,0,4,95,-4,0.25,4,0,0,0,4,-90,0,0,4
		end
	})

	addmode("q", {
		idle = function()
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.75, -0.2),angles(2.705260340591211 - 0.08726646259971647 * sin((sine + 0.1) * 2), -2.792526803190927, -0.6981317007977318)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.75, -0.2),angles(2.705260340591211 - 0.08726646259971647 * sin((sine + 0.1) * 2), 2.792526803190927, 0.6981317007977318)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.9198621771937625 - 0.10471975511965978 * sin((sine + 0.3) * 2), 0, 3.141592653589793)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, -2.45 - 0.05 * sin(sine * 2), 0),angles(0.03490658503988659 * sin(sine * 2), 0, 3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.3962634015954636 - 0.03490658503988659 * sin(sine * 2), 1.3089969389957472, -0.9599310885968813)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.5707963267948966 - 0.03490658503988659 * sin(sine * 2), -1.3089969389957472, 1.5707963267948966)),deltaTime) 
			--LeftArm,-1,0,0,2,155,-5,0.1,2,0.75,0,0,2,-160,0,0,2,-0.2,0,0,2,-40,0,0,2,RightArm,1,0,0,2,155,-5,0.1,2,0.75,0,0,2,160,0,0,2,-0.2,0,0,2,40,0,0,2,Head,0,0,0,2,-110,-6,0.3,2,1,0,0,2,-0,0,0,2,0,0,0,2,180,0,0,2,Torso,0,0,0,2,0,2,0,2,-2.45,-0.05,0,2,-0,0,0,2,0,0,0,2,180,0,0,2,RightLeg,1,0,0,2,80,-2,0,2,-1,0,0,2,75,0,0,2,0,0,0,2,-55,0,0,2,LeftLeg,-1,0,0,2,90,-2,0,2,-1,0,0,2,-75,0,0,2,0,0,0,2,90,0,0,2
		end
	})
	addmode("e", {
		idle = function()
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.9, 0.4 + 0.1 * sin(sine * 2), 0.3 - 0.15 * sin(sine * 2)),angles(-1.0471975511965976 - 0.12217304763960307 * sin(sine * 2), -1.3962634015954636, -0.6981317007977318)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, -1.85 - 0.1 * sin((sine + 0.2) * 2), 0),angles(-1.3962634015954636 + 0.03490658503988659 * sin(sine * 2), -0.08726646259971647, 3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.4 + 0.1 * sin(sine * 2), 0.2 - 0.15 * sin(sine * 2)),angles(0.6108652381980153 - 0.12217304763960307 * sin(sine * 2), 1.2217304763960306, -0.7853981633974483)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.6580627893946132 - 0.03490658503988659 * sin((sine + 0.6) * 2), 0.10471975511965978 + 0.06981317007977318 * sin(sine * 0.66), 3.141592653589793 + 0.3490658503988659 * sin(sine * 0.66))),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, 0.2 + 0.15 * sin((sine + 0.2) * 2), -0.7 + 0.1 * sin(sine * 2)),angles(1.4835298641951802 + 0.03490658503988659 * sin(sine * 2), 1.4835298641951802, -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.75 + 0.1 * sin((sine + 0.2) * 2), -0.5),angles(1.3962634015954636 - 0.03490658503988659 * sin(sine * 2), -1.6580627893946132, 0)),deltaTime) 
			--LeftArm,-0.9,0,0,2,-60,-7,0,2,0.4,0.1,0,2,-80,0,0,2,0.3,-0.15,0,2,-40,0,0,2,Torso,0,0,0,2,-80,2,0,2,-1.85,-0.1,0.2,2,-5,0,0,2,0,0,0,2,180,0,0,2,RightArm,1,0,0,2,35,-7,0,2,0.4,0.1,0,2,70,0,0,2,0.2,-0.15,0,2,-45,0,0,2,Head,0,0,0,2,-95,-2,0.6,2,1,0,0,2,6,4,0,0.66,0,0,0,2,180,20,0,0.66,RightLeg,1,0,0,2,85,2,0,2,0.2,0.15,0.2,2,85,0,0,2,-0.7,0.1,0,2,-90,0,0,2,LeftLeg,-1,0,0,2,80,-2,0,2,-0.75,0.1,0.2,2,-95,0,0,2,-0.5,0,0,2,0,0,0,2
		end
	})
	addmode("r", {
		idle = function()
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.9 - 0.2 * sin(sine * 2), 0),angles(1.5707963267948966, 1.6580627893946132 - 0.17453292519943295 * sin(sine + 0.8), -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0.3 * sin(sine + 0.8), -0.1 + 0.2 * sin(sine * 2), 0),angles(-1.5707963267948966, 0, -3.141592653589793)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.08726646259971647 * sin((sine - 0.5) * 2), 0.08726646259971647 * sin(sine - 1), -3.141592653589793 + 0.2617993877991494 * sin(sine * 5))),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1 + 0.1 * sin(sine * 7), 0.2 - 0.1 * sin(sine + 0.8), -0.25),angles(1.5707963267948966 + 0.5235987755982988 * sin(sine * 7), -0.6981317007977318, 0.3490658503988659 * sin(sine * 7))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.9 - 0.2 * sin(sine * 2), 0),angles(1.5707963267948966, -1.6580627893946132 - 0.17453292519943295 * sin(sine + 0.8), 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1 + 0.1 * sin(sine * 7), 0.2 + 0.1 * sin(sine + 0.8), -0.25),angles(1.5707963267948966 - 0.5235987755982988 * sin(sine * 7), 0.6981317007977318, 0.3490658503988659 * sin(sine * 7))),deltaTime) 
			--RightLeg,1,0,0,1,90,0,0,1,-0.9,-0.2,0,2,95,-10,0.8,1,0,0,0,1,-90,0,0,1,Torso,0,0.3,0.8,1,-90,0,0,1,-0.1,0.2,0,2,0,0,0,1,0,0,0,1,-180,0,0,1,Head,0,0,0,1,-90,5,-0.5,2,1,0,0,1,0,5,-1,1,0,0,0,1,-180,15,0,5,Fedora_Handle,8.657480066176504e-09,0,0,1,-6,0,0,1,-0.15052366256713867,0,0,1,0,0,0,1,-0.010221302509307861,0,0,1,0,0,0,1,LeftArm,-1,0.1,0,7,90,30,0,7,0.2,-0.1,0.8,1,-40,0,0,1,-0.25,0,0,1,0,20,0,7,LeftLeg,-1,0,0,1,90,0,0,1,-0.9,-0.2,0,2,-95,-10,0.8,1,0,0,0,1,90,0,0,1,RightArm,1,0.1,0,7,90,-30,0,7,0.2,0.1,0.8,1,40,0,0,1,-0.25,0,0,1,-0,20,0,7
		end
	})
	addmode("t", {
		idle = function()
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(1.5707963267948966, -1.6580627893946132 + 0.08726646259971647 * sin((sine - 0.3) * 4), 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1 + 0.15 * sin((sine - 0.4) * 4), 1.42, 0),angles(1.5707963267948966, 1.4835298641951802 - 0.3490658503988659 * sin((sine - 0.4) * 4), 1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.4835298641951802, 0.04363323129985824 - 0.08726646259971647 * sin((sine + 0.1) * 4), -3.141592653589793 + 0.04363323129985824 * sin(sine * 4))),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0.1 * sin(sine * 4), 0, 0),angles(-1.5707963267948966, -0.08726646259971647 + 0.08726646259971647 * sin(sine * 4), -3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1.1 + 0.1 * sin(sine * 4), 0),angles(1.5707963267948966, 1.5707963267948966 + 0.08726646259971647 * sin(sine * 4), -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1 - 0.02 * sin(sine * 4), -0.925 - 0.07 * sin(sine * 4), 0),angles(1.5707963267948966, -1.7453292519943295 + 0.08726646259971647 * sin(sine * 4), 1.5707963267948966)),deltaTime) 
			--LeftArm,-1,0,0,4,90,0,0,4,0.5,0,0,4,-95,5,-0.3,4,0,0,0,4,90,0,0,4,RightArm,1,0.15,-0.4,4,90,0,0,4,1.42,0,0,4,85,-20,-0.4,4,0,0,0,4,90,0,0,4,Head,0,0,0,4,-85,0,0,4,1,0,0,4,2.5,-5,0.1,4,0,0,0,4,-180,2.5,0,4,Torso,0,0.1,0,4,-90,0,0,4,0,0,0,4,-5,5,0,4,0,0,0,4,-180,0,0,4,RightLeg,1,0,0,4,90,0,0,4,-1.1,0.1,0,4,90,5,0,4,0,0,0,4,-90,0,0,4,LeftLeg,-1,-0.02,0,4,90,0,0,4,-0.925,-0.07,0,4,-100,5,0,4,0,0,0,4,90,0,0,4
		end
	})
	addmode("y", {
		idle = function()
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1.5, 0.5, 0),angles(-1.7453292519943295, 0.17453292519943295 - 0.04363323129985824 * sin(sine * 2), -1.4835298641951802)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.9000000953674316 - 0.1 * sin(sine * 2), 0),angles(-1.3962634015954636, 1.3962634015954636, 1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1.0000001192092896 - 0.1 * sin(sine * 2), 0),angles(-1.5707963267948966, -1.3962634015954636, -1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-2.0943951023931953 + 0.08726646259971647 * sin((sine - 1) * 2), -0.08726646259971647, 2.792526803190927)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 1.2000000476837158, 0),angles(2.6179938779914944 + 0.08726646259971647 * sin((sine - 1) * 2), 0.6981317007977318, -1.3962634015954636)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 0.1 * sin(sine * 2), 0),angles(-1.6580627893946132, 0.08726646259971647, 3.0543261909900767)),deltaTime) 
			--LeftArm,-1.5,0,0,2,-100,0,0,2,0.5,0,0,2,10,-2.5,0,2,0,0,0,2,-85,0,0,2,RightLeg,1,0,0,2,-80,0,0,2,-0.9000000953674316,-0.1,0,2,80,0,0,2,0,0,0,2,90,0,0,2,LeftLeg,-1,0,0,2,-90,0,0,2,-1.0000001192092896,-0.1,0,2,-80,0,0,2,0,0,0,2,-90,0,0,2,Fedora_Handle,8.657480066176504e-09,0,0,2,-6,0,0,2,-0.15052366256713867,0,0,2,0,0,0,2,-0.010221302509307861,0,0,2,0,0,0,2,Head,0,0,0,2,-120,5,-1,2,1,0,0,2,-5,0,0,2,0,0,0,2,160,0,0,2,RightArm,1,0,0,2,150,5,-1,2,1.2000000476837158,0,0,2,40,0,0,2,0,0,0,2,-80,0,0,2,Torso,0,0,0,2,-95,0,0,2,0,0.1,0,2,5,0,0,2,0,0,0,2,175,0,0,2
		end
	})
	addmode("u", {
		idle = function()
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 0.75 + 0.25 * sin(sine * 2), 0),angles(-1.5707963267948966, 0, 3.141592653589793)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1.5 - 0.1 * sin((sine + 0.2) * 2), 0),angles(-1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.4) * 2), 0, 3.141592653589793 + 0.3490658503988659 * sin(sine * 0.66))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-0.5 - 1 * sin((sine + 0.2) * 2.2), -0.75 - 0.25 * sin(sine * 2), 1 * sin((sine + 0.95) * 2.2)),angles(0, -1.5707963267948966, 0)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(0.5 + 1 * sin((sine + 0.2) * 2.2), -0.75 - 0.25 * sin(sine * 2), -1 * sin((sine + 0.95) * 2.2)),angles(0, 1.5707963267948966, 0)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(-0.5 - 1.85 * sin(sine * 2), 0.8 - 0.5 * sin(sine * 2), -1.85 * sin((sine + 0.75) * 2)),angles(0, 1.5707963267948966, 0)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(0.5 + 1.85 * sin(sine * 2), 0.8 - 0.5 * sin(sine * 2), 1.85 * sin((sine + 0.75) * 2)),angles(0, -1.5707963267948966, 0)),deltaTime) 
			--Torso,0,0,0,2,-90,0,0,2,0.75,0.25,0,2,-0,0,0,2,0,0,0,2,180,0,0,2,Fedora_Handle,8.657480066176504e-09,0,0,2,-6,0,0,2,-0.15052366256713867,0,0,2,0,0,0,2,-0.010221302509307861,0,0,2,0,0,0,2,Head,0,0,0,2,-90,-5,0.4,2,1.5,-0.1,0.2,2,-0,0,0,2,0,0,0,2,180,20,0,0.66,LeftLeg,-0.5,-1,0.2,2.2,-0,0,0,2,-0.75,-0.25,0,2,-90,0,0,2,0,1,0.95,2.2,0,0,0,2,RightLeg,0.5,1,0.2,2.2,0,0,0,2,-0.75,-0.25,0,2,90,0,0,2,0,-1,0.95,2.2,0,0,0,2,RightArm,-0.5,-1.85,0,2,0,0,0,2,0.8,-0.5,0,2,90,0,0,2,0,-1.85,0.75,2,0,0,0,2,LeftArm,0.5,1.85,0,2,-0,0,0,2,0.8,-0.5,0,2,-90,0,0,2,0,1.85,0.75,2,0,0,0,2
		end
	})
	addmode("i", {
		idle = function()
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.5, 0.5 + 0.1 * sin((sine - 0.4444444444444444) * 9), 0),angles(2.9670597283903604 + 0.17453292519943295 * sin((sine - 0.17777777777777778) * 9), -0.5235987755982988, 1.5707963267948966 + 0.17453292519943295 * sin(sine * 4.5))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.5 + 0.1 * sin((sine + 0.26666666666666666) * 4.5), -0.5),angles(1.7453292519943295 - 1.0471975511965976 * sin(sine * 4.5), -1.5707963267948966 + 0.03490658503988659 * sin(sine * 4.5), 1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, -0.5 + 0.5 * sin((sine + 0.17777777777777778) * 9), 0),angles(-1.3962634015954636 - 0.03490658503988659 * sin((sine + 0.17777777777777778) * 9), -0.05235987755982989 * sin(sine * 4.5), 3.141592653589793 + 0.03490658503988659 * sin(sine * 4.5))),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1 + 0.2 * sin(sine * 9), 0),angles(-1.5707963267948966 + 0.08726646259971647 * sin(sine * 9), 0.08726646259971647 * sin(sine * 4.5), 3.141592653589793 - 0.06981317007977318 * sin(sine * 4.5))),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.5, 0.5 + 0.1 * sin((sine - 0.4444444444444444) * 9), 0),angles(2.9670597283903604 + 0.17453292519943295 * sin((sine - 0.17777777777777778) * 9), 0.5235987755982988, -1.5707963267948966 + 0.17453292519943295 * sin(sine * 4.5))),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.5 + 0.1 * sin((sine - 0.26666666666666666) * 4.5), -0.5),angles(1.7453292519943295 + 1.0471975511965976 * sin(sine * 4.5), 1.5707963267948966 + 0.03490658503988659 * sin(sine * 4.5), -1.5707963267948966)),deltaTime) 
			--LeftArm,-0.5,0,0,4.5,170,10,-0.17777777777777778,9,0.5,0.1,-0.4444444444444444,9,-30,0,0,4.5,0,0,0,4.5,90,10,0,4.5,LeftLeg,-1,0,0,4.5,100,-60,0,4.5,-0.5,0.1,0.26666666666666666,4.5,-90,2,0,4.5,-0.5,0,0,4.5,90,0,0,4.5,Torso,0,0,0,4.5,-80,-2,0.17777777777777778,9,-0.5,0.5,0.17777777777777778,9,-0,-3,0,4.5,0,0,0,4.5,180,2,0,4.5,Head,0,0,0,4.5,-90,5,0,9,1,0.2,0,9,-0,5,0,4.5,0,0,0,4.5,180,-4,0,4.5,RightArm,0.5,0,0,4.5,170,10,-0.17777777777777778,9,0.5,0.1,-0.4444444444444444,9,30,0,0,4.5,0,0,0,4.5,-90,10,0,4.5,RightLeg,1,0,0,4.5,100,60,0,4.5,-0.5,0.1,-0.26666666666666666,4.5,90,2,0,4.5,-0.5,0,0,4.5,-90,0,0,4.5
		end,
	})
	addmode("o", {
		idle = function()
			local rY, lY = raycastlegs()

			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 + lY, lY * -0.5),angles(-1.8325957145940461 - 0.08726646259971647 * sin(sine * 2), -1.4835298641951802, -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 0, 0.09 * sin(sine * 2)),angles(-1.3962634015954636 + 0.08726646259971647 * sin(sine * 2), -0.08726646259971647, 3.141592653589793)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(2.9670597283903604 + 0.08726646259971647 * sin(sine * 1), -1.5707963267948966 + 0.08726646259971647 * sin((sine + 0.6) * 1), 1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1.1 + rY, rY * -0.5),angles(-1.7453292519943295 - 0.08726646259971647 * sin(sine * 2), 1.5707963267948966, 1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.2217304763960306 - 0.08726646259971647 * sin((sine + 0.3) * 2), -0.2617993877991494 - 0.08726646259971647 * sin(sine * 2), 3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(2.8797932657906435 + 0.08726646259971647 * sin(sine * 1), 1.5707963267948966 - 0.08726646259971647 * sin((sine + 0.6) * 1), -1.5707963267948966)),deltaTime) 
			--LeftLeg,-1,0,0,2,-105,-5,0,2,-1,0,0,2,-85,0,0,2,0,0,0,2,-90,0,0.75,2,Torso,0,0,0,2,-80,5,0,2,0,0,0,2,-5,0,0,2,0,0.09,0,2,180,0,0,2,LeftArm,-1,0,0,2,170,5,0,1,0.5,0,0,2,-90,5,0.6,1,0,0,0,2,90,0,0,2,RightLeg,1,0,0,2,-100,-5,0,2,-1.1,0,0,2,90,0,0,2,0,0,0,2,90,0,0.75,2,Head,0,0,0,2,-70,-5,0.3,2,1,0,0,2,-15,-5,0,2,0,0,0,2,180,0,0,2,RightArm,1,0,0,2,165,5,0,1,0.5,0,0,2,90,-5,0.6,1,0,0,0,2,-90,0,0,2
		end,
		walk = function()
			local fw, rt = velbycfrvec()

			local rY, lY = raycastlegs()

			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.04363323129985824 * sin(sine * 16), 0, 3.141592653589793 + 0.08726646259971647 * sin(sine * 8) - rt)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 - 0.3 * sin((sine + 0.15) * 8) + rY, rY * -0.5),angles(-1.5707963267948966 - 0.6981317007977318 * sin(sine * 8) * fw, 1.5707963267948966 + 0.6981317007977318 * sin(sine * 8) * rt, 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(0.08726646259971647 * sin((sine - 0.05) * 16), 1.5707963267948966 + 0.08726646259971647 * sin(sine * 8) - rt/3, 1.5707963267948966)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(0.08726646259971647 * sin((sine - 0.05) * 16), -1.5707963267948966 + 0.08726646259971647 * sin(sine * 8) - rt/3, -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 0.1 * sin((sine + 0.1) * 16), 0),angles(-1.5707963267948966, 0, 3.141592653589793 - 0.08726646259971647 * sin(sine * 8))),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 + 0.3 * sin((sine + 0.15) * 8) + lY, lY * -0.5),angles(1.5707963267948966 + 0.6981317007977318 * sin(sine * 8) * fw, -1.5707963267948966 + 0.6981317007977318 * sin(sine * 8) * rt, 1.5707963267948966)),deltaTime) 
			--Head,0,0,0,8,-90,2.5,0,16,1,0,0,8,-0,0,0,8,0,0,0,8,180,5,0,8,RightLeg,1,0,0,8,-90,-40,0,8,-1,-0.3,0.15,8,90,40,0,8,0,0,0,8,90,0,0,8,RightArm,1,0,0,8,0,5,-0.05,16,0.5,0,0,8,90,5,0,8,0,0,0,8,90,0,0,8,LeftArm,-1,0,0,8,0,5,-0.05,16,0.5,0,0,8,-90,5,0,8,0,0,0,8,-90,0,0,8,Torso,0,0,0,8,-90,0,0,8,0,0.1,0.1,16,-0,0,0,8,0,0,0,8,180,-5,0,8,LeftLeg,-1,0,0,8,90,40,0,8,-1,0.3,0.15,8,-90,40,0,8,0,0,0,8,90,0,0,8
		end
	})
	addmode("p", {
		idle = function()
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1.5, 0.5, 0),angles(1.5707963267948966, 3.141592653589793, -1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(0, 1.5707963267948966, 0)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1.5, 0.5, 0),angles(1.5707963267948966, 3.141592653589793, 1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(0, -1.5707963267948966, 0)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966, 0, -3.141592653589793)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf_0,angles(-1.5707963267948966, 0, -3.141592653589793)),deltaTime) 
			--RightArm,1.5,0,0,1,90,0,0,1,0.5,0,0,1,180,0,0,1,0,0,0,1,-90,0,0,1,RightLeg,1,0,0,1,0,0,0,1,-1,0,0,1,90,0,0,1,0,0,0,1,0,0,0,1,Fedora_Handle,8.657480066176504e-09,0,0,1,-6,0,0,1,-0.15052366256713867,0,0,1,0,0,0,1,-0.010221302509307861,0,0,1,0,0,0,1,LeftArm,-1.5,0,0,1,90,0,0,1,0.5,0,0,1,180,0,0,1,0,0,0,1,90,0,0,1,LeftLeg,-1,0,0,1,-0,0,0,1,-1,0,0,1,-90,0,0,1,0,0,0,1,0,0,0,1,Head,0,0,0,1,-90,0,0,1,1,0,0,1,0,0,0,1,0,0,0,1,-180,0,0,1,Torso,0,0,0,1,-90,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,-180,0,0,1
		end
	})
	addmode("f", {
		idle = function()
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(-3.0543261909900767 - 0.17453292519943295 * sin((sine + 1.5) * 1), -1.5707963267948966 + 0.08726646259971647 * sin((sine + 0.6) * 1), -1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(3.141592653589793 - 0.08726646259971647 * sin(sine * 1), 0.3490658503988659 + 0.08726646259971647 * sin((sine + 0.3) * 1), -1.9198621771937625 + 0.08726646259971647 * sin((sine + 1) * 1))),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.3089969389957472 - 0.2617993877991494 * sin((sine + 1.2) * 1), 0.08726646259971647 * sin((sine + 0.2) * 0.5), -2.9670597283903604)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 5 - 0.5 * sin((sine - 0.2) * 1), 0.2 * sin((sine - 1.2) * 1)),angles(-0.08726646259971647 + 0.17453292519943295 * sin((sine + 1.2) * 1), 0.08726646259971647 * sin(sine * 0.5), 3.141592653589793)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.3962634015954636 + 0.12217304763960307 * sin((sine + 1.5) * 1), -1.2217304763960306 + 0.08726646259971647 * sin((sine + 0.2) * 0.5), 1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.9198621771937625 + 0.12217304763960307 * sin((sine + 1.5) * 1), 1.2217304763960306 + 0.08726646259971647 * sin((sine + 0.2) * 0.5), -1.5707963267948966)),deltaTime) 
			--LeftArm,-1,0,0,1,-175,-10,1.5,1,0.5,0,0,1,-90,5,0.6,1,0,0,0,1,-90,0,0,1,RightArm,1,0,0,1,180,-5,0,1,0.5,0,0,1,20,5,0.3,1,0,0,0,1,-110,5,1,1,Head,0,0,0,1,-75,-15,1.2,1,1,0,0,1,-0,5,0.2,0.5,0,0,0,1,-170,0,0,1,Torso,0,0,0,1,-5,10,1.2,1,5,-0.5,-0.2,1,-0,5,0,0.5,0,0.2,-1.2,1,180,0,0,1,LeftLeg,-1,0,0,1,80,7,1.5,1,-1,0,0,1,-70,5,0.2,0.5,0,0,0,1,90,0,0,1,RightLeg,1,0,0,1,110,7,1.5,1,-1,0,0,1,70,5,0.2,0.5,0,0,0,1,-90,0,0,1
		end,
		walk = function()
			local fw, rt = velbycfrvec()

			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(-3.0543261909900767 - 0.17453292519943295 * sin((sine + 1.5) * 1) - fw * 0.1, -1.5707963267948966 + 0.08726646259971647 * sin((sine + 0.6) * 1) + rt * 0.2, -1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(3.141592653589793 - 0.08726646259971647 * sin(sine * 1), 0.3490658503988659 + 0.08726646259971647 * sin((sine + 0.3) * 1), -1.9198621771937625 + 0.08726646259971647 * sin((sine + 1) * 1))),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.3089969389957472 - 0.2617993877991494 * sin((sine + 1.2) * 1) + fw * 0.1, 0.08726646259971647 * sin((sine + 0.2) * 0.5) - rt * 0.2, -2.9670597283903604)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 5 - 0.5 * sin((sine - 0.2) * 1), 0.2 * sin((sine - 1.2) * 1)),angles(-0.08726646259971647 + 0.17453292519943295 * sin((sine + 1.2) * 1) - fw * 0.2, 0.08726646259971647 * sin(sine * 0.5), 3.141592653589793 - rt * 0.2)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, 0),angles(1.3962634015954636 + 0.12217304763960307 * sin((sine + 1.5) * 1) - fw * 0.2, -1.2217304763960306 + 0.08726646259971647 * sin((sine + 0.2) * 0.5), 1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, 0),angles(1.9198621771937625 + 0.12217304763960307 * sin((sine + 1.5) * 1) - fw * 0.2, 1.2217304763960306 + 0.08726646259971647 * sin((sine + 0.2) * 0.5), -1.5707963267948966)),deltaTime) 
			--LeftArm,-1,0,0,1,-175,-10,1.5,1,0.5,0,0,1,-90,5,0.6,1,0,0,0,1,-90,0,0,1,RightArm,1,0,0,1,180,-5,0,1,0.5,0,0,1,20,5,0.3,1,0,0,0,1,-110,5,1,1,Head,0,0,0,1,-75,-15,1.2,1,1,0,0,1,-0,5,0.2,0.5,0,0,0,1,-170,0,0,1,Torso,0,0,0,1,-5,10,1.2,1,5,-0.5,-0.2,1,-0,5,0,0.5,0,0.2,-1.2,1,180,0,0,1,LeftLeg,-1,0,0,1,80,7,1.5,1,-1,0,0,1,-70,5,0.2,0.5,0,0,0,1,90,0,0,1,RightLeg,1,0,0,1,110,7,1.5,1,-1,0,0,1,70,5,0.2,0.5,0,0,0,1,-90,0,0,1
		end
	})
	addmode("g", {
		idle = function()
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.9 + 0.4 * sin(sine * 8), 0.5, 0.5 * sin((sine + 0.25) * 4)),angles(1.5707963267948966, -1.5707963267948966 + 1.0471975511965976 * sin(sine * 8), 1.5707963267948966 + 0.6981317007977318 * sin((sine + 0.25) * 4))),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0.3 * sin((sine + 0.4) * 8), 0, 0),angles(-1.5707963267948966, 0.3490658503988659 * sin(sine * 8), -3.141592653589793)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.061086523819801536 * sin((sine + 0.125) * 16), -0.3839724354387525 * sin(sine * 8), -3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 + 0.4 * sin((sine - 0.01) * 8), 0),angles(1.5707963267948966, 1.7453292519943295 + 0.6981317007977318 * sin(sine * 8), -1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 - 0.4 * sin((sine - 0.01) * 8), 0),angles(1.5707963267948966, -1.7453292519943295 + 0.6981317007977318 * sin(sine * 8), 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.9 + 0.4 * sin(sine * 8), 0.5, -0.5 * sin((sine - 0.35) * 4)),angles(1.5707963267948966 + 0.6981317007977318 * sin(sine * 4), 1.5707963267948966 + 1.0471975511965976 * sin(sine * 8), -1.5707963267948966 + 0.17453292519943295 * sin((sine - 0.35) * 4))),deltaTime) 
			--LeftArm,-0.9,0.4,0,8,90,0,0.25,4,0.5,0,0,8,-90,60,0,8,0,0.5,0.25,4,90,40,0.25,4,Torso,0,0.3,0.4,8,-90,0,0,8,0,0,0,4,0,20,0,8,0,0,0,8,-180,0,0,8,Head,0,0,0,8,-90,3.5,0.125,16,1,0,0,8,0,-22,0,8,0,0,0,8,-180,0,0,1.1,RightLeg,1,0,0,8,90,0,0,8,-1,0.4,-0.01,8,100,40,0,8,0,0,0,8,-90,0,0,8,LeftLeg,-1,0,0,8,90,0,0,8,-1,-0.4,-0.01,8,-100,40,0,8,0,0,0,8,90,0,0,8,RightArm,0.9,0.4,0,8,90,40,0,4,0.5,0,0,8,90,60,0,8,0,-0.5,-0.35,4,-90,10,-0.35,4
		end
	})
	addmode("h", {
		idle = function()
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966, -0.4363323129985824 * sin(sine * 8), -3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 + 0.3 * sin(sine * 8), 0),angles(1.5707963267948966, 1.5707963267948966 + 0.5235987755982988 * sin(sine * 8), -1.5707963267948966)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.5, 1, 0),angles(-0.5235987755982988, -1.5707963267948966 - 0.5235987755982988 * sin(sine * 8), 3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.5, 1, 0),angles(-0.5235987755982988, 1.5707963267948966 - 0.5235987755982988 * sin(sine * 8), 3.141592653589793)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(-0.1 * sin(sine * 8), 0.2 * sin((sine + 0.1) * 16), 0),angles(-1.5707963267948966, 0.2617993877991494 * sin(sine * 8), -3.141592653589793)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 - 0.3 * sin(sine * 8), 0),angles(1.5707963267948966, -1.5707963267948966 + 0.5235987755982988 * sin(sine * 8), 1.5707963267948966)),deltaTime) 
			--Head,0,0,0,8,-90,0,0,8,1,0,0,8,0,-25,0,8,0,0,0,8,-180,0,0,8,RightLeg,1,0,0,8,90,0,0,8,-1,0.3,0,8,90,30,0,8,0,0,0,8,-90,0,0,8,LeftArm,-0.5,0,0,8,-30,0,0,8,1,0,0,8,-90,-30,0,8,0,0,0,8,180,0,0,8,RightArm,0.5,0,0,8,-30,0,0,8,1,0,0,16,90,-30,0,8,0,0,0,8,180,0,0,8,Torso,0,-0.1,0,8,-90,0,0,8,0,0.2,0.1,16,0,15,0,8,0,0,0,8,-180,0,0,8,LeftLeg,-1,0,0,8,90,0,0,8,-1,-0.3,0,8,-90,30,0,8,0,0,0,8,90,0,0,8,Fedora_Handle,8.657480066176504e-09,0,0,8,-6,0,0,8,-0.15052366256713867,0,0,8,0,0,0,8,-0.010221302509307861,0,0,8,0,0,0,8
		end
	})
	addmode("j", {
		idle = function()
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-0.8, -1, -0.1),angles(0.17453292519943295, -0.6981317007977318, 0)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1.2, 0.5, 0),angles(-0.3490658503988659 + 0.08726646259971647 * sin((sine + 0.1) * 4), 0, 0.6981317007977318 + 0.08726646259971647 * sin((sine + 0.1) * 4))),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1.1, -1, 0),angles(1.5707963267948966, 1.7453292519943295, -1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.08726646259971647 * sin((sine + 0.1) * 4), 0, 2.792526803190927)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, -1.7 + 0.5 * sin(sine * 4), 0.15 * sin(sine * 4)),angles(3.3161255787892263 + 0.17453292519943295 * sin(sine * 4), 0, 3.6651914291880923)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.8 + 0.4 * sin(sine * 4), 0.6 + 0.1 * sin(sine * 4), 0.4 - 0.25 * sin(sine * 4)),angles(2.9670597283903604, 2.2689280275926285 - 0.17453292519943295 * sin(sine * 4), -1.4835298641951802 - 0.17453292519943295 * sin(sine * 4))),deltaTime) 
			--GalaxyBeautifulHair_Handle,-0.15000000596046448,0,0,1,0,0,0,1,0.10000000149011612,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,LeftLeg,-0.8,0,0,4,10,0,0,4,-1,0,0,4,-40,0,0,4,-0.1,0,0,4,0,0,0,4,LeftArm,-1.2,0,0,4,-20,5,0.1,4,0.5,0,0,4,0,0,0,4,0,0,0,4,40,5,0.1,4,Fedora_Handle,8.657480066176504e-09,0,0,1,-6,0,0,1,-0.15052366256713867,0,0,1,0,0,0,1,-0.010221302509307861,0,0,1,0,0,0,1,ValkyrieHelm_Handle,8.658389560878277e-09,0,0,1,-15,0,0,1,-0.2433757781982422,0,0,1,0,0,0,1,-0.2657628059387207,0,0,1,0,0,0,1,RightLeg,1.1,0,0,4,90,0,0,4,-1,0,0,4,100,0,0,4,0,0,0,4,-90,0,0,4,BlackIronAntlers_Handle,8.658389560878277e-09,0,0,1,0,0,0,1,-0.6500000953674316,0,0,1,0,0,0,1,0.19972775876522064,0,0,1,0,0,0,1,DevAwardsAdurite_Handle,0,0,0,1,0,0,0,1,-0.25,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,SilverthornAntlers_Handle,8.658389560878277e-09,0,0,1,0,0,0,1,-0.6500000953674316,0,0,1,0,0,0,1,0.19972775876522064,0,0,1,0,0,0,1,Head,0,0,0,4,-90,5,0.1,4,1,0,0,4,-0,0,0,4,0,0,0,4,160,0,0,4,Torso,0,0,0,4,190,10,0,4,-1.70,0.5,0,4,-0,0,0,4,0,0.15,0,4,210,0,0,4,RightArm,0.8,0.4,0,4,170,0,0,4,0.6,0.1,0,4,130,-10,0,4,0.4,-0.25,0,4,-85,-10,0,4
		end
	})
	addmode("k", {
		idle = function()
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.6580627893946132 - 0.08726646259971647 * sin((sine + 0.3333333333333333) * 12), -0.08726646259971647 * sin((sine + 0.2) * 6), 3.141592653589793)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -0.5 - 0.5 * sin((sine + 0.39999999999999997) * 12), -0.5),angles(1.7453292519943295 - 1.0471975511965976 * sin(sine * 6), -1.5707963267948966 + 0.1308996938995747 * sin(sine * 6), 1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -0.5 - 0.5 * sin((sine + 0.39999999999999997) * 12), -0.5),angles(1.7453292519943295 + 1.0471975511965976 * sin(sine * 6), 1.5707963267948966 + 0.1308996938995747 * sin(sine * 6), -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, -0.5 + 0.3 * sin((sine + 0.16666666666666666) * 12), 0),angles(-1.3962634015954636 + 0.08726646259971647 * sin((sine + 0.3333333333333333) * 12), 0.08726646259971647 * sin((sine + 0.06666666666666667) * 6), 3.141592653589793)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.8 - 0.1 * sin(sine * 6), 0.5 + 0.1 * sin(sine * 6), -0.2),angles(3.141592653589793 - 0.17453292519943295 * sin((sine + 0.39999999999999997) * 12), -0.17453292519943295, 1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.8 - 0.1 * sin(sine * 6), 0.5 - 0.1 * sin(sine * 6), -0.2),angles(3.141592653589793 - 0.17453292519943295 * sin((sine + 0.39999999999999997) * 12), 0.17453292519943295, -1.5707963267948966)),deltaTime) 
			--GalaxyBeautifulHair_Handle,-0.15000000596046448,0,0,1.5,0,0,0,1.5,0.10000000149011612,0,0,1.5,0,0,0,1.5,0,0,0,1.5,0,0,0,1.5,Head,0,0,0,6,-95,-5,0.3333333333333333,12,1,0,0,6,-0,-5,0.2,6,0,0,0,6,180,0,0,6,ValkyrieHelm_Handle,8.658389560878277e-09,0,0,1.5,-15,0,0,1.5,-0.2433757781982422,0,0,1.5,0,0,0,1.5,-0.2657628059387207,0,0,1.5,0,0,0,1.5,SilverthornAntlers_Handle,8.658389560878277e-09,0,0,1.5,0,0,0,1.5,-0.6500000953674316,0,0,1.5,0,0,0,1.5,0.19972775876522064,0,0,1.5,0,0,0,1.5,BlackIronAntlers_Handle,8.658389560878277e-09,0,0,1.5,0,0,0,1.5,-0.6500000953674316,0,0,1.5,0,0,0,1.5,0.19972775876522064,0,0,1.5,0,0,0,1.5,Fedora_Handle,8.657480066176504e-09,0,0,1.5,-6,0,0,1.5,-0.15052366256713867,0,0,1.5,0,0,0,1.5,-0.010221302509307861,0,0,1.5,0,0,0,1.5,LeftLeg,-1,0,0,6,100,-60,0,6,-0.5,-0.5,0.39999999999999997,12,-90,7.5,0,6,-0.5,0,0,6,90,0,0,6,EyelessSmileHead_Handle,-0.00043487548828125,0,0,1.5,180,0,0,1.5,0.6000361442565918,0,0,1.5,0,0,0,1.5,0.0003204345703125,0,0,1.5,180,0,0,1.5,RightLeg,1,0,0,6,100,60,0,6,-0.5,-0.5,0.39999999999999997,12,90,7.5,0,6,-0.5,0,0,6,-90,0,0,6,DevAwardsAdurite_Handle,0,0,0,1.5,0,0,0,1.5,-0.25,0,0,1.5,0,0,0,1.5,0,0,0,1.5,0,0,0,1.5,Torso,0,0,0,6,-80,5,0.3333333333333333,12,-0.5,0.3,0.16666666666666666,12,-0,5,0.06666666666666667,6,0,0,0,6,180,0,0,6,LeftArm,-0.8,-0.1,0,6,180,-10,0.39999999999999997,12,0.5,0.1,0,6,-10,0,0,6,-0.2,0,0,6,90,0,0,6,RightArm,0.8,-0.1,0,6,180,-10,0.39999999999999997,12,0.5,-0.1,0,6,10,0,0,6,-0.2,0,0,6,-90,0,0,6
		end
	})
	addmode("l", {
		idle = function()
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.04363323129985824 * sin((sine + 0.1) * 1), -0.17453292519943295 * sin((sine + 0.1) * 5), -3.141592653589793)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 + 0.2 * sin(sine * 5), -0.2 + 0.2 * sin(sine * 5)),angles(2.181661564992912 - 0.8726646259971648 * sin(sine * 5), 1.9198621771937625 - 0.3490658503988659 * sin(sine * 5), -1.5707963267948966)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(0.7, 0.8, 0),angles(1.0471975511965976 + 0.03490658503988659 * sin(sine * 10), 2.0943951023931953 + 0.10471975511965978 * sin((sine + 0.1) * 5), 1.5707963267948966)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 - 0.2 * sin(sine * 5), -0.2 - 0.2 * sin(sine * 5)),angles(2.181661564992912 + 0.8726646259971648 * sin(sine * 5), -1.9198621771937625 - 0.3490658503988659 * sin(sine * 5), 1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 0.15 + 0.4 * sin((sine - 0.5) * 10), 0),angles(-1.4835298641951802, 0.17453292519943295 * sin(sine * 5), -3.141592653589793)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-0.7, 0.5, -0.3),angles(1.7453292519943295, -0.8726646259971648, 1.5707963267948966)),deltaTime) 
			--Head,0,0,0,5,-90,2.5,0.1,1,1,0,0,4,0,-10,0.1,5,0,0,0,4,-180,0,0,4,RightLeg,1,0,0,4,125,-50,0,5,-1,0.2,0,5,110,-20,0,5,-0.2,0.2,0,5,-90,0,0,4,RightArm,0.7,0,0,4,60,2,0,10,0.8,0,0,4,120,6,0.1,5,0,0,0,4,90,0,0,4,LeftLeg,-1,0,0,4,125,50,0,5,-1,-0.2,0,5,-110,-20,0,5,-0.2,-0.2,0,5,90,0,0,4,Torso,0,0,0,4,-85,0,0,4,0.15,0.4,-0.5,10,0,10,0,5,0,0,0,4,-180,0,0,4,LeftArm,-0.7,0,0,4,100,0,0,4,0.5,0,0,4,-50,0,0,4,-0.3,0,0,4,90,0,0,4
		end
	})
end)

btn("Immortality Lord", function()
	local backup=aligns
	aligns={
		{PartName="Torso",meshid="17269636541"},
		{PartName="Head",meshid="17269753087",C0=angles(0,3.14,0)},
		{PartName="Head",meshid="17375312569",C0=cf(1.50995803e-08,-1.07200003,-0.100000001,-1,0,1.50995803e-07,0,1,0,-1.50995803e-07,0,-1)},
		{PartName="Left Arm",meshid="17269487439",C0=angles(0,0,1.5707963267948966)},
		{PartName="Right Arm",meshid="17269487439",C0=angles(0,0,1.5707963267948966)},
		{PartName="Left Leg",meshid="17269487439",C0=angles(0,0,1.5707963267948966)},
		{PartName="Right Leg",meshid="17269487439",C0=angles(0,0,1.5707963267948966)},

		{PartName="Torso",meshid="111946216585470"},
		{PartName="Head",meshid="92572400594624",C0=angles(0,3.14,0)},
		{PartName="Left Arm",meshid="117649985156221"},
		{PartName="Right Arm",meshid="93749227415046"},
		{PartName="Left Leg",meshid="137156465227879"},
		{PartName="Right Leg",meshid="76010149115685"},

		{PartName="Torso",meshid="126825022897778"},
		{PartName="Left Arm",meshid="138744606849121",textureid="83207562332062",C0=angles(0,0,1.5707963267948966)},
		{PartName="Right Arm",meshid="138744606849121",textureid="83207562332062",C0=angles(0,0,1.5707963267948966)},
		{PartName="Left Leg",meshid="138744606849121",textureid="136752500636691",C0=angles(0,0,1.5707963267948966)},
		{PartName="Right Leg",meshid="138744606849121",textureid="136752500636691",C0=angles(0,0,1.5707963267948966)}
	}
	local t=reanimate()
	aligns=backup
	if type(t)~="table" then return end
	local getJoint=t.getJoint
	local RootJoint=getJoint("RootJoint")
	local RightShoulder=getJoint("Right Shoulder")
	local LeftShoulder=getJoint("Left Shoulder")
	local RightHip=getJoint("Right Hip")
	local LeftHip=getJoint("Left Hip")
	local Neck=getJoint("Neck")
	local getVel=t.getVel
	local setCfr=t.setCfr
	local getCamCF=t.getCamCF
	local cframes=t.cframes
	local joints=t.joints
	local getAccWeldFromMesh=t.getAccWeldFromMesh
	local setWalkSpeed=t.setWalkSpeed
	local fling=t.fling
	local rad=math.rad

	Neck.C1=cf(0,-1,0,-1,0,0,0,0,1,0,1,-0)
	RootJoint.C1=cf(0,0,0,-1,0,0,0,0,1,0,1,-0)
	RightShoulder.C1=cf(-1,1,0,0,0,1,0,1,-0,-1,0,0)
	LeftShoulder.C1=cf(1,1,0,0,0,-1,0,1,0,1,0,0)
	RightHip.C1=cf(1,2,0,0,0,1,0,1,-0,-1,0,0)
	LeftHip.C1=cf(-1,2,0,0,0,-1,0,1,0,1,0,0)

	setWalkSpeed(32)
	t.setJumpPower(0)
	t.setHipHeight(7)
	t.setGravity(math.huge)

	local torso=t.getPart("Torso")
	local rootpart=t.getPart("HumanoidRootPart")

	local leftWingPart={}
	cframes[leftWingPart]=cf_0

	local leftWingAccWeld=getAccWeldFromMesh("17269814619","")
	leftWingAccWeld.C0=angles(0,3.14,0)
	leftWingAccWeld.C1=cf_0
	leftWingAccWeld.Part1=leftWingPart

	local LeftWing={
		C0=cf(-.3,1,1)*angles(0,1.5707963267948966,0),
		C1=cf(2.2,2,1.5),
		Part0=torso,
		Part1=leftWingPart
	}
	tinsert(joints,LeftWing)

	local rightWingPart={}
	cframes[rightWingPart]=cf_0

	local rightWingAccWeld=getAccWeldFromMesh("17269824947","")
	rightWingAccWeld.C0=angles(0,3.14,0)
	rightWingAccWeld.C1=cf_0
	rightWingAccWeld.Part1=rightWingPart

	local RightWing={
		C0=cf(.3,1,1)*angles(0,1.5707963267948966,0),
		C1=cf(2.2,2,-1.5),
		Part0=torso,
		Part1=rightWingPart
	}
	tinsert(joints,RightWing)

	local swordpart={}
	cframes[swordpart]=cf_0

	local swordAccWeld0=getAccWeldFromMesh("17326555172","")
	swordAccWeld0.C0=cf(-0.0023765564,2.14191723,3.825109,-1,0,0,0,-0.519688249,-0.85435611,0,-0.854355931,0.519688308)
	swordAccWeld0.C1=cf_0
	swordAccWeld0.Part1=swordpart
	local swordAccWeld1=getAccWeldFromMesh("17326476901","")
	swordAccWeld1.C0=cf(-0.00237464905,-1.31204176,-3.18902349,-1,0,0,0,-0.519688249,-0.85435611,0,-0.854355931,0.519688308)
	swordAccWeld1.C1=cf_0
	swordAccWeld1.Part1=swordpart

	local Sword={
		C0=cf(0,-2,0)*angles(1.57,0,0),
		C1=cf(0,-6.3,0),
		Part0=t.getPart("Right Arm"),
		Part1=swordpart
	}
	tinsert(joints,Sword)

	local DefaultsNeckC0 = cf(0,2,0)*angles(-1.5707963267948966,0,3.141592653589793)
	local DefaultsRootJointC0 = angles(-1.5707963267948966,0,3.141592653589793)
	local DefaultsRightShoulderC0 = cf(-1,0,0)*angles(0,1.5707963267948966,0)
	local DefaultsLeftShoulderC0 = cf(1,0,0)*angles(0,-1.5707963267948966,0)

	local TimingSine=sine*60
	local attacking=false
	local animOverwrite=nil
	local neckSnap=false

	local Lerp1=function(a,b,c)
		return Lerp(a,b,min(c*6*deltaTime,1))
	end

	local v3_030=v3_010*3
	local flycf=nil
	local flypos=nil
	local charcf=cf_0
	local animations=function(onground)		
		TimingSine=sine*60
		local vel=getVel()
		local xzvel=vel*v3_101
		if flycf then
			if xzvel~=v3_0 then
				local camrot=cfGet(getCamCF(),"Rotation")
				local clv=cfGet(camrot,"LookVector")
				local crv=cfGet(camrot,"RightVector")
				local fw=vnormalize(clv*v3_101)*xzvel
				fw=clv*(v3Get(fw,"X")+v3Get(fw,"Z"))
				local rt=vnormalize(crv*v3_101)*xzvel
				rt=crv*(v3Get(rt,"X")+v3Get(rt,"Z"))
				flypos=flypos+vnormalize(fw+rt)*deltaTime*3.2
				flycf=cfAdd(camrot,flypos)
				charcf=cfAdd(flycf,cfGet(flycf,"UpVector")*3-v3_030)
			end
			cframes[rootpart]=flycf
			setCfr(charcf)
		elseif onground then
			charcf=cframes[rootpart]
		elseif cframes[rootpart].Y<charcf.Y then
			local newcf=cframes[rootpart]
			local lastY=cfGet(charcf,"Y")
			charcf=cfAdd(cfGet(newcf,"Rotation"),v3(cfGet(newcf,"X"),lastY+(cfGet(newcf,"Y")-lastY)*deltaTime*0.6,cfGet(newcf,"Z")))
			cframes[rootpart]=charcf
			setCfr(charcf)
		else
			charcf=cframes[rootpart]
		end
		if attacking then
			animOverwrite()
		elseif xzvel~=v3_0 then
			if neckSnap then
				Neck.C0 = DefaultsNeckC0
				neckSnap = false
			else
				Neck.C0 = Lerp1(Neck.C0,DefaultsNeckC0,.25)
			end
			if mrandom(15) == 1 then
				Neck.C0 = DefaultsNeckC0*angles(rad(mrandom(-20,20)),rad(mrandom(-20,20)),rad(mrandom(-20,20)))
				neckSnap = true
			end
			if onground and not flycf then
				RightShoulder.C0 = Lerp1(RightShoulder.C0,cf(3,1,0)*angles(-0.17453292519943295,0,0)*DefaultsRightShoulderC0,.25)
				Sword.C0 = Lerp1(Sword.C0,cf(0,-2,0)*angles(rad(154.35-5.65*sin(TimingSine/25)),0,0),.25)
			else
				RightShoulder.C0 = Lerp1(RightShoulder.C0,cf(3,1,0)*angles(rad(80+5*cos(TimingSine/25)),0,0.7853981633974483)*DefaultsRightShoulderC0,.25)
				Sword.C0 = Lerp1(Sword.C0,cf(0,-0,-1)*angles(0,2.9670597283903604,-0.17453292519943295),.25)
			end
			RootJoint.C0 = Lerp1(RootJoint.C0,DefaultsRootJointC0*cf(0,0,-sin(TimingSine/25))*angles(0.3490658503988659,0,0),.25)
			LeftShoulder.C0 = Lerp1(LeftShoulder.C0,cf(-3,1,0)*angles(0.3490658503988659,0,rad(-10-10*cos(TimingSine/25)))*DefaultsLeftShoulderC0,.25)
			RightHip.C0 = Lerp1(RightHip.C0,cf(2,-2,0)*angles(-0.3490658503988659,1.3962634015954636,rad(10+10*cos(TimingSine/25))),.25)
			LeftHip.C0 = Lerp1(LeftHip.C0,cf(-2,-2,0)*angles(-0.17453292519943295,-1.3962634015954636,rad(-10-10*cos(TimingSine/25))),.25)
		else
			RootJoint.C0 = Lerp1(RootJoint.C0,DefaultsRootJointC0*cf(0,0,-sin(TimingSine/25))*angles(0.3490658503988659,0,0),.25)
			if neckSnap then
				Neck.C0 = DefaultsNeckC0*angles(0.3490658503988659,rad(10*sin(TimingSine/50)),0)
				neckSnap = false
			else
				Neck.C0 = Lerp1(Neck.C0,DefaultsNeckC0*angles(0.3490658503988659,rad(10*sin(TimingSine/50)),0),.25)
			end
			if mrandom(15) == 1 then
				Neck.C0 = DefaultsNeckC0*angles(rad(20+mrandom(-20,20)),rad((10*sin(TimingSine/50))+mrandom(-20,20)),rad(mrandom(-20,20)))
				neckSnap = true
			end
			if onground and not flycf then
				RightShoulder.C0 = Lerp1(RightShoulder.C0,cf(3,1,0)*angles(-0.17453292519943295,0,0)*DefaultsRightShoulderC0,.25)
				Sword.C0 = Lerp1(Sword.C0,cf(0,-2,0)*angles(rad(154.35-5.65*sin(TimingSine/25)),0,0),.25)
			else
				RightShoulder.C0 = Lerp1(RightShoulder.C0,cf(3,1,0)*angles(rad(80+5*cos(TimingSine/25)),0,0.7853981633974483)*DefaultsRightShoulderC0,.25)
				Sword.C0 = Lerp1(Sword.C0,cf(0,0,-1)*angles(0,2.9670597283903604,-0.17453292519943295),.25)
			end
			LeftShoulder.C0 = Lerp1(LeftShoulder.C0,cf(-3,1,0)*angles(0.3490658503988659,0,rad(-10-10*cos(TimingSine/25)))*DefaultsLeftShoulderC0,.25)
			RightHip.C0 = Lerp1(RightHip.C0,cf(2,-2,0)*angles(0.17453292519943295,1.3962634015954636,rad(10+10*cos(TimingSine/25))),.25)
			LeftHip.C0 = Lerp1(LeftHip.C0,cf(-2,-2,0)*angles(0.3490658503988659,-1.3962634015954636,rad(-10-10*cos(TimingSine/25))),.25)
		end
		RightWing.C0 = Lerp1(RightWing.C0,cf(0.3,1,1)*angles(0,rad(105-25*cos(TimingSine/25)),0),.25)
		LeftWing.C0 = Lerp1(LeftWing.C0,cf(-0.3,1,1)*angles(0,rad(75+25*cos(TimingSine/25)),0),.25)
	end

	local onKeyPressed=function(key)
		if key=="f" then
			if flycf then
				flycf=nil
				charcf=cf(flypos)
				setCfr(charcf)
			else
				flypos=cfGet(cframes[rootpart],"Position")
				flycf=cf(flypos)
				charcf=flycf
			end
		elseif key=="z" then
			if attacking then return end
			attacking=true
			setWalkSpeed(0)
			animOverwrite=function()
				RootJoint.C0 = Lerp1(RootJoint.C0,DefaultsRootJointC0*cf(0,0,-sin(TimingSine/25))*angles(0.08726646259971647,0,-0.3490658503988659),.25)
				if neckSnap then
					Neck.C0 = DefaultsNeckC0
					neckSnap = false
				else
					Neck.C0 = Lerp1(Neck.C0,DefaultsNeckC0,.25)
				end
				if mrandom(15) == 1 then
					Neck.C0 = DefaultsNeckC0*angles(rad(mrandom(-20,20)),rad(mrandom(-20,20)),rad(mrandom(-20,20)))
					neckSnap = true
				end
				RightShoulder.C0 = Lerp1(RightShoulder.C0,cf(3,1,0)*angles(1.3962634015954636,0,0.8726646259971648)*DefaultsRightShoulderC0,.25)
				Sword.C0 = Lerp1(Sword.C0,cf(-1,-1,0)*angles(3.141592653589793,-1.5707963267948966,0),.25)
				LeftShoulder.C0 = Lerp1(LeftShoulder.C0,cf(-3,1,0)*angles(0.08726646259971647,0,rad(-10-10*cos(TimingSine/25)))*DefaultsLeftShoulderC0,.25)
				RightHip.C0 = Lerp1(RightHip.C0,cf(2,-2,0)*angles(-0.3490658503988659,1.3962634015954636,rad(10+10*cos(TimingSine/25))),.25)
				LeftHip.C0 = Lerp1(LeftHip.C0,cf(-2,-2,0)*angles(-0.17453292519943295,-1.3962634015954636,rad(-10-10*cos(TimingSine/25))),.25)
			end
			twait(0.25)
			local flingpos=cfGet(cfMul(cframes[rootpart],cf(0,0,-9)),"Position")
			for i,v in next,QueryDescendants(ws,"Humanoid") do
				local p=v.Parent
				p=QueryDescendants(p,">BasePart#HumanoidRootPart")[1] or FindFirstChildWhichIsA(p,"BasePart")
				if p and (vmagnitude(insGet(p,"Position")-flingpos)<9) then
					fling(v)
				end
			end
			animOverwrite=function()
				RootJoint.C0 = Lerp1(RootJoint.C0,DefaultsRootJointC0*cf(0,0,-sin(TimingSine/25))*angles(0.08726646259971647,0,0.3490658503988659),.25)
				if neckSnap then
					Neck.C0 = DefaultsNeckC0
					neckSnap = false
				else
					Neck.C0 = Lerp1(Neck.C0,DefaultsNeckC0,.25)
				end
				if mrandom(15) == 1 then
					Neck.C0 = DefaultsNeckC0*angles(rad(mrandom(-20,20)),rad(mrandom(-20,20)),rad(mrandom(-20,20)))
					neckSnap = true
				end
				RightShoulder.C0 = Lerp1(RightShoulder.C0,cf(2,1,-1)*angles(1.3962634015954636,0,-0.8726646259971648)*DefaultsRightShoulderC0,.25)
				Sword.C0 = Lerp1(Sword.C0,cf(-1,-1,0)*angles(3.141592653589793,-1.5707963267948966,0),.25)
				LeftShoulder.C0 = Lerp1(LeftShoulder.C0,cf(-3,1,0)*angles(0.08726646259971647,0,rad(-10-10*cos(TimingSine/25)))*DefaultsLeftShoulderC0,.25)
				RightHip.C0 = Lerp1(RightHip.C0,cf(2,-2,0)*angles(-0.3490658503988659,1.3962634015954636,rad(10+10*cos(TimingSine/25))),.25)
				LeftHip.C0 = Lerp1(LeftHip.C0,cf(-2,-2,0)*angles(-0.17453292519943295,-1.3962634015954636,rad(-10-10*cos(TimingSine/25))),.25)
			end
			twait(0.25)
			setWalkSpeed(32)
			attacking=false
		elseif key=="x" then
			attacking=true
			setWalkSpeed(0)
			local newpos=cfGet(insGet(mouse,"Hit"),"Position")+v3_010*10
			local newcf=cfl(newpos,newpos+cfGet(getCamCF(),"LookVector")*v3_101)
			animOverwrite=function()
				RootJoint.C0 = Lerp1(RootJoint.C0,DefaultsRootJointC0*cf(0,0,-sin(TimingSine/25))*angles(0.3490658503988659,0,0),.25)
				if neckSnap then
					Neck.C0 = DefaultsNeckC0
					neckSnap = false
				else
					Neck.C0 = Lerp1(Neck.C0,DefaultsNeckC0,.25)
				end
				if mrandom(15) == 1 then
					Neck.C0 = DefaultsNeckC0*angles(rad(mrandom(-20,20)),rad(mrandom(-20,20)),rad(mrandom(-20,20)))
					neckSnap = true
				end
				RightShoulder.C0 = Lerp1(RightShoulder.C0,cf(3,1,0)*angles(rad(80+5*cos(TimingSine/25)),0,0.7853981633974483)*DefaultsRightShoulderC0,.25)
				Sword.C0 = Lerp1(Sword.C0,cf(0,-0,-1)*angles(0,2.9670597283903604,-0.17453292519943295),.25)
				LeftShoulder.C0 = Lerp1(LeftShoulder.C0,cf(-3,1,0)*angles(0.3490658503988659,0,rad(-10-10*cos(TimingSine/25)))*DefaultsLeftShoulderC0,.25)
				RightHip.C0 = Lerp1(RightHip.C0,cf(2,-2,0)*angles(-0.3490658503988659,1.3962634015954636,rad(10+10*cos(TimingSine/25))),.25)
				LeftHip.C0 = Lerp1(LeftHip.C0,cf(-2,-2,0)*angles(-0.17453292519943295,-1.3962634015954636,rad(-10-10*cos(TimingSine/25))),.25)
			end
			twait(0.5)
			local animStart=sine
			animOverwrite=function()
				RootJoint.C0 = Lerp1(RootJoint.C0,DefaultsRootJointC0*cf(0,0,-20*(.5+sine-animStart))*angles(0.3490658503988659,0,0),.25)
				if neckSnap then
					Neck.C0 = DefaultsNeckC0
					neckSnap = false
				else
					Neck.C0 = Lerp1(Neck.C0,DefaultsNeckC0,.25)
				end
				if mrandom(15) == 1 then
					Neck.C0 = DefaultsNeckC0*angles(rad(mrandom(-20,20)),rad(mrandom(-20,20)),rad(mrandom(-20,20)))
					neckSnap = true
				end
				RightShoulder.C0 = Lerp1(RightShoulder.C0,cf(3,1,0)*angles(rad(80+5*cos(TimingSine/25)),0,0.7853981633974483)*DefaultsRightShoulderC0,.25)
				Sword.C0 = Lerp1(Sword.C0,cf(0,-0,-1)*angles(0,2.9670597283903604,-0.17453292519943295),.25)
				LeftShoulder.C0 = Lerp1(LeftShoulder.C0,cf(-3,1,0)*angles(0.3490658503988659,0,rad(-10-10*cos(TimingSine/25)))*DefaultsLeftShoulderC0,.25)
				RightHip.C0 = Lerp1(RightHip.C0,cf(2,-2,0)*angles(-0.3490658503988659,1.3962634015954636,rad(10+10*cos(TimingSine/25))),.25)
				LeftHip.C0 = Lerp1(LeftHip.C0,cf(-2,-2,0)*angles(-0.17453292519943295,-1.3962634015954636,rad(-10-10*cos(TimingSine/25))),.25)
			end
			twait(0.5)
			if flycf then
				flycf=newcf
				flypos=newpos
			end
			charcf=newcf
			setCfr(newcf)

			twait(0.5)
			animStart=sine

			animOverwrite=function()
				RootJoint.C0 = Lerp1(RootJoint.C0,DefaultsRootJointC0*cf(0,0,(-sin(TimingSine/25))-(10-(sine-animStart)*20))*angles(0.3490658503988659,0,0),.25)
				if neckSnap then
					Neck.C0 = DefaultsNeckC0
					neckSnap = false
				else
					Neck.C0 = Lerp1(Neck.C0,DefaultsNeckC0,.25)
				end
				if mrandom(15) == 1 then
					Neck.C0 = DefaultsNeckC0*angles(rad(mrandom(-20,20)),rad(mrandom(-20,20)),rad(mrandom(-20,20)))
					neckSnap = true
				end
				RightShoulder.C0 = Lerp1(RightShoulder.C0,cf(3,1,0)*angles(rad(80+5*cos(TimingSine/25)),0,0.7853981633974483)*DefaultsRightShoulderC0,.25)
				Sword.C0 = Lerp1(Sword.C0,cf(0,-0,-1)*angles(0,2.9670597283903604,-0.17453292519943295),.25)
				LeftShoulder.C0 = Lerp1(LeftShoulder.C0,cf(-3,1,0)*angles(0.3490658503988659,0,rad(-10-10*cos(TimingSine/25)))*DefaultsLeftShoulderC0,.25)
				RightHip.C0 = Lerp1(RightHip.C0,cf(2,-2,0)*angles(-0.3490658503988659,1.3962634015954636,rad(10+10*cos(TimingSine/25))),.25)
				LeftHip.C0 = Lerp1(LeftHip.C0,cf(-2,-2,0)*angles(-0.17453292519943295,-1.3962634015954636,rad(-10-10*cos(TimingSine/25))),.25)
			end
			twait(0.5)
			setWalkSpeed(32)
			attacking=false
		end
	end

	local animations1=function()
		animations(true)
	end
	local animations0=function()
		animations(false)
	end
	local lastmode="default"
	t.addmode("default",{
		modeEntered=function()
			onKeyPressed(lastmode)
			lastmode="default"
		end,
		idle=animations1,walk=animations1,jump=animations0,fall=animations0
	})
	t.addmode("z",{
		modeEntered=function()
			onKeyPressed("z")
			lastmode="z"
		end,
		idle=animations1,walk=animations1,jump=animations0,fall=animations0
	})
	t.addmode("x",{
		modeEntered=function()
			onKeyPressed("x")
			lastmode="x"
		end,
		idle=animations1,walk=animations1,jump=animations0,fall=animations0
	})
	t.addmode("f",{
		modeEntered=function()
			onKeyPressed("f")
			lastmode="f"
		end,
		idle=animations1,walk=animations1,jump=animations0,fall=animations0
	})
end)
lbl("(needs specific accessories)")

local lcv4effects=nil
btn("LCV4 simplified", function()
	local t=reanimate()
	if type(t)~="table" then return end

	local getJoint=t.getJoint
	local RootJoint=getJoint("RootJoint")
	local RightShoulder=getJoint("Right Shoulder")
	local LeftShoulder=getJoint("Left Shoulder")
	local RightHip=getJoint("Right Hip")
	local LeftHip=getJoint("Left Hip")
	local Neck=getJoint("Neck")

	local setCfr=t.setCfr
	local getVel=t.getVel
	local cframes=t.cframes
	local rootpart=t.getPart("HumanoidRootPart")
	--local rightarm=t.getPart("Right Arm")

	local lastkeybindf=emptyfunction
	local idle=emptyfunction
	local walk=emptyfunction
	local deltaTime60=0
	local sine60=sine*60
	local lastY=cframes[rootpart].Y
	local lastsine=sine
	local delta=0
	local t60fps=0
	local resume60fps={}
	local resume60fps1={}
	local resumes=0

	local updateColor=emptyfunction
	local updateGuiColor=emptyfunction
	local updateGuiPos=emptyfunction
	local modechangedanimation=emptyfunction
	local WEffect=emptyfunction

	local modetable={
		modeEntered=function()
			lastkeybindf()
		end,
		idle=function()
			delta=sine-lastsine
			lastsine=sine

			resumes=0
			t60fps=t60fps+delta
			while t60fps>0.0167 do
				t60fps=t60fps-0.0167
				resumes=resumes+1
				resume60fps,resume60fps1=resume60fps1,resume60fps
				for i,v in next,resume60fps1 do
					cresume(v)
				end
				tclear(resume60fps1)
			end

			deltaTime60=deltaTime*6
			sine60=sine*60
			lastY=cframes[rootpart].Y
			idle()
			updateGuiPos()
		end,
		walk=function()
			delta=sine-lastsine
			lastsine=sine

			resumes=0
			t60fps=t60fps+delta
			while t60fps>0.0167 do
				t60fps=t60fps-0.0167
				resumes=resumes+1
				resume60fps,resume60fps1=resume60fps1,resume60fps
				for i,v in next,resume60fps1 do
					cresume(v)
				end
				tclear(resume60fps1)
			end

			deltaTime60=deltaTime*6
			sine60=sine*60
			lastY=cframes[rootpart].Y
			walk()
			updateGuiPos()
		end,
		fall=function()
			delta=sine-lastsine
			lastsine=sine

			resumes=0
			t60fps=t60fps+delta
			while t60fps>0.0167 do
				t60fps=t60fps-0.0167
				resumes=resumes+1
				resume60fps,resume60fps1=resume60fps1,resume60fps
				for i,v in next,resume60fps1 do
					cresume(v)
				end
				tclear(resume60fps1)
			end

			local newcf=cframes[rootpart]
			newcf=cfAdd(cfGet(newcf,"Rotation"),v3(cfGet(newcf,"X"),lastY+(cfGet(newcf,"Y")-lastY)*deltaTime*0.6,cfGet(newcf,"Z")))
			cframes[rootpart]=newcf
			setCfr(newcf)
			lastY=newcf.Y
			deltaTime60=deltaTime*6
			sine60=sine*60
			if getVel()*v3_101==v3_0 then
				idle()
			else
				walk()
			end
			updateGuiPos()
		end
	}
	t.addmode("default",modetable)
	local bindKey=function(key,f)
		local modetable=tclone(modetable)
		modetable.modeEntered=function()
			lastkeybindf=f
			f()
		end
		t.addmode(key,modetable)
	end
	local WalkSpeed=50
	local HipHeight=3
	local setWalkSpeed=t.setWalkSpeed
	setWalkSpeed(WalkSpeed)
	local setHipHeight=t.setHipHeight
	setHipHeight(HipHeight)
	t.setJumpPower(0)
	t.setGravity(math.huge)

	local rad=0.017453292519943295
	local fmod=math.fmod
	local c3_0=c3()
	local rgb=Color3.fromRGB
	local hsv=Color3.fromHSV
	local NECKC0=cf(0,1,0,-1,-0,-0,0,0,1,0,1,0)
	local ROOTC0=cf(0,0,0,-1,0,0,0,0,1,0,1,0)
	local RSC0=cf(-0.5,0,0,0,0,1,0,1,0,-1,0,0)
	local LSC0=cf(0.5,0,0,0,0,-1,0,1,0,1,0,0)
	local Lerp1=function(a,b,c)
		return Lerp(a,b,min(1,deltaTime60*c))
	end

	local Mode=0
	local NeckSnap=false
	local CurrentColor=c3_0

	local ChangeName=emptyfunction
	if lcv4effects then
		local i1=i("BillboardGui")
		local i2=i("TextLabel")
		insSet(i1,"AlwaysOnTop",true)
		insSet(i1,"Size",u2(7,35,3,15))
		insSet(i1,"StudsOffset",v3(0,2,0))
		insSet(i1,"ResetOnSpawn",false)
		insSet(i1,"MaxDistance",math.huge)
		insSet(i1,"Name",rs())
		insSet(i2,"BackgroundTransparency",1)
		insSet(i2,"TextScaled",true)
		insSet(i2,"BorderSizePixel",0)
		insSet(i2,"TextStrokeTransparency",0)
		insSet(i2,"Size",u2(1,0,0.5,0))
		insSet(i2,"Name",rs())
		insSet(i2,"Parent",i1)
		local fonts=e.Font
		fonts={
			fonts.Antique,
			fonts.Arcade,
			fonts.Arial,
			fonts.ArialBold,
			fonts.Bodoni,
			fonts.Cartoon,
			fonts.Code,
			fonts.Fantasy,
			fonts.Garamond,
			fonts.Highway,
			fonts.Legacy,
			fonts.SciFi,
			fonts.SourceSans,
			fonts.SourceSansBold,
			fonts.SourceSansItalic,
			fonts.SourceSansLight,
			fonts.SourceSansSemibold
		}
		local fontsl=#fonts
		local thread=nil
		thread=tspawn(function()
			local i=0
			while true do
				i=i+1
				if i==3 then
					i=0
					updateColor()
					insSet(i2,"TextColor3",CurrentColor)
				end
				insSet(i2,"Font",fonts[mrandom(fontsl)])
				insSet(i2,"Position",u2(0,mrandom(-5,5),0.05,mrandom(-5,5)))

				tinsert(resume60fps,thread)
				cyield()
			end
			Destroy(i1)
		end)
		updateGuiColor=function()
			insSet(i2,"TextColor3",CurrentColor)
		end
		updateGuiPos=function()
			insSet(i1,"StudsOffsetWorldSpace",cfGet(cfMul(cfMul(cframes[rootpart],cfMul(RootJoint.C0,Inverse(RootJoint.C1))),cfMul(Neck.C0,Inverse(Neck.C1))),"Position"))
		end
		insSet(i1,"Parent",i10)
		ChangeName=function(t)
			insSet(i2,"Text",t)
		end
		local v3_001=v3(0,0,1)
		local MakeMesh=function(Parent,MeshType,MeshId,Scale,Offset)
			local NEWMESH = i("SpecialMesh")
			NEWMESH.MeshType = MeshType
			NEWMESH.MeshId = "rbxassetid://"..MeshId
			NEWMESH.Offset = Offset or v3_0
			NEWMESH.Scale = Scale
			NEWMESH.Parent = Parent
			return NEWMESH
		end
		local NewPart=function(Parent,Material,Transparency,Color,Size)
			local part = i("Part")
			part.Transparency = Transparency
			part.CanCollide = false
			part.Anchored = true
			part.Color = Color
			part.Name = rs()
			part.Size = Size
			part.Material = Material
			part.Parent = Parent
			return part
		end
		WEffect=function(Time,EffectType,Size,Size2,Transparency,Transparency2,CFrame,MoveToPos,RotationX,RotationY,RotationZ,Material)
			local EFFECT=nil
			local MSH=nil
			if EffectType=="Sphere" then
				EFFECT=NewPart(ws,Material,Transparency,CurrentColor,v3(1,1,1))
				MSH=MakeMesh(EFFECT,"Sphere","",Size,v3_0)
			elseif EffectType=="Block" then
				EFFECT=NewPart(ws,Material,Transparency,CurrentColor,v3(1,1,1))
				MSH=i("BlockMesh",EFFECT)
				MSH.Scale=Size
			elseif EffectType=="Wave" then
				EFFECT=NewPart(ws,Material,Transparency,CurrentColor,v3(1,1,1))
				MSH=MakeMesh(EFFECT,"FileMesh","20329976",Size,v3(0,0,-Size.X/8))
			elseif EffectType=="Ring" then
				EFFECT=NewPart(ws,Material,Transparency,CurrentColor,v3(1,1,1))
				MSH=MakeMesh(EFFECT,"FileMesh","559831844",v3(Size.X,Size.X,0.1),v3_0)
			elseif EffectType=="Slash" then
				EFFECT=NewPart(ws,Material,Transparency,CurrentColor,v3(1,1,1))
				MSH=MakeMesh(EFFECT,"FileMesh","662586858",v3(Size.X/10,0,Size.X/10),v3_0)
			elseif EffectType=="Round Slash" then
				EFFECT=NewPart(ws,Material,Transparency,CurrentColor,v3(1,1,1))
				MSH=MakeMesh(EFFECT,"FileMesh","662585058",v3(Size.X/10,0,Size.X/10),v3_0)
			elseif EffectType=="Swirl" then
				EFFECT=NewPart(ws,Material,Transparency,CurrentColor,v3(1,1,1))
				MSH=MakeMesh(EFFECT,"FileMesh","1051557",Size,v3_0)
			elseif EffectType=="Skull" then
				EFFECT=NewPart(ws,Material,Transparency,CurrentColor,v3(1,1,1))
				MSH=MakeMesh(EFFECT,"FileMesh","4770583",Size,v3_0)
			elseif EffectType=="Crystal" then
				EFFECT=NewPart(ws,Material,Transparency,CurrentColor,v3(1,1,1))
				MSH=MakeMesh(EFFECT,"FileMesh","9756362",Size,v3_0)
			else
				return
			end
			local MOVE=v3_0
			local ROT=angles(rad*(RotationX),rad*(RotationY),rad*(RotationZ))
			local GROWTH=Size - Size2
			local TRANS=Transparency - Transparency2
			if MoveToPos then
				MOVE=(CFrame.Position-MoveToPos)/Time
			end
			local iswave=EffectType=="Wave"
			local thread=crunning()
			for i=1,Time+1 do
				Size=Size-GROWTH/Time
				MSH.Scale=Size
				if iswave then
					MSH.Offset=v3_001*(Size.X/-8)
				end
				Transparency=Transparency-TRANS/Time
				EFFECT.Transparency=Transparency
				CFrame=CFrame*ROT+MOVE
				EFFECT.CFrame=CFrame
				EFFECT.Color=CurrentColor

				tinsert(resume60fps,thread)
				cyield()
			end
			Destroy(EFFECT)
		end
		modechangedanimation=function()
			--NewSound(3318714899, soundholder(5), 2, 1.4, false)

			local ecf = cframes[rootpart]
			for i = 1, 5 do
				tspawn(WEffect,25,"Crystal",v3(2,2,2),v3(0,0,500),1,0,ecf,nil,mrandom(-2,2),mrandom(-12,12),mrandom(-2,2),"Neon")
			end
			tspawn(WEffect,25,"Crystal",v3_0,v3(30,30,30),0,1,cfMul(ecf,cfMul(RootJoint.C0,Inverse(RootJoint.C1))),nil,0,0,0,"Neon")
			ecf=ecf*cf(0,0,1)
			tspawn(WEffect,50,"Wave",v3_0,v3(150,5,150),0.5,1,ecf,nil,0,0,0,"Neon")
			tspawn(WEffect,50,"Wave",v3_0,v3(160,10,160),0.5,1,ecf,nil,0,1,0,"Neon")
			tspawn(WEffect,50,"Wave",v3_0,v3(170,5,170),0.5,1,ecf,nil,0,2,0,"Neon")
			tspawn(WEffect,50,"Wave",v3_0,v3(180,10,180),0.5,1,ecf,nil,0,3,0,"Neon")
			tspawn(WEffect,50,"Wave",v3_0,v3(190,5,190),0.5,1,ecf,nil,0,4,0,"Neon")
			tspawn(WEffect,50,"Wave",v3_0,v3(200,10,200),0.5,1,ecf,nil,0,5,0,"Neon")
		end
	end

	local modechanged=function()
		modechangedanimation()

		if Mode == 0 then
			HipHeight = 3
			WalkSpeed = 50
			ChangeName("\227\128\144\239\187\191 LCV4 \227\128\145")
			walk=function()
				for i=1,resumes do
					if mrandom(20)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(500)),rad*(mrandom(500)),rad*(mrandom(500))),1)
					end
					--[[pcall(function()
						if mrandom(3)==1 then
							WEffect({TIME=mrandom(15,25)*2,EffectType="Crystal",Size=v3(3+2*cos(sine60/4),3+2*cos(sine60/4),3+2*cos(sine60/4)),Size2=v3_0,Transparency=0,Transparency2=-11,CFrame=cf(Character.HumanoidRootPart.CFrame.Position-v3(mrandom(-20,20),2,mrandom(-20,20))),MoveToPos=Character.Torso.Position+v3(0,mrandom(100)/1.5,0),RotationX=0,RotationY=0,RotationZ=0,Material="Neon",Color=CurrentColor,SoundID=nil,SoundPitch=nil,SoundVolume=nil})
						end
					end)]]
				end
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0.5*cos(sine60/50),0,-0.5*sin(sine60/50))*angles(rad*(40),0,0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*cf(0,-0.25,0)*angles(rad*(-40),0,0),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-45),0,rad*(5+2*cos(sine60/19)))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-45),0,rad*(-5-2*cos(sine60/19)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5,-0.5)*angles(rad*(-20+9*cos(sine60/74)),rad*(80),0)*angles(rad*(5*cos(sine60/37)),0,0),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(rad*(-20-9*cos(sine60/54)),rad*(-80),0)*angles(rad*(-5*cos(sine60/41)),0,0),0.25)
			end
			idle=function()
				for i=1,resumes do
					if mrandom(20)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(500)),rad*(mrandom(500)),rad*(mrandom(500))),1)
					end
					--[[pcall(function()
						if mrandom(3)==1 then
							WEffect({TIME=mrandom(15,25)*2,EffectType="Crystal",Size=v3(3+2*cos(sine60/4),3+2*cos(sine60/4),3+2*cos(sine60/4)),Size2=v3_0,Transparency=0,Transparency2=-11,CFrame=cf(Character.HumanoidRootPart.CFrame.Position-v3(mrandom(-20,20),2,mrandom(-20,20))),MoveToPos=Character.Torso.Position+v3(0,mrandom(100)/1.5,0),RotationX=0,RotationY=0,RotationZ=0,Material="Neon",Color=CurrentColor,SoundID=nil,SoundPitch=nil,SoundVolume=nil})
						end
					end)]]
				end
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0.5*cos(sine60/50),0,-0.5*sin(sine60/50)),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20),0,0),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(135+8.5*cos(sine60/50)),0,rad*(25))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(25+8.5*cos(sine60/50)),0,rad*(-25-5*cos(sine60/25)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5,-0.5)*angles(rad*(-15+9*cos(sine60/74)),rad*(80),0)*angles(rad*(5*cos(sine60/37)),0,0),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(rad*(-15-9*cos(sine60/54)),rad*(-80),0)*angles(rad*(-5*cos(sine60/41)),0,0),0.25)
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 1 then
			HipHeight = 3
			WalkSpeed = 25
			ChangeName("Stage 1")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.5*sin(sine60/50))*angles(rad*(20),0,0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0,0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-41.6-4*sin(sine60/50)),0,0)*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(20),0,rad*(-10-10*sin(sine60/50)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(-20),rad*(80),rad*(10+10*sin(sine60/50))),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,-0.01)*angles(rad*(-10),rad*(-80),rad*(-10-10*sin(sine60/50))),0.25)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.5*sin(sine60/50))*angles(rad*(20),0,0),0.25)
				if NeckSnap then
					Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20),rad*(10*sin(sine60/100)),0),1)
					NeckSnap=false
				else
					Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20),rad*(10*sin(sine60/100)),0),0.25)
				end
				for i=1,resumes do
					--[[pcall(function()
						if mrandom(60)==1 then
							Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20+mrandom(-20,20)),rad*((10*sin(sine60/100))+mrandom(-20,20)),rad*(mrandom(-20,20))),1)
							NeckSnap=true
						end
					end)]]
				end
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-41.6-4*sin(sine60/50)),0,0)*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(20),0,rad*(-10-10*sin(sine60/50)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(10),rad*(80),rad*(10*sin(sine60/50))),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,-0.01)*angles(rad*(20),rad*(-80),rad*(-10*sin(sine60/50))),0.25)
			end
			CurrentColor=c3(0.14902,0.14902,0.14902)
			updateColor=emptyfunction
		elseif Mode == 2 then
			HipHeight = 3
			WalkSpeed = 50
			ChangeName("UpsideDown")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,.5*cos(sine60/15))*angles(rad*(40),rad*(-5*cos(sine60/30)),0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*cf(0,-0.25,0)*angles(rad*(-40),0,0),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-45),0,rad*(5+2*cos(sine60/19)))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-45),0,rad*(-5-2*cos(sine60/19)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5,-0.5)*angles(rad*(-20+9*cos(sine60/74)),rad*(80),0)*angles(rad*(5*cos(sine60/37)),0,0),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(rad*(-20-9*cos(sine60/54)),rad*(-80),0)*angles(rad*(-5*cos(sine60/41)),0,0),0.25)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.5*cos(sine60/15))*angles(0,rad*(-10*cos(sine60/30)),0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(0,rad*(-15*cos(sine60/30)),0),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(135-15*cos(sine60/30)),0,rad*(25+15*cos(sine60/30)))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(5),rad*(5),rad*(-10+15*cos(sine60/30)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(-10),rad*(80),rad*(10+10*sin(sine60/15))),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,-0.01)*angles(0,rad*(-80),rad*(-10-10*sin(sine60/15))),0.25)
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 3 then
			HipHeight = 3
			WalkSpeed = 50
			ChangeName("Glitch")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.5*cos(sine60/15))*angles(rad*(20-2.5*sin(sine60/15)),0,0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-10-10*sin(sine60/15)),0,0),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5+.25*sin(sine60/15),0)*angles(rad*(-50+5*sin(sine60/15)),0,0)*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5+.25*sin(sine60/15),0)*angles(rad*(110),0,0)*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(-10),rad*(80),rad*(5+5*sin(sine60/15))),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,-0.01)*angles(0,rad*(-80),rad*(-5-5*sin(sine60/15))),0.25)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.5*cos(sine60/15))*angles(rad*(-2.5*sin(sine60/15)),0,0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(10-10*sin(sine60/15)),0,0),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5+.25*sin(sine60/15),0)*angles(rad*(135+5*sin(sine60/15)),0,rad*(25))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5+.25*sin(sine60/15),0)*angles(0,0,rad*(-10+10*cos(sine60/15)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(-10),rad*(80),rad*(5+5*sin(sine60/15))),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,-0.01)*angles(0,rad*(-80),rad*(-5-5*sin(sine60/15))),0.25)
			end
			updateColor=function()
				CurrentColor=hsv(mrandom(),mrandom(),mrandom())
			end
		elseif Mode == 4 then
			HipHeight = 3
			WalkSpeed = 50
			ChangeName("Alastor's Game")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,cos(sine60/25),-sin(sine60/25))*angles(rad*(5*sin(sine60/25)),0,rad*(70)),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(0,0,rad*(-70))*angles(rad*(5*cos(sine60/25)),0,0),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1,0.5,-0.25)*angles(0,rad*(-10),rad*(-90))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(0,0,rad*(-20+5*sin(sine60/25)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.1*sin(sine60/25),-0.01)*angles(0,rad*(80),0),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.5-0.25*sin(sine60/25),-0.51)*angles(rad*(-10),rad*(-80),0),0.25)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,cos(sine60/25),-sin(sine60/25))*angles(rad*(5*sin(sine60/25)),0,0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(5*cos(sine60/25)),0,0),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(160),0,rad*(15-5*sin(sine60/25)))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(0,0,rad*(-15+5*sin(sine60/25)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.1*sin(sine60/25),-0.01)*angles(0,rad*(80),0),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.5-0.25*sin(sine60/25),-0.51)*angles(rad*(-10),rad*(-80),0),0.25)
			end
			updateColor=function()
				CurrentColor=rgb(mrandom(99),0,0)
			end
		elseif Mode == 5 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName("DIE IN A FIRE")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0.125*sin(sine60/12),0)*angles(rad*(10-5*cos(sine60/12)),rad*(-10*cos(sine60/12)),rad*(-5*cos(sine60/12))),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(10-5*cos(sine60/12)),rad*(10*cos(sine60/12)),rad*(5*cos(sine60/12))),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5+.2*sin(sine60/12),-0.25)*angles(rad*(165-15*cos(sine60/12)),rad*(-10+5*sin(sine60/12)),rad*(10))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5-0.15*cos(sine60/12),0.5*sin(sine60/12))*angles(rad*(-30*sin(sine60/12)),rad*(5*cos(sine60/12)),0)*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.9-0.2*cos(sine60/12),0.5*sin(sine60/12))*angles(rad*(-10-40*sin(sine60/12)),rad*(90+5*cos(sine60/12)),rad*(2.5*cos(sine60/12))),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.9+.2*cos(sine60/12),-0.5*sin(sine60/12))*angles(rad*(-10+40*sin(sine60/12)),rad*(-90+5*cos(sine60/12)),rad*(2.5*cos(sine60/12))),0.25)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.05*cos(sine60/12))*angles(rad*(15),0,0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-15-3*cos(sine60/12)),rad*(5-5*sin(sine60/12)),0),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5+0.1*cos(sine60/12),0)*angles(rad*(-53.75+1.75*cos(sine60/12)),0,rad*(5))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5+.1*sin(sine60/12),0)*angles(rad*(15),0,rad*(-5+5*cos(sine60/12)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.05*cos(sine60/12),-0.01)*angles(rad*(10),rad*(80),0),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.05*cos(sine60/12),-0.01)*angles(rad*(20),rad*(-80),0),0.25)
			end
			updateColor=function()
				CurrentColor=hsv(fmod(sine/3,1),1,1)
			end
		elseif Mode == 6 then
			HipHeight = 3
			WalkSpeed = 50
			ChangeName("\227\128\144 \239\187\191\239\189\140 \239\189\143 \239\189\134 \239\189\137 \227\128\145")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.5*sin(sine60/9))*angles(rad*(45),0,0),0.7/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*cf(0,-0.05,0)*angles(rad*(-45),0,0),0.7/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,-0.1)*angles(rad*(-45),0,0)*RSC0,0.7/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(135),0,0)*LSC0,0.7/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(-10),rad*(80),rad*(5+5*sin(sine60/9))),1/2)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,-0.01)*angles(0,rad*(-80),rad*(-5-5*sin(sine60/9))),1/2)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,2+0.5*cos(sine60/12))*angles(rad*(-60+2.5*sin(sine60/12)),0,rad*(5+1*sin(sine60/12))),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(4.5*sin(sine60/12)),0,rad*(-5-2.5*sin(sine60/12))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-30),0,rad*(15-5.5*cos(sine60/20)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.15,0.50+0.05*cos(sine60/99),0.4)*angles(rad*(-43),rad*(2.5*sin(sine60/99)),rad*(45-7.5*sin(sine60/99)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*cos(sine60/12),-0.05)*angles(rad*(35-7.5*sin(sine60/12)),rad*(75),0)*angles(rad*(-8-2.5*sin(sine60/12)),0,0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*cos(sine60/12),-0.05)*angles(rad*(35-7.5*sin(sine60/12)),rad*(-90),0)*angles(rad*(-8-2.5*sin(sine60/12)),0,0),1/3)
			end
			updateColor=function()
				CurrentColor=hsv(fmod(sine/3,1),1,1)
			end
		elseif Mode == 7 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName("E  D  G  Y")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.1)*angles(rad*(5),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-15,25)-2.5*sin(sine60/12)),rad*(mrandom(-15,25)),rad*(mrandom(-15,25))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.55,0.5,0.5)*angles(rad*(250),rad*(20),rad*(-80))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-35*cos(sine60/WalkSpeed)),0,rad*(-5))*LSC0,0.35/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2+0.2*cos(sine60/WalkSpeed))*angles(0,rad*(90),0)*angles(0,0,rad*(-15)),2/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2-0.2*cos(sine60/WalkSpeed))*angles(0,rad*(-90),0)*angles(0,0,rad*(15)),2/3)
			end
			idle=function()
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(7+6.5*sin(sine60/24)),rad*(10*sin(sine60/24)),rad*(6*sin(sine60/24))),0.5/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(120+6.5*sin(sine60/34)),rad*(5*sin(sine60/34)),rad*(10*sin(sine60/34)))*angles(rad*(5),0,0)*RSC0,0.5/3)
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,1.5+0.5*cos(sine60/32))*angles(0,0,rad*(10)),0.4/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad,0,rad*(22))*LSC0,0.4/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.4,-0.5)*angles(rad*(6.5*sin(sine60/12)),rad*(90),rad*(40*sin(sine60/34)))*angles(rad*(-3),rad*(-1*cos(sine60/36)),rad*(-10-2*cos(sine60/39))),0.2)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(rad*(10+4.6*sin(sine60/12)),rad*(-90),rad*(20*sin(sine60/34)))*angles(rad*(-3),rad*(-1*cos(sine60/36)),rad*(10+6*cos(sine60/31))),0.2)
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 8 then
			HipHeight = 3
			WalkSpeed = 140
			ChangeName("UnColorEd")
			walk=function()
				for i=1,resumes do
					--WEffect({Time=mrandom(15,65),EffectType="Wave",Size=v3(0,0.05,0),Size2=v3(0.516,0.516,0.516)*mrandom(8),Transparency=0,Transparency2=1,CFrame=Character.HumanoidRootPart.CFrame*cf(0,-2,0)*angles(rad*(mrandom(-5,5)),rad*(mrandom(-360,360)),rad*(mrandom(-5,5))),MoveToPos=nil,RotationX=0,RotationY=0,RotationZ=0,Material="Neon",Color=C3(0,0,0),SoundID=nil,SoundPitch=nil,SoundVolume=nil})
				end
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(.25*cos(sine60/63)+.92*sin(sine60/95),0,1+1*sin(sine60/53))*angles(rad*(70),0,rad*(3*cos(sine60/47))),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(15-2.5*sin(sine60/12)),0,0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(0,0,rad*(12-4.10*sin(sine60/12)))*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(0,0,rad*(-12+4.10*sin(sine60/12)))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5-0.02*sin(sine60/12),-0.5)*angles(rad*(-10-2.5*sin(sine60/21)),rad*(90),0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.02*sin(sine60/12),-0.01)*angles(rad*(-20-2.5*sin(sine60/51)),rad*(-90),0),0.15/3)	
			end
			idle=function()
				for i=1,resumes do
					if mrandom(3)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-10000,10000)),rad*(mrandom(-10000,10000)),rad*(mrandom(-10000,10000))),1/3)
					end
					--WEffect({Time=mrandom(15,65),EffectType="Wave",Size=v3(0,0.05,0),Size2=v3(0.516,0.516,0.516)*mrandom(8),Transparency=0,Transparency2=1,CFrame=Character.HumanoidRootPart.CFrame*cf(0,-2,0)*angles(rad*(mrandom(-5,5)),rad*(mrandom(-360,360)),rad*(mrandom(-5,5))),MoveToPos=nil,RotationX=0,RotationY=0,RotationZ=0,Material="Neon",Color=c3_0,SoundID=nil,SoundPitch=nil,SoundVolume=nil})
				end
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,2+.5*cos(sine60/32))*angles(rad*(-25+2*cos(sine60/42)),0,0),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-2.5+1*cos(sine60/12)),rad*(mrandom(-5,5)),0),1/3) 
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-30),0,rad*(15-5.5*cos(sine60/20)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-30),0,rad*(-15+5.5*cos(sine60/20)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.2)*angles(rad*(-30+2*cos(sine60/32)),rad*(80),0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,-0.2)*angles(rad*(-30+2*cos(sine60/46)),rad*(-80),0),1/3)
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 9 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName(" ")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.175+0.025*cos(sine60/3.5)-sin(sine60/3.5)/7)*angles(rad*(9-2.5*cos(sine60/3.5)),0,rad*(10*cos(sine60/7))),0.15)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-15,15)),rad*(mrandom(-15,15)),rad*(mrandom(-15,15))),0.35/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.925-0.5*cos(sine60/7)/2,0.5*cos(sine60/7)/2)*angles(rad*(-15-35*cos(sine60/7))+sin(sine60/7)/-2.5,rad*(90-2*cos(sine60/7)),0)*angles(rad*(2.5*cos(sine60/7)),0,0),0.3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.925+0.5*cos(sine60/7)/2,-0.5*cos(sine60/7)/2)*angles(rad*(-15+35*cos(sine60/7))+sin(sine60/7)/2.5,rad*(-90-2*cos(sine60/7)),0)*angles(rad*(-2.5*cos(sine60/7)),0,0),0.3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-60-5*cos(sine60/12)),rad*(-2.5*cos(sine60/12)),rad*(5+2.5*cos(sine60/12)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1,0.5+0.05*sin(sine60/30),0.025*cos(sine60/20))*angles(rad*(-70)*cos(sine60/7),rad*(-90),	rad*(-5)),0.1)
			end
			idle=function()
				for i=1,resumes do
					--local HITFLOOR,HITPOS=rayCast(Character.Torso.Position,(cf(Character.Torso.Position,Character.Torso.Position+v3(0,-1,0))).LookVector,4)
					--local POSITION=cf(HITPOS)*angles(0,rad*(mrandom(0,360)),0)*cf(mrandom(3,6),0,0).Position
					--local SPHEREFLOOR,SPHEREPOS=rayCast(POSITION+v3(0,1,0),(cf(POSITION,POSITION+v3(0,-1,0))).LookVector,5)
					--WEffect({Time=mrandom(10,30)*2,EffectType="Sphere",Size=v3(1.5,1.5,1.5),Size2=v3_0,Transparency=0,Transparency2=1,CFrame=cf(SPHEREPOS-v3(0,2,0))*angles(rad*(mrandom(0,360)),rad*(mrandom(0,360)),rad*(mrandom(0,360))),MoveToPos=SPHEREPOS+v3(0,mrandom(15,25)/5,0),mrandom(-25,25)/35,RotationY=mrandom(-25,25)/35,RotationZ=mrandom(-25,25)/35,Material="Neon",Color=c3_0,SoundID=nil,SoundPitch=mrandom(12,16)/10,SoundVolume=2,RED=true})
					--WEffect({Time=mrandom(10,30)*2,EffectType="Skull",Size=v3(1.5,1.5,1.5)*3.95,Size2=v3(0.425,0.425,0.425),Transparency=0,Transparency2=1,CFrame=cf(SPHEREPOS-v3(0,2,0))*angles(rad*(mrandom(0,360)),rad*(mrandom(0,360)),rad*(mrandom(0,360))),MoveToPos=SPHEREPOS+v3(0,mrandom(25,35)/5,0),mrandom(-25,25)/35,RotationY=mrandom(-25,25)/35,RotationZ=mrandom(-25,25)/35,Material="Neon",Color=c3_0,SoundID=nil,SoundPitch=mrandom(12,16)/10,SoundVolume=2,RED=true})
				end	
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,-0.1,-0.1+0.05*cos(sine60/12))*angles(rad*(15),0,0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(160),0,rad*(15-5*sin(sine60/25)))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5+0.025*cos(sine60/12),0)*angles(0,rad*(7.5*sin(sine60/12)),rad*(-12-7.5*sin(sine60/12)))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.05*cos(sine60/12),-0.01)*angles(rad*(20),rad*(90),0)*angles(rad*(-8),0,0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.05*cos(sine60/12),-0.01)*angles(rad*(5),rad*(-90),0)*angles(rad*(-8),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20),rad*(-10-2.5*sin(sine60/10)),rad*(20*cos(sine60/10))),1/3)
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 10 then
			HipHeight = 0
			WalkSpeed = 300
			ChangeName("oof speed")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.175+0.025*cos(sine60/3.5)+sin(sine60/3.5)/-7)*angles(rad*(9-2.5*cos(sine60/3.5)),0,rad*(10*cos(sine60/7))),0.15)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-15,15)),rad*(mrandom(-15,15)),rad*(mrandom(-15,15))),0.35/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.925-0.5*cos(sine60/7)/2,0.5*cos(sine60/7)/2)*angles(rad*(-15-35*cos(sine60/7))+sin(sine60/7)/-2.5,rad*(90-2*cos(sine60/7)),0)*angles(rad*(2.5*cos(sine60/7)),0,0),0.3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.925+0.5*cos(sine60/7)/2,-0.5*cos(sine60/7)/2)*angles(rad*(-15+35*cos(sine60/7))+sin(sine60/7)/2.5,rad*(-90-2*cos(sine60/7)),0)*angles(rad*(-2.5*cos(sine60/7)),0,0),0.3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-60-5*cos(sine60/12)),rad*(-2.5*cos(sine60/12)),rad*(5+2.5*cos(sine60/12)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1,0.5+0.05*sin(sine60/30),0.025*cos(sine60/20))*angles(rad*(-70)*cos(sine60/7),rad*(-90),	rad*(-5)),0.1)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.2)*angles(rad*(sine60*-6),0,0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0,0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-75*sin(sine60/5)),0,0)*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(75*sin(sine60/5)),0,0)*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(75*sin(sine60/5)),rad*(90),0),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,-0.01)*angles(rad*(-75*sin(sine60/5)),rad*(-90),0),0.25)
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 11 then
			HipHeight = 3
			WalkSpeed = 32
			ChangeName("War Crimes")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.5*sin(sine60/25))*angles(rad*(20),0,0),0.25)
				if NeckSnap then
					Neck.C0=Lerp1(Neck.C0,NECKC0,1)
					NeckSnap=false
				else
					Neck.C0=Lerp1(Neck.C0,NECKC0,0.25)
				end
				for i=1,resumes do
					if mrandom(15)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-20,20)),rad*(mrandom(-20,20)),rad*(mrandom(-20,20))),1)
						NeckSnap=true
					end
				end
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-10),0,0)*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(20),0,rad*(-10-10*cos(sine60/25)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,0)*angles(rad*(-20),rad*(80),rad*(10+10*cos(sine60/25))),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(rad*(-10),rad*(-80),rad*(-10-10*cos(sine60/25))),0.25)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.5*sin(sine60/25))*angles(rad*(20),0,0),0.25)
				if NeckSnap then
					Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20),rad*(10*sin(sine60/50)),0),1)
					NeckSnap=false
				else
					Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20),rad*(10*sin(sine60/50)),0),0.25)
				end
				for i=1,resumes do
					if mrandom(15)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20+mrandom(-20,20)),rad*((10*sin(sine60/50))+mrandom(-20,20)),rad*(mrandom(-20,20))),1)
						NeckSnap=true
					end
				end
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-10),0,0)*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(20),0,rad*(-10-10*cos(sine60/25)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,0)*angles(rad*(10),rad*(80),rad*(10+10*cos(sine60/25))),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(rad*(20),rad*(-80),rad*(-10-10*cos(sine60/25))),0.25)
			end
			CurrentColor=rgb(20,20,20)
			updateColor=emptyfunction
		elseif Mode == 12 then
			HipHeight = 2
			WalkSpeed = 50
			ChangeName("Treacherous Thorns")
			walk=function()
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.25,-0.5)*angles(0,rad*(90),0)*angles(rad*(-2.5),0,rad*(-20)),0.2)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(0,rad*(-90),0)*angles(rad*(-2.5),0,rad*(20)),0.2)
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,-0.5,0.5+0.1*cos(sine60/28))*angles(rad*(75),0,0),0.2)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-20),0,0),0.2)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-30),0,rad*(30+2.5*cos(sine60/28))),0.2)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-30),0,rad*(-30-2.5*cos(sine60/28))),0.2)
			end
			idle=function()
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.25,-0.5)*angles(0,rad*(90),0)*angles(rad*(-2.5),0,rad*(-10)),0.1)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(0,rad*(-90),0)*angles(rad*(-2.5),0,rad*(10)),0.1)
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,1.5+0.1*cos(sine60/28))*angles(rad*(-cos(sine60/34)),0,0),0.1)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(15),0,0),0.1)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(10),0,rad*(20+2.5*cos(sine60/28))),0.1)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(10),0,rad*(-20-2.5*cos(sine60/28))),0.1)
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 13 then
			HipHeight = 2
			WalkSpeed = 16
			ChangeName("5YSTEM FA1LURE")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(.25*cos(sine60/63)+.92*sin(sine60/95),0,1+1*sin(sine60/53))*angles(rad*(70),0,rad*(3*cos(sine60/47))),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(15-2.5*sin(sine60/12)),0,0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(0,0,rad*(12-4.10*sin(sine60/12)))*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(0,0,rad*(-12+4.10*sin(sine60/12)))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5-0.02*sin(sine60/12),-0.5)*angles(rad*(-10-2.5*sin(sine60/21)),rad*(90),0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.02*sin(sine60/12),-0.01)*angles(rad*(-20-2.5*sin(sine60/51)),rad*(-90),0),0.15/3)	
			end
			idle=function()
				for i=1,resumes do
					if mrandom(2)==1 then
						RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1,0.5,-0.6)*angles(rad*(mrandom(-10000,10000)),rad*(mrandom(-10000,10000)),rad*(mrandom(-10000,10000)))*RSC0,0.15/3)
						LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1,0.5,-0.6)*angles(rad*(mrandom(-10000,10000)),rad*(mrandom(-10000,10000)),rad*(mrandom(-10000,10000)))*LSC0,0.15/3)
					end
				end
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,3+1*sin(sine60/26))*angles(rad*(25-2.5*sin(sine60/24)),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-15-2.5*sin(sine60/12*5)),0,rad*(mrandom(-5,5))),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1,0.5,-0.6)*angles(rad*(165),0,rad*(-50))*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1,0.5,-0.6)*angles(rad*(165),0,rad*(50))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5-0.02*sin(sine60/12),-0.5)*angles(rad*(-70-2.5*sin(sine60/32)),rad*(90),0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.02*sin(sine60/12),-0.01)*angles(rad*(-70-2.5*sin(sine60/16)),rad*(-90),0),0.15/3)
			end
			updateColor=function()
				CurrentColor=rgb(mrandom(255),0,0)
			end
		elseif Mode == 14 then
			HipHeight = 0
			WalkSpeed = 50
			ChangeName("\227\131\128\227\131\188\227\131\170\227\131\179!")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.175+0.025*cos(sine60/3.5)+sin(sine60/3.5)/-7)*angles(rad*(26-4.5*cos(sine60/3.5)),0,rad*(15*cos(sine60/7))),0.15)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(25+mrandom(-5,5)-4*cos(sine60/12)),rad*(mrandom(-5,5)),rad*(15)),1/3)
				for i=1,resumes do
					if mrandom(5)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-25,25)-4*cos(sine60/12)),rad*(mrandom(-25,25)),0),1.5/3)	
					end
				end
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.925-0.5*cos(sine60/7)/2,0.7*cos(sine60/7)/2)*angles(rad*(-15-55*cos(sine60/7))+sin(sine60/7)/-2.5,rad*(90-0.1*cos(sine60/7)),0)*angles(rad*(0.1*cos(sine60/7)),0,0),0.3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.925+0.5*cos(sine60/7)/2,-0.7*cos(sine60/7)/2)*angles(rad*(-15+55*cos(sine60/7))+sin(sine60/7)/2.5,rad*(-90-0.1*cos(sine60/7)),0)*angles(rad*(-0.1*cos(sine60/7)),0,0),0.3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5+.2*sin(sine60/12),-0.25)*angles(rad*(165-15*cos(sine60/12)),rad*(-10+5*sin(sine60/12)),rad*(10))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1,0.5+0.05*sin(sine60/30),-0.34*cos(sine60/7))*angles(rad*(-110)*cos(sine60/7),rad*(-90),	rad*(-13)),0.15)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.03+0.05*cos(sine60/12))*angles(0,0,rad*(-35)),1/5)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(25+mrandom(-5,5)-4*cos(sine60/12)),rad*(mrandom(-5,5)),rad*(15)),1/5)
				for i=1,resumes do
					if mrandom(5)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-25,25)-4*cos(sine60/12)),rad*(mrandom(-25,25)),0),1.5/3)	
					end
				end
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(160),0,rad*(15-5*sin(sine60/25)))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5+0.025*cos(sine60/12),0)*angles(0,rad*(7.5*sin(sine60/12)),rad*(-12-7.5*sin(sine60/12)))*LSC0,0.15/5)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.05*cos(sine60/12),0)*angles(0,rad*(95),0)*angles(rad*(-15),0,0),1/5)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.05*cos(sine60/12),0)*angles(0,rad*(-55),0)*angles(rad*(-12),0,0),1/5)
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 15 then
			HipHeight = 0
			WalkSpeed = 36
			ChangeName("LCV01")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.05*cos(sine60/12))*angles(rad*(20),rad*(2.5*cos(sine60/12)),rad*(-2.5*cos(sine60/12))),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-20-3*cos(sine60/12)),rad*(-2.5*cos(sine60/12)),rad*(-2.5*cos(sine60/12))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-70-5*cos(sine60/12)),rad*(-2.5*cos(sine60/12)),rad*(5+2.5*cos(sine60/12)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,-0.2*cos(sine60/12))*angles(rad*(20+45*cos(sine60/12)),rad*(-10*cos(sine60/12)),rad*(2.5*cos(sine60/12)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.925-0.5*cos(sine60/7)/2,0.5*cos(sine60/7)/2)*angles(rad*(-15-35*cos(sine60/7))+sin(sine60/7)/-2.5,rad*(90-2*cos(sine60/7)),0)*angles(rad*(2.5*cos(sine60/7)),0,0),0.3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.925+0.5*cos(sine60/7)/2,-0.5*cos(sine60/7)/2)*angles(rad*(-15+35*cos(sine60/7))+sin(sine60/7)/2.5,rad*(-90-2*cos(sine60/7)),0)*angles(rad*(-2.5*cos(sine60/7)),0,0),0.3)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.05*cos(sine60/12)),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20-2.5*sin(sine60/12)),0,rad*(30*cos(sine60/12))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-41.6-4*sin(sine60/50)),0,0)*RSC0,0.7/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(20),0,rad*(-10-10*sin(sine60/50)))*LSC0,0.7/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.05*cos(sine60/12),-0.01)*angles(0,rad*(90),0)*angles(rad*(-8),0,0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.05*cos(sine60/12),-0.01)*angles(0,rad*(-90),0)*angles(rad*(-8),0,0),1/3)
			end
			updateColor=function()
				CurrentColor=hsv(fmod(sine/3,1),1,1)
			end
		elseif Mode == 16 then
			HipHeight = 0
			WalkSpeed = 25
			ChangeName(" ")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,3-0.5*sin(sine60/50))*angles(rad*(20),0,0),0.7/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0,0.7/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-41.6-4*sin(sine60/50)),0,0)*RSC0,0.7/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(20),0,rad*(-10-10*sin(sine60/50)))*LSC0,0.7/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(-20),rad*(80),rad*(10+10*sin(sine60/50))),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,-0.01)*angles(rad*(-10),rad*(-80),rad*(-10-10*sin(sine60/50))),1/3)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.05*cos(sine60/12)),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20-2.5*sin(sine60/12)),0,rad*(30*cos(sine60/12))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-41.6-4*sin(sine60/50)),0,0)*RSC0,0.7/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(20),0,rad*(-10-10*sin(sine60/50)))*LSC0,0.7/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.05*cos(sine60/12),-0.01)*angles(0,rad*(90),0)*angles(rad*(-8),0,0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.05*cos(sine60/12),-0.01)*angles(0,rad*(-90),0)*angles(rad*(-8),0,0),1/3)
			end
			updateColor=function()
				CurrentColor=rgb(mrandom(255),mrandom(255),mrandom(255))
			end
		elseif Mode == 17 then
			HipHeight = 0
			WalkSpeed = 18
			ChangeName("Revenge")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.1)*angles(rad*(5),0,0),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*cf(0,0,((1.1)-1))*angles(rad*(15-1*sin(sine60/(WalkSpeed/2))),0,0),1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.25,0.5,0.5)*angles(rad*(-35),rad*(25-2.5*sin(sine60/WalkSpeed)),rad*(55-2.5*sin(sine60/WalkSpeed)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.925-0.5*cos(sine60/7)/2,0.5*cos(sine60/7)/2)*angles(rad*(-15-35*cos(sine60/7))+sin(sine60/7)/-2.5,rad*(90-2*cos(sine60/7)),0)*angles(rad*(2.5*cos(sine60/7)),0,0),0.3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.925+0.5*cos(sine60/7)/2,-0.5*cos(sine60/7)/2)*angles(rad*(-15+35*cos(sine60/7))+sin(sine60/7)/2.5,rad*(-90-2*cos(sine60/7)),0)*angles(rad*(-2.5*cos(sine60/7)),0,0),0.3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(160),0,rad*(15-5*sin(sine60/25)))*RSC0,0.25)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(-0.04*sin(sine60/24),0.04*sin(sine60/12),0.05*cos(sine60/12))*angles(rad*(-2.5*sin(sine60/12)),rad*(-2.5*sin(sine60/24)),0),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*cf(0,0,((1.1)-1))*angles(rad*(25-4*sin(sine60/12)),0,0),1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.25,0.5,0.5)*angles(rad*(-35),rad*(25-2.5*sin(sine60/12)),rad*(55-2.5*sin(sine60/12)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1+0.06*sin(sine60/24)-0.05*cos(sine60/12),-0.01)*angles(rad*(-2.5*sin(sine60/12)),rad*(75),0)*angles(rad*(-2-2.5*sin(sine60/24)),0,0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.06*sin(sine60/24)-0.05*cos(sine60/12),-0.01)*angles(rad*(-2.5*sin(sine60/12)),rad*(-75),0)*angles(rad*(-2+2.5*sin(sine60/24)),0,0),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(160),0,rad*(15-5*sin(sine60/25)))*RSC0,0.25)
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 18 then
			HipHeight = 0
			WalkSpeed = 50
			ChangeName("Famous 600k")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,4+0.6*cos(sine60/12))*angles(rad*(20),0,0),0.6/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-20-2.5*sin(sine60/12)),0,0),0.5/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-20),0,rad*(30))*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-20),0,rad*(-30))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.8,-0.01)*angles(0,rad*(90),rad*(-25+10*cos(sine60/12))),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.8,-0.01)*angles(0,rad*(-90),rad*(20-10*cos(sine60/12))),0.15/3)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,4+0.6*cos(sine60/12))*angles(rad*(-10),rad*(5),0),0.6/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20-2.5*sin(sine60/12)),rad*(-5),0),0.5/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(20),rad*(-20),rad*(30))*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-20),rad*(20),rad*(-30))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.8,-0.01)*angles(0,rad*(90),rad*(25+10*cos(sine60/12))),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.8,-0.01)*angles(0,rad*(-90),rad*(-10-10*cos(sine60/12))),0.15/3)
			end
			CurrentColor=rgb(255,255,255)
			updateColor=emptyfunction
		elseif Mode == 19 then
			HipHeight = 0
			WalkSpeed = 20
			ChangeName("SuperUBlockAlt")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,3+0.5*cos(sine60/22))*angles(rad*(20),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(5),0,0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.1,-0.4)*angles(rad*(150),0,0)*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-0.45,0.5,-1)*angles(rad*(60),0,rad*(80))*LSC0,0.35/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,0)*angles(0,rad*(90),0)*angles(rad*(-8),0,rad*(-15)),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(0,rad*(-90),0)*angles(rad*(-8),0,rad*(15)),0.15/3)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,3+0.5*cos(sine60/22)),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-2.5*sin(sine60/12)),0,0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.2,0.5+0.05*sin(sine60/24),-0.7)*angles(rad*(180),0,0)*angles(rad*(5),0,0)*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-0.45,0.5,-1)*angles(rad*(90),0,rad*(90))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.8,-0.01)*angles(0,rad*(70),rad*(-20+10*cos(sine60/22)))*angles(rad*(-8),0,0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.8,-0.01)*angles(0,rad*(-70),rad*(25-10*cos(sine60/22)))*angles(rad*(-8),0,0),0.15/3)
			end
			updateColor=function()
				CurrentColor=rgb(mrandom(255),mrandom(255),mrandom(255))
			end
		elseif Mode == 20 then
			HipHeight = 0
			WalkSpeed = 50
			ChangeName("DeepEnd")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(-0.25*cos(sine60/63)+.92*sin(sine60/95),0,4-2*sin(sine60/53))*angles(rad*(70),0,rad*(3*cos(sine60/47))),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(15-2.5*sin(sine60/12)),0,0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(0,0,rad*(12-4.10*sin(sine60/12)))*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-0.75,0.5,0.5)*angles(rad*(-25+mrandom(-23,23)),rad*(mrandom(-23,23)),rad*(45+mrandom(-23,23)))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5-0.02*sin(sine60/12),-0.5)*angles(rad*(-10-2.5*sin(sine60/21)),rad*(90),0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.02*sin(sine60/12),-0.01)*angles(rad*(-20-2.5*sin(sine60/51)),rad*(-90),0),0.15/3)	
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,2+1*cos(sine60/18)),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0,1/3) 
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5+0.05*sin(sine60/12),0)*angles(rad*(160+4*cos(sine60/62)),0,rad*(15-3*cos(sine60/12)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5+0.05*sin(sine60/12),0)*angles(0,0,rad*(-15+3*cos(sine60/12)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,0)*angles(rad*(-17+9.4*cos(sine60/26)),rad*(80),0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.5,-0.5)*angles(rad*(-22+10.8*cos(sine60/32)),rad*(-80),0),1/3)
				for i=1,resumes do
					if mrandom(32)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-100000,100000)),rad*(mrandom(-99999,99999)),rad*(mrandom(-200,48375935))),1/3) 
					end
					if mrandom(20)==1 then
						RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5+0.05*sin(sine60/12),0)*angles(rad*(mrandom(-90,90)),rad*(mrandom(-30,30)),rad*(mrandom(-50,50)))*RSC0,1/3)
						LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5+0.05*sin(sine60/12),0)*angles(rad*(mrandom(-10000,10000)),rad*(mrandom(-900,900)),rad*(mrandom(-20,20)))*LSC0,1/3)
					end
				end
			end
			updateColor=function()
				CurrentColor=hsv(fmod(sine/3,1),1,1)
			end
		elseif Mode == 21 then
			HipHeight = 0
			WalkSpeed = 50
			ChangeName("LCV4 Visualizer")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0.5*cos(sine60/50),0,-0.5*sin(sine60/50))*angles(rad*(40),0,0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*cf(0,-0.25,0)*angles(rad*(-40),0,0),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-45),0,rad*(5+2*cos(sine60/19)))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-45),0,rad*(-5-2*cos(sine60/19)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5,-0.5)*angles(rad*(-20+9*cos(sine60/74)),rad*(80),0)*angles(rad*(5*cos(sine60/37)),0,0),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(rad*(-20-9*cos(sine60/54)),rad*(-80),0)*angles(rad*(-5*cos(sine60/41)),0,0),0.25)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.05*cos(sine60/12)),0.8/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-1-2*cos(sine60/32)),0,rad*(10)),1/3) 
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(40.5),0,rad*(10))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.45,0.4,0.5)*angles(rad*(25),0,rad*(35))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.025*cos(sine60/12),-0.01)*angles(0,rad*(83),0),0.8/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.05*cos(sine60/12),-0.01)*angles(0,rad*(-83),0),0.8/3)
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 22 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName("Ultra Skidded Rainbow King V4 - CrAzEd")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.1)*angles(rad*(5),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(5-8*sin(sine60/(WalkSpeed/2))),0,0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.1,-0.4)*angles(rad*(150),0,0)*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-60*cos(sine60/WalkSpeed)),0,rad*(-5))*LSC0,0.35/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2+0.2*cos(sine60/WalkSpeed))*angles(0,rad*(90),0)*angles(0,0,rad*(-15)),2/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2-0.2*cos(sine60/WalkSpeed))*angles(0,rad*(-90),0)*angles(0,0,rad*(15)),2/3)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.7)*angles(rad*(mrandom(-15,15)),rad*(mrandom(-15,15)),rad*(mrandom(-15,15))),0.35/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(30+mrandom(-15,15)),rad*(mrandom(-15,15)),rad*(mrandom(-15,15))),0.35/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(160+mrandom(-15,15)),rad*(mrandom(-15,15)),rad*(-30+mrandom(-15,15)))*RSC0,0.35/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(160+mrandom(-15,15)),rad*(mrandom(-15,15)),rad*(30+mrandom(-15,15)))*LSC0,0.35/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5,-0.5)*angles(0,rad*(90),0),0.35/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(rad*(-60),0,0)*angles(0,rad*(-90),0),0.35/3)
			end
			updateColor=function()
				CurrentColor=rgb(mrandom(255),mrandom(255),mrandom(255))
			end
		elseif Mode == 23 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName("The School Shooter")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.1)*angles(rad*(5),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(5-8*sin(sine60/(WalkSpeed/2))),0,0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,-0.03)*angles(rad*(180),rad*(-15),0)*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-60*cos(sine60/WalkSpeed)),0,rad*(-5))*LSC0,0.35/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2+0.2*cos(sine60/WalkSpeed))*angles(0,rad*(90),0)*angles(0,0,rad*(-15)),2/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2-0.2*cos(sine60/WalkSpeed))*angles(0,rad*(-90),0)*angles(0,0,rad*(15)),2/3)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.05*cos(sine60/12)),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-2.5*sin(sine60/12)),0,0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,-0.03)*angles(rad*(180),rad*(-15),0)*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.45,0.4,0.5)*angles(rad*(25),0,rad*(35))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.05*cos(sine60/12),-0.01)*angles(0,rad*(75),0)*angles(rad*(-8),0,0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.05*cos(sine60/12),-0.01)*angles(0,rad*(-75),0)*angles(rad*(-8),0,0),0.15/3)
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 24 then
			HipHeight = 0
			WalkSpeed = 50
			ChangeName("The Quick Brown Fox")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.25*cos(sine60/12))*angles(rad*(15+2.5*sin(sine60/12)),0,rad*(2.5+2.5*sin(sine60/12))),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-10+4.5*sin(sine60/12)),0,rad*(-2.5-2.5*sin(sine60/12))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1,0.5+0.025*cos(sine60/12),-1)*angles(0,rad*(-7.5*sin(sine60/12)),rad*(-90+7.5*sin(sine60/12)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1,0.025*cos(sine60/12),-1)*angles(rad*(25),rad*(7.5*sin(sine60/12)),rad*(90-7.5*sin(sine60/12)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(-25-2.5*sin(sine60/12)),rad*(75),0)*angles(rad*(-8-5.5*sin(sine60/12)),0,0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.5,-0.5)*angles(rad*(-2.5*sin(sine60/12)),rad*(-90),0)*angles(rad*(-8-2.5*sin(sine60/12)),0,0),1/3)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.25*cos(sine60/12))*angles(rad*(4+2.5*sin(sine60/12)),0,0),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(15+4.5*sin(sine60/12)),0,rad*(-4*sin(sine60/12))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1,0.5+0.025*cos(sine60/12),-1)*angles(0,rad*(-7.5*sin(sine60/12)),rad*(-90+7.5*sin(sine60/12)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1,0.025*cos(sine60/12),-1)*angles(rad*(25),rad*(7.5*sin(sine60/12)),rad*(90-7.5*sin(sine60/12)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(-7.5*sin(sine60/12)),rad*(75),0)*angles(rad*(-8-2.5*sin(sine60/12)),0,0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.5,-0.5)*angles(rad*(-7.5*sin(sine60/12)),rad*(-90),0)*angles(rad*(-8-2.5*sin(sine60/12)),0,0),1/3)
			end
			updateColor=function()
				CurrentColor=rgb(mrandom(255),mrandom(255),mrandom(255))
			end
		elseif Mode == 25 then
			HipHeight = 1
			WalkSpeed = 50
			ChangeName("Alien")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.25*cos(sine60/12))*angles(rad*(25+2.5*sin(sine60/12)),0,rad*(25)),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-25+4.5*sin(sine60/12)),0,rad*(-25)),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.25,0.35+0.15*cos(sine60/12),0)*angles(rad*(110),rad*(-15-2.5*sin(sine60/12)),rad*(35+7.5*sin(sine60/12)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.25,0.5,0.5)*angles(rad*(-45),0,rad*(45))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(-25-2.5*sin(sine60/12)),rad*(75),0)*angles(rad*(-8-5.5*sin(sine60/12)),0,0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.5,-0.5)*angles(rad*(-2.5*sin(sine60/12)),rad*(-90),0)*angles(rad*(-8-2.5*sin(sine60/12)),0,0),1/3)
			end
			idle=function()
				for i=1,resumes do
					if mrandom(5)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(25+mrandom(-1,1)),rad*(mrandom(-1,1)),rad*(mrandom(-1,1))),0.6)
					end
				end
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.25*cos(sine60/12))*angles(rad*(4+2.5*sin(sine60/12)),0,rad*(25)),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(4.5*sin(sine60/12)),0,rad*(-25)),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.25,0.35+0.15*cos(sine60/12),0)*angles(rad*(110),rad*(-15-2.5*sin(sine60/12)),rad*(35+7.5*sin(sine60/12)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(5),0,rad*(-15-10*sin(sine60/12)))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(-2.5*sin(sine60/12)),rad*(75),0)*angles(rad*(-8-2.5*sin(sine60/12)),0,0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.5,-0.5)*angles(rad*(-2.5*sin(sine60/12)),rad*(-90),0)*angles(rad*(-8-2.5*sin(sine60/12)),0,0),1/3)
			end
			updateColor=function()
				CurrentColor=rgb(0,mrandom(255),0)
			end
		elseif Mode == 26 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName("K33P TH3 S3CR3T") 
			walk=function()
				for i=1,resumes do
					if mrandom(1)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(500)),rad*(mrandom(500)),rad*(mrandom(500))),1)
					end
					--local hfloor6,hpos6=rayCast(Character.Torso.Position,(cf(Character.Torso.Position,Character.Torso.Position+v3(0,-1,0))).LookVector,4)
					--local spos=cf(hpos6)*angles(0,rad*(mrandom(0,360)),0)*cf(mrandom(3,6),0,0).Position
					--local sfloor,spos6=rayCast(spos+v3(0,1,0),(cf(spos,spos+v3(0,-1,0))).LookVector,5)
					--WEffect({Time=30,EffectType="Sphere",Size=v3(0.5,0,0.5),Size2=v3(0.2,25,0.2),Transparency=0.3,Transparency2=1,CFrame=cf(hpos6)*angles(0,rad*(mrandom(0,360)),0)*cf(0,0,mrandom(3,15))*angles(rad*(mrandom(-15,15)),0,rad*(mrandom(-15,15))),MoveToPos=nil,RotationX=0,RotationY=mrandom(-1,1)*5,RotationZ=0,Material="Neon",Color=c3_0,UseBoomerangMath=true,SizeBoomerang=50,SoundID=nil,SoundPitch=nil,SoundVolume=nil})	
				end	
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.1)*angles(rad*(5),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-15,25)-2.5*sin(sine60/12)),rad*(mrandom(-15,25)),rad*(mrandom(-15,25))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.55,0.5,0.5)*angles(rad*(250),rad*(20),rad*(-80))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-35*cos(sine60/WalkSpeed)),0,rad*(-5))*LSC0,0.35/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2+0.2*cos(sine60/WalkSpeed))*angles(0,rad*(90),0)*angles(0,0,rad*(-15)),2/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2-0.2*cos(sine60/WalkSpeed))*angles(0,rad*(-90),0)*angles(0,0,rad*(15)),2/3)
			end
			idle=function()
				for i=1,resumes do
					Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(500)),rad*(mrandom(500)),rad*(mrandom(500))),1)
					--local hfloor6,hpos6=rayCast(Character.Torso.Position,(cf(Character.Torso.Position,Character.Torso.Position+v3(0,-1,0))).LookVector,4)
					--local spos=cf(hpos6)*angles(0,rad*(mrandom(0,360)),0)*cf(mrandom(3,6),0,0).Position
					--local sfloor,spos6=rayCast(spos+v3(0,1,0),(cf(spos,spos+v3(0,-1,0))).LookVector,5)
					--WEffect({Time=30,EffectType="Sphere",Size=v3(0.5,0,0.5),Size2=v3(0.2,25,0.2),Transparency=0.3,Transparency2=1,CFrame=cf(hpos6)*angles(0,rad*(mrandom(0,360)),0)*cf(0,0,mrandom(3,15))*angles(rad*(mrandom(-15,15)),0,rad*(mrandom(-15,15))),MoveToPos=nil,RotationX=0,RotationY=mrandom(-1,1)*5,RotationZ=0,Material="Neon",Color=c3_0,UseBoomerangMath=true,SizeBoomerang=50,SoundID=nil,SoundPitch=nil,SoundVolume=nil})	
				end	
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-1.3+0.1*cos(sine60/24))*angles(rad*(-4*sin(sine60/24)),rad*(1*cos(sine60/24)),rad*(-10)),0.1/3)            
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(7-2*sin(sine60/20)),rad*(-20),0),0.1/3)              
				RightHip.C0=Lerp1(RightHip.C0,cf(1,0.1-0.1*cos(sine60/24)-rad*(1*cos(sine60/24)),-0.3)*angles(rad*(13-6*sin(sine60/24)),rad*(90),0),0.1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1.3-0.1*cos(sine60/24)+rad*(1*cos(sine60/24)),-0.15)*angles(rad*(-90-6*sin(sine60/24)),rad*(-90),0),0.1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(0.8,0.4+0.1*sin(sine60/35),0.5)*angles(rad*(90),rad*(90),0),0.1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(0.3,0.7+0.1*sin(sine60/35),-1.5)*angles(rad*(80),rad*(4*sin(sine60/35)),rad*(50+3*sin(sine60/35))),0.1/3)
			end
			CurrentColor=c3(0.145098,0.0392157,0.223529)
			updateColor=emptyfunction
		elseif Mode == 27 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName(" ")
			walk=function()
				for i=1,resumes do
					--local hfloor6,hpos6=rayCast(Character.Torso.Position,(cf(Character.Torso.Position,Character.Torso.Position+v3(0,-1,0))).LookVector,4)
					--local spos=cf(hpos6)*angles(0,rad*(mrandom(0,360)),0)*cf(mrandom(3,6),0,0).Position
					--local sfloor,spos6=rayCast(spos+v3(0,1,0),(cf(spos,spos+v3(0,-1,0))).LookVector,5)
					--WEffect({Time=30,EffectType="Sphere",Size=v3(0.5,0,0.5),Size2=v3(0.2,25,0.2),Transparency=0.3,Transparency2=1,CFrame=cf(hpos6)*angles(0,rad*(mrandom(0,360)),0)*cf(0,0,mrandom(3,15))*angles(rad*(mrandom(-15,15)),0,rad*(mrandom(-15,15))),MoveToPos=nil,RotationX=0,RotationY=mrandom(-1,1)*5,RotationZ=0,Material="Neon",Color=Color3.fromRGB(0,0,0),UseBoomerangMath=true,SizeBoomerang=50,SoundID=nil,SoundPitch=nil,SoundVolume=nil})	
					--WEffect({Time=mrandom(10,30)*2,EffectType="Sphere",Size=v3(1.5,1.5,1.5),Size2=v3_0,Transparency=0,Transparency2=1,CFrame=cf(spos6-v3(0,2,0))*angles(rad*(mrandom(0,360)),rad*(mrandom(0,360)),rad*(mrandom(0,360))),MoveToPos=spos6+v3(0,mrandom(15,25)/5,0),mrandom(-25,25)/35,RotationY=mrandom(-25,25)/35,RotationZ=mrandom(-25,25)/35,Material="Neon",Color=Color3.fromRGB(0,0,0),SoundID=nil,SoundPitch=mrandom(12,16)/10,SoundVolume=2,RED=true})
					--WEffect({Time=12,EffectType="Block",Size=v3(3,3,3)/3,Size2=v3_0,Transparency=.5,Transparency2=1,CFrame=Character.RightArm.CFrame*cf(0,-1.45,0),MoveToPos=nil,RotationX=0,RotationY=0,RotationZ=0,Material="Neon",Color=Color3.fromRGB(0,0,0),SoundID=nil,SoundPitch=nil,SoundVolume=nil})
					--WEffect({Time=mrandom(10,30)*2,EffectType="Skull",Size=v3(1.5,1.5,1.5)*3.95,Size2=v3(0.425,0.425,0.425),Transparency=0,Transparency2=1,CFrame=cf(spos6-v3(0,2,0))*angles(rad*(mrandom(0,360)),rad*(mrandom(0,360)),rad*(mrandom(0,360))),MoveToPos=spos6+v3(0,mrandom(25,35)/5,0),mrandom(-25,25)/35,RotationY=mrandom(-25,25)/35,RotationZ=mrandom(-25,25)/35,Material="Neon",Color=Color3.fromRGB(0,0,0),SoundID=nil,SoundPitch=mrandom(12,16)/10,SoundVolume=2,RED=true})
				end	
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.1)*angles(rad*(5),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(2)-2.5*sin(sine60/12)),rad*(mrandom(2)),rad*(mrandom(2))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(35*cos(sine60/WalkSpeed)),0,rad*(5))*RSC0,0.35/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,-0.2*cos(sine60/12))*angles(rad*(20+45*cos(sine60/12)),rad*(-10*cos(sine60/12)),rad*(2.5*cos(sine60/12)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2+0.2*cos(sine60/WalkSpeed))*angles(0,rad*(90),0)*angles(0,0,rad*(-15)),2/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2-0.2*cos(sine60/WalkSpeed))*angles(0,rad*(-90),0)*angles(0,0,rad*(15)),2/3)
			end
			idle=function()
				for i=1,resumes do
					--local hfloor6,hpos6=rayCast(Character.Torso.Position,(cf(Character.Torso.Position,Character.Torso.Position+v3(0,-1,0))).LookVector,4)
					--local spos=cf(hpos6)*angles(0,rad*(mrandom(0,360)),0)*cf(mrandom(3,6),0,0).Position
					--local sfloor,spos6=rayCast(spos+v3(0,1,0),(cf(spos,spos+v3(0,-1,0))).LookVector,5)
					--WEffect({Time=30,EffectType="Sphere",Size=v3(0.5,0,0.5),Size2=v3(0.2,25,0.2),Transparency=0.3,Transparency2=1,CFrame=cf(hpos6)*angles(0,rad*(mrandom(0,360)),0)*cf(0,0,mrandom(3,15))*angles(rad*(mrandom(-15,15)),0,rad*(mrandom(-15,15))),MoveToPos=nil,RotationX=0,RotationY=mrandom(-1,1)*5,RotationZ=0,Material="Neon",Color=Color3.fromRGB(0,0,0),UseBoomerangMath=true,SizeBoomerang=50,SoundID=nil,SoundPitch=nil,SoundVolume=nil})	
					--WEffect({Time=mrandom(10,30)*2,EffectType="Sphere",Size=v3(1.5,1.5,1.5),Size2=v3_0,Transparency=0,Transparency2=1,CFrame=cf(spos6-v3(0,2,0))*angles(rad*(mrandom(0,360)),rad*(mrandom(0,360)),rad*(mrandom(0,360))),MoveToPos=spos6+v3(0,mrandom(15,25)/5,0),mrandom(-25,25)/35,RotationY=mrandom(-25,25)/35,RotationZ=mrandom(-25,25)/35,Material="Neon",Color=Color3.fromRGB(0,0,0),SoundID=nil,SoundPitch=mrandom(12,16)/10,SoundVolume=2,RED=true})
					--WEffect({Time=12,EffectType="Block",Size=v3(3,3,3)/3,Size2=v3_0,Transparency=.5,Transparency2=1,CFrame=Character.RightArm.CFrame*cf(0,-1.45,0),MoveToPos=nil,RotationX=0,RotationY=0,RotationZ=0,Material="Neon",Color=Color3.fromRGB(0,0,0),SoundID=nil,SoundPitch=nil,SoundVolume=nil})
					--WEffect({Time=mrandom(10,30)*2,EffectType="Skull",Size=v3(1.5,1.5,1.5)*3.95,Size2=v3(0.425,0.425,0.425),Transparency=0,Transparency2=1,CFrame=cf(spos6-v3(0,2,0))*angles(rad*(mrandom(0,360)),rad*(mrandom(0,360)),rad*(mrandom(0,360))),MoveToPos=spos6+v3(0,mrandom(25,35)/5,0),mrandom(-25,25)/35,RotationY=mrandom(-25,25)/35,RotationZ=mrandom(-25,25)/35,Material="Neon",Color=Color3.fromRGB(0,0,0),SoundID=nil,SoundPitch=mrandom(12,16)/10,SoundVolume=2,RED=true})
					if mrandom(4)==1 then
						RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(mrandom(-99999999,99999999)),rad*(mrandom(-99999999,99999999)),rad*(mrandom(-99999999,99999999)))*RSC0,0.15/3)
						LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(mrandom(-99999999,99999999)),rad*(mrandom(-99999999,99999999)),rad*(mrandom(-99999999,99999999)))*LSC0,0.15/3)
					end	
					if mrandom(25)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-10000,10000)),rad*(mrandom(-10000,10000)),rad*(mrandom(-10000,10000))),1.5/3)
					end	
				end
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.1*cos(sine60/12)),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-5,5)),rad*(mrandom(-5,5)),rad*(mrandom(-5,5))),0.35/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(160),0,rad*(15-5*sin(sine60/25)))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(0,rad*(20),rad*(-20))*LSC0,0.5/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.05*cos(sine60/12),0)*angles(0,rad*(80),0)*angles(rad*(-3),0,0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.05*cos(sine60/12),0)*angles(0,rad*(-80),0)*angles(rad*(-3),0,0),1/3)
				for i=1,resumes do
					if mrandom(20)==1 then
						RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5+0.05*sin(sine60/12),0)*angles(rad*(mrandom(-90,90)),rad*(mrandom(-30,30)),rad*(mrandom(-50,50)))*RSC0,1/3)
						LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5+0.05*sin(sine60/12),0)*angles(rad*(mrandom(-10000,10000)),rad*(mrandom(-900,900)),rad*(mrandom(-20,20)))*LSC0,1/3)
					end
					if mrandom(2)==1 then
						RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(mrandom(-99999999,99999999)),rad*(mrandom(-99999999,99999999)),rad*(mrandom(-99999999,99999999)))*RSC0,0.15/3)
						LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(mrandom(-99999999,99999999)),rad*(mrandom(-99999999,99999999)),rad*(mrandom(-99999999,99999999)))*LSC0,0.15/3)
					end	
				end
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 28 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName("Anime Banisher")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.1)*angles(rad*(5),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-15,25)-2.5*sin(sine60/12)),rad*(mrandom(-15,25)),rad*(mrandom(-15,25))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.55,0.5,0.5)*angles(rad*(250),rad*(20),rad*(-80))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-35*cos(sine60/WalkSpeed)),0,rad*(-5))*LSC0,0.35/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2+0.2*cos(sine60/WalkSpeed))*angles(0,rad*(90),0)*angles(0,0,rad*(-15)),2/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2-0.2*cos(sine60/WalkSpeed))*angles(0,rad*(-90),0)*angles(0,0,rad*(15)),2/3)
			end
			idle=function()
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.25,-0.5)*angles(0,rad*(90),0)*angles(rad*(-2.5),0,rad*(-10)),0.1)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(0,rad*(-90),0)*angles(rad*(-2.5),0,rad*(10)),0.1)
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,1.5+0.1*cos(sine60/28))*angles(rad*(-1*cos(sine60/34)),0,0),0.1)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(15),0,0),0.1)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1,0.5,-0.25)*angles(0,rad*(-10),rad*(-90))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(10),0,rad*(-20-2.5*cos(sine60/28))),0.1)
			end
			CurrentColor=c3(0.580392,0,0)
			updateColor=emptyfunction
		elseif Mode == 29 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName("AirPlane")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.1)*angles(rad*(5),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(2)-2.5*sin(sine60/12)),rad*(mrandom(2)),rad*(mrandom(2))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5+.2*sin(sine60/12),-0.25)*angles(rad*(165-15*cos(sine60/12)),rad*(-10+5*sin(sine60/12)),rad*(10))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,-0.2*cos(sine60/12))*angles(rad*(20+45*cos(sine60/12)),rad*(-10*cos(sine60/12)),rad*(2.5*cos(sine60/12)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2+0.2*cos(sine60/WalkSpeed))*angles(0,rad*(90),0)*angles(0,0,rad*(-15)),2/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2-0.2*cos(sine60/WalkSpeed))*angles(0,rad*(-90),0)*angles(0,0,rad*(15)),2/3)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,.15*sin(sine60/32)),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(40),rad*(-10),0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(160),0,rad*(15-5*sin(sine60/25)))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(0,0,rad*(-10-5*sin(sine60/24)))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*sin(sine60/32),0)*angles(0,rad*(90),0)*angles(rad*(-8+2.5*sin(sine60/32)),0,0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*sin(sine60/32),0)*angles(0,rad*(-90),0)*angles(rad*(-8+2.5*sin(sine60/32)),0,0),0.15/3)
				for i=1,resumes do
					if mrandom(72)==1 then	
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-100000,100000)),rad*(mrandom(-99999,99999)),rad*(mrandom(-200,48375935))),1/3) 
					end
				end
			end
			CurrentColor=c3(0.580392,0,0)
			updateColor=emptyfunction
		elseif Mode == 30 then
			HipHeight = 0
			WalkSpeed = 200
			ChangeName("Death")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,4+1*sin(sine60/26))*angles(rad*(25-2.5*sin(sine60/48/2)),0,rad*(3*cos(sine60/47))),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(15-2.5*sin(sine60/12)),rad*(2.5*cos(sine60/12)),0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-20-13*sin(sine60/12)),0,rad*(12-4.10*sin(sine60/12)))*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-20-13*sin(sine60/12)),0,rad*(-12+4.10*sin(sine60/12)))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5-0.02*sin(sine60/12),-0.5)*angles(rad*(-10-2.5*sin(sine60/21)),rad*(90),0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.02*sin(sine60/12),-0.01)*angles(rad*(-20-2.5*sin(sine60/16)),rad*(-90),0),0.15/3)	
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,4+1*sin(sine60/26))*angles(rad*(-5-2.5*sin(sine60/48/2)),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(15-2.5*sin(sine60/12)),rad*(2.5*cos(sine60/12)),0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-20-13*sin(sine60/12)),0,rad*(12-4.10*sin(sine60/12)))*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-20-13*sin(sine60/12)),0,rad*(-12+4.10*sin(sine60/12)))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5-0.02*sin(sine60/12),-0.5)*angles(rad*(-10-2.5*sin(sine60/21)),rad*(90),0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.02*sin(sine60/12),-0.01)*angles(rad*(-20-2.5*sin(sine60/16)),rad*(-90),0),0.15/3)	
			end
			CurrentColor=rgb(98,37,209)
			updateColor=emptyfunction
		elseif Mode == 31 then
			HipHeight = 0
			WalkSpeed = 110
			ChangeName("Big Ban")
			walk=function()
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.1*cos(sine60/20),0)*angles(0,rad*(90),0)*angles(rad*(-3),rad*(-5.5),rad*(-62*cos(sine60/6))),0.1)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.1*cos(sine60/20),0)*angles(0,rad*(-90),0)*angles(rad*(-3),rad*(5.5),rad*(-62*cos(sine60/6))),0.1)
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0.01+0.03*cos(sine60/6),0.1*cos(sine60/6))*angles(rad*(-31-2*cos(sine60/20)),0,0),0.1)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-12-3*cos(sine60/40)),0,rad*(-3*cos(sine60/67))),0.1)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(105+2*cos(sine60/20)),0,rad*(12))*RSC0,0.5/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-80*cos(sine60/6)),0,rad*(-12))*RSC0,0.5/3)
			end
			idle=function()
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.1*cos(sine60/20),0)*angles(0,rad*(90),0)*angles(rad*(-3),rad*(-5.5),rad*(-1-2*cos(sine60/20))),0.1)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.1*cos(sine60/20),0)*angles(0,rad*(-90),0)*angles(rad*(-3),rad*(5.5),rad*(-1+2*cos(sine60/20))),0.1)
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0.01+0.03*cos(sine60/20),0.1*cos(sine60/20))*angles(rad*(1-2*cos(sine60/20)),0,rad*(-12)),0.1)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(3-3*cos(sine60/40)),0,rad*(12+3*cos(sine60/67))),0.1)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(60+4*cos(sine60/20)),0,rad*(15))*RSC0,0.5/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(0,0,rad*(7))*RSC0,0.5/3)
			end
			updateColor=function()
				CurrentColor=hsv(fmod(sine/3,1),1,1)
			end
		elseif Mode == 32 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName("Rainbow Hell")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.05)*angles(rad*(15),0,rad*(-7*cos(sine60/(WalkSpeed)))),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(5-8*sin(sine60/(WalkSpeed/2))),0,0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.55,0)*angles(rad*(180-5*cos(sine60/15)),rad*(-5),rad*(-5))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-15),rad*(5),rad*(-5))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.9-0.2*cos(sine60/12),0.5*sin(sine60/12))*angles(rad*(-10-40*sin(sine60/12)),rad*(90+5*cos(sine60/12)),rad*(2.5*cos(sine60/12))),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.9+.2*cos(sine60/12),-0.5*sin(sine60/12))*angles(rad*(-10+40*sin(sine60/12)),rad*(-90+5*cos(sine60/12)),rad*(2.5*cos(sine60/12))),0.25)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(-0.05*cos(sine60/20)+0.05*sin(sine60/20),0,0),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(5+mrandom(-6,6)),rad*(mrandom(-6,6)),rad*(-10*cos(sine60/20)+mrandom(-6,6))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.55,0)*angles(rad*(180-5*cos(sine60/15)),rad*(-5),rad*(-5))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.45,0.5,0)*angles(rad*(5+mrandom(-6,6)),rad*(mrandom(-6,6)),rad*(-15+mrandom(-6,6)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1-0.05*cos(sine60/20)+0.05*sin(sine60/20),-1,-0.01)*angles(0,rad*(80),0)*angles(rad*(-6),0,0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1-0.05*cos(sine60/20)+0.05*sin(sine60/20),-1,-0.03)*angles(0,rad*(-80),0)*angles(rad*(-6),0,0),1/3)
			end
			updateColor=function()
				CurrentColor=hsv(fmod(sine/3,1),1,1)
			end
		elseif Mode == 33 then
			HipHeight = 3
			WalkSpeed = 50
			ChangeName("SOLID LC")
			walk=function()
				if NeckSnap then
					Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20),rad*(10*sin(sine60/100)),0),1)
					NeckSnap=false
				else
					Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20),rad*(10*sin(sine60/100)),0),0.25)
				end
				for i=1,resumes do
					if mrandom(60)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20+mrandom(-20,20)),rad*((10*sin(sine60/100))+mrandom(-20,20)),rad*(mrandom(-20,20))),1)
						NeckSnap=true
					end
				end
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0.5*cos(sine60/50),0,-0.5*sin(sine60/50))*angles(rad*(40),0,0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*cf(0,-0.25,0)*angles(rad*(-40),0,0),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.55,0.5,0.5)*angles(rad*(250),rad*(20),rad*(-80))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-45),0,rad*(-5-2*cos(sine60/19)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5,-0.5)*angles(rad*(-20+9*cos(sine60/74)),rad*(80),0)*angles(rad*(5*cos(sine60/37)),0,0),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(rad*(-20-9*cos(sine60/54)),rad*(-80),0)*angles(rad*(-5*cos(sine60/41)),0,0),0.25)
			end
			idle=function()
				if NeckSnap then
					Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20),rad*(10*sin(sine60/100)),0),1)
					NeckSnap=false
				else
					Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20),rad*(10*sin(sine60/100)),0),0.25)
				end
				for i=1,resumes do
					if mrandom(60)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(20+mrandom(-20,20)),rad*((10*sin(sine60/100))+mrandom(-20,20)),rad*(mrandom(-20,20))),1)
						NeckSnap=true
					end
				end
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(.5*cos(sine60/50),0,-0.5*sin(sine60/50))*angles(rad*(-25+5*sin(sine60/50)),0,0),0.7/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(30+5*sin(sine60/50)),0,0),0.7/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.55,0.5,0.5)*angles(rad*(250),rad*(20),rad*(-80))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-20+8.5*cos(sine60/50)),0,rad*(-25-5*cos(sine60/25)))*LSC0,0.7/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5,-0.5)*angles(rad*(-5+9*cos(sine60/74)),rad*(80),0)*angles(rad*(5*cos(sine60/37)),0,0),0.7/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(rad*(13-9*cos(sine60/54)),rad*(-80),0)*angles(rad*(-5*cos(sine60/41)),0,0),0.7/3)
			end
			updateColor=function()
				CurrentColor=hsv(fmod(sine/3,1),1,1)
			end
		elseif Mode == 34 then
			HipHeight = 3
			WalkSpeed = 50
			ChangeName("Immortality Vibe")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,3+.5*cos(sine60/9))*angles(rad*(-2.5*sin(sine60/9)),0,0),1/2)
				Neck.C0=Lerp1(Neck.C0,NECKC0*cf()*angles(rad*(10-10*sin(sine60/9)),0,0),1/2)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5+.25*sin(sine60/9),0)*angles(0,0,rad*(10+10*cos(sine60/9)))*RSC0,0.7/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5+.25*sin(sine60/9),0)*angles(0,0,rad*(-10+10*cos(sine60/9)))*LSC0,0.7/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(-10),rad*(80),rad*(5+5*sin(sine60/9))),1/2)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,-0.01)*angles(0,rad*(-80),rad*(-5-5*sin(sine60/9))),1/2)
			end
			idle=walk
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 35 then
			HipHeight = 0
			WalkSpeed = 18
			ChangeName("Respected")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.1)*angles(rad*(5),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(2)-2.5*sin(sine60/12)),rad*(mrandom(2)),rad*(mrandom(2))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5+.2*sin(sine60/12),-0.25)*angles(rad*(165-15*cos(sine60/12)),rad*(-10+5*sin(sine60/12)),rad*(10))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,-0.2*cos(sine60/12))*angles(rad*(20+45*cos(sine60/12)),rad*(-10*cos(sine60/12)),rad*(2.5*cos(sine60/12)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2+0.2*cos(sine60/WalkSpeed))*angles(0,rad*(90),0)*angles(0,0,rad*(-15)),2/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2-0.2*cos(sine60/WalkSpeed))*angles(0,rad*(-90),0)*angles(0,0,rad*(15)),2/3)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,.15*sin(sine60/32)),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(40),rad*(-10),0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(160),0,rad*(15-5*sin(sine60/25)))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(0,0,rad*(-10-5*sin(sine60/24)))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*sin(sine60/32),0)*angles(0,rad*(90),0)*angles(rad*(-8+2.5*sin(sine60/32)),0,0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*sin(sine60/32),0)*angles(0,rad*(-90),0)*angles(rad*(-8+2.5*sin(sine60/32)),0,0),0.15/3)
				for i=1,resumes do
					if mrandom(72)==1 then	
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-100000,100000)),rad*(mrandom(-99999,99999)),rad*(mrandom(-200,48375935))),1/3) 
					end
				end
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 36 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName("MAYHEM")
			walk=function()
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.85,-0.15-0.15*cos(sine60/4))*angles(0,rad*(90),0)*angles(0,rad*(5*cos(sine60/8)),rad*(25*cos(sine60/8))),0.1)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.85,-0.15+0.15*cos(sine60/4))*angles(0,rad*(-90),0)*angles(0,rad*(5*cos(sine60/8)),rad*(25*cos(sine60/8))),0.1)
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.15-0.1*cos(sine60/4))*angles(rad*(5),0,rad*(-5*cos(sine60/8))),0.1)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(25-5*cos(sine60/0.325)),rad*(-5*cos(sine60/0.25)),rad*(5*cos(sine60/8))),0.1)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-70-5*cos(sine60/12)),rad*(-2.5*cos(sine60/12)),rad*(5+2.5*cos(sine60/12)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(160),0,rad*(25)),0.1)
			end
			idle=function()
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.1*cos(sine60/32),0)*angles(0,rad*(90),0)*angles(rad*(-10-2.5*cos(sine60/32)),rad*(-20),0),0.1)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.1*cos(sine60/32),0)*angles(0,rad*(-90),0)*angles(0,0,rad*(-10+2.5*cos(sine60/32))),0.1)
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.1*cos(sine60/32))*angles(rad*(10-2*cos(sine60/32)),0,rad*(20)),0.1)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(25-2.5*cos(sine60/32)),rad*(-5*cos(sine60/0.25)),rad*(-20-5*cos(sine60/0.465))),0.1)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.55,0.5,0.5)*angles(rad*(250),rad*(20),rad*(-80))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(160),0,rad*(25)),0.1)
			end
			CurrentColor=c3(1,0,0)
			updateColor=emptyfunction
		elseif Mode == 37 then
			HipHeight = 3
			WalkSpeed = 50
			ChangeName("SOLID LC")
			walk=function()
				for i=1,resumes do
					if mrandom(3)==1 then
						--WEffect({TIME=mrandom(15,25)*2,EffectType="Sphere",Size=v3(3+2*cos(sine60/4),3+2*cos(sine60/4),3+2*cos(sine60/4)),Size2=v3_0,Transparency=0,Transparency2=-11,CFrame=cf(Character.HumanoidRootPart.CFrame.Position-v3(mrandom(-20,20),2,mrandom(-20,20))),MoveToPos=Character.Torso.Position+v3(0,mrandom(45,145)/1.5,0),RotationX=0,RotationY=0,RotationZ=0,Material="Neon",Color=Color3.fromRGB(0,mrandom(0,255),0),SoundID=nil,SoundPitch=nil,SoundVolume=nil})
					end
				end
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,.5*cos(sine60/15))*angles(rad*(40),rad*(-5*cos(sine60/30)),0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*cf(0,-0.25,0)*angles(rad*(-40),0,0),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-45),0,rad*(5+2*cos(sine60/19)))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-45),0,rad*(-5-2*cos(sine60/19)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5,-0.5)*angles(rad*(-20+9*cos(sine60/74)),rad*(80),0)*angles(rad*(5*cos(sine60/37)),0,0),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0)*angles(rad*(-20-9*cos(sine60/54)),rad*(-80),0)*angles(rad*(-5*cos(sine60/41)),0,0),0.25)
			end
			idle=function()
				for i=1,resumes do
					if mrandom(3)==1 then
						--WEffect({TIME=mrandom(15,25)*2,EffectType="Sphere",Size=v3(3+2*cos(sine60/4),3+2*cos(sine60/4),3+2*cos(sine60/4)),Size2=v3_0,Transparency=0,Transparency2=-11,CFrame=cf(Character.HumanoidRootPart.CFrame.Position-v3(mrandom(-20,20),2,mrandom(-20,20))),MoveToPos=Character.Torso.Position+v3(0,mrandom(45,145)/1.5,0),RotationX=0,RotationY=0,RotationZ=0,Material="Neon",Color=Color3.fromRGB(0,mrandom(0,255),0),SoundID=nil,SoundPitch=nil,SoundVolume=nil})
					end
				end
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,0.5*cos(sine60/15))*angles(0,rad*(-10*cos(sine60/30)),0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(0,rad*(-15*cos(sine60/30)),0),0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(135-15*cos(sine60/30)),0,rad*(25+15*cos(sine60/30)))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(5),rad*(5),rad*(-10+15*cos(sine60/30)))*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(-10),rad*(80),rad*(10+10*sin(sine60/15))),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,-0.01)*angles(0,rad*(-80),rad*(-10-10*sin(sine60/15))),0.25)
			end
			updateColor=function()
				CurrentColor=hsv(fmod(sine/3,1),1,1)
			end
		elseif Mode == 38 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName("FEVER")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.1)*angles(rad*(5),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(5-8*sin(sine60/0.96)),0,0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.1,-0.4)*angles(rad*(150),0,0)*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-60*cos(sine60/1.92)),0,rad*(-5))*LSC0,0.35/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2+0.2*cos(sine60/WalkSpeed))*angles(0,rad*(90),0)*angles(0,0,rad*(-15)),2/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2-0.2*cos(sine60/WalkSpeed))*angles(0,rad*(-90),0)*angles(0,0,rad*(15)),2/3)
			end
			idle=function()
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(15-2.5*sin(sine60/12)),0,0),3/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.4,0.35,0.4)*angles(rad*(135),0,rad*(3))*angles(rad*(-1.5*cos(sine60/15)+2.5*sin(sine60/12)),0,0)*RSC0,0.15/3)
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(-0.05*cos(sine60/15)+0.05*sin(sine60/15),0,0.05*cos(sine60/20)),0.8/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.4,0.35,0.4)*angles(rad*(15),0,rad*(12))*angles(rad*(-1.5*cos(sine60/15)+2.5*sin(sine60/12)),0,0)*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1-0.05*cos(sine60/15)+0.05*sin(sine60/15),-1-0.05*cos(sine60/20),-0.01)*angles(0,rad*(83),0),0.8/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1-0.05*cos(sine60/15)+0.05*sin(sine60/15),-1-0.05*cos(sine60/20),-0.01)*angles(0,rad*(-83),0),0.8/3)
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		elseif Mode == 9001.1 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName(" ")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.1)*angles(rad*(5),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(2)-2.5*sin(sine60/12)),rad*(mrandom(2)),rad*(mrandom(2))),1/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5+.2*sin(sine60/12),-0.25)*angles(rad*(165-15*cos(sine60/12)),rad*(-10+5*sin(sine60/12)),rad*(10))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,-0.2*cos(sine60/12))*angles(rad*(20+45*cos(sine60/12)),rad*(-10*cos(sine60/12)),rad*(2.5*cos(sine60/12)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2+0.2*cos(sine60/WalkSpeed))*angles(0,rad*(90),0)*angles(0,0,rad*(-15)),2/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*cos(sine60/WalkSpeed*2),-0.2-0.2*cos(sine60/WalkSpeed))*angles(0,rad*(-90),0)*angles(0,0,rad*(15)),2/3)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,.15*sin(sine60/32)),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(40),rad*(-10),0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(160),0,rad*(15-5*sin(sine60/25)))*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(0,0,rad*(-10-5*sin(sine60/24)))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*sin(sine60/32),0)*angles(0,rad*(90),0)*angles(rad*(-8+2.5*sin(sine60/32)),0,0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*sin(sine60/32),0)*angles(0,rad*(-90),0)*angles(rad*(-8+2.5*sin(sine60/32)),0,0),0.15/3)
				for i=1,resumes do
					if mrandom(72)==1 then	
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-100000,100000)),rad*(mrandom(-99999,99999)),rad*(mrandom(-200,48375935))),1/3) 
					end
				end
			end
			CurrentColor=hsv(0.11748632788658,0.28372022509575,0)
			updateColor=emptyfunction
		elseif Mode == 9001.2 then
			HipHeight = 0
			WalkSpeed = 999
			ChangeName("500 Miles")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.175+0.025*cos(sine60/3.5)+sin(sine60/3.5)/-7)*angles(rad*(9-2.5*cos(sine60/3.5)),0,rad*(10*cos(sine60/7))),0.15)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-15,15)),rad*(mrandom(-15,15)),rad*(mrandom(-15,15))),0.35/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.925-0.5*cos(sine60/7)/2,0.5*cos(sine60/7)/2)*angles(rad*(-15-35*cos(sine60/7))+sin(sine60/7)/-2.5,rad*(90-2*cos(sine60/7)),0)*angles(rad*(2.5*cos(sine60/7)),0,0),0.3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.925+0.5*cos(sine60/7)/2,-0.5*cos(sine60/7)/2)*angles(rad*(-15+35*cos(sine60/7))+sin(sine60/7)/2.5,rad*(-90-2*cos(sine60/7)),0)*angles(rad*(-2.5*cos(sine60/7)),0,0),0.3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-60-5*cos(sine60/12)),rad*(-2.5*cos(sine60/12)),rad*(5+2.5*cos(sine60/12)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1,0.5+0.05*sin(sine60/30),0.025*cos(sine60/20))*angles(rad*(-70)*cos(sine60/7),rad*(-90),	rad*(-5)),0.1)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.2)*angles(rad*(sine60*-6),0,0),0.25)
				Neck.C0=Lerp1(Neck.C0,NECKC0,0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-75*sin(sine60/5)),0,0)*RSC0,0.25)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(75*sin(sine60/5)),0,0)*LSC0,0.25)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(75*sin(sine60/5)),rad*(90),0),0.25)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,-0.01)*angles(rad*(-75*sin(sine60/5)),rad*(-90),0),0.25)
			end
			updateColor=function()
				CurrentColor=hsv(fmod(sine/3,1),1,1)
			end
		elseif Mode == 9001.9742 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName("Nostalgia")
			if mrandom(10)==1 then
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(500)),rad*(mrandom(500)),rad*(mrandom(500))),1)
			end
			walk=function()
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(40-4.2*sin(sine60/16)),0,0),0.8/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-30*sin(sine60/16)),0,rad*(12))*RSC0,0.8/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(30*sin(sine60/16)),0,rad*(-12))*LSC0,0.8/3)
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.1+0.1*sin(sine60/16)),0.8/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.07*sin(sine60/16))*angles(0,rad*(90),0)*angles(0,0,rad*(-5+30*sin(sine60/16))),0.8/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,0.07*sin(sine60/16))*angles(0,rad*(-90),0)*angles(0,0,rad*(5+30*sin(sine60/16))),0.8/3)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,.15*sin(sine60/32)),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(40),rad*(-10),0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(0,0,rad*(10+5*sin(sine60/24)))*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(0,0,rad*(-10-5*sin(sine60/24)))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.15*sin(sine60/32),0)*angles(0,rad*(90),0)*angles(rad*(-8+2.5*sin(sine60/32)),0,0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.15*sin(sine60/32),0)*angles(0,rad*(-90),0)*angles(rad*(-8+2.5*sin(sine60/32)),0,0),0.15/3)	
			end
			CurrentColor=rgb(100,0,0) 
			updateColor=emptyfunction
		elseif Mode == 77543 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName("The True Cannon")
			walk=function()
				for i=1,resumes do
					--WEffect({Time=90,EffectType="Sphere",Size=v3(0.1,0.1,0.1),Size2=v3(0.1,0.1,0.1),Transparency=0,Transparency2=1,CFrame=Character.HumanoidRootPart.CFrame*cf(mrandom(-15,15),mrandom(-2.5,13.1),mrandom(-15,15)),MoveToPos=nil,RotationX=0,RotationY=0,RotationZ=0,Material="Neon",Color=Color3.fromRGB(255,255,255),SoundID=nil,SoundPitch=nil,SoundVolume=nil})
					--WEffect({Time=90,EffectType="Sphere",Size=v3(0.1,0.1,0.1),Size2=v3(0.1,0.1,0.1),Transparency=0,Transparency2=1,CFrame=Character.HumanoidRootPart.CFrame*cf(mrandom(-15,15),mrandom(-2.5,13.1),mrandom(-15,15)),MoveToPos=nil,RotationX=0,RotationY=0,RotationZ=0,Material="Neon",Color=Color3.fromRGB(255,255,255),SoundID=nil,SoundPitch=nil,SoundVolume=nil})
				end
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(.25*cos(sine60/63)+.92*sin(sine60/95),0,1+1*sin(sine60/53))*angles(rad*(70),0,rad*(3*cos(sine60/47))),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(15-2.5*sin(sine60/12)),0,0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(0,0,rad*(12-4.10*sin(sine60/12)))*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(0,0,rad*(-12+4.10*sin(sine60/12)))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.5-0.02*sin(sine60/12),-0.5)*angles(rad*(-10-2.5*sin(sine60/21)),rad*(90),0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.02*sin(sine60/12),-0.01)*angles(rad*(-20-2.5*sin(sine60/51)),rad*(-90),0),0.15/3)	
			end
			idle=function()
				for i=1,resumes do
					--WEffect({Time=90,EffectType="Sphere",Size=v3(0.1,0.1,0.1),Size2=v3(0.1,0.1,0.1),Transparency=0,Transparency2=1,CFrame=Character.HumanoidRootPart.CFrame*cf(mrandom(-15,15),mrandom(-2.5,13.1),mrandom(-15,15)),MoveToPos=nil,RotationX=0,RotationY=0,RotationZ=0,Material="Neon",Color=Color3.fromRGB(255,255,255),SoundID=nil,SoundPitch=nil,SoundVolume=nil})
					--WEffect({Time=90,EffectType="Sphere",Size=v3(0.1,0.1,0.1),Size2=v3(0.1,0.1,0.1),Transparency=0,Transparency2=1,CFrame=Character.HumanoidRootPart.CFrame*cf(mrandom(-15,15),mrandom(-2.5,13.1),mrandom(-15,15)),MoveToPos=nil,RotationX=0,RotationY=0,RotationZ=0,Material="Neon",Color=Color3.fromRGB(255,255,255),SoundID=nil,SoundPitch=nil,SoundVolume=nil})
				end
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,2+.5*cos(sine60/32))*angles(rad*(-25+2*cos(sine60/42)),0,0),1/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-2.5+1*cos(sine60/12)),rad*(mrandom(-5,5)),0),1/3) 
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5,0)*angles(rad*(-30),0,rad*(15-5.5*cos(sine60/20)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5,0)*angles(rad*(-30),0,rad*(-15+5.5*cos(sine60/20)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.2)*angles(rad*(-30+2*cos(sine60/32)),rad*(80),0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1,-0.2)*angles(rad*(-30+2*cos(sine60/46)),rad*(-80),0),1/3)
			end
			CurrentColor=c3(1,1,1)
			updateColor=emptyfunction
		elseif Mode == 9001.3 then
			HipHeight = 0
			WalkSpeed = 25
			ChangeName(" ")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.175+0.025*cos(sine60/3.5)-sin(sine60/3.5)/7)*angles(rad*(3-2.5*cos(sine60/3.5)),0,rad*(8*cos(sine60/7))),0.15)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-1),0,0),0.15)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.8-0.5*cos(sine60/7)/2,0.6*cos(sine60/7)/2)*angles(rad*(-15-15*cos(sine60/7))-sin(sine60/7)/2.5,rad*(90-10*cos(sine60/7)),0)*angles(rad*(2*cos(sine60/7)),0,0),0.3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.8+0.5*cos(sine60/7)/2,-0.6*cos(sine60/7)/2)*angles(rad*(-15+15*cos(sine60/7))+sin(sine60/7)/2.5,rad*(-90-10*cos(sine60/7)),0)*angles(rad*(-2*cos(sine60/7)),0,0),0.3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.25,0.35+0.15*cos(sine60/12),0)*angles(rad*(110),rad*(-15-2.5*sin(sine60/12)),rad*(35+7.5*sin(sine60/12)))*RSC0,1/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.5+0.05*sin(sine60/7),0)*angles(rad*(-56)*cos(sine60/7),rad*(10*cos(sine60/7)),	rad*(-6)),0.1)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,-0.1+0.1*cos(sine60/12))*angles(0,0,rad*(20)),0.1)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(-6.5*sin(sine60/12)),0,rad*(-20)),0.1)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-0.9-0.1*cos(sine60/12),0)*angles(0,rad*(75),0)*angles(rad*(-12.5),0,0),0.1)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.9-0.1*cos(sine60/12),-0.2)*angles(0,rad*(-65),0)*angles(rad*(-6.5),0,rad*(6)),0.1)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,1+0.05*sin(sine60/12),0)*angles(rad*(110),rad*(6+6.5*sin(sine60/12)),rad*(25)),0.1)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.3,1+0.05*sin(sine60/12),-0.5)*angles(rad*(110),rad*(6-6.5*sin(sine60/12)),rad*(25)),0.1)
			end
			CurrentColor=c3(1,1,0)
			updateColor=emptyfunction
		elseif Mode == 90 then
			HipHeight = 0
			WalkSpeed = 16
			ChangeName("sTrEeSeD")
			walk=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,0,2-0.1*cos(sine60/15))*angles(rad*(30),0,0),0.5/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0,0.25)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.45-0.05*cos(sine60/12),0)*angles(rad*(-30),0,rad*(15-7.5*cos(sine60/12)))*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-1.5,0.45-0.05*cos(sine60/12),0.3)*angles(rad*(-30),0,rad*(-15+7.5*cos(sine60/12)))*LSC0,1/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1,-0.01)*angles(rad*(-15-2.5*cos(sine60/12)),rad*(80),0)*angles(rad*(-8-2.5*sin(sine60/12)),0,0),1/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-0.5,-0.5)*angles(rad*(-25-2.5*cos(sine60/12)),rad*(-80),0)*angles(rad*(-8-2.5*sin(sine60/12)),0,0),1/3)
			end
			idle=function()
				RootJoint.C0=Lerp1(RootJoint.C0,ROOTC0*cf(0,-0.1,-0.1+0.05*cos(sine60/12))*angles(rad*(15),0,0),0.15/3)
				RightShoulder.C0=Lerp1(RightShoulder.C0,cf(1.5,0.5+0.025*cos(sine60/12),0)*angles(0,rad*(-7.5*sin(sine60/12)),rad*(12+7.5*sin(sine60/12)))*RSC0,0.15/3)
				LeftShoulder.C0=Lerp1(LeftShoulder.C0,cf(-0.7,0.5,-0.3)*angles(rad*(-200),0,rad*(30))*LSC0,0.15/3)
				RightHip.C0=Lerp1(RightHip.C0,cf(1,-1-0.05*cos(sine60/12),-0.01)*angles(rad*(20),rad*(90),0)*angles(rad*(-8),0,0),0.15/3)
				LeftHip.C0=Lerp1(LeftHip.C0,cf(-1,-1-0.05*cos(sine60/12),-0.01)*angles(rad*(5),rad*(-90),0)*angles(rad*(-8),0,0),0.15/3)
				Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(25+mrandom(-5,5)-4*cos(sine60/12)),rad*(mrandom(-5,5)),rad*(15)),1/3)
				for i=1,resumes do
					if mrandom(10)==1 then
						Neck.C0=Lerp1(Neck.C0,NECKC0*angles(rad*(mrandom(-25,25)-4*cos(sine60/12)),rad*(mrandom(-25,25)),0),1.5/3)
					end
				end
			end
			CurrentColor=c3_0
			updateColor=emptyfunction
		end
		updateColor()
		updateGuiColor()
		setWalkSpeed(WalkSpeed)
		setHipHeight(HipHeight)
	end
	local modescount=38
	bindKey("e",function()
		Mode=Mode+1
		if Mode>modescount then
			Mode=0
		end
		modechanged()
	end)
	bindKey("q",function()
		Mode=Mode-1
		if Mode<0 then
			Mode=modescount
		end
		modechanged()
	end)
	modechanged()
end)
swtc("lcv4 fd effects",{
	{value=false,text="disabled"},
	{value=true,text="enabled"},
},function(v)
	lcv4effects=v
end)
lbl("(needs specific accessories)")

btn("goofy trolus (goofy)", function()
	local t=reanimate()
	if type(t)~="table" then return end
	local velbycfrvec=t.velbycfrvec
	local raycastlegs=t.raycastlegs
	local getJoint=t.getJoint
	local RootJoint=getJoint("RootJoint")
	local RightShoulder=getJoint("Right Shoulder")
	local LeftShoulder=getJoint("Left Shoulder")
	local RightHip=getJoint("Right Hip")
	local LeftHip=getJoint("Left Hip")
	local Neck=getJoint("Neck")
	t.addmode("default", {
		idle = function()
			local rY, lY = raycastlegs()

			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(0.6981317007977318 * sin((sine + 0.5) * 4), 1.5707963267948966 - 0.3490658503988659 * sin(sine * 4), 0)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(0.6981317007977318 * sin((sine + 0.5) * 4), -1.5707963267948966 + 0.3490658503988659 * sin(sine * 4), 0)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 + rY, 0),angles(1.5707963267948966 - 1.0471975511965976 * sin(sine * 4), 1.6580627893946132, -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, -0.2 + 0.2 * sin((sine + 1) * 8), 0),angles(-1.5707963267948966 + 0.6981317007977318 * sin(sine * 4), 0, 3.141592653589793)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 + lY, 0),angles(1.5707963267948966 - 1.0471975511965976 * sin(sine * 4), -1.6580627893946132, 1.5707963267948966)),deltaTime) 
			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 - 0.8726646259971648 * sin((sine + 0.25) * 4), 0, 3.141592653589793)),deltaTime) 
			--RightArm,1,0,0,4,0,40,0.5,4,0.5,0,0,4,90,-20,0,4,0,0,0,4,0,0,0,4,LeftArm,-1,0,0,4,-0,40,0.5,4,0.5,0,0,4,-90,20,0,4,0,0,0,4,0,0,0,4,RightLeg,1,0,0,4,90,-60,0,4,-1,0,0,4,95,0,0,4,0,0,0,4,-90,0,0,4,Torso,0,0,0,4,-90,40,0,4,-0.2,0.2,1,8,-0,0,0,4,0,0,0,4,180,0,0,4,LeftLeg,-1,0,0,4,90,-60,0,4,-1,0,0,4,-95,0,0,4,0,0,0,4,90,0,0,4,Head,0,0,0,4,-90,-50,0.25,4,1,0,0,4,-0,0,0,4,0,0,0,4,180,0,0,4,CPlusPlusTextbook_Handle,8.658389560878277e-09,0,0,4,0,0,0,4,-0.25,0,0,4,0,0,0,4,-0.0002722442150115967,0,0,4,0,0,0,4
		end,
		walk = function()
			local fw, rt = velbycfrvec()

			Neck.C0 = Lerp(Neck.C0,cfMul(cf(0, 1, 0),angles(-1.5707963267948966 + 0.5235987755982988 * sin((sine + 0.45) * 8), 0, 3.141592653589793)),deltaTime) 
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cf(1, 0.5, 0),angles(2.0943951023931953 - 1.7453292519943295 * sin((sine - 0.1) * 4), 1.9198621771937625, -1.5707963267948966)),deltaTime) 
			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(cf(0, 0.25 + 0.5 * sin((sine - 0.125) * 8), 0),angles(-1.5707963267948966 + 0.17453292519943295 * sin(sine * 8), 0, 3.141592653589793)),deltaTime) 
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 - 1 * sin(sine * 4), 0),angles(1.5707963267948966 - 1.2217304763960306 * sin((sine - 0.15) * 4) * fw, -1.5707963267948966 - 0.6108652381980153 * sin((sine - 0.15) * 4) * rt, 1.5707963267948966)),deltaTime) 
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 + 1 * sin(sine * 4), 0),angles(1.5707963267948966 + 1.2217304763960306 * sin((sine - 0.15) * 4) * fw, 1.5707963267948966 + 0.6108652381980153 * sin((sine - 0.15) * 4) * rt, -1.5707963267948966)),deltaTime) 
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cf(-1, 0.5, 0),angles(2.0943951023931953 + 1.7453292519943295 * sin((sine - 0.1) * 4), -1.7453292519943295, 1.5707963267948966)),deltaTime) 
			--Head,0,0,0,4,-90,30,0.45,8,1,0,0,4,-0,0,0,4,0,0,0,4,180,0,0,4,CPlusPlusTextbook_Handle,8.658389560878277e-09,0,0,4,0,0,0,4,-0.25,0,0,4,0,0,0,4,-0.0002722442150115967,0,0,4,0,0,0,4,RightArm,1,0,0,4,120,-100,-0.1,4,0.5,0,0,4,110,0,0,4,0,0,0,4,-90,0,0,4,Torso,0,0,0,4,-90,10,0,8,0.25,0.5,-0.125,8,-0,0,0,4,0,0,0,4,180,0,0,4,LeftLeg,-1,0,0,4,90,-70,-0.15,4,-1,-1,0,4,-90,-35,-0.15,4,0,0,0,4,90,0,0,4,RightLeg,1,0,0,4,90,70,-0.15,4,-1,1,0,4,90,35,-0.15,4,0,0,0,4,-90,0,0,4,LeftArm,-1,0,0,4,120,100,-0.1,4,0.5,0,0,4,-100,0,0,4,0,0,0,4,90,0,0,4
		end
	})
end)

btn("good cop bad cop animations", function()
	local t=reanimate()
	if type(t)~="table" then return end
	local addmode=t.addmode
	local getJoint=t.getJoint
	local RootJoint=getJoint("RootJoint")
	local RightShoulder=getJoint("Right Shoulder")
	local LeftShoulder=getJoint("Left Shoulder")
	local RightHip=getJoint("Right Hip")
	local LeftHip=getJoint("Left Hip")
	local Neck=getJoint("Neck")
	local setWalkSpeed=t.setWalkSpeed
	local setJumpPower=t.setJumpPower
	setWalkSpeed(20)
	setJumpPower(50)

	local ROOTC0=angles(-1.5707963267948966,0,3.141592653589793)
	local NECKC0=cfMul(cf(0,1,0),angles(-1.5707963267948966,0,3.141592653589793))
	local RSC0=cfMul(cf(-0.5,0,0),angles(0,1.5707963267948966,0))
	local LSC0=cfMul(cf(0.5,0,0),angles(0,-1.5707963267948966,0))
	local rad=math.rad

	--bruh yeah shackluster had a lot of math.rad(0) instead of just 0
	--and a lot of multyplying by angles(0, 0, 0)
	--and he had ArtificialHB
	--and he had a sine value increasing by 2/3 each frame
	--and a lot of variables with names saying other things
	--and he had both C0 and C1 lerps for the same animations

	local jumplerps=function()
		local Animation_Speed = 0.45 / deltaTime
		RootJoint.C1 = Lerp(RootJoint.C1,ROOTC0, 0.2 / Animation_Speed)
		Neck.C1 = Lerp(Neck.C1,cfMul(cf(0, -0.5, 0),angles(-1.5707963267948966, 0, 3.141592653589793)), 0.2 / Animation_Speed)
		RightHip.C1 = Lerp(RightHip.C1,cfMul(cf(0.5, 1, 0),angles(0, 1.5707963267948966, 0)), 0.7 / Animation_Speed)
		LeftHip.C1 = Lerp(LeftHip.C1,cfMul(cf(-0.5, 1, 0),angles(0, -1.5707963267948966, 0)), 0.7 / Animation_Speed)

		RootJoint.C0 = Lerp(RootJoint.C0,ROOTC0, 0.2 / Animation_Speed)
		Neck.C0 = Lerp(Neck.C0,cfMul(NECKC0,angles(-0.3490658503988659, 0, 0)), 0.2 / Animation_Speed)
		RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cfMul(cf(1.5, 0.5, 0),angles(-0.6981317007977318, 0, 0.3490658503988659)), RSC0), 0.2 / Animation_Speed)
		LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cfMul(cf(-1.5, 0.5, 0),angles(-0.6981317007977318, 0, -0.3490658503988659)), LSC0), 0.2 / Animation_Speed)
		RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1, -0.3),angles(0, 1.5707963267948966, 0),angles(-0.08726646259971647, 0, -0.3490658503988659)), 0.2 / Animation_Speed)
		LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1, -0.3),angles(0, -1.5707963267948966, 0),angles(-0.08726646259971647, 0, 0.3490658503988659)), 0.2 / Animation_Speed)	
	end
	local falllerps=function()
		local Animation_Speed = 0.45 / deltaTime
		RootJoint.C1 = Lerp(RootJoint.C1,ROOTC0, 0.2 / Animation_Speed)
		Neck.C1 = Lerp(Neck.C1,cfMul(cf(0, -0.5, 0),angles(-1.5707963267948966, 0, 3.141592653589793)), 0.2 / Animation_Speed)
		RightHip.C1 = Lerp(RightHip.C1,cfMul(cf(0.5, 1, 0),angles(0, 1.5707963267948966, 0)), 0.7 / Animation_Speed)
		LeftHip.C1 = Lerp(LeftHip.C1,cfMul(cf(-0.5, 1, 0),angles(0, -1.5707963267948966, 0)), 0.7 / Animation_Speed)

		RootJoint.C0 = Lerp(RootJoint.C0,ROOTC0, 0.2 / Animation_Speed)
		Neck.C0 = Lerp(Neck.C0,cfMul(NECKC0,angles(0.3490658503988659, 0, 0)), 0.2 / Animation_Speed)
		RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cfMul(cf(1.5, 0.5, 0),angles(0, 0, 1.0471975511965976)), RSC0), 0.2 / Animation_Speed)
		LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cfMul(cf(-1.5, 0.5, 0),angles(0, 0, -1.0471975511965976)), LSC0), 0.2 / Animation_Speed)
		RightHip.C0 = Lerp(RightHip.C0,cfMul(cfMul(cf(1, -1, 0),angles(0, 1.5707963267948966, 0)),angles(0, 0, 0.3490658503988659)), 0.2 / Animation_Speed)
		LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cfMul(cf(-1, -1, 0),angles(0, -1.5707963267948966, 0)),angles(0, 0, 0.17453292519943295)), 0.2 / Animation_Speed)
	end

	local idleOverwrite=nil

	addmode("default",{ --mode 1
		modeLeft=function() --enter mode 0
			setWalkSpeed(0)
			setJumpPower(0)
			idleOverwrite=function()
				local sine = sine * 40
				local Animation_Speed = 0.45 / deltaTime
				RootJoint.C1 = Lerp(RootJoint.C1,ROOTC0, 0.2 / Animation_Speed)
				Neck.C1 = Lerp(Neck.C1,cfMul(cf(0, -0.5, 0),angles(-1.5707963267948966, 0, 3.141592653589793)), 0.2 / Animation_Speed)
				RightHip.C1 = Lerp(RightHip.C1,cfMul(cf(0.5, 1, 0),angles(0, 1.5707963267948966, 0)), 0.7 / Animation_Speed)
				LeftHip.C1 = Lerp(LeftHip.C1,cfMul(cf(-0.5, 1, 0),angles(0, -1.5707963267948966, 0)), 0.7 / Animation_Speed)

				RootJoint.C0 = Lerp(RootJoint.C0,ROOTC0 * cf(0, 0, 0.05 * cos(sine / 12)), 1 / Animation_Speed)
				Neck.C0 = Lerp(Neck.C0, NECKC0, 1 / Animation_Speed)
				RightShoulder.C0 = Lerp(RightShoulder.C0, cf(1.5, 0.5, 0) * angles(0, 0, 0.4363323129985824) * RSC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Lerp(LeftShoulder.C0, cf(-1.5, 0.5, 0) * angles(0, 0, -0.4363323129985824) * LSC0, 1 / Animation_Speed)
				RightHip.C0 = Lerp(RightHip.C0, cf(1, -1 - 0.05 * cos(sine / 12), -0.01) * angles(0, 1.4486232791552935, 0), 1 / Animation_Speed)
				LeftHip.C0 = Lerp(LeftHip.C0, cf(-1, -1 - 0.05 * cos(sine / 12), -0.01) * angles(0, -1.4486232791552935, 0), 1 / Animation_Speed)
			end
			twait(0.15)
			idleOverwrite=function()
				local sine = sine * 40
				local Animation_Speed = 0.45 / deltaTime
				RootJoint.C1 = Lerp(RootJoint.C1,ROOTC0, 0.2 / Animation_Speed)
				Neck.C1 = Lerp(Neck.C1,cfMul(cf(0, -0.5, 0),angles(-1.5707963267948966, 0, 3.141592653589793)), 0.2 / Animation_Speed)
				RightHip.C1 = Lerp(RightHip.C1,cfMul(cf(0.5, 1, 0),angles(0, 1.5707963267948966, 0)), 0.7 / Animation_Speed)
				LeftHip.C1 = Lerp(LeftHip.C1,cfMul(cf(-0.5, 1, 0),angles(0, -1.5707963267948966, 0)), 0.7 / Animation_Speed)

				RootJoint.C0 = Lerp(RootJoint.C0,ROOTC0 * cf(0, 0, 0.05 * cos(sine / 12)), 1 / Animation_Speed)
				Neck.C0 = Lerp(Neck.C0, NECKC0 * angles(0.08726646259971647, 0, 0), 1 / Animation_Speed)
				RightShoulder.C0 = Lerp(RightShoulder.C0, cf(1.25, 0.5, -0.5) * angles(1.7453292519943295, 0, -1.2217304763960306) * RSC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Lerp(LeftShoulder.C0, cf(-1.25, 0.35, -0.35) * angles(1.2217304763960306, 0, 1.3962634015954636) * LSC0, 1 / Animation_Speed)
				RightHip.C0 = Lerp(RightHip.C0, cf(1, -1 - 0.05 * cos(sine / 12), -0.01) * angles(0, 1.4486232791552935, 0), 1 / Animation_Speed)
				LeftHip.C0 = Lerp(LeftHip.C0, cf(-1, -1 - 0.05 * cos(sine / 12), -0.01) * angles(0, -1.4486232791552935, 0), 1 / Animation_Speed)
			end
			twait(0.5)
			--CreateSound(363808674, Torso, 6, 1, false)
			idleOverwrite=function()
				local sine = sine * 40
				local Animation_Speed = 0.45 / deltaTime
				RootJoint.C1 = Lerp(RootJoint.C1,ROOTC0, 0.2 / Animation_Speed)
				Neck.C1 = Lerp(Neck.C1,cfMul(cf(0, -0.5, 0),angles(-1.5707963267948966, 0, 3.141592653589793)), 0.2 / Animation_Speed)
				RightHip.C1 = Lerp(RightHip.C1,cfMul(cf(0.5, 1, 0),angles(0, 1.5707963267948966, 0)), 0.7 / Animation_Speed)
				LeftHip.C1 = Lerp(LeftHip.C1,cfMul(cf(-0.5, 1, 0),angles(0, -1.5707963267948966, 0)), 0.7 / Animation_Speed)

				RootJoint.C0 = Lerp(RootJoint.C0,ROOTC0 * cf(0, 0, 0.05 * cos(sine / 12)), 1 / Animation_Speed)
				Neck.C0 = Lerp(Neck.C0, NECKC0 * angles(0.08726646259971647, 0.4363323129985824, 0), 1 / Animation_Speed)
				RightShoulder.C0 = Lerp(RightShoulder.C0, cf(1.25, 0.5, -0.5) * angles(1.7453292519943295, 0, -0.8726646259971648) * RSC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Lerp(LeftShoulder.C0, cf(-1.25, 0.35, -0.35) * angles(1.2217304763960306, 0, 1.0471975511965976) * LSC0, 1 / Animation_Speed)
				RightHip.C0 = Lerp(RightHip.C0, cf(1, -1 - 0.05 * cos(sine / 12), -0.01) * angles(0, 1.4486232791552935, 0), 1 / Animation_Speed)
				LeftHip.C0 = Lerp(LeftHip.C0, cf(-1, -1 - 0.05 * cos(sine / 12), -0.01) * angles(0, -1.4486232791552935, 0), 1 / Animation_Speed)
			end
			twait(0.3)
			--CreateSound(363808674, Torso, 6, 1, false)
			idleOverwrite=function()
				local sine = sine * 40
				local Animation_Speed = 0.45 / deltaTime
				RootJoint.C1 = Lerp(RootJoint.C1,ROOTC0, 0.2 / Animation_Speed)
				Neck.C1 = Lerp(Neck.C1,cfMul(cf(0, -0.5, 0),angles(-1.5707963267948966, 0, 3.141592653589793)), 0.2 / Animation_Speed)
				RightHip.C1 = Lerp(RightHip.C1,cfMul(cf(0.5, 1, 0),angles(0, 1.5707963267948966, 0)), 0.7 / Animation_Speed)
				LeftHip.C1 = Lerp(LeftHip.C1,cfMul(cf(-0.5, 1, 0),angles(0, -1.5707963267948966, 0)), 0.7 / Animation_Speed)

				RootJoint.C0 = Lerp(RootJoint.C0,ROOTC0 * cf(0, 0, 0.05 * cos(sine / 12)), 1 / Animation_Speed)
				Neck.C0 = Lerp(Neck.C0, NECKC0 * angles(0.08726646259971647, -0.4363323129985824, 0), 1 / Animation_Speed)
				RightShoulder.C0 = Lerp(RightShoulder.C0, cf(1.25, 0.5, -0.5) * angles(1.7453292519943295, 0, -1.5707963267948966) * RSC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Lerp(LeftShoulder.C0, cf(-1.25, 0.35, -0.35) * angles(1.2217304763960306, 0, 1.5707963267948966) * LSC0, 1 / Animation_Speed)
				RightHip.C0 = Lerp(RightHip.C0, cf(1, -1 - 0.05 * cos(sine / 12), -0.01) * angles(0, 1.4486232791552935, 0), 1 / Animation_Speed)
				LeftHip.C0 = Lerp(LeftHip.C0, cf(-1, -1 - 0.05 * cos(sine / 12), -0.01) * angles(0, -1.4486232791552935, 0), 1 / Animation_Speed)
			end
			twait(0.3)
			idleOverwrite=nil
			setWalkSpeed(20)
			setJumpPower(50)
		end,
		idle = function()
			if idleOverwrite then 
				return idleOverwrite()
			end

			local Animation_Speed = 0.45 / deltaTime
			local sine = sine * 40

			RootJoint.C1 = Lerp(RootJoint.C1,ROOTC0, 0.2 / Animation_Speed)
			Neck.C1 = Lerp(Neck.C1,cfMul(cf(0, -0.5, 0),angles(-1.5707963267948966, 0, 3.141592653589793)), 0.2 / Animation_Speed)
			RightHip.C1 = Lerp(RightHip.C1,cfMul(cf(0.5, 1, 0),angles(0, 1.5707963267948966, 0)), 0.7 / Animation_Speed)
			LeftHip.C1 = Lerp(LeftHip.C1,cfMul(cf(-0.5, 1, 0),angles(0, -1.5707963267948966, 0)), 0.7 / Animation_Speed)

			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(ROOTC0, cf(0.05 * cos(sine / 12), 0, 0.05 * sin(sine / 12))), 0.15 / Animation_Speed)
			Neck.C0 = Lerp(Neck.C0,cfMul(NECKC0, angles(rad(15 - 2.5 * sin(sine / 12)), 0, -0.4363323129985824)), 1 / Animation_Speed)
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cfMul(cf(1.25, 0.5, 0.3),angles(-0.7853981633974483, 0, -0.7853981633974483)), RSC0), 1 / Animation_Speed)
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cfMul(cf(-1.25, 0.5, 0.3),angles(-0.6981317007977318, 0, 0.7853981633974483)), LSC0), 1 / Animation_Speed)
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cfMul(cf(1 + 0.05 * cos(sine / 12), -1 - 0.05 * sin(sine / 12), -0.01),angles(0, 1.4835298641951802, 0)),angles(-0.017453292519943295, 0, 0)), 0.15 / Animation_Speed)
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cfMul(cf(-1 + 0.05 * cos(sine / 12), -1 - 0.05 * sin(sine / 12), -0.01),angles(0, -1.4835298641951802, 0)),angles(-0.017453292519943295, 0, 0)), 0.15 / Animation_Speed)
		end,
		walk = function()
			local Animation_Speed = 0.45 / deltaTime
			local sine = sine * 40
			RootJoint.C1 = Lerp(RootJoint.C1,cfMul(ROOTC0, cf(0, 0, 0.05 * cos(sine / (2.4)))), 2 * 1.25 / Animation_Speed)
			Neck.C1 = Lerp(Neck.C1,cfMul(cf(0, -0.5, 0),angles(-1.5707963267948966, 0, 3.141592653589793)), 0.2 * 1.25 / Animation_Speed)
			RightHip.C1 = Lerp(RightHip.C1,cfMul(cfMul(cf(0.5, 0.875 - 0.125 * sin(sine / 4.8) - 0.15 * cos(sine / 2.4), 0),angles(0, 1.5707963267948966, 0)),angles(0, 0, rad(35 * cos(sine / 4.8)))), 0.6 / Animation_Speed)
			LeftHip.C1 = Lerp(LeftHip.C1,cfMul(cfMul(cf(-0.5, 0.875 + 0.125 * sin(sine / 4.8) - 0.15 * cos(sine / 2.4), 0),angles(0, -1.5707963267948966, 0)),angles(0, 0, rad(35 * cos(sine / 4.8)))), 0.6 / Animation_Speed)

			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(ROOTC0, cf(0, 0, -0.05)), 0.15 / Animation_Speed)
			Neck.C0 = Lerp(Neck.C0,cfMul(NECKC0,angles(0.08726646259971647, 0, 0)), 0.15 / Animation_Speed)
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cfMul(cf(1.25, 0.5 + 0.05 * sin(sine / (2.4)), 0.3),angles(-0.7853981633974483, 0, -0.7853981633974483)), RSC0), 1 / Animation_Speed)
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cfMul(cf(-1.25, 0.5 + 0.05 * sin(sine / (2.4)), 0.3),angles(-0.6981317007977318, 0, 0.7853981633974483)), LSC0), 1 / Animation_Speed)
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cfMul(cf(1, -1, 0),angles(0, 1.3962634015954636, 0)),angles(0, 0, -0.08726646259971647)), 2 / Animation_Speed)
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cfMul(cf(-1, -1, 0),angles(0, -1.3962634015954636, 0)),angles(0, 0, 0.08726646259971647)), 2 / Animation_Speed)
		end,
		jump = jumplerps,
		fall = falllerps
	})

	addmode("f",{ --mode 0
		modeLeft=function() --enter mode 1
			setWalkSpeed(0)
			setJumpPower(0)
			--CreateSound(147722227, Torso, 4, 1.3, false)
			idleOverwrite=function()
				local sine = sine * 40
				local Animation_Speed = 0.45 / deltaTime
				RootJoint.C1 = Lerp(RootJoint.C1,ROOTC0, 0.2 / Animation_Speed)
				Neck.C1 = Lerp(Neck.C1,cfMul(cf(0, -0.5, 0),angles(-1.5707963267948966, 0, 3.141592653589793)), 0.2 / Animation_Speed)
				RightHip.C1 = Lerp(RightHip.C1,cfMul(cf(0.5, 1, 0),angles(0, 1.5707963267948966, 0)), 0.7 / Animation_Speed)
				LeftHip.C1 = Lerp(LeftHip.C1,cfMul(cf(-0.5, 1, 0),angles(0, -1.5707963267948966, 0)), 0.7 / Animation_Speed)

				RootJoint.C0 = Lerp(RootJoint.C0,ROOTC0 * cf(0, 0, 0.05 * cos(sine / 12)), 1 / Animation_Speed)
				Neck.C0 = Lerp(Neck.C0, NECKC0 * angles(0.6108652381980153, 0, 0), 1 / Animation_Speed)
				RightShoulder.C0 = Lerp(RightShoulder.C0, cf(1.5, 0.5, 0) * angles(0, 0, 0.4363323129985824) * RSC0, 1 / Animation_Speed)
				LeftShoulder.C0 = Lerp(LeftShoulder.C0, cf(-1.5, 0.5, 0) * angles(0, 0, -0.4363323129985824) * LSC0, 1 / Animation_Speed)
				RightHip.C0 = Lerp(RightHip.C0, cf(1, -1 - 0.05 * cos(sine / 12), -0.01) * angles(0, 1.4486232791552935, 0), 1 / Animation_Speed)
				LeftHip.C0 = Lerp(LeftHip.C0, cf(-1, -1 - 0.05 * cos(sine / 12), -0.01) * angles(0, -1.4486232791552935, 0), 1 / Animation_Speed)
			end
			twait(0.15)
			idleOverwrite=nil
			setWalkSpeed(20)
			setJumpPower(50)
		end,
		idle = function()
			if idleOverwrite then 
				return idleOverwrite()
			end

			local Animation_Speed = 0.45 / deltaTime
			local sine = sine * 40

			RootJoint.C1 = Lerp(RootJoint.C1,ROOTC0, 0.2 / Animation_Speed)
			Neck.C1 = Lerp(Neck.C1,cfMul(cf(0, -0.5, 0),angles(-1.5707963267948966, 0, 3.141592653589793)), 0.2 / Animation_Speed)
			RightHip.C1 = Lerp(RightHip.C1,cfMul(cf(0.5, 1, 0),angles(0, 1.5707963267948966, 0)), 0.7 / Animation_Speed)
			LeftHip.C1 = Lerp(LeftHip.C1,cfMul(cf(-0.5, 1, 0),angles(0, -1.5707963267948966, 0)), 0.7 / Animation_Speed)

			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(ROOTC0, cf(0, 0, 0.05 * cos(sine / 12))), 1 / Animation_Speed)
			Neck.C0 = Lerp(Neck.C0,cfMul(NECKC0,angles(rad(-5 - 2.5 * cos(sine / 12)), 0, 0.4363323129985824)), 1 / Animation_Speed)
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cfMul(cf(0.9, 0.5 + 0.05 * sin(sine / 12), -0.5),angles(1.7453292519943295, 0, -1.2217304763960306)), RSC0), 1 / Animation_Speed)
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cfMul(cf(-0.9, 0.25 + 0.05 * sin(sine / 12), -0.35),angles(1.2217304763960306, 0, 1.3962634015954636)), LSC0), 1 / Animation_Speed)
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cf(1, -1 - 0.05 * cos(sine / 12), -0.01),angles(0, 1.3962634015954636, 0)), 1 / Animation_Speed)
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cf(-1, -1 - 0.05 * cos(sine / 12), -0.01),angles(0, -1.3962634015954636, 0)), 1 / Animation_Speed)
		end,
		walk = function()
			local Animation_Speed = 0.45 / deltaTime
			local sine = sine * 40
			RootJoint.C1 = Lerp(RootJoint.C1,cfMul(ROOTC0, cf(0, 0, 0.05 * cos(sine / (2.4)))), 2 * 1.25 / Animation_Speed)
			Neck.C1 = Lerp(Neck.C1,cfMul(cf(0, -0.5, 0),angles(-1.5707963267948966, 0, 3.141592653589793)), 0.2 * 1.25 / Animation_Speed)
			RightHip.C1 = Lerp(RightHip.C1,cfMul(cfMul(cf(0.5, 0.875 - 0.125 * sin(sine / 4.8) - 0.15 * cos(sine / 2.4), 0),angles(0, 1.5707963267948966, 0)),angles(0, 0, rad(35 * cos(sine / 4.8)))), 0.6 / Animation_Speed)
			LeftHip.C1 = Lerp(LeftHip.C1,cfMul(cfMul(cf(-0.5, 0.875 + 0.125 * sin(sine / 4.8) - 0.15 * cos(sine / 2.4), 0),angles(0, -1.5707963267948966, 0)),angles(0, 0, rad(35 * cos(sine / 4.8)))), 0.6 / Animation_Speed)

			RootJoint.C0 = Lerp(RootJoint.C0,cfMul(ROOTC0, cf(0, 0, -0.05)), 0.15 / Animation_Speed)
			Neck.C0 = Lerp(Neck.C0,cfMul(NECKC0,angles(0.08726646259971647, 0, 0)), 0.15 / Animation_Speed)
			RightShoulder.C0 = Lerp(RightShoulder.C0,cfMul(cfMul(cf(0.9, 0.5 + 0.05 * sin(sine / (2.4)), -0.5),angles(1.7453292519943295, 0, -1.2217304763960306)), RSC0), 1 / Animation_Speed)
			LeftShoulder.C0 = Lerp(LeftShoulder.C0,cfMul(cfMul(cf(-0.9, 0.25 + 0.05 * sin(sine / (2.4)), -0.35),angles(1.2217304763960306, 0, 1.3962634015954636)), LSC0), 1 / Animation_Speed)
			RightHip.C0 = Lerp(RightHip.C0,cfMul(cfMul(cf(1, -1, 0),angles(0, 1.3962634015954636, 0)),angles(0, 0, -0.08726646259971647)), 2 / Animation_Speed)
			LeftHip.C0 = Lerp(LeftHip.C0,cfMul(cfMul(cf(-1, -1, 0),angles(0, -1.3962634015954636, 0)),angles(0, 0, 0.08726646259971647)), 2 / Animation_Speed)
		end,
		jump = jumplerps,
		fall = falllerps
	})
end)
lbl("original by shackluster")
lbl("the classics never die")

btn("metamorphosis vibe", function()
	local t=reanimate()
	if type(t)~="table" then return end
	local addmode=t.addmode
	local getJoint=t.getJoint
	local velbycfrvec=t.velbycfrvec
	local RootJoint=getJoint("RootJoint")
	local RightShoulder=getJoint("Right Shoulder")
	local LeftShoulder=getJoint("Left Shoulder")
	local RightHip=getJoint("Right Hip")
	local LeftHip=getJoint("Left Hip")
	local Neck=getJoint("Neck")
	t.setWalkSpeed(4.5)

	addmode("default",{
		idle=function()
			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.7453292519943295-0.08726646259971647*sin(sine*8),-0.12217304763960307*sin((sine+0.2)*4),2.8797932657906435+0.2007128639793479*sin((sine+0.15)*4))),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1+0.1*sin(sine*4),0),angles(1.5707963267948966,1.5707963267948966+0.17453292519943295*sin(sine*4),-1.5707963267948966)),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.3,0),angles(2.530727415391778+0.20943951023931956*sin((sine+0.4)*8),1.5707963267948966-0.4363323129985824*sin((sine+0.2)*4),-1.5707963267948966)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.5,0),angles(1.0471975511965976,-1.2217304763960306+0.08726646259971647*sin((sine+0.2)*4),1.5707963267948966)),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1-0.1*sin(sine*4),0),angles(1.5707963267948966,-1.5707963267948966+0.17453292519943295*sin(sine*4),1.5707963267948966)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(-0.1 * sin(sine*4),0,0),angles(-1.5707963267948966,0.08726646259971647*sin(sine*4),3.141592653589793)),deltaTime) 
			--MW_animatorProgressSave: Fedora_Handle,8.657480066176504e-09,0,0,4,-6,0,0,4,-0.15052366256713867,0,0,4,0,0,0,4,-0.010221302509307861,0,0,4,0,0,0,4,Bandana_Handle,3.9362930692732334e-09,0,0,4,0,0,0,4,0.3000001907348633,0,0,4,0,0,0,4,-0.6002722978591919,0,0,4,0,0,0,4,Head,0,0,0,4,-100,-5,0,8,1,0,0,4,-0,-7,0.2,4,0,0,0,4,165,11.5,0.15,4,RightLeg,1,0,0,4,90,0,0,4,-1,0.1,0,4,90,10,0,4,0,0,0,4,-90,0,0,4,RightArm,1,0,0,4,145,12,0.4,8,0.3,0,0,4,90,-25,0.2,4,0,0,0,4,-90,0,0,4,LeftArm,-1,0,0,4,60,0,0,4,0.5,0,0,4,-70,5,0.2,4,0,0,0,4,90,0,0,4,LeftLeg,-1,0,0,4,90,0,0,4,-1,-0.1,0,4,-90,10,0,4,0,0,0,4,90,0,0,4,Torso,0,-0.1,0,4,-90,0,0,4,0,0,0,4,-0,5,0,4,0,0,0,4,180,0,0,4
		end,
		walk=function()
			local fw,rt=velbycfrvec()

			Neck.C0=Lerp(Neck.C0,cfMul(cf(0,1,0),angles(-1.5707963267948966+0.08726646259971647*sin((sine-0.1)*8),0.3490658503988659*sin((sine-0.07)*4),3.141592653589793-0.4363323129985824*sin((sine-0.4)*4))),deltaTime) 
			RightHip.C0=Lerp(RightHip.C0,cfMul(cf(1,-1+0.3*sin((sine + 0.3)*4),0),angles(1.5707963267948966,1.5707963267948966+0.6981317007977318*sin(sine*4)*rt,-1.5707963267948966+0.6981317007977318*sin(sine*4)*fw)),deltaTime) 
			RightShoulder.C0=Lerp(RightShoulder.C0,cfMul(cf(1,0.5,0),angles(-0.5235987755982988*sin((sine+0.2)*4),1.5707963267948966-0.3490658503988659*sin(sine*4),0)),deltaTime) 
			LeftShoulder.C0=Lerp(LeftShoulder.C0,cfMul(cf(-1,0.5,0),angles(0.5235987755982988*sin((sine+0.2)*4),-1.5707963267948966-0.3490658503988659*sin(sine*4),0)),deltaTime) 
			LeftHip.C0=Lerp(LeftHip.C0,cfMul(cf(-1,-1-0.3*sin((sine + 0.3)*4),0),angles(1.5707963267948966,-1.5707963267948966-0.6981317007977318*sin(sine*4)*rt,1.5707963267948966+0.6981317007977318*sin(sine*4)*fw)),deltaTime) 
			RootJoint.C0=Lerp(RootJoint.C0,cfMul(cf(0,0.05+0.2*sin((sine + 0.15)*8),0),angles(-1.5707963267948966,0,3.141592653589793)),deltaTime) 
			--MW_animatorProgressSave: Fedora_Handle,8.657480066176504e-09,0,0,4,-6,0,0,4,-0.15052366256713867,0,0,4,0,0,0,4,-0.010221302509307861,0,0,4,0,0,0,4,Bandana_Handle,3.9362930692732334e-09,0,0,4,0,0,0,4,0.3000001907348633,0,0,4,0,0,0,4,-0.6002722978591919,0,0,4,0,0,0,4,Head,0,0,0,4,-90,5,-0.1,8,1,0,0,4,-0,20,-0.07,4,0,0,0,4,180,-25,-0.4,4,RightLeg,1,0,0,4,90,0,0,4,-1,0.3,0.3,4,90,40,0,4,0,0,0,4,-90,40,0,4,RightArm,1,0,0,4,0,-30,0.2,4,0.5,0,0,4,90,-20,0,4,0,0,0,4,0,0,0,4,LeftArm,-1,0,0,4,0,30,0.2,4,0.5,0,0,4,-90,-20,0,4,0,0,0,4,0,0,0,4,LeftLeg,-1,0,0,4,90,0,0,4,-1,-0.3,0.3,4,-90,-40,0,4,0,0,0,4,90,40,0,4,Torso,0,0,0,4,-90,0,0,4,0.05,0.2,0.15,8,-0,0,0,4,0,0,0,4,180,0,0,4
		end
	})
end)

lbl("INTERWORLD - METAMORPHOSIS")
lbl("was listening to ^^ and animating")

btn("empty reanimate (no animations)", reanimate)
insSet(btn("stop current script",stopreanimate),"TextColor3",c3(0.75,0,0))

lbl("SETTINGS (REANIMATE TO APPLY)")

swtc("client sided placeholders",{
	{value=true,text="yes"},
	{value=false,text="no"}
},function(v)
	placeholders=v
end)

swtc("highlight fling targets",{
	{value=true,text="yes"},
	{value=false,text="no"}
},function(v)
	highlightflingtargets=v
end)

swtc("allow shiftlock",{
	{value=true,text="yes"},
	{value=false,text="no"}
},function(v)
	allowshiftlock=v
end)

swtc("ctrl click tp",{
	{value=true,text="yes"},
	{value=false,text="no"}
},function(v)
	ctrltp=v
end)

swtc("click fling",{
	{value=true,text="yes"},
	{value=false,text="no"}
},function(v)
	clickfling=v
end)

if sethiddenproperty then
	if setscriptable then
		swtc("fling reproot",{
			{value=3,text="sethiddenproperty"},
			{value=2,text="setscriptable"},
			{value=1,text="no unc"},
			{value=0,text="off (prediction fling)"}
		},function(v)
			flingtargetting=v
		end)
		lbl("(makes fling fast and undodgeable)")
		lbl("game can detect/break \"no unc\"")
	else
		swtc("fling reproot",{
			{value=3,text="sethiddenproperty"},
			{value=1,text="no unc"},
			{value=0,text="off (prediction fling)"}
		},function(v)
			flingtargetting=v
		end)
		lbl("(makes fling fast and undodgeable)")
		lbl("game can detect/break \"no unc\"")
		lbl("setscriptable missing")
	end
else
	if setscriptable then
		swtc("fling reproot",{
			{value=2,text="setscriptable"},
			{value=1,text="no unc"},
			{value=0,text="off (prediction fling)"}
		},function(v)
			flingtargetting=v
		end)
		lbl("(makes fling fast and undodgeable)")
		lbl("game can detect/break \"no unc\"")
		lbl("sethiddenproperty missing")
	else
		swtc("fling reproot",{
			{value=0,text="off (prediction fling)"},
			{value=1,text="no unc"}
		},function(v)
			flingtargetting=v
		end)
		lbl("(makes fling fast and undodgeable)")
		lbl("game can detect/break \"no unc\"")
		lbl("BETTER FLING BUT AT UR RISK")
		lbl("sethiddenproperty missing")
		lbl("setscriptable missing")
	end
end

swtc("fling direction",{
	{value=0,text="upwards"},
	{value=1,text="downwards"},
	{value=2,text="horizontal"},
},function(v)
	if v==0 then
		flingoffset=-v3_010
		flingvel=v3(0,16000,0)
		flingrotvel=v3(16000,0,16000)
	elseif v==1 then
		flingoffset=v3_010
		flingvel=v3(0,-16000,0)
		flingrotvel=v3(16000,0,16000)
	elseif v==2 then
		flingoffset=v3(-0.5,0,0)
		flingvel=v3(16000,0,0)
		flingrotvel=v3(0,16000,0)
	end
end)

swtc("fling enhancements",{
	{value=3,text="all"},
	{value=1,text="changestate physics"},
	{value=2,text="disable sitting"},
	{value=0,text="none"}
},function(v)
	flingchangestate=v
end)

swtc("respawn tp",{
	{value=3,text="hide body"},
	{value=0,text="stay at spawn"},
	{value=1,text="random tp close"},
	{value=2,text="behind char"}
},function(v)
	respawntp=v
end)

swtc("new gui scripts",{
	{value=true,text="disable"},
	{value=false,text="keep"}
},function(v)
	disguiscripts=v
end)

swtc("new character scripts",{
	{value=function(v)
		if IsA(v,"Script") then --mind Enum.RunContext.Client
			insSet(v,"Disabled",true)
		end
	end,text="disable"},
	{value=false,text="keep"}
},function(v)
	discharscripts=v
end)

if replicatesignal then
	swtc("breakjoints",{
		{value=4,text="serverbreakjoints"},
		{value=1,text="breakjoints+health"},
		{value=2,text="health or breakjoints"},
		{value=3,text="breakjoints"}
	},function(v)
		breakjointsmethod=v
	end)
else
	swtc("breakjoints",{
		{value=1,text="breakjoints+health"},
		{value=2,text="health or breakjoints"},
		{value=3,text="breakjoints"}
	},function(v)
		breakjointsmethod=v
	end)
	lbl("serverbreakjoints unsupported")
end

swtc("coregui death effect",{
	{value=true,text="disable"},
	{value=false,text="dont modify"}
},function(v)
	hidedeatheffect=v
end)

swtc("set simulation radius",{
	{value=true,text="yes"},
	{value=false,text="no"}
},function(v)
	simrad=v
end)

local cg=FindFirstChildOfClass(game,"CoreGui")
if pcall(GetChildren,cg) then
	insSet(i10,"Parent",cg)
else
	insSet(i7,"Text","PLAYERGUI MODE")
	insSet(i10,"Parent",pg)
	twait(3)
	insSet(i7,"Text",guiTheme.guiTitle)
end