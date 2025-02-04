--[[
  ____              _                 _                       
 | __ )  __ _ _   _| | ___  _ __ __ _(_)                      
 |  _ \ / _` | | | | |/ _ \| '__/ _` | |                      
 | |_) | (_| | |_| | | (_) | | | (_| | |                      
 |____/ \__,_|\__, |_|\___/|_|  \__,_|_|                  _   
 |  _ \  _____|___/___| | ___  _ __  _ __ ___   ___ _ __ | |_ 
 | | | |/ _ \ \ / / _ \ |/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __|
 | |_| |  __/\ V /  __/ | (_) | |_) | | | | | |  __/ | | | |_ 
 |____/ \___| \_/ \___|_|\___/| .__/|_| |_| |_|\___|_| |_|\__|
                              |_|                             
--]] 
Config = {}
Config.InventorySystem = 'qb' -- Supports 'qb' & 'ox'
Config.TargetSystem = 'ox' -- Supports 'qb' & 'ox'

Config.Jobname = 'burgershot'

----- | GARAGE PED STUFF | -----
Config.BurgershotGaragePed = {
  {
      BurgershotGaragePedModel = 'mp_m_waremech_01',
      BurgershotGaragePedLocation = vec4(-1177.92, -892.45, 12.8, 308.56),
      BurgershotGarageRenderDistance = 15,
  }
}

Config.Bike2Spawn = vector4(-1169.82, -895.78, 13.9, 33.88)
Config.Bike2Vehicle = 'burgerbike2'

Config.VanSpawn = vector4(-1171.58, -894.93, 13.87, 27.1)
Config.VanVehicle = 'burgervan'

Config.BikeSpawn = vector4(-1172.3, -898.99, 13.79, 303.34)
Config.BikeVehicle = 'burgershotbike'

Config.CarSpawn = vector4(-1168.41, -895.57, 13.94, 28.42)
Config.CarVehicle = 'stalion2'

----- | DELIVERY PED STUFF | -----
Config.BurgershotDeliveryPed = {
  {
    BurgershotDeliveryPedModel = 'a_m_y_business_03',
    BurgershotDeliveryPedLocation = vector4(-1195.8, -901.62, 13.0, 41.53),
    BurgershotDeliveryRenderDistance = 5,
  }
}

Config.DeliveryLocations = {
  ['deliveryroute'] = {
    [1] = {
      name = "1",
      coords = vector4(-952.48, -1077.58, 2.67, 34.72), -- VESPUCCI CANALS / INVENTION CT
    },
    [2] = {
      name = "2",
      coords = vector4(-1043.36, -1580.35, 5.03, 34.72), -- LA PUERTA / BAY CITY AVE
    },
    [3] = {
      name = "3",
      coords = vector4(-1447.65, -537.27, 34.74, 36.38), -- Del Perro Heights Apartment
    },
    [4] = {
      name = "4",
      coords = vector4(-706.09, -1036.47, 16.41, 36.38), -- Across from south rockford appartments
    },
    [5] = {
      name = "5",
      coords = vector4(-702.82, -1023.36, 16.42, 298.18), -- Across from south rockford appartments
    },
  }
}

Config.MinBag = 1 -- Min amount of food bags for order
Config.MaxBag = 3 -- Max amount of food bags for order

Config.MinPay = 25 -- Min amount of pay per delivery
Config.MaxPay = 100 -- Max amount of pay per delivery

Config.PayWorker = true -- Toggles if the player should recieve a pay or not
Config.PlayerPercent = 30 -- The percent the player gets of the total cost

