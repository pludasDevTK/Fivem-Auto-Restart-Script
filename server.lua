ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

------------------------------------------------

---Config----
weabhooklink = "" ---Discord Weabhook Link
ReplyUserName = "Autorestart" ---Discord Bot Name
AvatarURL = "" ---Discord Url Of Avatar 
local scripts = {'script1', 'script2'}  ---Scripts To Restart
local allert_msg = "'ALLERT' Auto Restart In 10 Sec"  ---Allert Before Script Restart Message On Discord
local restart_title = "Auto Restart" ---Script Restart Title On Discord
local restart_msg = "AUTO RESTART\nStatus - ``Successful``\nNext Restart In - `6h`"  ---Script Restart Message On Discord
local everytime = true ---If False Then Will Restart Scripts Only Once At The Beginning Of The Script
local time_break = 21600000  ---Time Between Restarts [6h] [Set Everytime To True To Use It]

------------------------------------------------
---------------DONT EDIT BELOW------------------
------------------------------------------------
function sendToDiscord(name, message, color)
    local connect = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = "Made By Benjamin Krishan [pludas]",
              },
          }
      }
    PerformHttpRequest(weabhooklink, function(err, text, headers) end, 'POST', json.encode({username = ReplyUserName, embeds = connect, avatar_url = AvatarURL}), { ['Content-Type'] = 'application/json' })
  end


Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(1)
    PerformHttpRequest(weabhooklink, function(err, text, headers) end, 'POST', json.encode({username = ReplyUserName, content = allert_msg, avatar_url = AvatarURL}), { ['Content-Type'] = 'application/json' }) 
      Citizen.Wait(10000) ---10 Sec
      for index, value in next, scripts do
    StopResource(value)
    Citizen.Wait(1000)
    StartResource(value)
    end
     sendToDiscord(restart_title, restart_msg, 1645055)
     if everytime then
        Citizen.Wait(time_break)
     else
      break 
     end
  end
end)
------------------------------------------------
-----------YOUR OWN RESTARTS BELOW--------------
------------------------------------------------
