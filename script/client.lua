Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

cRP = {}
Tunnel.bindInterface("inventory",cRP)
vSERVER = Tunnel.getInterface("inventory")




RegisterNUICallback("invClose",function()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "hideMenu" })
end)




function cRP.closeInventory()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "hideMenu" })
end

RegisterNetEvent('cloneplates')
AddEventHandler('cloneplates',function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local clonada = GetVehicleNumberPlateText(vehicle)
    if IsEntityAVehicle(vehicle) then
        PlateIndex = GetVehicleNumberPlateText(vehicle)
        SetVehicleNumberPlateText(vehicle,"CLONADA")
        FreezeEntityPosition(vehicle,false)
        if clonada == CLONADA then 
            SetVehicleNumberPlateText(vehicle,PlateIndex)
            PlateIndex = nil
        end
    end
end)


Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		if IsControlJustPressed(0,243) and not IsPlayerFreeAiming(PlayerId()) and GetEntityHealth(PlayerPedId()) >= 102 and not vRP.isHandcuff() then
			SetNuiFocus(true,true)
			SetCursorLocation(0.5,0.5)
			SendNUIMessage({ action = "showMenu" })

			
			local identity = false
			if identity then
				identity = false
				SendNUIMessage({ type = 'close' })
			else
				local  carteira,banco,coins,nome,sobrenome,idade,user_id,identidade,telefone,job,cargo,vip,faturas,multas,mypaypal = vSERVER.Identidade()
				SendNUIMessage({
					type = 'open',
					nome = nome,
					sobrenome = sobrenome,
					carteira = carteira,
					banco = banco,
					vip = vip,
					emprego = job,
					cargo = cargo,
					id = user_id,
					documento = identidade,
					idade = idade,
					telefone = telefone,
					multas = multas,
					mypaypal = mypaypal

				})
				identity = true
			end
		end
		Citizen.Wait(5)
	end
end)





RegisterNUICallback("dropItem",function(data)
	vSERVER.dropItem(data.item,data.amount)
end)




RegisterNUICallback("sendItem",function(data)
	vSERVER.sendItem(data.item,data.amount)
end)




RegisterNUICallback("useItem",function(data)
	vSERVER.useItem(data.item,data.type,data.amount)
end)




RegisterNUICallback("DoSomething",function(data)
	if data.tDrop == "roubar" then
		vSERVER.roubItem(data.item,data.amount)
	elseif data.tDrop == "armamento" then
		vSERVER.getWeapon(data.item)
	end
end)




RegisterNUICallback("requestMochila",function(data,cb)
	local inventario,peso,maxpeso = vSERVER.Mochila()
	vSERVER.Armamento()
	if inventario then
		cb({ inventario = inventario, peso = peso, maxpeso = maxpeso })
	end
end)




RegisterNUICallback("requestNearMochila",function(data,cb)
	local nearinventario = vSERVER.NearMochila()
	if nearinventario then
		cb({ nearinventario = nearinventario })
	end
end)




RegisterNUICallback("requestArmamento",function(data,cb)
	local armamento = vSERVER.Armamento()
	if armamento then
		cb({ armamento = armamento })
	end
end)




RegisterNetEvent("inventory:Update")
AddEventHandler("inventory:Update",function(action)
	SendNUIMessage({ action = action })
end)




function cRP.plateDistance()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			FreezeEntityPosition(GetVehiclePedIsUsing(ped),true)
			return true
		end
	end
	return false
end




function cRP.plateApply(plate)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	if IsEntityAVehicle(vehicle) then
		SetVehicleNumberPlateText(vehicle,plate)
		FreezeEntityPosition(vehicle,false)
	end
end




function cRP.repairVehicle(index,status)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			SetEntityAsMissionEntity(v,true,true)
			local fuel = GetVehicleFuelLevel(v)
			if status then
				SetVehicleFixed(v)
				SetVehicleFuelLevel(v,fuel)
				SetVehicleDeformationFixed(v)
				SetVehicleUndriveable(v,false)
			else
				SetVehicleEngineHealth(v,1000.0)
				SetVehicleBodyHealth(v,1000.0)
				SetVehicleFuelLevel(v,fuel)
			end
		end
	end
end




function cRP.repairTires(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			for i = 0,8 do
				SetVehicleTyreFixed(v,i)
			end
		end
	end
end




function cRP.lockpickVehicle(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			SetEntityAsMissionEntity(v,true,true)
			if GetVehicleDoorsLockedForPlayer(v,PlayerId()) == 1 then
				SetVehicleDoorsLocked(v,false)
				SetVehicleDoorsLockedForAllPlayers(v,false)
			else
				SetVehicleDoorsLocked(v,true)
				SetVehicleDoorsLockedForAllPlayers(v,true)
			end
			SetVehicleLights(v,2)
			Wait(200)
			SetVehicleLights(v,0)
			Wait(200)
			SetVehicleLights(v,2)
			Wait(200)
			SetVehicleLights(v,0)
		end
	end
end




local blockButtons = false
function cRP.blockButtons(status)
	blockButtons = status
end




Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if blockButtons then
			timeDistance = 4
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,56,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,38,true)
			DisableControlAction(0,20,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,105,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,327,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,243,true)
		end
		Citizen.Wait(timeDistance)
	end
end)



function cRP.parachuteColors()
	vRP.giveWeapons({["GADGET_PARACHUTE"] = { ammo = 1 }})
    SetPedParachuteTintIndex(PlayerPedId(),math.random(7))
end



function cRP.checkObjects(prop)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	if DoesObjectOfTypeExistAtCoords(x,y,z,0.7,GetHashKey(prop),true) then
		return true
	end

	return false
end




local registerCoords = {}
function cRP.cashRegister()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	for k,v in pairs(registerCoords) do
		local distance = GetDistanceBetweenCoords(x,y,z,v[1],v[2],v[3],true)
		if distance <= 1 then
			return false,v[1],v[2],v[3]
		end
	end

	local object = GetClosestObjectOfType(x,y,z,0.4,GetHashKey("prop_till_01"),0,0,0)
	if DoesEntityExist(object) then
		local x2,y2,z2 = table.unpack(GetEntityCoords(object))
		SetEntityHeading(ped,GetEntityHeading(object)-360.0)
		SetPedComponentVariation(ped,5,45,0,2)
		return true,x2,y2,z2
	end

	return false
end




function cRP.updateRegister(status)
	registerCoords = status
end
