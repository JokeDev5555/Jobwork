--===========================================================================================================================
--=============================================== ZC - Devloper Team ========================================================
--======================================= https://discord.gg/dK3D7TCRCM =====================================================
--====================================แบ่งปันสคริป รับงานคัสตอม โมดิฟาย หลังบ้าน เขียนสคริป ลดหน่วง===================================
--===================================================มีทีมงานซัพพอร์ต===========================================================
--===========================================================================================================================

local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118,
    ["Enter"] = 191
}

local obg1 = 0
local Pop1 = {}
local IsPickingUp, IsProcessing, IsOpenMenu = false, false, false

ESX = nil

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
        Citizen.Wait(5000)
    end
)

function GenerateCoords(Zone)
    while true do
        Citizen.Wait(7)
        --
        local CoordX, CoordY
        --
        math.randomseed(GetGameTimer())
        local modX = math.random(-20, 20)
        --
        Citizen.Wait(100)
        --
        math.randomseed(GetGameTimer())
        local modY = math.random(-20, 20)
        --
        CoordX = Zone.x + modX
        CoordY = Zone.y + modY
        --
        local coordZ = GetCoordZ(CoordX, CoordY)
        local coord = vector3(CoordX, CoordY, coordZ)
        --
        if ValidateObjectCoord(coord) then
            return coord
        end
    end
end

function GenerateCrabCoords()
    while true do
        Citizen.Wait(7)
        --
        local crabCoordX, crabCoordY
        --
        math.randomseed(GetGameTimer())
        local modX = math.random(Config["spawnrandomX"][1], Config["spawnrandomX"][2])
        --
        Citizen.Wait(100)
        --
        math.randomseed(GetGameTimer())
        local modY = math.random(Config["spawnrandomY"][1], Config["spawnrandomY"][2])
        --
        crabCoordX = Config.Zone.Pos.x + modX
        crabCoordY = Config.Zone.Pos.y + modY
        --
        local coordZ = GetCoordZ(crabCoordX, crabCoordY)
        local coord = vector3(crabCoordX, crabCoordY, coordZ)
        --
        if ValidateObjectCoord(coord) then
            return coord
        end
    end
end

function GetCoordZ(x, y)
    local groundCheckHeights = Config.grandZ
    --
    for i, height in ipairs(groundCheckHeights) do
        local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
        --
        if foundGround then
            return z
        end
    end
    return 41.33
end

function ValidateObjectCoord(plantCoord)
    if obg1 > 0 then
        local validate = true
        --
        for k, v in pairs(Pop1) do
            if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
                validate = false
            end
        end
        --
        if GetDistanceBetweenCoords(plantCoord, Config.Zone.Pos.x, Config.Zone.Pos.y, Config.Zone.Pos.z, false) > 20 then
            validate = false
        end
        --
        return validate
    else
        return true
    end
end

function SpawnObjects()
    while obg1 < Config.spawnobj do
        Citizen.Wait(7)
        local CrabCoords = GenerateCrabCoords()
        --
        local Listobg1 = {
            {Name = Config.object},
            {Name = Config.object}
        }
        --
        local random_obg1 = math.random(#Listobg1)
        --
        ESX.Game.SpawnLocalObject(
            Listobg1[random_obg1].Name,
            CrabCoords,
            function(object)
                PlaceObjectOnGroundProperly(object)
                FreezeEntityPosition(object, true)
                --
                table.insert(Pop1, object)
                obg1 = obg1 + 1
            end
        )
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(10)
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            --
            if
                GetDistanceBetweenCoords(PlayerCoords, Config.Zone.Pos.x, Config.Zone.Pos.y, Config.Zone.Pos.z, true) <
                    50
             then
                SpawnObjects()
                Citizen.Wait(500)
            else
                Citizen.Wait(500)
            end
        end
    end
)

-- function checkHasItem(item_name)
--     local inventory = ESX.GetPlayerData().inventory
--     for i = 1, #inventory do
--         local item = inventory[i]
--         if item_name == item.name and item.count > 0 then
--             canuse = true
--             return true
--         end
--     end
--     if Config.Useitem then
--         TriggerEvent(
--             "pNotify:SendNotification",
--             {
--                 text = Config.Noitemwork,
--                 type = "error",
--                 timeout = (3000),
--                 layout = "bottomCenter",
--                 queue = "global"
--             }
--         )
--     end
--     canuse = false

--     return false
-- end

