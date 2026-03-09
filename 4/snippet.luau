warn("[ModHandler] Please wait...")

local ModuleLocation = game:GetService("ReplicatedFirst"):WaitForChild("Modules")
function findByPath(pathString: string)
	local pathParts = string.split(pathString, ".")

	local current = game

	local startIndex = 1
	if pathParts[1]:lower() == "game" then
		startIndex = 2
	end

	for i = startIndex, #pathParts do
		local partName = pathParts[i]

		current = current:FindFirstChild(partName)

		if not current then
			return nil
		end
	end

	return current
end

for i, Modules in ipairs(ModuleLocation:GetChildren()) do
	if Modules:IsA("Folder") then
		if Modules:FindFirstChild("Info") and Modules.Info:IsA("ModuleScript") then
			local Module = require(Modules.Info)
			if Module.Name and Module.Description and Module.Version and Module.Author and Module.Icon and Module.Location then
				for i, ModuleCh in ipairs(Modules:GetChildren()) do
					if ModuleCh:IsA("ScreenGui") or ModuleCh:IsA("BaseScript") then
						if ModuleCh.Name ~= "Info" then
							if Module.Location == "Auto" then
								if ModuleCh:IsA("ScreenGui") then
									if ModuleCh:FindFirstChild("BaseFrame") and ModuleCh:FindFirstChild("BaseFrame"):IsA("Frame") then
										local BaseCount = 0
										local ChildrenList = {}
										for i, Children in ipairs(ModuleCh:GetChildren()) do
											BaseCount = i
											table.insert(ChildrenList, Children)
										end
										local Folder = Instance.new("Folder")
										Folder.Name = tostring(Module.Name).."_"..tostring(Module.Version)
										
										for i, Check in ipairs(game.StarterGui["RichChat PROTO3"]:GetChildren()) do
											if Check:IsA("Folder") then
												if Check.Name == tostring(Module.Name).."_"..tostring(Module.Version) then
													Check:Destroy()
												end
											end
										end
										
										for i, LastChild in ipairs(ChildrenList) do
											LastChild.Parent = Folder
										end
										
										Folder.Parent = game.StarterGui["RichChat PROTO3"]
									end
								elseif ModuleCh:IsA("BaseScript") then
									ModuleCh.Parent = game.StarterGui["RichChat PROTO3"]
								end
							else
								if ModuleCh:FindFirstChild("BaseFrame") and ModuleCh:FindFirstChild("BaseFrame"):IsA("Frame") then
									local BaseCount = 0
									local ChildrenList = {}
									for i, Children in ipairs(ModuleCh:GetChildren()) do
										BaseCount = i
										table.insert(ChildrenList, Children)
									end
									local Folder = Instance.new("Folder")
									Folder.Name = tostring(Module.Name).."_"..tostring(Module.Version)

									for i, Check in ipairs(game.StarterGui["RichChat PROTO3"]:GetChildren()) do
										if Check:IsA("Folder") then
											if Check.Name == tostring(Module.Name).."_"..tostring(Module.Version) then
												Check:Destroy()
											end
										end
									end

									for i, LastChild in ipairs(ChildrenList) do
										LastChild.Parent = Folder
									end

									Folder.Parent = findByPath(Module.Location)
								elseif ModuleCh:IsA("BaseScript") then
									ModuleCh.Parent = findByPath(Module.Location)
								end
							end
						end
					end
				end
			else
				warn("[ModHandler] Invalid Info arguments! Check 3.")
			end
		else
			warn("[ModHandler] Couldn't find Info ModuleScript. Check 2.")
		end
	else
		warn("[ModHandler] Found an instance, but it's not folder. Check 1.")
	end
end
