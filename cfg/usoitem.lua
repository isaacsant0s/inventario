active = {}
actived = {}
bandage = {}
amountUse = {}
syringeTime = {}
blips = {}

function tcRP.useItem(itemName,type,ramount)
	local webhookusar = Config.webhookusar
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserAptitudes(user_id)
		if user_id and ramount ~= nil and parseInt(ramount) >= 0 and not actived[user_id] and actived[user_id] == nil then 
		
			if type == "usar" then
				if itemName == "bandagem" then
					vida = vRPclient.getHealth(source)
					if vida > 101 and vida < 240 then
					
						if bandage[user_id] == 0 or not bandage[user_id] then
							if vRP.tryGetInventoryItem(user_id,"bandagem",1) then
								actived[user_id] = true
								vRPclient._CarregarObjeto(source,"amb@world_human_clipboard@male@idle_a","idle_c","v_ret_ta_firstaid",49,60309)
								TriggerClientEvent('inventory:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								TriggerClientEvent("progress",source,20000,"bandagem")
								SetTimeout(20000,function()
									actived[user_id] = nil
									bandage[user_id] = 160
									TriggerClientEvent('bandagem',source)
									TriggerClientEvent('cancelando',source,false)
									vRPclient._DeletarObjeto(source)
									TriggerClientEvent("Notify",source,"sucesso","Bandagem utilizada com sucesso.",8000)
									SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
								end)
							end
						else
							TriggerClientEvent("Notify",source,"importante","Você precisa aguardar <b>"..bandage[user_id].." segundos</b> para utilizar outra Bandagem.",8000)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Você não pode utilizar de vida cheia ou nocauteado.",8000)
					end
				elseif itemName == "gaze" then
					if vRP.tryGetInventoryItem(user_id,"gaze",1) then
						vRPclient._CarregarObjeto(source,"amb@world_human_clipboard@male@idle_a","idle_c","v_ret_ta_firstaid",49,60309)
						TriggerClientEvent("vrp_inventory:fechar",source)
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("progress",source,10000,"Usando...")
						TriggerClientEvent("resetWarfarina",source)
						SetTimeout(10000,function()
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Gaze utilizado com sucesso.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "celular" then
					if vRP.tryGetInventoryItem(user_id,"celular",1) then
						vRP.giveInventoryItem(user_id,"celulardesligado",1)
						TriggerClientEvent("Notify",source,"sucesso","Celular desligado.",8000)
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
					end
				elseif itemName == "celulardesligado" then
					if vRP.tryGetInventoryItem(user_id,"celulardesligado",1) then
						vRP.giveInventoryItem(user_id,"celular",1)
						TriggerClientEvent("Notify",source,"sucesso","Celular ligado.",8000)
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
					end
				elseif itemName == "colete" then
					if vRP.tryGetInventoryItem(user_id,"colete",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						TriggerClientEvent('cancelando',source,true)
						vRPclient._playAnim(source,true,{{"oddjobs@basejump@ig_15","puton_parachute"}},false)
						TriggerClientEvent("progress",source,3000,"colocando")
						SetTimeout(3000,function()
							actived[user_id] = nil
							TriggerClientEvent('cancelando',source,false)
							vRPclient.setArmour(source,100)
							vRPclient._stopAnim(source,false)
						end)
					end
------------------------------------------------------------------------------------------------------------]
-----------------------------------------[COMIDA]-----------------------------------------------------------]	
------------------------------------------------------------------------------------------------------------]
				elseif itemName == "hotdog" then
					if vRP.tryGetInventoryItem(user_id,"hotdog",1) then
						local nowfome = vRP.getHunger(user_id)
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						TriggerClientEvent('cancelando',source,true)
						vRPclient._CarregarObjeto(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_a","prop_cs_hotdog_01",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'comendo',0.5)
						TriggerClientEvent("progress",source,8000,"comendo")
						SetTimeout(8000,function()
							vRP.varyHunger(user_id, -40)
							actived[user_id] = nil
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Você comeu um dogão no capricho.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "pizzadequeijo" then
					local src = source
					if vRP.tryGetInventoryItem(user_id,"pizzadequeijo",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","v_res_tt_pizzaplate",49,28422)
						TriggerClientEvent("progress",source,25000,"comendo")
						SetTimeout(25000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRP.varyHunger(user_id,-75)
							vRPclient._DeletarObjeto(src)
							TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Pizza de Queijo</b>.",5000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "pizzadecalabresa" then
					local src = source
					if vRP.tryGetInventoryItem(user_id,"pizzadecalabresa",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","v_res_tt_pizzaplate",49,28422)
						TriggerClientEvent("progress",source,25000,"comendo")
						SetTimeout(25000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRP.varyHunger(user_id,-75)
							vRPclient._DeletarObjeto(src)
							TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Pizza de Calabresa</b>.",5000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "xburguer" then
					local src = source
					if vRP.tryGetInventoryItem(user_id,"xburguer",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_cs_burger_01",49,28422)
						TriggerClientEvent("progress",source,18000,"comendo")
						SetTimeout(18000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRP.varyHunger(user_id,-50)
							vRPclient._DeletarObjeto(src)
							TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>X-Burguer</b>.",5000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "paocomovo" then
					local src = source
					if vRP.tryGetInventoryItem(user_id,"paocomovo",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_sandwich_01",49,28422)
						TriggerClientEvent("progress",source,18000,"comendo")
						SetTimeout(18000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRP.varyHunger(user_id,-40)
							vRPclient._DeletarObjeto(src)
							TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Pão com Ovo</b>.",5000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
	------------------------------------------------------------------------------------------------------------]
				elseif itemName == "lanchenatural" then
					if vRP.tryGetInventoryItem(user_id,"lanchenatural",1) then
						local nowfome = vRP.getHunger(user_id)
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						TriggerClientEvent('cancelando',source,true)
						vRPclient._CarregarObjeto(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_a","prop_sandwich_01",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'comendo',0.5)
						TriggerClientEvent("progress",source,12000,"comendo")
						SetTimeout(12000,function()
							vRP.varyHunger(user_id, -30)
							actived[user_id] = nil
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Você comeu um Lanche Natural.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "rosquinha" then
					if vRP.tryGetInventoryItem(user_id,"rosquinha",1) then
						local nowfome = vRP.getHunger(user_id)
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						TriggerClientEvent('cancelando',source,true)
						vRPclient._CarregarObjeto(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_a","prop_donut_01",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'comendo',0.5)
						TriggerClientEvent("progress",source,10000,"comendo")
						SetTimeout(10000,function()
							vRP.varyHunger(user_id, -20)
							actived[user_id] = nil
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Você comeu uma rosquinha.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "xsalada" then
					local src = source
					if vRP.tryGetInventoryItem(user_id,"xsalada",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_cs_burger_01",49,28422)
						TriggerClientEvent("progress",source,18000,"comendo")
						SetTimeout(18000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRP.varyHunger(user_id,-30)
							vRPclient._DeletarObjeto(src)
							TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>X-Salada</b>.",5000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "xcalabresa" then
					local src = source
					if vRP.tryGetInventoryItem(user_id,"xcalabresa",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_cs_burger_01",49,28422)
						TriggerClientEvent("progress",source,18000,"comendo")
						SetTimeout(18000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRP.varyHunger(user_id,-30)
							vRPclient._DeletarObjeto(src)
							TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>X-Calabresa</b>.",5000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
	------------------------------------------------------------------------------------------------------------]
	-----------------------------------------[LIQUIDOS]---------------------------------------------------------]	
	------------------------------------------------------------------------------------------------------------]			
				elseif itemName == "agua" then
					if vRP.tryGetInventoryItem(user_id,"agua",1) then
						actived[user_id] = true
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","ba_prop_club_water_bottle",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'bebendo',0.5)
						TriggerClientEvent("progress",source,10000,"bebendo")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, -50)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Agua ultilizada.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
							vRP.giveInventoryItem(user_id,"garrafasvazia",1)
						end)
					end
				elseif itemName == "refrigerante" then
					if vRP.tryGetInventoryItem(user_id,"refrigerante",1) then
						actived[user_id] = true
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_ecola_can",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'bebendo',0.5)
						TriggerClientEvent("progress",source,12000,"bebendo")
						SetTimeout(12000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, -20)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Refrigerante ultilizado.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "sucolaranja" then
					if vRP.tryGetInventoryItem(user_id,"sucolaranja",1) then
						actived[user_id] = true
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_food_cb_juice01",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'bebendo',0.5)
						TriggerClientEvent("progress",source,10000,"bebendo")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, -40)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Suco de Laranja ultilizado.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "capuccino" then
					if vRP.tryGetInventoryItem(user_id,"capuccino",1) then
						actived[user_id] = true
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_fib_coffee",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'bebendo',0.5)
						TriggerClientEvent("progress",source,14000,"bebendo")
						SetTimeout(14000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, -20)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Capuccino ultilizado.",10500)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end		
				elseif itemName == "cafe" then
					if vRP.tryGetInventoryItem(user_id,"cafe",1) then
						actived[user_id] = cafe
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_fib_coffee",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'bebendo',0.5)
						TriggerClientEvent("progress",source,15000,"bebendo")
						SetTimeout(15000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, -15)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Cafe ultilizado.",10500)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end		
				elseif itemName == "cerveja" then
					if vRP.tryGetInventoryItem(user_id,"cerveja",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						TriggerClientEvent('cancelando',source,true)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'bebendo',0.5)
						TriggerClientEvent("progress",source,30000,"bebendo")
						SetTimeout(30000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, 10)
							vRPclient.playScreenEffect(source,"RaceTurbo",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFight",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightIn",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",20)
							vRPclient.playScreenEffect(source,"DrugsDrivingIn",20)
							vRPclient.playScreenEffect(source,"DrugsDrivingOut",20)
							vRPclient.playScreenEffect(source,"MP_corona_switch",20)
							vRPclient.playScreenEffect(source,"SniperOverlay",20)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Cerveja utilizada com sucesso.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "tequila" then
					if vRP.tryGetInventoryItem(user_id,"tequila",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						TriggerClientEvent('cancelando',source,true)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_tequila_bottle",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'bebendo',0.5)
						TriggerClientEvent("progress",source,30000,"bebendo")
						SetTimeout(30000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, 20)
							vRPclient.playScreenEffect(source,"RaceTurbo",40)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFight",40)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightIn",40)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",40)
							vRPclient.playScreenEffect(source,"DrugsDrivingIn",40)
							vRPclient.playScreenEffect(source,"DrugsDrivingOut",40)
							vRPclient.playScreenEffect(source,"MP_corona_switch",40)
							vRPclient.playScreenEffect(source,"SniperOverlay",40)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Tequila utilizada com sucesso.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "vodka" then
					if vRP.tryGetInventoryItem(user_id,"vodka",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						TriggerClientEvent('cancelando',source,true)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'bebendo',0.5)
						TriggerClientEvent("progress",source,30000,"bebendo")
						SetTimeout(30000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, 10)
							vRPclient.playScreenEffect(source,"RaceTurbo",30)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFight",30)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightIn",30)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",30)
							vRPclient.playScreenEffect(source,"DrugsDrivingIn",30)
							vRPclient.playScreenEffect(source,"DrugsDrivingOut",30)
							vRPclient.playScreenEffect(source,"MP_corona_switch",30)
							vRPclient.playScreenEffect(source,"SniperOverlay",30)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Vodka utilizada com sucesso.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "whisky" then
					if vRP.tryGetInventoryItem(user_id,"whisky",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						TriggerClientEvent('cancelando',source,true)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'bebendo',0.5)
						TriggerClientEvent("progress",source,30000,"bebendo")
						SetTimeout(30000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, 10)
							vRPclient.playScreenEffect(source,"RaceTurbo",110)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFight",110)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightIn",110)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",110)
							vRPclient.playScreenEffect(source,"DrugsDrivingIn",110)
							vRPclient.playScreenEffect(source,"DrugsDrivingOut",110)
							vRPclient.playScreenEffect(source,"MP_corona_switch",110)
							vRPclient.playScreenEffect(source,"SniperOverlay",110)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Whisky utilizado com sucesso.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "conhaque" then
					if vRP.tryGetInventoryItem(user_id,"conhaque",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						TriggerClientEvent('cancelando',source,true)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_logopen",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'bebendo',0.5)
						TriggerClientEvent("progress",source,30000,"bebendo")
						SetTimeout(30000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, 10)
							vRPclient.playScreenEffect(source,"RaceTurbo",90)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFight",90)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightIn",90)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",90)
							vRPclient.playScreenEffect(source,"DrugsDrivingIn",90)
							vRPclient.playScreenEffect(source,"DrugsDrivingOut",90)
							vRPclient.playScreenEffect(source,"MP_corona_switch",90)
							vRPclient.playScreenEffect(source,"SniperOverlay",90)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Conhaque utilizado com sucesso.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "absinto" then
					if vRP.tryGetInventoryItem(user_id,"absinto",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						TriggerClientEvent('cancelando',source,true)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'bebendo',0.5)
						TriggerClientEvent("progress",source,30000,"bebendo")
						SetTimeout(30000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, 30)
							vRPclient.playScreenEffect(source,"RaceTurbo",80)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFight",80)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightIn",80)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",80)
							vRPclient.playScreenEffect(source,"DrugsDrivingIn",80)
							vRPclient.playScreenEffect(source,"DrugsDrivingOut",80)
							vRPclient.playScreenEffect(source,"MP_corona_switch",80)
							vRPclient.playScreenEffect(source,"SniperOverlay",80)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Absinto utilizado com sucesso.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------				
				elseif itemName == "dorflex" or itemName == "anador" or itemName == "buscopan" or itemName == "cicatricure" or itemName == "dipirona" or itemName == "paracetamol" or itemName == "novalgina" or itemName == "navagina" or itemName == "glicose" or itemName == "advil" then
					if (vRP.tryGetInventoryItem(user_id,"dorflex",1) or vRP.tryGetInventoryItem(user_id,"anador",1) or vRP.tryGetInventoryItem(user_id,"buscopan",1) or vRP.tryGetInventoryItem(user_id,"cicatricure",1) or vRP.tryGetInventoryItem(user_id,"dipirona",1) or vRP.tryGetInventoryItem(user_id,"paracetamol",1) or vRP.tryGetInventoryItem(user_id,"novalgina",1) or vRP.tryGetInventoryItem(user_id,"glicose",1) or vRP.tryGetInventoryItem(user_id,"advil",1)) then
						TriggerClientEvent('inventory:Update',source,'updateMochila')
						vRPclient._playAnim(source,true,{{"mp_player_intdrink","loop_bottle"}},true)	
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("progress",source,5000,"remedio")
						SetTimeout(5000,function()
							vRPclient._stopAnim(source,false)
							TriggerClientEvent('cancelando',source,false)
							TriggerClientEvent("Notify",source,"sucesso","Remédio utilizado com sucesso.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end	
				elseif itemName == "mochila" then
					if vRP.tryGetInventoryItem(user_id,"mochila",1) then
						TriggerClientEvent('inventory:Update',source,'updateMochila')
						vRP.varyExp(user_id,"physical","strength",650)
						TriggerClientEvent("Notify",source,"sucesso","Mochila utilizada com sucesso.",8000)
						SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
					end
				elseif itemName == "maconha" then
				if vRP.getInventoryItemAmount(user_id,"isqueiro") <= 0 then
								TriggerClientEvent("Notify",source,"aviso","Você não tem um isqueiro.",5000)
								return
							end
					if vRP.tryGetInventoryItem(user_id,"maconha",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
						TriggerClientEvent("progress",source,10000,"Usando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRPclient._DeletarObjeto(source)
							vRP.varyHunger(user_id, 35)
							TriggerClientEvent("DoAcid",source,30000)
							TriggerClientEvent("Notify",source,"sucesso","Maconha utilizada com sucesso.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
	---------------------------------------------------------------------------------------------
	------------------------                  -[CIGARROS]-                 ----------------------
	---------------------------------------------------------------------------------------------
				elseif itemName == "gudang" then
				if vRP.getInventoryItemAmount(user_id,"isqueiro") <= 0 then
								TriggerClientEvent("Notify",source,"aviso","Você não tem um isqueiro.",5000)
								return
							end
					if vRP.tryGetInventoryItem(user_id,"gudang",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"amb@world_human_aa_smoke@male@idle_a","idle_a","prop_cs_ciggy_01",49,28422)
						TriggerClientEvent("progress",source,10000,"Fumando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, 20)
							vRPclient._stopAnim(source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFight",20)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Voce fumou um gudang.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
	---------------------------------------------------------------------------------------------
				elseif itemName == "derby" then
				if vRP.getInventoryItemAmount(user_id,"isqueiro") <= 0 then
								TriggerClientEvent("Notify",source,"aviso","Você não tem um isqueiro.",5000)
								return
							end
					if vRP.tryGetInventoryItem(user_id,"derby",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"amb@world_human_aa_smoke@male@idle_a","idle_a","prop_cs_ciggy_01",49,28422)
						TriggerClientEvent("progress",source,10000,"Fumando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, 20)
							vRPclient._stopAnim(source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",20)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Voce fumou um derby.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
	---------------------------------------------------------------------------------------------
				elseif itemName == "malboro" then
				if vRP.getInventoryItemAmount(user_id,"isqueiro") <= 0 then
								TriggerClientEvent("Notify",source,"aviso","Você não tem um isqueiro.",5000)
								return
							end
					if vRP.tryGetInventoryItem(user_id,"malboro",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_cs_ciggy_01",49,28422)
						TriggerClientEvent("progress",source,10000,"Fumando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, 10)
							vRPclient._stopAnim(source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",20)
							vRPclient.playScreenEffect(source,"DrugsDrivingIn",20)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Voce fumou um malboro.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
	---------------------------------------------------------------------------------------------
				elseif itemName == "black" then
				if vRP.getInventoryItemAmount(user_id,"isqueiro") <= 0 then
								TriggerClientEvent("Notify",source,"aviso","Você não tem um isqueiro.",5000)
								return
							end
					if vRP.tryGetInventoryItem(user_id,"black",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"amb@world_human_aa_smoke@male@idle_a","idle_a","prop_cs_ciggy_01",49,28422)
						TriggerClientEvent("progress",source,10000,"Fumando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, 25)
							vRPclient._stopAnim(source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFight",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightIn",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",20)
							vRPclient.playScreenEffect(source,"DrugsDrivingIn",20)
							vRPclient.playScreenEffect(source,"DrugsDrivingOut",20)
							vRPclient.playScreenEffect(source,"MP_corona_switch",20)
							vRPclient.playScreenEffect(source,"SniperOverlay",20)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Voce fumou um black.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
	---------------------------------------------------------------------------------------------
				elseif itemName == "luckystrike" then
				if vRP.getInventoryItemAmount(user_id,"isqueiro") <= 0 then
								TriggerClientEvent("Notify",source,"aviso","Você não tem um isqueiro.",5000)
								return
							end
					if vRP.tryGetInventoryItem(user_id,"luckystrike",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"amb@world_human_aa_smoke@male@idle_a","idle_a","prop_cs_ciggy_01",49,28422)
						TriggerClientEvent("progress",source,10000,"Fumando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, 10)
							vRPclient._stopAnim(source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",20)
							vRPclient.playScreenEffect(source,"DrugsDrivingOut",20)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Voce fumou um lucky strike.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
	---------------------------------------------------------------------------------------------
				elseif itemName == "eight" then
				if vRP.getInventoryItemAmount(user_id,"isqueiro") <= 0 then
								TriggerClientEvent("Notify",source,"aviso","Você não tem um isqueiro.",5000)
								return
							end
					if vRP.tryGetInventoryItem(user_id,"eight",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"amb@world_human_aa_smoke@male@idle_a","idle_a","prop_cs_ciggy_01",49,28422)
						TriggerClientEvent("progress",source,10000,"Fumando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRP.varyThirst(user_id, 10)
							vRPclient._DeletarObjeto(source)
							vRPclient._stopAnim(source,false)
							TriggerClientEvent("Notify",source,"sucesso","Voce fumou um eight.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
	---------------------------------------------------------------------------------------------
	-------------------------------------[REMEDIOS]----------------------------------------------
	---------------------------------------------------------------------------------------------
				elseif itemName == "anestesia" then
					if vRP.tryGetInventoryItem(user_id,"anestesia",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"mp_player_intdrink","loop_bottle","ng_proc_drug01a002",49,60309)
						TriggerClientEvent("progress",source,10000,"Tomando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",20)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Voce tomou uma anestesia.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "dorflex" then
					if vRP.tryGetInventoryItem(user_id,"dorflex",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"mp_player_intdrink","loop_bottle","ng_proc_drug01a002",49,60309)
						TriggerClientEvent("progress",source,10000,"Tomando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",20)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Voce tomou uma dorflex.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "cicatricure" then
					if vRP.tryGetInventoryItem(user_id,"cicatricure",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"mp_player_intdrink","loop_bottle","ng_proc_drug01a002",49,60309)
						TriggerClientEvent("progress",source,10000,"Tomando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",20)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Voce tomou uma cicatricure.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end				
				elseif itemName == "dipiroca" then
					if vRP.tryGetInventoryItem(user_id,"dipiroca",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"mp_player_intdrink","loop_bottle","ng_proc_drug01a002",49,60309)
						TriggerClientEvent("progress",source,10000,"Tomando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",20)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Voce tomou uma dipiroca.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "nocucedin" then
					if vRP.tryGetInventoryItem(user_id,"nocucedin",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"mp_player_intdrink","loop_bottle","ng_proc_drug01a002",49,60309)
						TriggerClientEvent("progress",source,10000,"Tomando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",20)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Voce tomou uma nocucedin.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "paracetanal" then
					if vRP.tryGetInventoryItem(user_id,"paracetanal",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"mp_player_intdrink","loop_bottle","ng_proc_drug01a002",49,60309)
						TriggerClientEvent("progress",source,10000,"Tomando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRPclient.playScreenEffect(source,"RaceTurbo",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",20)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Voce tomou uma paracetanal.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "cocaina" then
					if vRP.tryGetInventoryItem(user_id,"cocaina",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._playAnim(source,true,{{"anim@mp_player_intuppernose_pick","idle_a"}},true)
						TriggerClientEvent("progress",source,10000,"Usando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRPclient._stopAnim(source,false)
							vRP.varyHunger(user_id, 20)
							vRP.varyThirst(user_id, 10)
							TriggerClientEvent("DoAcid",source,30000)
							TriggerClientEvent("Notify",source,"sucesso","Cocaína utilizada com sucesso.",8000)
						end)
						 SetTimeout(120000,function()
							TriggerClientEvent('energeticos',source,false)
							TriggerClientEvent("Notify",source,"aviso","O efeito da cocaína passou e o coração voltou a bater normalmente.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "lancaperfume" then
					if vRP.tryGetInventoryItem(user_id,"lancaperfume",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@coffee@male@idle_a","idle_a","prop_ecola_can",49,28422)
						TriggerClientEvent("progress",source,10000,"Usando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRP.varyHunger(user_id, 10)
							vRP.varyThirst(user_id, 25)
							vRPclient._stopAnim(source,false)
							TriggerClientEvent("DoAcid",source,30000)
							vRPclient._DeletarObjeto(source)
							TriggerEvent("vrp_inventory:Cancel")
							TriggerClientEvent("Notify",source,"sucesso","Lanca Perfume utilizada com sucesso.",8000)
						end)
						 SetTimeout(120000,function()
							TriggerClientEvent('energeticos',source,false)
							TriggerClientEvent("Notify",source,"aviso","O efeito da Lanca Perfume passou e o coração voltou a bater normalmente.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "metanfetamina" then
					if vRP.tryGetInventoryItem(user_id,"metanfetamina",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._playAnim(source,true,{{"anim@mp_player_intuppernose_pick","idle_a"}},true)
						TriggerClientEvent("progress",source,10000,"Usando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRP.varyHunger(user_id, 10)
							vRP.varyThirst(user_id, 25)
							vRPclient._stopAnim(source,false)
							TriggerClientEvent('energeticos',source,true)
							TriggerClientEvent("DoAcid",source,30000)
							TriggerClientEvent("Notify",source,"sucesso","Metanfetamina utilizada com sucesso.",8000)
						end)
						 SetTimeout(120000,function()
							TriggerClientEvent('energeticos',source,false)
							TriggerClientEvent("Notify",source,"aviso","O efeito da Metanfetamina passou e o coração voltou a bater normalmente.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "lsd" then
					if vRP.tryGetInventoryItem(user_id,"lsd",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._playAnim(source,true,{{"anim@mp_player_intuppernose_pick","idle_a"}},true)
						TriggerClientEvent("progress",source,10000,"Usando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRP.varyHunger(user_id, 10)
							vRP.varyThirst(user_id, 25)
							vRPclient._stopAnim(source,false)
							TriggerClientEvent("DoAcid",source,30000)
							TriggerClientEvent("Notify",source,"sucesso","Lsd utilizada com sucesso.",8000)
						end)
						 SetTimeout(120000,function()
							TriggerClientEvent('energeticos',source,false)
							TriggerClientEvent("Notify",source,"aviso","O efeito do LSD passou e o coração voltou a bater normalmente.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end	
				elseif itemName == "rebite" then
					if vRP.tryGetInventoryItem(user_id,"rebite",1) then
						actived[user_id] = true
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						TriggerClientEvent('cancelando',source,true)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
						TriggerClientEvent("progress",source,5000,"bebendo")
						SetTimeout(5000,function()
							actived[user_id] = nil
							vRPclient.playScreenEffect(source,"RaceTurbo",90)
							vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",90)
							TriggerClientEvent('energeticos',source,true)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Rebite utilizado com sucesso.",8000)
						end)
						SetTimeout(90000,function()
							TriggerClientEvent('energeticos',source,false)
							TriggerClientEvent("Notify",source,"aviso","O efeito do rebite passou e o coração voltou a bater normalmente.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "capuz" then
					if vRP.getInventoryItemAmount(user_id,"capuz") >= 1 then
						local nplayer = vRPclient.getNearestPlayer(source,2)
						if nplayer then
							vRPclient.setCapuz(nplayer)
							vRP.closeMenu(nplayer)
							TriggerClientEvent("Notify",source,"sucesso","Capuz utilizado com sucesso.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end
					end	
				elseif itemName == "Anestesia" then
					if vRP.tryGetInventoryItem(user_id,"anestesia",1) then
						actived[user_id] = true
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._playAnim(source,true,{{"anim@mp_player_intuppernose_pick","idle_a"}},true)
						TriggerClientEvent("progress",source,10000,"Tomando...")
						SetTimeout(10000,function()
							actived[user_id] = nil
							vRP.varyHunger(user_id, 10)
							vRP.varyThirst(user_id, 10)
							vRPclient._stopAnim(source,false)
							TriggerClientEvent('energeticos',source,true)
							vRPclient.playScreenEffect(source,"RaceTurbo",20)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFight",50)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightIn",50)
							vRPclient.playScreenEffect(source,"DrugsMichaelAliensFightOut",50)
							vRPclient.playScreenEffect(source,"DrugsDrivingIn",50)
							vRPclient.playScreenEffect(source,"DrugsDrivingOut",50)
							vRPclient.playScreenEffect(source,"MP_corona_switch",50)
							vRPclient.playScreenEffect(source,"SniperOverlay",50)
							TriggerClientEvent("Notify",source,"sucesso","Anestesia utilizada com sucesso.",8000)
						end)
						 SetTimeout(120000,function()
							TriggerClientEvent('energeticos',source,false)
							TriggerClientEvent("Notify",source,"aviso","O efeito da Anestesia passou e o coração voltou a bater normalmente.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "energetico" then
					if vRP.tryGetInventoryItem(user_id,"energetico",1) then
						actived[user_id] = true
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("vrp_inventory:fechar",source)
						vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
						TriggerClientEvent("vrp_sound:source",source,'bebendo',0.5)
						TriggerClientEvent("progress",source,5000,"bebendo")
						SetTimeout(5000,function()
							actived[user_id] = nil
							vthirst = -20
							TriggerClientEvent('energeticos',source,true)
							TriggerClientEvent('cancelando',source,false)
							vRPclient._DeletarObjeto(source)
							TriggerClientEvent("Notify",source,"sucesso","Energético utilizado com sucesso.",8000)
						end)
						SetTimeout(60000,function()
							TriggerClientEvent('energeticos',source,false)
							TriggerClientEvent("Notify",source,"aviso","O efeito do energético passou e o coração voltou a bater normalmente.",8000)
							SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
						end)
					end
				elseif itemName == "lockpick" then
					local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
					local policia = vRP.getUsersByPermission("policias.permissao")
					TriggerClientEvent("vrp_inventory:fechar",source)
					SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
					if #policia < 0 then
						TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento para iniciar o roubo.")
						return true
					end
					if vRP.hasPermission(user_id,"policias.permissao") then
						TriggerEvent("setPlateEveryone",placa)
						vGARAGE.vehicleClientLock(-1,vnetid,lock)
						TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
						return
					end
					if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 and vRP.tryGetInventoryItem(user_id,"lockpick",1) and vehicle then
						actived[user_id] = true
						if vRP.hasPermission(user_id,"policias.permissao") then
							actived[user_id] = nil
							TriggerEvent("setPlateEveryone",placa)
							vGARAGE.vehicleClientLock(-1,vnetid,lock)
							return
						end

						TriggerClientEvent('cancelando',source,true)
						vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
						TriggerClientEvent("progress",source,40000,"roubando")
						SetTimeout(40000,function()
							actived[user_id] = nil
							TriggerClientEvent('cancelando',source,false)
							vRPclient._stopAnim(source,false)

							if math.random(100) >= 50 then
								TriggerEvent("setPlateEveryone",placa)
								vGARAGE.vehicleClientLock(-1,vnetid,lock)
								TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
								vRP.searchTimer(user_id,180)
							else
								vRP.searchTimer(user_id,180)
								TriggerClientEvent("Notify",source,"negado","Roubo do veículo falhou e as autoridades foram acionadas.",8000)
								local policia = vRP.getUsersByPermission("policias.permissao")
								local x,y,z = vRPclient.getPosition(source)
								for k,v in pairs(policia) do
									local player = vRP.getUserSource(parseInt(v))
									if player then
										async(function()
											local id = idgens:gen()
											vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
											TriggerClientEvent("NotifyPush",player,{ code = 'SOUL', title = "Ocorrência em andamento", x = x, y = y, z = z, badge = "Roubo na "..street.." do veículo "..model.." de placa "..placa.." verifique o ocorrido." })
											pick[id] = vRPclient.addBlip(player,x,y,z,10,5,"Ocorrência",0.5,false)
											SetTimeout(20000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
										end)
									end
								end
							end
						end)
					end
				elseif itemName == "placa" then
					if vRPclient.GetVehicleSeat(source) then
						if vRP.tryGetInventoryItem(user_id,"placa",1) then
							local placa = vRP.generatePlate()
							TriggerClientEvent("vrp_inventory:fechar",source)
							TriggerClientEvent('cancelando',source,true)
							TriggerClientEvent("vehicleanchor",source)
							TriggerClientEvent("progress",source,59500,"clonando")
							SetTimeout(60000,function()
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent("cloneplates",source,placa)
								TriggerClientEvent("Notify",source,"sucesso","Placa clonada com sucesso.",8000)
							end)
						end
					end
				elseif itemName == "masterpick" then
					local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
					local policia = vRP.getUsersByPermission("policias.permissao")
					TriggerClientEvent("vrp_inventory:fechar",source)
					SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
					if #policia < 2 then
						TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento para iniciar o roubo, mínimo 2.")
						return true
					end
					if vRP.hasPermission(user_id,"policias.permissao") then
						TriggerEvent("setPlateEveryone",placa)
						vGARAGE.vehicleClientLock(-1,vnetid,lock)
						TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
						return
					end
					if vRP.getInventoryItemAmount(user_id,"masterpick") >= 1 and vRP.tryGetInventoryItem(user_id,"masterpick",1) and vehicle then
						actived[user_id] = true
						if vRP.hasPermission(user_id,"policias.permissao") then
							actived[user_id] = nil
							TriggerEvent("setPlateEveryone",placa)
							vGARAGE.vehicleClientLock(-1,vnetid,lock)
							return
						end

						TriggerClientEvent('cancelando',source,true)
						vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
						TriggerClientEvent("progress",source,60000,"roubando")
						SetTimeout(60000,function()
							actived[user_id] = nil
							TriggerClientEvent('cancelando',source,false)
							vRPclient._stopAnim(source,false)

							if math.random(100) >= 20 then
								TriggerEvent("setPlateEveryone",placa)
								vGARAGE.vehicleClientLock(-1,vnetid,lock)
								TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
								vRP.searchTimer(user_id,180)
							else
								vRP.searchTimer(user_id,180)
								TriggerClientEvent("Notify",source,"negado","Roubo do veículo falhou e as autoridades foram acionadas.",8000)
								local policia = vRP.getUsersByPermission("policias.permissao")
								local x,y,z = vRPclient.getPosition(source)
								for k,v in pairs(policia) do
									local player = vRP.getUserSource(parseInt(v))
									if player then
										async(function()
											local id = idgens:gen()
											vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
											TriggerClientEvent("NotifyPush",player,{ code = 'SOUL', title = "Ocorrência em andamento", x = x, y = y, z = z, badge = "Roubo na "..street.." do veículo "..model.." de placa "..placa.." verifique o ocorrido." })
											pick[id] = vRPclient.addBlip(player,x,y,z,10,5,"Ocorrência",0.5,false)
											SetTimeout(20000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
											SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
										end)
									end
								end
							end
						end)
					end
				elseif itemName == "militec" then
					if not vRPclient.isInVehicle(source) then
						local vehicle = vRPclient.getNearestVehicle(source,3.5)
						if vehicle then
							if vRP.hasPermission(user_id,"mecanico.permissao") then
								actived[user_id] = true
								TriggerClientEvent('cancelando',source,true)
								TriggerClientEvent('arrumarcarromotor', source)
								TriggerClientEvent("vrp_inventory:fechar",source)
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								vRPclient._stopAnim(source,false)
								SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
							else
								if vRP.tryGetInventoryItem(user_id,"militec",1) then
									actived[user_id] = true
									TriggerClientEvent('Creative:Update',source,'updateMochila')
									TriggerClientEvent('cancelando',source,true)
									TriggerClientEvent('arrumarcarromotor', source)
									TriggerClientEvent("vrp_inventory:fechar",source)
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									vRPclient._stopAnim(source,false)
									SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
								end
							end
						end
					end	
				elseif itemName == "repairkit" then
					if not vRPclient.isInVehicle(source) then
						local vehicle = vRPclient.getNearestVehicle(source,3.5)
						if vehicle then
							if vRP.hasPermission(user_id,"mecanico.permissao") then
								actived[user_id] = true
								TriggerClientEvent('cancelando',source,true)
								TriggerClientEvent('arrumarcarrointeiro', source)
								TriggerClientEvent("vrp_inventory:fechar",source)
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								vRPclient._stopAnim(source,false)
								SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
							else
								if vRP.tryGetInventoryItem(user_id,"repairkit",1) then
									actived[user_id] = true
									TriggerClientEvent('Creative:Update',source,'updateMochila')
									TriggerClientEvent('cancelando',source,true)
									TriggerClientEvent('arrumarcarrointeiro', source)
									TriggerClientEvent("vrp_inventory:fechar",source)
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									vRPclient._stopAnim(source,false)
									SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
								end
							end
						end
					end
				elseif itemName == "pneu" then
					if not vRPclient.isInVehicle(source) then
						local vehicle = vRPclient.getNearestVehicle(source,3)
						if vehicle then
							if vRP.hasPermission(user_id,"mecanico.permissao") then
								actived[user_id] = true
								TriggerClientEvent('cancelando',source,true)
								TriggerClientEvent('arrumarpneuteste', source)
								TriggerClientEvent("vrp_inventory:fechar",source)
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
								SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
							else
								if vRP.tryGetInventoryItem(user_id,"pneu",1) then
									actived[user_id] = true
									TriggerClientEvent('Creative:Update',source,'updateMochila')
									TriggerClientEvent('cancelando',source,true)
									TriggerClientEvent('arrumarpneuteste', source)
									TriggerClientEvent("vrp_inventory:fechar",source)
										actived[user_id] = nil
										TriggerClientEvent('cancelando',source,false)
										end
									SendWebhookMessage(webhookusar,"\n**Registro de Inventário** \n\n**Informações**: \n**Player ID que usou**: ` "..user_id.." ` \n**Item**: ` "..vRP.itemNameList(itemName).." ` \n\n------------------------------------\r")
									end
								end
							end
						end
			elseif type == "equipar" then
				if vRP.tryGetInventoryItem(user_id,itemName,1) then
					local weapons = {}
					local identity = vRP.getUserIdentity(user_id)
					weapons[string.gsub(itemName,"wbody|","")] = { ammo = 0 }
					vRPclient._giveWeapons(source,weapons)
					PerformHttpRequest(webhookequipar, function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{ 
								title = "REGISTRO DE INVENTARIO",
								thumbnail = {
								}, 
								fields = {
									{ 
										name = "**EQUIPOU:**", 
										value = "` ["..vRP.itemNameList(itemName).."] `"
									},
									{ 
										name = "**QUEM EQUIPOU:**", 
										value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `"
									}
								}, 
								footer = { 
									text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
								},
								color = 00000000 
							}
						}
					}), { ['Content-Type'] = 'application/json' })
					TriggerClientEvent('inventory:Update',source,'updateMochila')
				end
			elseif type == "recarregar" then
				local uweapons = vRPclient.getWeapons(source)
				local weaponuse = string.gsub(itemName,"wammo|","")
				local weaponusename = "wammo|"..weaponuse
				local identity = vRP.getUserIdentity(user_id)
				if uweapons[weaponuse] then
				  local itemAmount = 0
				  local data = vRP.getUserDataTable(user_id)
				  for k,v in pairs(data.inventory) do
					if weaponusename == k then
						if v.amount > 250 then
							v.amount = 250
					  	end
		  
					  itemAmount = v.amount
		  
						if vRP.tryGetInventoryItem(user_id, weaponusename, parseInt(v.amount)) then
							local weapons = {}
							weapons[weaponuse] = { ammo = v.amount }
							itemAmount = v.amount
							vRPclient._giveWeapons(source,weapons,false)
							TriggerClientEvent('inventory:Update',source,'updateMochila')
						end
					end
				end
			end
		end
	end
end