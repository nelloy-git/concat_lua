function CreateVisualConusForUnitBySplat(hero,flag,long,step,range,angleSector)
	local image={}
	local image2={}
	local pid=GetPlayerId(GetOwningPlayer(hero))
	local data=HERO[pid]
	local size=step/3
	local r60=70//size
	local r40=50//size
	local LastMouseX=0

	for i=1,long*2 do
		image[i]=CreateImage(ImportPath.."\\pointerORIG",16,16,16,4000,4000,0,0,0,150,4)
		SetImageColor(image[i],0,255,0,128)
		SetImageRenderAlways(image[i], true)
		if GetLocalPlayer()~=Player(pid) then
			ShowImage(image[i],false)
		else
			ShowImage(image[i],true)
		end

	end

	local distance=0
	local mouseMoving=false
	local savedDistance=0
	local lastAngle=0
	local delta=0
	local angle=0
	local function Destroy()
		DestroyTimer(GetExpiredTimer())
		--data.MarkIsActivated=true
		--print("destroy")
		for i=1,#image do
			DestroyImage(image[i])
			DestroyImage(image2[i])
		end
	end
	local curAngle=GetUnitFacing(hero)
	local iter=0
	local curBlock=0
	TimerStart(CreateTimer(), TIMER_PERIOD, true, function()
		local xs,ys=MoveXY(GetUnitX(hero)-16,GetUnitY(hero)-16,0,curAngle)--стартовое смещение и это центр юнита
		iter=iter+1
		angle=AngleBetweenXY(xs, ys, GetPlayerMouseX[pid], GetPlayerMouseY[pid])/bj_DEGTORAD--data.AngleMouse
		curAngle=lerpTheta(curAngle,angle,TIMER_PERIOD*8)
		if LastMouseX == GetPlayerMouseX[pid] then
			mouseMoving=false
		else
			mouseMoving=true
		end
		LastMouseX = GetPlayerMouseX[pid]
		delta=curAngle-lastAngle
		lastAngle=curAngle
		if mouseMoving then
			distance=DistanceBetweenXY(GetPlayerMouseX[pid],GetPlayerMouseY[pid],GetUnitXY(hero))
			savedDistance=DistanceBetweenXY(GetPlayerMouseX[pid],GetPlayerMouseY[pid],GetUnitXY(hero))
		else
			distance=savedDistance
		end
		local block=0
		for _=1,#image do
			distance=distance-step
			if distance>=0 then
				block=block+1
			end
		end
		local k=0
		local k2=0
		local a=0
		local k3=0
		local pointToRange=range
		local pointToRange2=range*.87
		for i=1,#image do
			if i<=angleSector then
				--рисуем полукруг
				a=a+step
				k=k+1
				local nx,ny=MoveXY(xs,ys,range,-angleSector/2+curAngle+a)
				SetImagePosition(image[i],nx,ny,0)
			else
				local rxs,rys=MoveXY(xs,ys,range,-angleSector/2+curAngle+k*step)
				local angleR=AngleBetweenXY(rxs,rys,xs, ys)/bj_DEGTORAD
				k2=k2+1
				pointToRange=pointToRange-step
				if pointToRange>0 then
					local nx,ny=MoveXY(rxs,rys,step*k2,angleR)
					SetImagePosition(image[i],nx,ny,0)
				else
					k3=k3+1
					pointToRange2=pointToRange2-step
					if pointToRange2>0 then
						local nx,ny=MoveXY(rxs,rys,step*k2,angleR)
						local nx2,ny2=MoveXY(nx,ny,step*k3,angleR-angleSector*2)
						SetImagePosition(image[i],nx2,ny2,0)
					end

				end
			end
		end

		if flag==1 then
			if not data.MarkIsActivated then
				Destroy()
			end
		end
	end)
end