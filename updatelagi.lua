repeat
    task.wait()
until game:IsLoaded()
if hwid == "16003a41d764ac40af135c8682e2c1e1048718aeeb975093dab59604b1d81b2b" then

local Players   = game:GetService("Players")
local Client    = Players.LocalPlayer
local PlayerGui = Client.PlayerGui
local kontolodn = PlayerGui:FindFirstChild("Hub")
if kontolodn then
local a = True
while a do
local argscreatps = {
    [1] = "Create"
}
game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.PrivateServer:FireServer(unpack(argscreatps))
shared.PsCode = PlayerGui.Hub.Container.Window.PrivateServer.ServerLabel.Text
local argsfirserver = {
    [1] = "Join",
    [2] = shared.PsCode,
    [3] = "JawaTengah"
}
game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.PrivateServer:FireServer(unpack(argsfirserver))
wait(5)

end
else
loadstring(game:HttpGet('https://raw.githubusercontent.com/Anonyko/rawrism/refs/heads/main/abcdefghijklmnopqrstuvwxyz.lua'))()
end

else
    print("manahwidluanjing")
end