Citizen.CreateThread(
    function()
        --
        local Config1 = Config.Zone
        local blip1 = AddBlipForCoord(Config1.Pos.x, Config1.Pos.y, Config1.Pos.z)
        --
        SetBlipSprite(blip1, Config1.Blips.Id)
        SetBlipDisplay(blip1, 4)
        SetBlipScale(blip1, Config1.Blips.Size)
        SetBlipColour(blip1, Config1.Blips.Color)
        SetBlipAsShortRange(blip1, true)
        --
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config1.Blips.Text)
        EndTextCommandSetBlipName(blip1)
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(7)
            --
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local nearbyObject, nearbyID
            local x = math.random(1, Config.deleteobject)
            --
            for i = 1, #Pop1, 1 do
                if GetDistanceBetweenCoords(coords, GetEntityCoords(Pop1[i]), false) < Config.radarpick then
                    nearbyObject, nearbyID = Pop1[i], i
                end
            end

            if nearbyObject and IsPedOnFoot(playerPed) then
                --
                
                   
                    
                        FreezeEntityPosition(playerPed, true)
                        --
                        prophand()
                        RachYO()

                        TriggerEvent(
                            Config.loading,
                            {
                                name = "unique_action_name",
                                duration = Config.timepick * 1000,
                                label = Config.textdoing,
                                useWhileDead = false,
                                canCancel = false,
                                controlDisables = {
                                    disableMovement = false,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true
                                }
                            },
                            function(status)
                                if not status then
                                --
                                end
                            end
                        )

                        if Config.playsound then
                            TriggerServerEvent("Militia_Joboilone", 10, Config.sound, 0.7)
                        end
                        Wait(Config.timepick * 1000)

                        ClearPedTasks(playerPed)
                        if x == 1 then
                            ESX.Game.DeleteObject(nearbyObject)
                            table.remove(Pop1, nearbyID)
                            obg1 = obg1 - 1
                        end
                        FreezeEntityPosition(playerPed, false)

                        local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
                        local object =
                            GetClosestObjectOfType(
                            position.x,
                            position.y,
                            position.z,
                            15.0,
                            GetHashKey(Config.prophand),
                            false,
                            false,
                            false
                        )
                        if object ~= 0 then
                            DeleteObject(object)
                        end
                        --
                        Wait(100)
                     
                        TriggerServerEvent(Config.ServerEventname)
                        canuse = false
                    
              
            else
                Citizen.Wait(500)
            end
        end
    end
)

function RachYO()
    RequestAnimDict(Config.Animation1)
    while (not HasAnimDictLoaded(Config.Animation1)) do
        Citizen.Wait(7)
    end
    Wait(100)
    TaskPlayAnim(GetPlayerPed(-1), Config.Animation1, Config.Animation2, 2.0, -2.0, -1, 1, 0, false, false, false)
end

function deleteobject()
    --
    local nearbyObject, nearbyID
    local x = math.random(1, 2)
    --
    if x == 2 then
        ESX.Game.DeleteObject(nearbyObject)
        table.remove(Pop1, nearbyID)
        obg1 = obg1 - 1
    end
end

AddEventHandler(
    "onResourceStop",
    function(resource)
        if resource == GetCurrentResourceName() then
            for k, v in pairs(Pop1) do
                ESX.Game.DeleteObject(v)
            end
        end
    end
)

RegisterFontFile("font4thai")
fontId = RegisterFontId("font4thai")

Draw3DText = function(coords, text, scale)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(fontId)
        SetTextProportional(0)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x, y)
        local factor = (string.len(text)) / Config.Textz.notz.long -- ลด-กว้าง / เพิ่ม-แคบ
        DrawRect(x, y + 0.0125, 0.015 + factor, Config.Textz.notz.big, 0, 0, 0, Config.Textz.notz.K)
    end
end

RegisterNetEvent("Militia_Joboilone_a")
AddEventHandler(
    "Militia_Joboilone_a",
    function(playerNetId, maxDistance, soundFile, soundVolume)
        local lCoords = GetEntityCoords(GetPlayerPed(-1))
        local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
        local distIs = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
        if (distIs <= maxDistance) then
            SendNUIMessage(
                {
                    transactionType = "playSound",
                    transactionFile = soundFile,
                    transactionVolume = soundVolume
                }
            )
        end
    end
)

function DeteHan()
    local ped = GetPlayerPed(-1)
    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local object =
        GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(Config.prop), false, false, false)
    if object ~= 0 then
        DeleteObject(object)
    end
end

function GiveHand()
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local prop = CreateObject(GetHashKey(Config.prop), x, y, z + 0.2, true, true, true)
    local boneIndex = GetPedBoneIndex(ped, 57005)

    AttachEntityToEntity(prop, ped, boneIndex, 0.16, 0.00, 0.00, 410.0, 20.00, 140.0, true, true, false, true, 1, true)
end

function prophand()
    local ped = GetPlayerPed(-1)
    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local object =
        GetClosestObjectOfType(
        position.x,
        position.y,
        position.z,
        15.0,
        GetHashKey(Config.prophand),
        false,
        false,
        false
    )
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local prop = CreateObject(GetHashKey(Config.prophand), x, y, z + 0.2, true, true, true)
    local boneIndex = GetPedBoneIndex(ped, 57005)
    AttachEntityToEntity(prop, ped, boneIndex, 0.16, 0.00, 0.00, 410.0, 20.00, 140.0, true, true, false, true, 1, true)
end

Citizen.CreateThread(
    function()
        while true do
            ZC2 = Config.loop
            Citizen.Wait(ZC2)
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local nearbyObject, nearbyID
            --
            for i = 1, #Pop1, 1 do
                if GetDistanceBetweenCoords(coords, GetEntityCoords(Pop1[i]), false) < Config.radarpick then
                    ZC2 = 69.40
                    nearbyObject, nearbyID = Pop1[i], i
                    if nearbyObject and IsPedOnFoot(playerPed) then
                        if not isPickingUp then
                            DisplayHelpText(Config.textpickup)
                        end
                    end
                end
            end
        end
    end
)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end