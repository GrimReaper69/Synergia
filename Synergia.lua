if _G.Synergia then _G.Synergia.Window:Destroy() end


_G.UIL = {
	["Service"] = {
		["Players"] = game:GetService("Players"),
		["Player"] = game:GetService("Players").LocalPlayer,
		["TweenService"] = game:GetService("TweenService"),
		["UserInputService"] = game:GetService("UserInputService"),
		["MonitorSize"] = workspace.CurrentCamera.ViewportSize,
		["RunService"] = game:GetService("RunService"),
		["Processes"] = {},
		["Events"] = {}
	},
	["Function"] = {
		["Animate"] = function(element: Instance, property: string, value: Color3 | UDim2 | number)
			local service: TweenService = nil
			local properties = {}
			properties[property] = value
			service = _G.UIL.Service.TweenService:Create(element, TweenInfo.new(.2, Enum.EasingStyle.Linear), properties)
			service:Play()
			return service end,
		["RunCallback"] = function(name: string, callback: any)
			_G.UIL.Function.CreateProcess(name, callback)
		end,
		["CreateProcess"] = function(name: string, process: any)
			_G.UIL.Function.CloseProcess(name)
			process = coroutine.create(process)
			coroutine.resume(process)
			_G.UIL.Service.Processes[name] = process
			print("Started Process | " .. name)
		end,
		["CloseProcess"] = function(name: string)
			if _G.UIL.Service.Processes[name] then
				coroutine.close(_G.UIL.Service.Processes[name])
				_G.UIL.Service.Processes[name] = nil
				print("Closed Process | " .. name)
			end
		end,
		["CreateEvent"] = function(name: string, event: RBXScriptSignal, callback)
			_G.UIL.Function.CloseEvent(name)
			_G.UIL.Service.Events[name] = event:Connect(callback)
			print("Connected Event | " .. name)
			return name
		end,
		["CloseEvent"] = function(name: string)
			if _G.UIL.Service.Events[name] then
				_G.UIL.Service.Events[name]:Disconnect()
				_G.UIL.Service.Events[name] = nil
				print("Disconnected Event | " .. name)
			end
		end
	},
	["Element"] = {
		["Element"] = {},
		["Page"] = {},
		["Tab"] = {},
		["Label"] = {},
		["Paragraph"] = {},
		["Button"] = {},
		["Toggle"] = {},
		["Keybind"] = {},
		["Slider"] = {},
		["Textbox"] = {},
		["Dropdown"] = {}
	}
}


_G.UIL.Element.Element.__index = _G.UIL.Element.Element


_G.UIL.Element.Page.__index = _G.UIL.Element.Page
setmetatable(_G.UIL.Element.Page, {__index = _G.UIL.Element.Element})


_G.UIL.Element.Tab.__index = _G.UIL.Element.Tab
setmetatable(_G.UIL.Element.Tab, {__index = _G.UIL.Element.Element})


_G.UIL.Element.Label.__index = _G.UIL.Element.Label
setmetatable(_G.UIL.Element.Label, {__index = _G.UIL.Element.Element})


_G.UIL.Element.Paragraph.__index = _G.UIL.Element.Paragraph
setmetatable(_G.UIL.Element.Paragraph, {__index = _G.UIL.Element.Element})


_G.UIL.Element.Button.__index = _G.UIL.Element.Button
setmetatable(_G.UIL.Element.Button, {__index = _G.UIL.Element.Element})


_G.UIL.Element.Toggle.__index = _G.UIL.Element.Toggle
setmetatable(_G.UIL.Element.Toggle, {__index = _G.UIL.Element.Element})


_G.UIL.Element.Keybind.__index = _G.UIL.Element.Keybind
setmetatable(_G.UIL.Element.Keybind, {__index = _G.UIL.Element.Element})


_G.UIL.Element.Slider.__index = _G.UIL.Element.Slider
setmetatable(_G.UIL.Element.Slider, {__index = _G.UIL.Element.Element})


_G.UIL.Element.Textbox.__index = _G.UIL.Element.Textbox
setmetatable(_G.UIL.Element.Textbox, {__index = _G.UIL.Element.Element})


_G.UIL.Element.Dropdown.__index = _G.UIL.Element.Dropdown
setmetatable(_G.UIL.Element.Dropdown, {__index = _G.UIL.Element.Element})


function _G.UIL.Element.Element:CreatePage(title: string, icon: number, tabs: ScrollingFrame, pages: Frame, tooltip: TextLabel, uiPageLayout: UIPageLayout, homePage: ScrollingFrame, homeTab: Frame)
	local pageMeta = setmetatable({}, _G.UIL.Element.Page)
	pageMeta.page = nil
	pageMeta.tab = nil
	pageMeta.name = title
	
	
	--- [ Page (Pages) (Instance) ] ---


	local page = Instance.new("ScrollingFrame")
	page.Parent = pages
	page.Name = title
	page.BackgroundTransparency = 1
	page.Size = UDim2.new(1, 0, 1, 0)
	page.ZIndex = 1
	page.ClipsDescendants = true
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.CanvasSize = UDim2.new(0, 0, 2, 0)
	page.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	page.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	page.ScrollBarImageTransparency = 1
	page.ScrollBarThickness = 0
	page.ScrollingDirection = Enum.ScrollingDirection.Y
	page.VerticalScrollBarInset = Enum.ScrollBarInset.None
	page.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left


	--- [ Page.UIListLayout (Pages) (Instance) ] ---


	local pageUiListLayout = Instance.new("UIListLayout")
	pageUiListLayout.Parent = page
	pageUiListLayout.Padding = UDim.new(0.05, 0)
	pageUiListLayout.FillDirection = Enum.FillDirection.Vertical
	pageUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	pageUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	pageUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top


	--- [ Page.UIPadding (Pages) (Instance) ] ---


	local pageUiPadding = Instance.new("UIPadding")
	pageUiPadding.Parent = page
	
	
	--- [ Page.Script (Pages) (Script) ] ---


	pageUiPadding.PaddingTop = UDim.new(0, _G.UIL.Service.MonitorSize.Y * 0.02)
	pageMeta.page = page
	
	
	_G.UIL.Function.CreateEvent(
		title .. " Page (Destroying)",
		page.Destroying,
		function()
			_G.UIL.Function.CreateProcess(
				title .. " Page (Destroying)",
				function()
					pageMeta.page = nil
					_G.UIL.Function.CloseEvent(title .. " Page (Destroying)")
				end
			)
		end
	)
	
	
	local events: { string } = {}
	
	
	function pageMeta:Open()
		for _, tab in pairs(tabs:GetChildren()) do if tab.Name == title then return pageMeta:Select() end end
		
		
		for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
		

		--- [ Tab (Tabs) (Instance) ] ---


		local tab = Instance.new("Frame")
		tab.Parent = tabs
		tab.Name = title
		tab.Active = true
		tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		tab.Size = UDim2.new(0.25, 0, 0.8, 0)
		tab.ZIndex = 1
		tab:SetAttribute("Enabled", false)


		--- [ Tab.UICorner (Tabs) (Instance) ] ---


		local UiCorner = Instance.new("UICorner")
		UiCorner.Parent = tab
		UiCorner.CornerRadius = UDim.new(0.2, 0)


		--- [ Tab.CloseTabButton (Tabs) (Instance) ] ---


		local closeTabButton = Instance.new("TextButton")
		closeTabButton.Parent = tab
		closeTabButton.Name = "CloseTabButton"
		closeTabButton.AutoButtonColor = false
		closeTabButton.BackgroundTransparency = 1
		closeTabButton.Position = UDim2.new(0.85, 0, 0.25, 0)
		closeTabButton.Size = UDim2.new(0.1, 0, 0.5, 0)
		closeTabButton.ZIndex = 2
		closeTabButton.TextTransparency = 1


		--- [ Tab.SwitchTabButton (Tabs) (Instance) ] ---


		local switchTabButton = Instance.new("TextButton")
		switchTabButton.Parent = tab
		switchTabButton.Name = "SwitchTabButton"
		switchTabButton.AutoButtonColor = false
		switchTabButton.BackgroundTransparency = 1
		switchTabButton.Size = UDim2.new(1, 0, 1, 0)
		switchTabButton.ZIndex = 1
		switchTabButton.TextTransparency = 1


		--- [ Tab.SwitchTabButton.UICorner (Tabs) (Instance) ] ---


		local switchTabButtonUiCorner = Instance.new("UICorner")
		switchTabButtonUiCorner.Parent = switchTabButton
		switchTabButtonUiCorner.CornerRadius = UDim.new(0.2, 0)


		--- [ Tab.SwitchTabButton.TabDisplay (Tabs) (Instance) ] ---


		local switchTabButtonTabDisplay = Instance.new("Frame")
		switchTabButtonTabDisplay.Parent = switchTabButton
		switchTabButtonTabDisplay.Name = "TabDisplay"
		switchTabButtonTabDisplay.Active = true
		switchTabButtonTabDisplay.BackgroundTransparency = 1
		switchTabButtonTabDisplay.Position = UDim2.new(0.05, 0, 0, 0)
		switchTabButtonTabDisplay.Size = UDim2.new(0.95, 0, 1, 0)
		switchTabButtonTabDisplay.ZIndex = 1


		--- [ Tab.SwitchTabButton.TabDisplay.UIListLayout (Tabs) (Instance) ] ---


		local switchTabButtonTabDisplayUiListLayout = Instance.new("UIListLayout")
		switchTabButtonTabDisplayUiListLayout.Parent = switchTabButtonTabDisplay
		switchTabButtonTabDisplayUiListLayout.Padding = UDim.new(0.05, 0)
		switchTabButtonTabDisplayUiListLayout.FillDirection = Enum.FillDirection.Horizontal
		switchTabButtonTabDisplayUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
		switchTabButtonTabDisplayUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		switchTabButtonTabDisplayUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center


		--- [ Tab.SwitchTabButton.TabDisplay.TabIcon (Tabs) (Instance) ] ---


		local switchTabButtonTabDisplayTabIcon = Instance.new("ImageLabel")
		switchTabButtonTabDisplayTabIcon.Parent = switchTabButtonTabDisplay
		switchTabButtonTabDisplayTabIcon.Name = "TabIcon"
		switchTabButtonTabDisplayTabIcon.Active = true
		switchTabButtonTabDisplayTabIcon.BackgroundTransparency = 1
		switchTabButtonTabDisplayTabIcon.LayoutOrder = 1
		switchTabButtonTabDisplayTabIcon.Size = UDim2.new(0.125, 0, 0.55, 0)
		switchTabButtonTabDisplayTabIcon.ZIndex = 1
		switchTabButtonTabDisplayTabIcon.Image = "rbxassetid://" .. tostring(icon)
		switchTabButtonTabDisplayTabIcon.ScaleType = Enum.ScaleType.Crop


		--- [ Tab.SwitchTabButton.TabDisplay.TabLabel (Tabs) (Instance) ] ---


		local switchTabButtonTabDisplayTabLabel = Instance.new("TextLabel")
		switchTabButtonTabDisplayTabLabel.Parent = switchTabButtonTabDisplay
		switchTabButtonTabDisplayTabLabel.Name = "TabLabel"
		switchTabButtonTabDisplayTabLabel.Active = true
		switchTabButtonTabDisplayTabLabel.BackgroundTransparency = 1
		switchTabButtonTabDisplayTabLabel.LayoutOrder = 2
		switchTabButtonTabDisplayTabLabel.Size = UDim2.new(0.625, 0, 0.65, 0)
		switchTabButtonTabDisplayTabLabel.ZIndex = 1
		switchTabButtonTabDisplayTabLabel.Font = Enum.Font.SourceSans
		switchTabButtonTabDisplayTabLabel.Text = title
		switchTabButtonTabDisplayTabLabel.TextColor3 = Color3.fromRGB(221, 221, 221)
		switchTabButtonTabDisplayTabLabel.TextScaled = true
		switchTabButtonTabDisplayTabLabel.TextXAlignment = Enum.TextXAlignment.Left
		switchTabButtonTabDisplayTabLabel.TextYAlignment = Enum.TextYAlignment.Center


		--- [ Tab.SwitchTabButton.TabDisplay.CloseTabLabel (Tabs) (Instance) ] ---


		local switchTabButtonTabDisplayCloseTabLabel = Instance.new("TextLabel")
		switchTabButtonTabDisplayCloseTabLabel.Parent = switchTabButtonTabDisplay
		switchTabButtonTabDisplayCloseTabLabel.Name = "CloseTabLabel"
		switchTabButtonTabDisplayCloseTabLabel.Active = true
		switchTabButtonTabDisplayCloseTabLabel.BackgroundTransparency = 1
		switchTabButtonTabDisplayCloseTabLabel.LayoutOrder = 3
		switchTabButtonTabDisplayCloseTabLabel.Size = UDim2.new(0.1, 0, 1, 0)
		switchTabButtonTabDisplayCloseTabLabel.ZIndex = 1
		switchTabButtonTabDisplayCloseTabLabel.Font = Enum.Font.SourceSans
		switchTabButtonTabDisplayCloseTabLabel.Text = "×"
		switchTabButtonTabDisplayCloseTabLabel.TextColor3 = Color3.fromRGB(221, 221, 221)
		switchTabButtonTabDisplayCloseTabLabel.TextScaled = true
		switchTabButtonTabDisplayCloseTabLabel.TextXAlignment = Enum.TextXAlignment.Center
		switchTabButtonTabDisplayCloseTabLabel.TextYAlignment = Enum.TextYAlignment.Center


		--- [ Tab.SwitchTabButton.TabDisplay.CloseTabLabel.UIPadding (Tabs) (Instance) ] ---


		local switchTabButtonTabDisplayCloseTabLabelUiPadding = Instance.new("UIPadding")
		switchTabButtonTabDisplayCloseTabLabelUiPadding.Parent = switchTabButtonTabDisplayCloseTabLabel
		switchTabButtonTabDisplayCloseTabLabelUiPadding.PaddingBottom = UDim.new(0.1, 0)


		--- [ Tab.Script (Tabs) (Script) ] ---


		local wordThreshold = 11
		local numWords = string.len(title)
		local isTruncated = numWords > wordThreshold


		if isTruncated then
			switchTabButtonTabDisplayTabLabel.Text = title:sub(1, wordThreshold - 1) .. "..."
		end


		--- [ Tab.Script (Tabs) (Event) ] ---
		
		
		local animation: Tween = nil
		
		
		table.insert(events, _G.UIL.Function.CreateEvent(
			title .. " Close Tab Button (MouseButton1Click)",
			closeTabButton.MouseButton1Click,
			function() pageMeta:Close() end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			title .. " Close Tab Button (MouseEnter)",
			closeTabButton.MouseEnter,
			function()
				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(switchTabButtonTabDisplayCloseTabLabel, "TextColor3", Color3.fromRGB(204, 51, 51))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			title .. " Close Tab Button (MouseLeave)",
			closeTabButton.MouseLeave,
			function()
				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(switchTabButtonTabDisplayCloseTabLabel, "TextColor3", Color3.fromRGB(221, 221, 221))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			title .. " Switch Tab Button (MouseButton1Click)",
			switchTabButton.MouseButton1Click,
			function() pageMeta:Select() end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			title .. " Switch Tab Button (MouseEnter)",
			switchTabButton.MouseEnter,
			function()
				if not tab:GetAttribute("Enabled") then
					_G.UIL.Function.Animate(tab, "BackgroundColor3", Color3.fromRGB(49, 49, 49))
				end
				if isTruncated then
					local cursorPosition = game:GetService("UserInputService"):GetMouseLocation()
					tooltip.Text = title
					tooltip.Size = UDim2.new(0, tooltip.TextBounds.X * 1.05, 0.03, 0)
					tooltip.Position = UDim2.new(0, cursorPosition.X - tooltip.AbsoluteSize.X / 2, 0, cursorPosition.Y * 1.7 - cursorPosition.Y)
					tooltip.Visible = true
				end
			end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			title .. " Switch Tab Button (MouseMoved)",
			switchTabButton.MouseMoved,
			function()
				if not isTruncated then return end
				local cursorPosition = game:GetService("UserInputService"):GetMouseLocation()
				tooltip.Position = UDim2.new(0, cursorPosition.X - tooltip.AbsoluteSize.X / 2, 0, cursorPosition.Y * 1.7 - cursorPosition.Y)
			end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			title .. " Switch Tab Button (MouseLeave)",
			switchTabButton.MouseLeave,
			function()	
				tooltip.Visible = false
				tooltip.Size = UDim2.new(1, 0, 0.03, 0)
				if not tab:GetAttribute("Enabled") then
					_G.UIL.Function.Animate(tab, "BackgroundColor3", Color3.fromRGB(30, 30, 30))
				end
			end)
		)
		
		
		table.insert(events, _G.UIL.Function.CreateEvent(
			title .. " Tab (Destroying)",
			tab.Destroying,
			function()
				_G.UIL.Function.CreateProcess(title .. " Tab (Destroying)", function()
					pageMeta.tab = nil
					tooltip.Visible = false
					homeTab:SetAttribute("Enabled", true)
					uiPageLayout:JumpTo(homePage)
					_G.UIL.Function.Animate(homeTab, "BackgroundColor3", Color3.fromRGB(68, 68, 68))
					for _, v in pairs(tabs:GetChildren()) do
						if v:IsA("Frame") and v.Name ~= homeTab.Name then
							v:SetAttribute("Enabled", false)
							_G.UIL.Function.Animate(v, "BackgroundColor3", Color3.fromRGB(30, 30, 30))
						end
					end
					for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
				end)
			end)
		)


		pageMeta.tab = tab
	end


	function pageMeta:Select()
		if not pageMeta.tab then pageMeta:Open() end
		pageMeta.tab:SetAttribute("Enabled", true)
		uiPageLayout:JumpTo(page)
		_G.UIL.Function.Animate(pageMeta.tab, "BackgroundColor3", Color3.fromRGB(68, 68, 68))
		for _, v in pairs(tabs:GetChildren()) do
			if v:IsA("Frame") and v.Name ~= title then
				v:SetAttribute("Enabled", false)
				_G.UIL.Function.Animate(v, "BackgroundColor3", Color3.fromRGB(30, 30, 30))
			end
		end
	end


	function pageMeta:Close()
		if pageMeta.tab then pageMeta.tab:Destroy() end
	end
	
	
	function pageMeta:CreateLabel(content: { text: string })
		assert(content.text, "Missing arguments while trying to create a label.")
		return _G.UIL.Element.Element:CreateLabel(pageMeta, content.text)
	end


	function pageMeta:CreateParagraph(content: { title: string, description: string })
		assert(content.title and content.description, "Missing arguments while trying to create a paragraph.")
		return _G.UIL.Element.Element:CreateParagraph(pageMeta, content.title, content.description)
	end


	function pageMeta:CreateButton(content: { title: string, description: string, callback: any })
		assert(content.title and content.callback, "Missing arguments while trying to create a button.")
		return _G.UIL.Element.Element:CreateButton(pageMeta, content.title, content.description, content.callback)
	end


	function pageMeta:CreateToggle(content: { title: string, description: string, default: boolean, callback: any })
		assert(content.title and content.callback and content.default ~= nil, "Missing arguments while trying to create a toggle.")
		return _G.UIL.Element.Element:CreateToggle(pageMeta, content.title, content.description, content.default, content.callback)
	end


	function pageMeta:CreateKeybind(content: { title: string, description: string, default: Enum.KeyCode, callback: any })
		assert(content.title and content.callback and content.default, "Missing arguments while trying to create a keybind.")
		return _G.UIL.Element.Element:CreateKeybind(pageMeta, content.title, content.description, content.default, content.callback)
	end


	function pageMeta:CreateSlider(content: { title: string, description: string, default: number, min: number, max: number, callback: any })
		assert(content.title and content.callback and content.default and content.min and content.max, "Missing arguments while trying to create a slider.")
		return _G.UIL.Element.Element:CreateSlider(pageMeta, content.title, content.description, content.default, content.min, content.max, content.callback)
	end


	function pageMeta:CreateTextbox(content: { title: string, description: string, placeholder: string, callback: any })
		assert(content.title and content.callback and content.placeholder, "Missing arguments while trying to create a textbox.")
		return _G.UIL.Element.Element:CreateTextbox(pageMeta, content.title, content.description, content.placeholder, content.callback)
	end


	function pageMeta:CreateDropdown(content: { title: string, description: string, default: string, options: { string }, callback: any })
		assert(content.title and content.callback and content.default and content.options, "Missing arguments while trying to create a dropdown.")
		local isDefaultValid = false
		for _, option in pairs(content.options) do
			if option == content.default then isDefaultValid = true break end
		end
		assert(isDefaultValid, "Invalid default while trying to create a dropdown.")
		return _G.UIL.Element.Element:CreateDropdown(pageMeta, content.title, content.description, content.default, content.options, content.callback)
	end
	
	
	return pageMeta
end


function _G.UIL.Element.Element:CreateTab(title: string, icon: number, tabs: ScrollingFrame, pages: Frame, home: ScrollingFrame, tooltip: TextLabel, uiPageLayout: UIPageLayout, homePage: ScrollingFrame, homeTab: Frame)
	local pageMeta = _G.UIL.Element.Element:CreatePage(title, icon, tabs, pages, tooltip, uiPageLayout, homePage, homeTab)


	--- [ HomePage.TabsFrame.Tab (Pages) (Instance) ] ---


	local homePageTabsFrameTab = Instance.new("TextButton")
	homePageTabsFrameTab.Parent = home
	homePageTabsFrameTab.Name = title
	homePageTabsFrameTab.AutoButtonColor = false
	homePageTabsFrameTab.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
	homePageTabsFrameTab.ZIndex = 1
	homePageTabsFrameTab.TextTransparency = 1


	--- [ HomePage.TabsFrame.Tab.UICorner (Pages) (Instance) ] ---


	local homePageTabsFrameTabUiCorner = Instance.new("UICorner")
	homePageTabsFrameTabUiCorner.Parent = homePageTabsFrameTab
	homePageTabsFrameTabUiCorner.CornerRadius = UDim.new(0.2, 0)


	--- [ HomePage.TabsFrame.Tab.UIStroke (Pages) (Instance) ] ---


	local homePageTabsFrameTabUiStroke = Instance.new("UIStroke")
	homePageTabsFrameTabUiStroke.Parent = homePageTabsFrameTab
	homePageTabsFrameTabUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	homePageTabsFrameTabUiStroke.Color = Color3.fromRGB(41, 41, 41)
	homePageTabsFrameTabUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	homePageTabsFrameTabUiStroke.Thickness = 5


	--- [ HomePage.TabsFrame.Tab.Icon (Pages) (Instance) ] ---


	local homePageTabsFrameTabIcon = Instance.new("ImageLabel")
	homePageTabsFrameTabIcon.Parent = homePageTabsFrameTab
	homePageTabsFrameTabIcon.Name = "Icon"
	homePageTabsFrameTabIcon.Active = true
	homePageTabsFrameTabIcon.BackgroundTransparency = 1
	homePageTabsFrameTabIcon.Position = UDim2.new(0.125, 0, 0.125, 0)
	homePageTabsFrameTabIcon.Size = UDim2.new(0.75, 0, 0.75, 0)
	homePageTabsFrameTabIcon.ZIndex = 1
	homePageTabsFrameTabIcon.Image = "rbxassetid://" .. icon
	homePageTabsFrameTabIcon.ScaleType = Enum.ScaleType.Crop


	--- [ HomePage.TabsFrame.Tab.Script (Pages) (Event) ] ---


	local animation: Tween = nil
	local events: { string } = {}
	
	
	table.insert(events, _G.UIL.Function.CreateEvent(
		title .. " Home Tab (MouseEnter)",
		homePageTabsFrameTab.MouseEnter,
		function()
			local cursorPosition = game:GetService("UserInputService"):GetMouseLocation()
			tooltip.Text = title
			tooltip.Size = UDim2.new(0, tooltip.TextBounds.X * 1.05, 0.03, 0)
			tooltip.Position = UDim2.new(0, cursorPosition.X - tooltip.AbsoluteSize.X / 2, 0, cursorPosition.Y * 1.85 - cursorPosition.Y)
			tooltip.Visible = true
			if animation ~= nil then animation:Cancel() end
			animation = _G.UIL.Function.Animate(homePageTabsFrameTab, "BackgroundColor3", Color3.fromRGB(76, 76, 76))
			animation.Completed:Wait()
			animation = nil
		end)
	)
	

	table.insert(events, _G.UIL.Function.CreateEvent(
		title .. " Home Tab (MouseMoved)",
		homePageTabsFrameTab.MouseMoved,
		function()
			local cursorPosition = game:GetService("UserInputService"):GetMouseLocation()
			tooltip.Position = UDim2.new(0, cursorPosition.X - tooltip.AbsoluteSize.X / 2, 0, cursorPosition.Y * 1.85 - cursorPosition.Y)
		end)
	)
	

	table.insert(events, _G.UIL.Function.CreateEvent(
		title .. " Home Tab (MouseLeave)",
		homePageTabsFrameTab.MouseLeave,
		function()
			tooltip.Visible = false
			tooltip.Size = UDim2.new(1, 0, 0.03, 0)				
			if animation ~= nil then animation:Cancel() end
			animation = _G.UIL.Function.Animate(homePageTabsFrameTab, "BackgroundColor3", Color3.fromRGB(61, 61, 61))
			animation.Completed:Wait()
			animation = nil
		end)
	)
	

	table.insert(events, _G.UIL.Function.CreateEvent(
		title .. " Home Tab (MouseButton1Click)",
		homePageTabsFrameTab.MouseButton1Click,
		function()
			pageMeta.page.CanvasSize = UDim2.new(0, pageMeta.page.AbsoluteCanvasSize.X, 0, pageMeta.page.AbsoluteCanvasSize.Y + _G.UIL.Service.MonitorSize.Y * 0.1)
			pageMeta:Select()				
			if animation ~= nil then animation:Cancel() end
			animation = _G.UIL.Function.Animate(homePageTabsFrameTab, "BackgroundColor3", Color3.fromRGB(91, 91, 91))
			animation.Completed:Wait()
			animation = _G.UIL.Function.Animate(homePageTabsFrameTab, "BackgroundColor3", Color3.fromRGB(76, 76, 76))
			animation.Completed:Wait()
			animation = nil
		end)
	)
	
	
	table.insert(events, _G.UIL.Function.CreateEvent(
		title .. " Home Tab (Destroying)",
		homePageTabsFrameTab.Destroying,
		function()
			_G.UIL.Function.CreateProcess(title .. " Home Tab (Destroying)", function()
				pageMeta = nil
				for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
			end)
		end)
	)
	
	
	function pageMeta:Destroy()
		homePageTabsFrameTab:Destroy()
		pageMeta:Close()
		pageMeta.page:Destroy()
	end
	

	return pageMeta
end


function _G.UIL.Element.Element:CreateLabel(pageMeta, text: string)
	local labelMeta = setmetatable({}, _G.UIL.Element.Label)


	--- [ Page.Label (Pages) (Instance) ] ---


	local label = Instance.new("TextLabel")
	label.Parent = pageMeta.page
	label.Name = "Label"
	label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	label.Size = UDim2.new(0.95, 0, 0.1, 0)
	label.ZIndex = 1
	label.Font = Enum.Font.SourceSans
	label.Text = text
	label.TextColor3 = Color3.fromRGB(221, 221, 221)
	label.TextDirection = Enum.TextDirection.LeftToRight
	label.TextScaled = true
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Label.UICorner (Pages) (Instance) ] ---


	local labelUiCorner = Instance.new("UICorner")
	labelUiCorner.Parent = label
	labelUiCorner.CornerRadius = UDim.new(0.25, 0)


	--- [ Page.Label.UIPadding (Pages) (Instance) ] ---


	local labelUiPadding = Instance.new("UIPadding")
	labelUiPadding.Parent = label
	labelUiPadding.PaddingLeft = UDim.new(0.025, 0)


	--- [ Page.Label.UIStroke (Pages) (Instance) ] ---


	local labelUiStroke = Instance.new("UIStroke")
	labelUiStroke.Parent = label
	labelUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	labelUiStroke.Color = Color3.fromRGB(81, 81, 81)
	labelUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	labelUiStroke.Thickness = 2


	function labelMeta:Set(content: { text: string })
		text = content.text
		
		
		label.Text = "Label"
		label.TextSize = label.TextBounds.Y
		label.TextScaled = false
		label.Text = text


		local labelTextSize = label.TextSize
		local oldLabelLines = 0
		local newLabelLines = 1
		local totalLabelHeightOffset = 0


		while newLabelLines > oldLabelLines do
			oldLabelLines = newLabelLines
			totalLabelHeightOffset = labelTextSize * oldLabelLines
			label.Size = UDim2.new(label.Size.X.Scale, 0, 0, totalLabelHeightOffset)
			newLabelLines = 1 + math.floor(((label.TextBounds.X * 1.05) * (math.round(label.TextBounds.Y / labelTextSize))) / label.AbsoluteSize.X)
		end


		if newLabelLines > 1 then
			totalLabelHeightOffset -= labelTextSize
			label.Size = UDim2.new(label.Size.X.Scale, 0, 0, totalLabelHeightOffset)
			labelUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end
		
		
		_G.UIL.Function.CreateEvent(
			pageMeta.name .. " Label (Destroying) (" .. tostring(string.len(text)) .. ")",
			label.Destroying,
			function()
				_G.UIL.Function.CreateProcess(pageMeta.name .. " Label (Destroying) (" .. tostring(string.len(text)) .. ")", function()
					labelMeta = nil
					_G.UIL.Function.CloseEvent(pageMeta.name .. " Label (Destroying) (" .. tostring(string.len(text)) .. ")")
				end)
			end
		)
	end

	
	function labelMeta:Show() label.Visible = true end
	
	
	function labelMeta:Hide() label.Visible = false end
	
	
	function labelMeta:Destroy() label:Destroy() end


	labelMeta:Set({text = text})


	return labelMeta
end


function _G.UIL.Element.Element:CreateParagraph(pageMeta, title: string, description: string)
	local paragraphMeta = setmetatable({}, _G.UIL.Element.Paragraph)


	--- [ Page.Paragraph (Pages) (Instance) ] ---


	local paragraph = Instance.new("Frame")
	paragraph.Parent = pageMeta.page
	paragraph.Name = "Paragraph"
	paragraph.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	paragraph.Size = UDim2.new(0.95, 0, 0.15, 0)
	paragraph.ZIndex = 1


	--- [ Page.Paragraph.UICorner (Pages) (Instance) ] ---


	local paragraphUiCorner = Instance.new("UICorner")
	paragraphUiCorner.Parent = paragraph
	paragraphUiCorner.CornerRadius = UDim.new(0.25, 0)


	--- [ Page.Paragraph.UIListLayout (Pages) (Instance) ] ---


	local paragraphUiListLayout = Instance.new("UIListLayout")
	paragraphUiListLayout.Parent = paragraph
	paragraphUiListLayout.FillDirection = Enum.FillDirection.Vertical
	paragraphUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	paragraphUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	paragraphUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center


	--- [ Page.Paragraph.UIStroke (Pages) (Instance) ] ---


	local paragraphUiStroke = Instance.new("UIStroke")
	paragraphUiStroke.Parent = paragraph
	paragraphUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	paragraphUiStroke.Color = Color3.fromRGB(81, 81, 81)
	paragraphUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	paragraphUiStroke.Thickness = 2


	--- [ Page.Paragraph.Title (Pages) (Instance) ] ---


	local paragraphTitle = Instance.new("TextLabel")
	paragraphTitle.Parent = paragraph
	paragraphTitle.Name = "Title"
	paragraphTitle.BackgroundTransparency = 1
	paragraphTitle.LayoutOrder = 1
	paragraphTitle.Size = UDim2.new(1, 0, 0.6, 0)
	paragraphTitle.ZIndex = 1
	paragraphTitle.Font = Enum.Font.SourceSansSemibold
	paragraphTitle.TextColor3 = Color3.fromRGB(221, 221, 221)
	paragraphTitle.TextScaled = true
	paragraphTitle.TextXAlignment = Enum.TextXAlignment.Left
	paragraphTitle.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Paragraph.Title.UIPadding (Pages) (Instance) ] ---


	local paragraphTitleUiPadding = Instance.new("UIPadding")
	paragraphTitleUiPadding.Parent = paragraphTitle
	paragraphTitleUiPadding.PaddingLeft = UDim.new(0.025, 0)


	--- [ Page.Paragraph.Description (Pages) (Instance) ] ---


	local paragraphDescription = Instance.new("TextLabel")
	paragraphDescription.Parent = paragraph
	paragraphDescription.Name = "Description"
	paragraphDescription.BackgroundTransparency = 1
	paragraphDescription.LayoutOrder = 2
	paragraphDescription.Size = UDim2.new(1, 0, 0.4, 0)
	paragraphDescription.ZIndex = 1
	paragraphDescription.Font = Enum.Font.SourceSans
	paragraphDescription.TextColor3 = Color3.fromRGB(150, 150, 150)
	paragraphDescription.TextScaled = true
	paragraphDescription.TextXAlignment = Enum.TextXAlignment.Left
	paragraphDescription.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Paragraph.Description.UIPadding (Pages) (Instance) ] ---


	local paragraphDescriptionUiPadding = Instance.new("UIPadding")
	paragraphDescriptionUiPadding.Parent = paragraphDescription
	paragraphDescriptionUiPadding.PaddingLeft = UDim.new(0.025, 0)


	function paragraphMeta:Set(content: { title: string, description: string })
		title = content.title
		description = content.description


		paragraphTitle.Text = "Title"
		paragraphTitle.TextSize = paragraphTitle.TextBounds.Y
		paragraphTitle.TextScaled = false
		paragraphTitle.Text = title


		paragraphDescription.Text = "Description"
		paragraphDescription.TextSize = paragraphDescription.TextBounds.Y
		paragraphDescription.TextScaled = false
		paragraphDescription.Text = description


		local titleTextSize = paragraphTitle.TextSize
		local descriptionTextSize = paragraphDescription.TextSize
		local oldTitleLines = 0
		local newTitleLines = 1
		local oldDescriptionLines = 0
		local newDescriptionLines = 1
		local totalTitleHeightOffset = 0
		local totaldescriptionHeightOffset = 0


		while newTitleLines > oldTitleLines do
			oldTitleLines = newTitleLines
			totalTitleHeightOffset = titleTextSize * oldTitleLines
			paragraphTitle.Size = UDim2.new(paragraphTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			newTitleLines = 1 + math.floor(((paragraphTitle.TextBounds.X * 1.1) * (math.round(paragraphTitle.TextBounds.Y / titleTextSize))) / paragraphTitle.AbsoluteSize.X)
		end


		while newDescriptionLines > oldDescriptionLines do
			oldDescriptionLines = newDescriptionLines
			totaldescriptionHeightOffset = descriptionTextSize * oldDescriptionLines
			paragraphDescription.Size = UDim2.new(paragraphDescription.Size.X.Scale, 0, 0, totaldescriptionHeightOffset)
			newDescriptionLines = 1 + math.floor(((paragraphDescription.TextBounds.X * 1.1) * (math.round(paragraphDescription.TextBounds.Y / descriptionTextSize))) / paragraphDescription.AbsoluteSize.X)
		end


		if newTitleLines > 1 then
			totalTitleHeightOffset -= titleTextSize
			paragraphTitle.Size = UDim2.new(paragraphTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			paragraphUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		if newDescriptionLines > 1 then
			totaldescriptionHeightOffset -= descriptionTextSize
			paragraphDescription.Size = UDim2.new(paragraphDescription.Size.X.Scale, 0, 0, totaldescriptionHeightOffset)
			paragraphUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		paragraph.Size = UDim2.new(paragraph.Size.X.Scale, 0, 0, totalTitleHeightOffset + totaldescriptionHeightOffset)
		
		
		_G.UIL.Function.CreateEvent(
			pageMeta.name .. " Paragraph (Destroying) (" .. tostring(string.len(title) + string.len(description)) .. ")",
			paragraph.Destroying,
			function()
				_G.UIL.Function.CreateProcess(pageMeta.name .. " Paragraph (Destroying) (" .. tostring(string.len(title) + string.len(description)) .. ")", function()
					paragraphMeta = nil
				end)
			end
		)
	end


	function paragraphMeta:SetTitle(content: { title: string })
		paragraphMeta:Set(content.title, description)
	end


	function paragraphMeta:SetDescription(content: { description: string })
		paragraphMeta:Set(title, content.description)
	end

	
	function paragraphMeta:Show() paragraph.Visible = true end
	
	
	function paragraphMeta:Hide() paragraph.Visible = false end
	
	
	function paragraphMeta:Destroy() paragraph:Destroy() end


	paragraphMeta:Set({title = title, description = description})


	return paragraphMeta
end


function _G.UIL.Element.Element:CreateButton(pageMeta, title: string, description: string, callback)
	local buttonMeta = setmetatable({}, _G.UIL.Element.Button)


	--- [ Page.Button (Pages) (Instance) ] ---


	local button = Instance.new("TextButton")
	button.Parent = pageMeta.page
	button.Name = "Button"
	button.AutoButtonColor = false
	button.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
	button.Size = UDim2.new(0.95, 0, 0.15, 0)
	button.ZIndex = 1
	button.TextTransparency = 1


	--- [ Page.Button.UICorner (Pages) (Instance) ] ---


	local buttonUiCorner = Instance.new("UICorner")
	buttonUiCorner.Parent = button
	buttonUiCorner.CornerRadius = UDim.new(0.25, 0)


	--- [ Page.Button.UIListLayout (Pages) (Instance) ] ---


	local buttonUiListLayout = Instance.new("UIListLayout")
	buttonUiListLayout.Parent = button
	buttonUiListLayout.FillDirection = Enum.FillDirection.Vertical
	buttonUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	buttonUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	buttonUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center


	--- [ Page.Button.UIStroke (Pages) (Instance) ] ---


	local buttonUiStroke = Instance.new("UIStroke")
	buttonUiStroke.Parent = button
	buttonUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	buttonUiStroke.Color = Color3.fromRGB(81, 81, 81)
	buttonUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	buttonUiStroke.Thickness = 2


	--- [ Page.Button.Title (Pages) (Instance) ] ---


	local buttonTitle = Instance.new("TextLabel")
	buttonTitle.Parent = button
	buttonTitle.Name = "Title"
	buttonTitle.BackgroundTransparency = 1
	buttonTitle.LayoutOrder = 1
	buttonTitle.Size = UDim2.new(1, 0, 0.6, 0)
	buttonTitle.ZIndex = 1
	buttonTitle.Font = Enum.Font.SourceSansSemibold
	buttonTitle.TextColor3 = Color3.fromRGB(221, 221, 221)
	buttonTitle.TextScaled = true
	buttonTitle.TextXAlignment = Enum.TextXAlignment.Left
	buttonTitle.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Button.Title.UIPadding (Pages) (Instance) ] ---


	local buttonTitleUiPadding = Instance.new("UIPadding")
	buttonTitleUiPadding.Parent = buttonTitle
	buttonTitleUiPadding.PaddingLeft = UDim.new(0.025, 0)


	--- [ Page.Button.Description (Pages) (Instance) ] ---


	local buttonDescription = Instance.new("TextLabel")
	buttonDescription.Parent = button
	buttonDescription.Name = "Description"
	buttonDescription.BackgroundTransparency = 1
	buttonDescription.LayoutOrder = 2
	buttonDescription.Size = UDim2.new(1, 0, 0.4, 0)
	buttonDescription.ZIndex = 1
	buttonDescription.Font = Enum.Font.SourceSans
	buttonDescription.TextColor3 = Color3.fromRGB(150, 150, 150)
	buttonDescription.TextScaled = true
	buttonDescription.TextXAlignment = Enum.TextXAlignment.Left
	buttonDescription.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Button.Description.UIPadding (Pages) (Instance) ] ---


	local buttonDescriptionUiPadding = Instance.new("UIPadding")
	buttonDescriptionUiPadding.Parent = buttonDescription
	buttonDescriptionUiPadding.PaddingLeft = UDim.new(0.025, 0)

	
	local events: { string } = {}	
	

	function buttonMeta:Set(content: { title: string, description: string, callback: any })
		for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
		
		
		title = content.title
		description = content.description
		callback = content.callback


		buttonTitle.Text = "Title"
		buttonTitle.TextSize = buttonTitle.TextBounds.Y
		buttonTitle.TextScaled = false
		buttonTitle.Text = title


		if description ~= nil then
			buttonDescription.Text = "Description"
			buttonDescription.TextSize = buttonDescription.TextBounds.Y
			buttonDescription.TextScaled = false
			buttonDescription.Text = description
		end


		local titleTextSize = buttonTitle.TextSize
		local descriptionTextSize = buttonDescription.TextSize
		local oldTitleLines = 0
		local newTitleLines = 1
		local oldDescriptionLines = 0
		local newDescriptionLines = 1
		local totalTitleHeightOffset = 0
		local totaldescriptionHeightOffset = 0


		while newTitleLines > oldTitleLines do
			oldTitleLines = newTitleLines
			totalTitleHeightOffset = titleTextSize * oldTitleLines
			buttonTitle.Size = UDim2.new(buttonTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			newTitleLines = 1 + math.floor(((buttonTitle.TextBounds.X * 1.1) * (math.round(buttonTitle.TextBounds.Y / titleTextSize))) / buttonTitle.AbsoluteSize.X)
		end


		if description ~= nil then
			while newDescriptionLines > oldDescriptionLines do
				oldDescriptionLines = newDescriptionLines
				totaldescriptionHeightOffset = descriptionTextSize * oldDescriptionLines
				buttonDescription.Size = UDim2.new(buttonDescription.Size.X.Scale, 0, 0, totaldescriptionHeightOffset)
				newDescriptionLines = 1 + math.floor(((buttonDescription.TextBounds.X * 1.1) * (math.round(buttonDescription.TextBounds.Y / descriptionTextSize))) / buttonDescription.AbsoluteSize.X)
			end
		end


		if newTitleLines > 1 then
			totalTitleHeightOffset -= titleTextSize
			buttonTitle.Size = UDim2.new(buttonTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			buttonUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		if newDescriptionLines > 1 then
			totaldescriptionHeightOffset -= descriptionTextSize
			buttonDescription.Size = UDim2.new(buttonDescription.Size.X.Scale, 0, 0, totaldescriptionHeightOffset)
			buttonUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		button.Size = UDim2.new(button.Size.X.Scale, 0, 0, totalTitleHeightOffset + totaldescriptionHeightOffset)


		local animation: Tween = nil

		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Button (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseEnter)",
			button.MouseEnter,
			function()
				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(button, "BackgroundColor3", Color3.fromRGB(76, 76, 76))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Button (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseLeave)",
			button.MouseLeave,
			function()
				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(button, "BackgroundColor3", Color3.fromRGB(61, 61, 61))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Button (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseButton1Click)",
			button.MouseButton1Click,
			function()
				_G.UIL.Function.RunCallback(pageMeta.name .. " Button (Callback) (" .. tostring(string.len(content.title) + string.len(content.description)) .. ")", callback)
				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(button, "BackgroundColor3", Color3.fromRGB(91, 91, 91))
				animation.Completed:Wait()
				animation = _G.UIL.Function.Animate(button, "BackgroundColor3", Color3.fromRGB(76, 76, 76))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		
		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Button (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (Destroying)",
			button.Destroying,
			function()
				_G.UIL.Function.CreateProcess(pageMeta.name .. " Button (Destroying) (" .. tostring(string.len(content.title) + string.len(content.description)) .. ")", function()
					buttonMeta = nil
					for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
				end)
			end)
		)
		

		if description ~= nil then buttonDescription.Visible = true
		else buttonDescription.Visible = false end
	end


	function buttonMeta:SetTitle(content: { title: string })
		buttonMeta:Set(content.title, description, callback)
	end


	function buttonMeta:SetDescription(content: { description: string })
		buttonMeta:Set(title, content.description, callback)
	end


	function buttonMeta:SetParagraph(content: { title: string, description: string })
		buttonMeta:Set(content.title, content.description, callback)
	end


	function buttonMeta:SetCallback(content: { callback: any })
		buttonMeta:Set(title, description, content.callback)
	end
	
	
	function buttonMeta:Show() button.Visible = true end
	
	
	function buttonMeta:Hide() button.Visible = false end
	
	
	function buttonMeta:Destroy() button:Destroy() end


	buttonMeta:Set({title = title, description = description, callback = callback})


	return buttonMeta
end


function _G.UIL.Element.Element:CreateToggle(pageMeta, title: string, description: string, default: boolean, callback)
	local toggleMeta = setmetatable({}, _G.UIL.Element.Toggle)


	--- [ Page.Toggle (Pages) (Instance) ] ---


	local toggle = Instance.new("TextButton")
	toggle.Parent = pageMeta.page
	toggle.Name = "Toggle"
	toggle.AutoButtonColor = false
	toggle.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
	toggle.Size = UDim2.new(0.95, 0, 0.15, 0)
	toggle.ZIndex = 1
	toggle.TextTransparency = 1


	--- [ Page.Toggle.UICorner (Pages) (Instance) ] ---


	local toggleUiCorner = Instance.new("UICorner")
	toggleUiCorner.Parent = toggle
	toggleUiCorner.CornerRadius = UDim.new(0.25, 0)


	--- [ Page.Toggle.UIStroke (Pages) (Instance) ] ---


	local toggleUiStroke = Instance.new("UIStroke")
	toggleUiStroke.Parent  = toggle
	toggleUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	toggleUiStroke.Color = Color3.fromRGB(81, 81, 81)
	toggleUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	toggleUiStroke.Thickness = 2


	--- [ Page.Toggle.Indicator (Pages) (Instance) ] ---


	local toggleIndicator = Instance.new("Frame")
	toggleIndicator.Parent = toggle
	toggleIndicator.Name = "Indicator"
	toggleIndicator.Active = true
	toggleIndicator.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	toggleIndicator.Position = UDim2.new(0.88, 0, 0.25, 0)
	toggleIndicator.Size = UDim2.new(0.09, 0, 0.5, 0)
	toggleIndicator.ZIndex = 1


	--- [ Page.Toggle.Indicator.UICorner (Pages) (Instance) ] ---


	local toggleIndicatorUiCorner = Instance.new("UICorner")
	toggleIndicatorUiCorner.Parent = toggleIndicator
	toggleIndicatorUiCorner.CornerRadius = UDim.new(1, 0)


	--- [ Page.Toggle.Indicator.Circle (Pages) (Instance) ] ---


	local toggleIndicatorCircle = Instance.new("Frame")
	toggleIndicatorCircle.Parent = toggleIndicator
	toggleIndicatorCircle.Name = "Circle"
	toggleIndicatorCircle.Active = true
	toggleIndicatorCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	toggleIndicatorCircle.Size = UDim2.new(0.5, 0, 1, 0)
	toggleIndicatorCircle.ZIndex = 1


	--- [ Page.Toggle.Indicator.Circle.UICorner (Pages) (Instance) ] ---


	local toggleIndicatorCircleUiCorner = Instance.new("UICorner")
	toggleIndicatorCircleUiCorner.Parent = toggleIndicatorCircle
	toggleIndicatorCircleUiCorner.CornerRadius = UDim.new(1, 0)


	--- [ Page.Toggle.TextFrame (Pages) (Instance) ] ---


	local toggleTextFrame = Instance.new("Frame")
	toggleTextFrame.Parent = toggle
	toggleTextFrame.Name = "TextFrame"
	toggleTextFrame.Active = true
	toggleTextFrame.BackgroundTransparency = 1
	toggleTextFrame.Size = UDim2.new(0.85, 0, 1, 0)
	toggleTextFrame.ZIndex = 1


	--- [ Page.Toggle.TextFrame.UIListLayout (Pages) (Instance) ] ---


	local toggleTextFrameUiListLayout = Instance.new("UIListLayout")
	toggleTextFrameUiListLayout.Parent = toggleTextFrame
	toggleTextFrameUiListLayout.FillDirection = Enum.FillDirection.Vertical
	toggleTextFrameUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	toggleTextFrameUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	toggleTextFrameUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center


	--- [ Page.Toggle.TextFrame.Title (Pages) (Instance) ] ---


	local toggleTextFrameTitle = Instance.new("TextLabel")
	toggleTextFrameTitle.Parent = toggleTextFrame
	toggleTextFrameTitle.Name = "Title"
	toggleTextFrameTitle.Active = true
	toggleTextFrameTitle.BackgroundTransparency = 1
	toggleTextFrameTitle.LayoutOrder = 1
	toggleTextFrameTitle.Size = UDim2.new(1, 0, 0.6, 0)
	toggleTextFrameTitle.ZIndex = 1
	toggleTextFrameTitle.Font = Enum.Font.SourceSansSemibold
	toggleTextFrameTitle.TextColor3 = Color3.fromRGB(221, 221, 221)
	toggleTextFrameTitle.TextScaled = true
	toggleTextFrameTitle.TextXAlignment = Enum.TextXAlignment.Left
	toggleTextFrameTitle.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Toggle.TextFrame.Title.UIPadding (Pages) (Instance) ] ---


	local toggleTextFrameTitleUiPadding = Instance.new("UIPadding")
	toggleTextFrameTitleUiPadding.Parent = toggleTextFrameTitle
	toggleTextFrameTitleUiPadding.PaddingLeft = UDim.new(0.025, 0)


	--- [ Page.Toggle.TextFrame.Description (Pages) (Instance) ] ---


	local toggleTextFrameDescription = Instance.new("TextLabel")
	toggleTextFrameDescription.Parent = toggleTextFrame
	toggleTextFrameDescription.Name = "Description"
	toggleTextFrameDescription.Active = true
	toggleTextFrameDescription.BackgroundTransparency = 1
	toggleTextFrameDescription.LayoutOrder = 2
	toggleTextFrameDescription.Size = UDim2.new(1, 0, 0.4, 0)
	toggleTextFrameDescription.ZIndex = 1
	toggleTextFrameDescription.Font = Enum.Font.SourceSans
	toggleTextFrameDescription.TextColor3 = Color3.fromRGB(150, 150, 150)
	toggleTextFrameDescription.TextScaled = true
	toggleTextFrameDescription.TextXAlignment = Enum.TextXAlignment.Left
	toggleTextFrameDescription.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Toggle.TextFrame.Description.UIPadding (Pages) (Instance) ] ---


	local toggleTextFrameDescriptionUiPadding = Instance.new("UIPadding")
	toggleTextFrameDescriptionUiPadding.Parent = toggleTextFrameDescription
	toggleTextFrameDescriptionUiPadding.PaddingLeft = UDim.new(0.025, 0)
	
	
	local events: { string } = {}
	

	function toggleMeta:Set(content: { title: string, description: string, default: boolean, callback: any })
		for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
		
		
		title = content.title
		description = content.description
		default = content.default
		callback = content.callback


		local isToggled = not default
		local animation: Tween = nil


		toggleTextFrameTitle.Text = "Title"
		toggleTextFrameTitle.TextSize = toggleTextFrameTitle.TextBounds.Y
		toggleTextFrameTitle.TextScaled = false
		toggleTextFrameTitle.Text = title


		if description ~= nil then
			toggleTextFrameDescription.Text = "Description"
			toggleTextFrameDescription.TextSize = toggleTextFrameDescription.TextBounds.Y
			toggleTextFrameDescription.TextScaled = false
			toggleTextFrameDescription.Text = description	
		end


		local titleTextSize = toggleTextFrameTitle.TextSize
		local descriptionTextSize = toggleTextFrameDescription.TextSize
		local oldTitleLines = 0
		local newTitleLines = 1
		local oldDescriptionLines = 0
		local newDescriptionLines = 1
		local totalTitleHeightOffset = 0
		local totalDescriptionHeightOffset = 0


		while newTitleLines > oldTitleLines do
			oldTitleLines = newTitleLines
			totalTitleHeightOffset = titleTextSize * oldTitleLines
			toggleTextFrameTitle.Size = UDim2.new(toggleTextFrameTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			newTitleLines = 1 + math.floor(((toggleTextFrameTitle.TextBounds.X * 1.1) * (math.round(toggleTextFrameTitle.TextBounds.Y / titleTextSize))) / toggleTextFrameTitle.AbsoluteSize.X)
		end


		if description ~= nil then
			while newDescriptionLines > oldDescriptionLines do
				oldDescriptionLines = newDescriptionLines
				totalDescriptionHeightOffset = descriptionTextSize * oldDescriptionLines
				toggleTextFrameDescription.Size = UDim2.new(toggleTextFrameDescription.Size.X.Scale, 0, 0, totalDescriptionHeightOffset)
				newDescriptionLines = 1 + math.floor(((toggleTextFrameDescription.TextBounds.X * 1.1) * (math.round(toggleTextFrameDescription.TextBounds.Y / descriptionTextSize))) / toggleTextFrameDescription.AbsoluteSize.X)
			end
		end


		if newTitleLines > 1 then
			totalTitleHeightOffset -= titleTextSize
			toggleTextFrameTitle.Size = UDim2.new(toggleTextFrameTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			toggleUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		if newDescriptionLines > 1 then
			totalDescriptionHeightOffset -= descriptionTextSize
			toggleTextFrameDescription.Size = UDim2.new(toggleTextFrameDescription.Size.X.Scale, 0, 0, totalDescriptionHeightOffset)
			toggleUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		toggleIndicator.Size = UDim2.new(0, toggleIndicator.AbsoluteSize.X, 0, toggleIndicator.AbsoluteSize.Y)
		toggle.Size = UDim2.new(toggle.Size.X.Scale, 0, 0, totalTitleHeightOffset + totalDescriptionHeightOffset)		


		local function Activate()
			if isToggled then
				_G.UIL.Function.Animate(toggleIndicatorCircle, "Position", UDim2.new(0, 0, 0, 0))
				_G.UIL.Function.Animate(toggleIndicator, "BackgroundColor3", Color3.fromRGB(180, 50, 50))
			else
				_G.UIL.Function.Animate(toggleIndicatorCircle, "Position", UDim2.new(0.5, 0, 0, 0))
				_G.UIL.Function.Animate(toggleIndicator, "BackgroundColor3", Color3.fromRGB(50, 180, 50))
			end
			isToggled = not isToggled
			_G.UIL.Function.RunCallback(pageMeta.name .. " Toggle (Callback) (" .. tostring(string.len(content.title) + string.len(content.description)) .. ")", function() callback(isToggled) end)
		end

		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Toggle (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseEnter)",
			toggle.MouseEnter,
			function()
				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(toggle, "BackgroundColor3", Color3.fromRGB(76, 76, 76))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		
		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Toggle (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseLeave)",
			toggle.MouseLeave,
			function()
				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(toggle, "BackgroundColor3", Color3.fromRGB(61, 61, 61))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Toggle (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseButton1Click)",
			toggle.MouseButton1Click,
			function()
				Activate()
				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(toggle, "BackgroundColor3", Color3.fromRGB(91, 91, 91))
				animation.Completed:Wait()
				animation = _G.UIL.Function.Animate(toggle, "BackgroundColor3", Color3.fromRGB(76, 76, 76))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		
		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Toggle (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (Destroying)",
			toggle.Destroying,
			function()
				_G.UIL.Function.CreateProcess(pageMeta.name .. " Toggle (Destroying) (" .. tostring(string.len(content.title) + string.len(content.description)) .. ")", function()
					toggleMeta = nil
					for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
				end)
			end)
		)
		
		
		if description ~= nil then toggleTextFrameDescription.Visible = true
		else toggleTextFrameDescription.Visible = false end


		Activate()
	end


	function toggleMeta:SetTitle(content: { title: string })
		toggleMeta:Set(content.title, description, default, callback)
	end


	function toggleMeta:SetDescription(content: { description: string })
		toggleMeta:Set(title, content.description, default, callback)
	end


	function toggleMeta:SetParagraph(content: { title: string, description: string })
		toggleMeta:Set(content.title, content.description, default, callback)
	end


	function toggleMeta:SetDefault(content: { default: boolean })
		toggleMeta:Set(title, description, content.default, callback)
	end


	function toggleMeta:SetCallback(content: { callback: any })
		toggleMeta:Set(title, description, default, content.callback)
	end

	
	function toggleMeta:Show() toggle.Visible = true end
	
	
	function toggleMeta:Hide() toggle.Visible = false end
	
	
	function toggleMeta:Destroy() toggle:Destroy() end


	toggleMeta:Set({title = title, description = description, default = default, callback = callback})


	return toggleMeta
end


function _G.UIL.Element.Element:CreateKeybind(pageMeta, title: string, description: string, default: Enum.KeyCode, callback)
	local keybindMeta = setmetatable({}, _G.UIL.Element.Keybind)


	--- [ Page.Keybind (Pages) (Instance) ] ---


	local keybind = Instance.new("TextButton")
	keybind.Parent = pageMeta.page
	keybind.Name = "Keybind"
	keybind.AutoButtonColor = false
	keybind.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
	keybind.Size = UDim2.new(0.95, 0, 0.15, 0)
	keybind.ZIndex = 1
	keybind.TextTransparency = 1


	--- [ Page.Keybind.UICorner (Pages) (Instance) ] ---


	local keybindUiCorner = Instance.new("UICorner")
	keybindUiCorner.Parent = keybind
	keybindUiCorner.CornerRadius = UDim.new(0.25, 0)


	--- [ Page.Keybind.UIStroke (Pages) (Instance) ] ---


	local keybindUiStroke = Instance.new("UIStroke")
	keybindUiStroke.Parent = keybind
	keybindUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	keybindUiStroke.Color = Color3.fromRGB(81, 81, 81)
	keybindUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	keybindUiStroke.Thickness = 2


	--- [ Page.Keybind.Key (Pages) (Instance) ] ---


	local keybindKey = Instance.new("TextLabel")
	keybindKey.Parent = keybind
	keybindKey.Name = "Key"
	keybindKey.Active = true
	keybindKey.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
	keybindKey.Position = UDim2.new(0.88, 0, 0.125, 0)
	keybindKey.Size = UDim2.new(0.09, 0, 0.75, 0)
	keybindKey.ZIndex = 1
	keybindKey.Font = Enum.Font.SourceSansSemibold
	keybindKey.TextColor3 = Color3.fromRGB(221, 221, 221)
	keybindKey.TextScaled = true
	keybindKey.TextXAlignment = Enum.TextXAlignment.Center
	keybindKey.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Keybind.Key.UICorner (Pages) (Instance) ] ---


	local keybindKeyUiCorner = Instance.new("UICorner")
	keybindKeyUiCorner.Parent = keybindKey
	keybindKeyUiCorner.CornerRadius = UDim.new(0.25, 0)


	--- [ Page.Keybind.Key.UIStroke (Pages) (Instance) ] ---


	local keybindKeyUiStroke = Instance.new("UIStroke")
	keybindKeyUiStroke.Parent = keybindKey
	keybindKeyUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	keybindKeyUiStroke.Color = Color3.fromRGB(31, 31, 31)
	keybindKeyUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	keybindKeyUiStroke.Thickness = 3


	--- [ Page.Keybind.TextFrame (Pages) (Instance) ] ---


	local keybindTextFrame = Instance.new("Frame")
	keybindTextFrame.Parent = keybind
	keybindTextFrame.Name = "TextFrame"
	keybindTextFrame.Active = true
	keybindTextFrame.BackgroundTransparency = 1
	keybindTextFrame.Size = UDim2.new(0.85, 0, 1, 0)
	keybindTextFrame.ZIndex = 1


	--- [ Page.Keybind.TextFrame.UIListLayout (Pages) (Instance) ] ---


	local keybindTextFrameUiListLayout = Instance.new("UIListLayout")
	keybindTextFrameUiListLayout.Parent = keybindTextFrame
	keybindTextFrameUiListLayout.FillDirection = Enum.FillDirection.Vertical
	keybindTextFrameUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	keybindTextFrameUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	keybindTextFrameUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center


	--- [ Page.Keybind.TextFrame.Title (Pages) (Instance) ] ---


	local keybindTextFrameTitle = Instance.new("TextLabel")
	keybindTextFrameTitle.Parent = keybindTextFrame
	keybindTextFrameTitle.Name = "Title"
	keybindTextFrameTitle.Active = true
	keybindTextFrameTitle.BackgroundTransparency = 1
	keybindTextFrameTitle.LayoutOrder = 1
	keybindTextFrameTitle.Size = UDim2.new(1, 0, 0.6, 0)
	keybindTextFrameTitle.ZIndex = 1
	keybindTextFrameTitle.Font = Enum.Font.SourceSansSemibold
	keybindTextFrameTitle.TextColor3 = Color3.fromRGB(221, 221, 221)
	keybindTextFrameTitle.TextScaled = true
	keybindTextFrameTitle.TextXAlignment = Enum.TextXAlignment.Left
	keybindTextFrameTitle.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Keybind.TextFrame.Title.UIPadding (Pages) (Instance) ] ---


	local keybindTextFrameTitleUiPadding = Instance.new("UIPadding")
	keybindTextFrameTitleUiPadding.Parent = keybindTextFrameTitle
	keybindTextFrameTitleUiPadding.PaddingLeft = UDim.new(0.025, 0)


	--- [ Page.Keybind.TextFrame.Description (Pages) (Instance) ] ---


	local keybindTextFrameDescription = Instance.new("TextLabel")
	keybindTextFrameDescription.Parent = keybindTextFrame
	keybindTextFrameDescription.Name = "Description"
	keybindTextFrameDescription.Active = true
	keybindTextFrameDescription.BackgroundTransparency = 1
	keybindTextFrameDescription.LayoutOrder = 2
	keybindTextFrameDescription.Size = UDim2.new(1, 0, 0.4, 0)
	keybindTextFrameDescription.ZIndex = 1
	keybindTextFrameDescription.Font = Enum.Font.SourceSans
	keybindTextFrameDescription.TextColor3 = Color3.fromRGB(150, 150, 150)
	keybindTextFrameDescription.TextScaled = true
	keybindTextFrameDescription.TextXAlignment = Enum.TextXAlignment.Left
	keybindTextFrameDescription.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Keybind.TextFrame.Description.UIPadding (Pages) (Instance) ] ---


	local keybindTextFrameDescriptionUiPadding = Instance.new("UIPadding")
	keybindTextFrameDescriptionUiPadding.Parent = keybindTextFrameDescription
	keybindTextFrameDescriptionUiPadding.PaddingLeft = UDim.new(0.025, 0)
	
	
	local events: { string } = {}
	
	
	function keybindMeta:Set(content: { title: string, description: string, default: Enum.KeyCode, callback: any })
		for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
		
		
		title = content.title
		description = content.description
		default = content.default
		callback = content.callback


		local animation: Tween = nil


		keybindTextFrameTitle.Text = "Title"
		keybindTextFrameTitle.TextSize = keybindTextFrameTitle.TextBounds.Y
		keybindTextFrameTitle.TextScaled = false
		keybindTextFrameTitle.Text = title


		if description ~= nil then
			keybindTextFrameDescription.Text = "Description"
			keybindTextFrameDescription.TextSize = keybindTextFrameDescription.TextBounds.Y
			keybindTextFrameDescription.TextScaled = false
			keybindTextFrameDescription.Text = description
		end


		local titleTextSize = keybindTextFrameTitle.TextSize
		local descriptionTextSize = keybindTextFrameDescription.TextSize
		local oldTitleLines = 0
		local newTitleLines = 1
		local oldDescriptionLines = 0
		local newDescriptionLines = 1
		local totalTitleHeightOffset = 0
		local totaldescriptionHeightOffset = 0


		while newTitleLines > oldTitleLines do
			oldTitleLines = newTitleLines
			totalTitleHeightOffset = titleTextSize * oldTitleLines
			keybindTextFrameTitle.Size = UDim2.new(keybindTextFrameTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			newTitleLines = 1 + math.floor(((keybindTextFrameTitle.TextBounds.X * 1.1) * (math.round(keybindTextFrameTitle.TextBounds.Y / titleTextSize))) / keybindTextFrameTitle.AbsoluteSize.X)
		end


		if description ~= nil then
			while newDescriptionLines > oldDescriptionLines do
				oldDescriptionLines = newDescriptionLines
				totaldescriptionHeightOffset = descriptionTextSize * oldDescriptionLines
				keybindTextFrameDescription.Size = UDim2.new(keybindTextFrameDescription.Size.X.Scale, 0, 0, totaldescriptionHeightOffset)
				newDescriptionLines = 1 + math.floor(((keybindTextFrameDescription.TextBounds.X * 1.1) * (math.round(keybindTextFrameDescription.TextBounds.Y / descriptionTextSize))) / keybindTextFrameDescription.AbsoluteSize.X)
			end
		end


		if newTitleLines > 1 then
			totalTitleHeightOffset -= titleTextSize
			keybindTextFrameTitle.Size = UDim2.new(keybindTextFrameTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			keybindUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		if newDescriptionLines > 1 then
			totaldescriptionHeightOffset -= descriptionTextSize
			keybindTextFrameDescription.Size = UDim2.new(keybindTextFrameDescription.Size.X.Scale, 0, 0, totaldescriptionHeightOffset)
			keybindUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end

		
		keybindKey.Size = UDim2.new(keybindKey.Size.X.Scale, 0, 0, keybindKey.AbsoluteSize.Y)
		keybind.Size = UDim2.new(keybind.Size.X.Scale, 0, 0, totalTitleHeightOffset + totaldescriptionHeightOffset)


		local keyPress = function(input: InputObject, gameProcessedEvent: boolean)
			if input.KeyCode == default and not gameProcessedEvent then
				_G.UIL.Function.RunCallback(pageMeta.name .. " Keybind (Callback) (" .. tostring(string.len(content.title) + string.len(content.description)) .. ")", function() callback(input.KeyCode) end)
			end
		end

		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Keybind (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (InputBegan)",
			_G.UIL.Service.UserInputService.InputBegan,
			keyPress)
		)

		
		local function setKey()
			keybindKey.Text = "..."
			_G.UIL.Function.CloseEvent(pageMeta.name .. " Keybind (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (InputBegan)")
			local once = _G.UIL.Service.UserInputService.InputBegan:Once(function(input: InputObject, gameProcessedEvent: boolean)
				if input.KeyCode ~= Enum.KeyCode.Unknown and not gameProcessedEvent then
					default = input.KeyCode
				end
				keybindKey.Text = default.Name
			end)
			while once.Connected do task.wait() end
			_G.UIL.Function.CreateEvent(
				pageMeta.name .. " Keybind (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (InputBegan)",
				_G.UIL.Service.UserInputService.InputBegan,
				keyPress
			)
		end

		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Keybind (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseEnter)",
			keybind.MouseEnter,
			function()
				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(keybind, "BackgroundColor3", Color3.fromRGB(76, 76, 76))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Keybind (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseLeave)",
			keybind.MouseLeave,
			function()
				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(keybind, "BackgroundColor3", Color3.fromRGB(61, 61, 61))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Keybind (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseButton1Click)",
			keybind.MouseButton1Click,
			function()
				setKey()
				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(keybind, "BackgroundColor3", Color3.fromRGB(91, 91, 91))
				animation.Completed:Wait()
				animation = _G.UIL.Function.Animate(keybind, "BackgroundColor3", Color3.fromRGB(76, 76, 76))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		
		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Keybind (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (Destroying)",
			keybind.Destroying,
			function()
				_G.UIL.Function.CreateProcess(pageMeta.name .. " Keybind (Destroying) (" .. tostring(string.len(content.title) + string.len(content.description)) .. ")", function()
					keybindMeta = nil
					for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
				end)
			end)
		)
		

		if description ~= nil then keybindTextFrameDescription.Visible = true
		else keybindTextFrameDescription.Visible = false end


		keybindKey.Text = default.Name
	end


	function keybindMeta:SetTitle(content: { title: string })
		keybindMeta:Set(content.title, description, default, callback)
	end


	function keybindMeta:SetDescription(content: { description: string })
		keybindMeta:Set(title, content.description, default, callback)
	end


	function keybindMeta:SetParagraph(content: { title: string, description: string })
		keybindMeta:Set(content.title, content.description, default, callback)
	end


	function keybindMeta:SetDefault(content: { default: Enum.KeyCode })
		keybindMeta:Set(title, description, content.default, callback)
	end


	function keybindMeta:SetCallback(content: { callback: any })
		keybindMeta:Set(title, description, default, content.callback)
	end

	
	function keybindMeta:Show() keybind.Visible = true end


	function keybindMeta:Hide() keybind.Visible = false end
	
	
	function keybindMeta:Destroy() keybind:Destroy() end


	keybindMeta:Set({title = title, description = description, default = default, callback = callback})


	return keybindMeta
end


function _G.UIL.Element.Element:CreateSlider(pageMeta, title: string, description: string, default: number, min: number, max: number, callback)
	local sliderMeta = setmetatable({}, _G.UIL.Element.Slider)


	--- [ Page.Slider (Pages) (Instance) ] ---


	local slider = Instance.new("Frame")
	slider.Parent = pageMeta.page
	slider.Name = "Slider"
	slider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	slider.Size = UDim2.new(0.95, 0, 0.225, 0)
	slider.ZIndex = 1


	--- [ Page.Slider.UICorner (Pages) (Instance) ] ---


	local sliderUiCorner = Instance.new("UICorner")
	sliderUiCorner.Parent = slider
	sliderUiCorner.CornerRadius = UDim.new(0.25, 0)


	--- [ Page.Slider.UIListLayout (Pages) (Instance) ] ---


	local sliderUiListLayout = Instance.new("UIListLayout")
	sliderUiListLayout.Parent = slider
	sliderUiListLayout.FillDirection = Enum.FillDirection.Vertical
	sliderUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	sliderUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	sliderUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center


	--- [ Page.Slider.UIStroke (Pages) (Instance) ] ---


	local sliderUiStroke = Instance.new("UIStroke")
	sliderUiStroke.Parent = slider
	sliderUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	sliderUiStroke.Color = Color3.fromRGB(81, 81, 81)
	sliderUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	sliderUiStroke.Thickness = 2


	--- [ Page.Slider.SliderFrame (Pages) (Instance) ] ---


	local sliderSliderFrame = Instance.new("Frame")
	sliderSliderFrame.Parent = slider
	sliderSliderFrame.Name = "SliderFrame"
	sliderSliderFrame.BackgroundTransparency = 1
	sliderSliderFrame.LayoutOrder = 3
	sliderSliderFrame.Size = UDim2.new(1, 0, 0.34, 0)
	sliderSliderFrame.ZIndex = 1


	--- [ Page.Slider.SliderFrame.SliderBar (Pages) (Instance) ] ---


	local sliderSliderFrameSliderBar = Instance.new("Frame")
	sliderSliderFrameSliderBar.Parent = sliderSliderFrame
	sliderSliderFrameSliderBar.Name = "SliderBar"
	sliderSliderFrameSliderBar.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
	sliderSliderFrameSliderBar.Position = UDim2.new(0.025, 0, 0.2, 0)
	sliderSliderFrameSliderBar.Size = UDim2.new(0.95, 0, 0.6, 0)
	sliderSliderFrameSliderBar.ZIndex = 1


	--- [ Page.Slider.SliderFrame.SliderBar.UICorner (Pages) (Instance) ] ---


	local sliderSliderFrameSliderBarUiCorner = Instance.new("UICorner")
	sliderSliderFrameSliderBarUiCorner.Parent = sliderSliderFrameSliderBar
	sliderSliderFrameSliderBarUiCorner.CornerRadius = UDim.new(1, 0)


	--- [ Page.Slider.SliderFrame.SliderBar.UIStroke (Pages) (Instance) ] ---


	local sliderSliderFrameSliderBarUiStroke = Instance.new("UIStroke")
	sliderSliderFrameSliderBarUiStroke.Parent = sliderSliderFrameSliderBar
	sliderSliderFrameSliderBarUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	sliderSliderFrameSliderBarUiStroke.Color = Color3.fromRGB(36, 36, 36)
	sliderSliderFrameSliderBarUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	sliderSliderFrameSliderBarUiStroke.Thickness = 3


	--- [ Page.Slider.SliderFrame.SliderBar.Slider (Pages) (Instance) ] ---


	local sliderSliderFrameSliderBarSlider = Instance.new("TextButton")
	sliderSliderFrameSliderBarSlider.Parent = sliderSliderFrameSliderBar
	sliderSliderFrameSliderBarSlider.Name = "Slider"
	sliderSliderFrameSliderBarSlider.AutoButtonColor = false
	sliderSliderFrameSliderBarSlider.BackgroundTransparency = 1	
	sliderSliderFrameSliderBarSlider.Size = UDim2.new(0.9, 0, 1, 0)
	sliderSliderFrameSliderBarSlider.ZIndex = 1
	sliderSliderFrameSliderBarSlider.TextTransparency = 1


	--- [ Page.Slider.SliderFrame.SliderBar.Slider.UICorner (Pages) (Instance) ] ---


	local sliderSliderFrameSliderBarSliderUiCorner = Instance.new("UICorner")
	sliderSliderFrameSliderBarSliderUiCorner.Parent = sliderSliderFrameSliderBarSlider
	sliderSliderFrameSliderBarSliderUiCorner.CornerRadius = UDim.new(1, 0)


	--- [ Page.Slider.SliderFrame.SliderBar.Slider.UIStroke (Pages) (Instance) ] ---


	local sliderSliderFrameSliderBarSliderUiStroke = Instance.new("UIStroke")
	sliderSliderFrameSliderBarSliderUiStroke.Parent = sliderSliderFrameSliderBarSlider
	sliderSliderFrameSliderBarSliderUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	sliderSliderFrameSliderBarSliderUiStroke.Color = Color3.fromRGB(36, 36, 36)
	sliderSliderFrameSliderBarSliderUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	sliderSliderFrameSliderBarSliderUiStroke.Thickness = 3


	--- [ Page.Slider.SliderFrame.SliderBar.Slider.Filler (Pages) (Instance) ] ---


	local sliderSliderFrameSliderBarSliderFiller = Instance.new("Frame")
	sliderSliderFrameSliderBarSliderFiller.Parent = sliderSliderFrameSliderBarSlider
	sliderSliderFrameSliderBarSliderFiller.Name = "Filler"
	sliderSliderFrameSliderBarSliderFiller.Active = true
	sliderSliderFrameSliderBarSliderFiller.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	sliderSliderFrameSliderBarSliderFiller.Size = UDim2.new(0, 0, 1, 0)
	sliderSliderFrameSliderBarSliderFiller.ZIndex = 1


	--- [ Page.Slider.SliderFrame.SliderBar.Slider.Filler.UICorner (Pages) (Instance) ] ---


	local sliderSliderFrameSliderBarSliderFillerUiCorner = Instance.new("UICorner")
	sliderSliderFrameSliderBarSliderFillerUiCorner.Parent = sliderSliderFrameSliderBarSliderFiller
	sliderSliderFrameSliderBarSliderFillerUiCorner.CornerRadius = UDim.new(1, 0)


	--- [ Page.Slider.SliderFrame.SliderBar.Value (Pages) (Instance) ] ---


	local sliderSliderFrameSliderBarValue = Instance.new("TextLabel")
	sliderSliderFrameSliderBarValue.Parent = sliderSliderFrameSliderBar
	sliderSliderFrameSliderBarValue.Name = "Value"
	sliderSliderFrameSliderBarValue.BackgroundTransparency = 1
	sliderSliderFrameSliderBarValue.Position = UDim2.new(0.9, 0, 0, 0)
	sliderSliderFrameSliderBarValue.Size = UDim2.new(0.1, 0, 1, 0)
	sliderSliderFrameSliderBarValue.ZIndex = 1
	sliderSliderFrameSliderBarValue.Font = Enum.Font.SourceSansBold
	sliderSliderFrameSliderBarValue.TextColor3 = Color3.fromRGB(221, 221, 221)
	sliderSliderFrameSliderBarValue.TextScaled = true
	sliderSliderFrameSliderBarValue.TextXAlignment = Enum.TextXAlignment.Center
	sliderSliderFrameSliderBarValue.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Slider.SliderFrame.SliderBar.Value.UIPadding (Pages) (Instance) ] ---


	local sliderSliderFrameSliderBarValueUiPadding = Instance.new("UIPadding")
	sliderSliderFrameSliderBarValueUiPadding.Parent = sliderSliderFrameSliderBarValue
	sliderSliderFrameSliderBarValueUiPadding.PaddingLeft = UDim.new(0.1, 0)


	--- [ Page.Slider.Title (Pages) (Instance) ] ---


	local sliderTitle = Instance.new("TextLabel")
	sliderTitle.Parent = slider
	sliderTitle.Name = "Title"
	sliderTitle.Active = true
	sliderTitle.BackgroundTransparency = 1
	sliderTitle.LayoutOrder = 1
	sliderTitle.Size = UDim2.new(1, 0, 0.4, 0)
	sliderTitle.ZIndex = 1
	sliderTitle.Font = Enum.Font.SourceSansSemibold
	sliderTitle.TextColor3 = Color3.fromRGB(221, 221, 221)
	sliderTitle.TextScaled = true
	sliderTitle.TextXAlignment = Enum.TextXAlignment.Left
	sliderTitle.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Slider.Title.UIPadding (Pages) (Instance) ] ---


	local sliderTitleUiPadding = Instance.new("UIPadding")
	sliderTitleUiPadding.Parent = sliderTitle
	sliderTitleUiPadding.PaddingLeft = UDim.new(0.025, 0)


	--- [ Page.Slider.Description (Pages) (Instance) ] ---


	local sliderDescription = Instance.new("TextLabel")
	sliderDescription.Parent = slider
	sliderDescription.Name = "Description"
	sliderDescription.Active = true
	sliderDescription.BackgroundTransparency = 1
	sliderDescription.LayoutOrder = 2
	sliderDescription.Size = UDim2.new(1, 0, 0.26, 0)
	sliderDescription.ZIndex = 1
	sliderDescription.Font = Enum.Font.SourceSans
	sliderDescription.TextColor3 = Color3.fromRGB(150, 150, 150)
	sliderDescription.TextScaled = true
	sliderDescription.TextXAlignment = Enum.TextXAlignment.Left
	sliderDescription.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Slider.Description.UIPadding (Pages) (Instance) ] ---


	local sliderDescriptionUiPadding = Instance.new("UIPadding")
	sliderDescriptionUiPadding.Parent = sliderDescription
	sliderDescriptionUiPadding.PaddingLeft = UDim.new(0.025, 0)

	
	local events: { string } = {}
	

	function sliderMeta:Set(content: { title: string, description: string, default: number, min: number, max: number, callback: any })
		for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
		
		
		title = content.title
		description = content.description
		default = content.default
		min = content.min
		max = content.max
		callback = content.callback


		local isDragging = false


		sliderTitle.Text = "Title"
		sliderTitle.TextSize = sliderTitle.TextBounds.Y
		sliderTitle.TextScaled = false
		sliderTitle.Text = title


		if description ~= nil then
			sliderDescription.Text = "Description"
			sliderDescription.TextSize = sliderDescription.TextBounds.Y
			sliderDescription.TextScaled = false
			sliderDescription.Text = description
		end


		local titleTextSize = sliderTitle.TextSize
		local descriptionTextSize = sliderDescription.TextSize
		local oldTitleLines = 0
		local newTitleLines = 1
		local oldDescriptionLines = 0
		local newDescriptionLines = 1
		local totalTitleHeightOffset = 0
		local totalDescriptionHeightOffset = 0


		while newTitleLines > oldTitleLines do
			oldTitleLines = newTitleLines
			totalTitleHeightOffset = titleTextSize * oldTitleLines
			sliderTitle.Size = UDim2.new(sliderTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			newTitleLines = 1 + math.floor(((sliderTitle.TextBounds.X * 1.1) * (math.round(sliderTitle.TextBounds.Y / titleTextSize))) / sliderTitle.AbsoluteSize.X)
		end


		if description ~= nil then
			while newDescriptionLines > oldDescriptionLines do
				oldDescriptionLines = newDescriptionLines
				totalDescriptionHeightOffset = descriptionTextSize * oldDescriptionLines
				sliderDescription.Size = UDim2.new(sliderDescription.Size.X.Scale, 0, 0, totalDescriptionHeightOffset)
				newDescriptionLines = 1 + math.floor(((sliderDescription.TextBounds.X * 1.1) * (math.round(sliderDescription.TextBounds.Y / descriptionTextSize))) / sliderDescription.AbsoluteSize.X)
			end
		end


		if newTitleLines > 1 then
			totalTitleHeightOffset -= titleTextSize
			sliderTitle.Size = UDim2.new(sliderTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			sliderUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		if newDescriptionLines > 1 then
			totalDescriptionHeightOffset -= descriptionTextSize
			sliderDescription.Size = UDim2.new(sliderDescription.Size.X.Scale, 0, 0, totalDescriptionHeightOffset)
			sliderUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		sliderSliderFrame.Size = UDim2.new(sliderSliderFrame.Size.X.Scale, 0, 0, sliderSliderFrame.AbsoluteSize.Y)
		slider.Size = UDim2.new(slider.Size.X.Scale, 0, 0, totalTitleHeightOffset + totalDescriptionHeightOffset + sliderSliderFrame.AbsoluteSize.Y)


		local function updateSlider(value)
			value = math.clamp(math.round(value), min, max)
			sliderSliderFrameSliderBarSliderFiller.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
			sliderSliderFrameSliderBarValue.Text = tostring(value)
			_G.UIL.Function.RunCallback(pageMeta.name .. " Slider (Callback) (" .. tostring(string.len(content.title) + string.len(content.description)) .. ")", function() callback(value) end)
		end
		
		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Slider Bar (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseButton1Down)",
			sliderSliderFrameSliderBarSlider.MouseButton1Down,
			function() isDragging = true end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Slider Bar (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseButton1Up)",
			sliderSliderFrameSliderBarSlider.MouseButton1Up,
			function() isDragging = false end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Slider Bar (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseLeave)",
			sliderSliderFrameSliderBarSlider.MouseLeave,
			function() isDragging = false end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Slider Bar (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseMoved)",
			sliderSliderFrameSliderBarSlider.MouseMoved,
			function()
				if isDragging then
					local xPosition = (_G.UIL.Service.Player:GetMouse().X - sliderSliderFrameSliderBarSlider.AbsolutePosition.X) / sliderSliderFrameSliderBarSlider.AbsoluteSize.X
					local newValue = min + xPosition * (max - min)
					updateSlider(newValue)
				end
			end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Slider Bar (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseButton1Click)",
			sliderSliderFrameSliderBarSlider.MouseButton1Click,
			function()
				local xPosition = (_G.UIL.Service.Player:GetMouse().X - sliderSliderFrameSliderBarSlider.AbsolutePosition.X) / sliderSliderFrameSliderBarSlider.AbsoluteSize.X
				local newValue = min + xPosition * (max - min)
				updateSlider(newValue)
			end)
		)
		
		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Slider (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (Destroying)",
			slider.Destroying,
			function()
				_G.UIL.Function.CreateProcess(pageMeta.name .. " Slider (Destroying) (" .. tostring(string.len(content.title) + string.len(content.description)) .. ")", function()
					sliderMeta = nil
					for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
				end)
			end)
		)
		
		
		if description ~= nil then sliderDescription.Visible = true
		else sliderDescription.Visible = false end


		updateSlider(default)
	end


	function sliderMeta:SetTitle(content: { title: string })
		sliderMeta:Set(content.title, description, default, min, max, callback)
	end


	function sliderMeta:SetDescription(content: { description: string })
		sliderMeta:Set(title, content.description, default, min, max, callback)
	end


	function sliderMeta:SetParagraph(content: { title: string, description: string })
		sliderMeta:Set(content.title, content.description, default, min, max, callback)
	end


	function sliderMeta:SetDefault(content: { default: number })
		sliderMeta:Set(title, description, content.default, min, max, callback)
	end


	function sliderMeta:SetRange(content: { min: number, max: number })
		sliderMeta:Set(title, description, default, content.min, content.max, callback)
	end


	function sliderMeta:SetCallback(content: { callback: any })
		sliderMeta:Set(title, description, default, min, max, content.callback)
	end


	function sliderMeta:Show() slider.Visible = true end


	function sliderMeta:Hide() slider.Visible = false end
	

	function sliderMeta:Destroy() slider:Destroy() end


	sliderMeta:Set({title = title, description = description, default = default, min = min, max = max, callback = callback})


	return sliderMeta
end


function _G.UIL.Element.Element:CreateTextbox(pageMeta, title: string, description: string, placeholder: string, callback)
	local textboxMeta = setmetatable({}, _G.UIL.Element.Textbox)


	--- [ Page.Textbox (Pages) (Instance) ] ---


	local textbox = Instance.new("Frame")
	textbox.Parent = pageMeta.page
	textbox.Name = "Textbox"
	textbox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	textbox.Size = UDim2.new(0.95, 0, 0.2, 0)
	textbox.ZIndex = 1


	--- [ Page.Textbox.UICorner (Pages) (Instance) ] ---


	local textboxUiCorner = Instance.new("UICorner")
	textboxUiCorner.Parent = textbox
	textboxUiCorner.CornerRadius = UDim.new(0.25, 0)


	--- [ Page.Textbox.UIListLayout (Pages) (Instance) ] ---


	local textboxUiListLayout = Instance.new("UIListLayout")
	textboxUiListLayout.Parent = textbox
	textboxUiListLayout.FillDirection = Enum.FillDirection.Vertical
	textboxUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	textboxUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	textboxUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center


	--- [ Page.Textbox.UIStroke (Pages) (Instance) ] ---


	local textboxUiStroke = Instance.new("UIStroke")
	textboxUiStroke.Parent = textbox
	textboxUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	textboxUiStroke.Color = Color3.fromRGB(81, 81, 81)
	textboxUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	textboxUiStroke.Thickness = 2


	--- [ Page.Textbox.Textbox (Pages) (Instance) ] ---


	local textboxTextbox = Instance.new("TextBox")
	textboxTextbox.Parent = textbox
	textboxTextbox.Name = "Textbox"
	textboxTextbox.BackgroundTransparency = 1
	textboxTextbox.ClearTextOnFocus = false
	textboxTextbox.CursorPosition = 1
	textboxTextbox.LayoutOrder = 3
	textboxTextbox.MultiLine = false
	textboxTextbox.ShowNativeInput = true
	textboxTextbox.Size = UDim2.new(1, 0, 0.25, 0)
	textboxTextbox.TextEditable = true
	textboxTextbox.ZIndex = 1
	textboxTextbox.Font = Enum.Font.SourceSans
	textboxTextbox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
	textboxTextbox.Text = ""
	textboxTextbox.TextColor3 = Color3.fromRGB(221, 221, 221)
	textboxTextbox.TextScaled = true
	textboxTextbox.TextXAlignment = Enum.TextXAlignment.Left
	textboxTextbox.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Textbox.Textbox.UIPadding (Pages) (Instance) ] ---


	local textboxTextboxUiPadding = Instance.new("UIPadding")
	textboxTextboxUiPadding.Parent = textboxTextbox
	textboxTextboxUiPadding.PaddingLeft = UDim.new(0.025, 0)


	--- [ Page.Textbox.Title (Pages) (Instance) ] ---


	local textboxTitle = Instance.new("TextLabel")
	textboxTitle.Parent = textbox
	textboxTitle.Name = "Title"
	textboxTitle.Active = true
	textboxTitle.BackgroundTransparency = 1
	textboxTitle.LayoutOrder = 1
	textboxTitle.Size = UDim2.new(1, 0, 0.45, 0)
	textboxTitle.ZIndex = 1
	textboxTitle.Font = Enum.Font.SourceSansSemibold
	textboxTitle.TextColor3 = Color3.fromRGB(221, 221, 221)
	textboxTitle.TextScaled = true
	textboxTitle.TextXAlignment = Enum.TextXAlignment.Left
	textboxTitle.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Textbox.Title.UIPadding (Pages) (Instance) ] ---


	local textboxTitleUiPadding = Instance.new("UIPadding")
	textboxTitleUiPadding.Parent = textboxTitle
	textboxTitleUiPadding.PaddingLeft = UDim.new(0.025, 0)


	--- [ Page.Textbox.Description (Pages) (Instance) ] ---


	local textboxDescription = Instance.new("TextLabel")
	textboxDescription.Parent = textbox
	textboxDescription.Name = "Description"
	textboxDescription.Active = true
	textboxDescription.BackgroundTransparency = 1
	textboxDescription.LayoutOrder = 2
	textboxDescription.Size = UDim2.new(1, 0, 0.3, 0)
	textboxDescription.ZIndex = 1
	textboxDescription.Font = Enum.Font.SourceSans
	textboxDescription.TextColor3 = Color3.fromRGB(150, 150, 150)
	textboxDescription.TextScaled = true
	textboxDescription.TextXAlignment = Enum.TextXAlignment.Left
	textboxDescription.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Textbox.Description.UIPadding (Pages) (Instance) ] ---


	local textboxDescriptionUiPadding = Instance.new("UIPadding")
	textboxDescriptionUiPadding.Parent = textboxDescription
	textboxDescriptionUiPadding.PaddingLeft = UDim.new(0.025, 0)

	
	local events: { string } = {}
 	

	function textboxMeta:Set(content: { title: string, description: string, placeholder: string, callback: any })
		for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
		
		
		title = content.title
		description = content.description
		placeholder = content.placeholder
		callback = content.callback


		textboxTitle.Text = "Title"
		textboxTitle.TextSize = textboxTitle.TextBounds.Y
		textboxTitle.TextScaled = false
		textboxTitle.Text = title


		if description ~= nil then
			textboxDescription.Text = "Description"
			textboxDescription.TextSize = textboxDescription.TextBounds.Y
			textboxDescription.TextScaled = false
			textboxDescription.Text = description
		end


		textboxTextbox.PlaceholderText = "Placeholder"
		textboxTextbox.TextSize = textboxTextbox.TextBounds.Y
		textboxTextbox.TextScaled = false
		textboxTextbox.PlaceholderText = placeholder


		local titleTextSize = textboxTitle.TextSize
		local descriptionTextSize = textboxDescription.TextSize
		local textboxTextSize = textboxTextbox.TextSize
		local oldTitleLines = 0
		local newTitleLines = 1
		local oldDescriptionLines = 0
		local newDescriptionLines = 1
		local oldTextboxLines = 0
		local newTextboxLines = 1
		local totalTitleHeightOffset = 0
		local totalDescriptionHeightOffset = 0
		local totalTextboxHeightOffset = 0


		while newTitleLines > oldTitleLines do
			oldTitleLines = newTitleLines
			totalTitleHeightOffset = titleTextSize * oldTitleLines
			textboxTitle.Size = UDim2.new(textboxTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			newTitleLines = 1 + math.floor(((textboxTitle.TextBounds.X * 1.1) * (math.round(textboxTitle.TextBounds.Y / titleTextSize))) / textboxTitle.AbsoluteSize.X)
		end


		if description ~= nil then
			while newDescriptionLines > oldDescriptionLines do
				oldDescriptionLines = newDescriptionLines
				totalDescriptionHeightOffset = descriptionTextSize * oldDescriptionLines
				textboxDescription.Size = UDim2.new(textboxDescription.Size.X.Scale, 0, 0, totalDescriptionHeightOffset)
				newDescriptionLines = 1 + math.floor(((textboxDescription.TextBounds.X * 1.1) * (math.round(textboxDescription.TextBounds.Y / descriptionTextSize))) / textboxDescription.AbsoluteSize.X)
			end
		end


		while newTextboxLines > oldTextboxLines do
			oldTextboxLines = newTextboxLines
			totalTextboxHeightOffset = textboxTextSize * oldTextboxLines
			textboxTextbox.Size = UDim2.new(textboxTextbox.Size.X.Scale, 0, 0, totalTextboxHeightOffset)
			newTextboxLines = 1 + math.floor(((textboxTextbox.TextBounds.X * 1.1) * (math.round(textboxTextbox.TextBounds.Y / textboxTextSize))) / textboxTextbox.AbsoluteSize.X)
		end


		if newTitleLines > 1 then
			totalTitleHeightOffset -= titleTextSize
			textboxTitle.Size = UDim2.new(textboxTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			textboxUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		if newDescriptionLines > 1 then
			totalDescriptionHeightOffset -= descriptionTextSize
			textboxDescription.Size = UDim2.new(textboxDescription.Size.X.Scale, 0, 0, totalDescriptionHeightOffset)
			textboxUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		if newTextboxLines > 1 then
			totalTextboxHeightOffset -= textboxTextSize
			textboxTextbox.Size = UDim2.new(textboxTextbox.Size.X.Scale, 0, 0, totalTextboxHeightOffset)
			textboxUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		textbox.Size = UDim2.new(textbox.Size.X.Scale, 0, 0, totalTitleHeightOffset + totalDescriptionHeightOffset + totalTextboxHeightOffset)

		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Textbox (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (GetPropertyChangedSignal)",
			textboxTextbox:GetPropertyChangedSignal("Text"),
			function()
				local oldTextboxLines = 0
				local newTextboxLines = 1
				local totalTextboxHeightOffset = 0


				while newTextboxLines > oldTextboxLines do
					oldTextboxLines = newTextboxLines
					totalTextboxHeightOffset = textboxTextSize * oldTextboxLines
					textboxTextbox.Size = UDim2.new(textboxTextbox.Size.X.Scale, 0, 0, totalTextboxHeightOffset)
					newTextboxLines = 1 + math.floor(((textboxTextbox.TextBounds.X * 1.1) * (math.round(textboxTextbox.TextBounds.Y / textboxTextSize))) / textboxTextbox.AbsoluteSize.X)
				end


				if newTextboxLines > 1 then
					totalTextboxHeightOffset -= textboxTextSize
					textboxTextbox.Size = UDim2.new(textboxTextbox.Size.X.Scale, 0, 0, totalTextboxHeightOffset)
					textboxUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
				end


				textbox.Size = UDim2.new(textbox.Size.X.Scale, 0, 0, textboxTitle.AbsoluteSize.Y + textboxDescription.AbsoluteSize.Y + textboxTextbox.AbsoluteSize.Y)
			end)
		)
		
		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Textbox (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (FocusLost)",
			textboxTextbox.FocusLost,
			function()
				_G.UIL.Function.RunCallback(pageMeta.name .. " Textbox (Callback) (" .. tostring(string.len(content.title) + string.len(content.description) + string.len(content.placeholder)) .. ")", function() callback(textboxTextbox.Text) end)
			end)
		)
		
		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Textbox (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (Destroying)",
			textbox.Destroying,
			function()
				_G.UIL.Function.CreateProcess(pageMeta.name .. " Textbox (Destroying) (" .. tostring(string.len(content.title) + string.len(content.description) + string.len(content.placeholder)) .. ")", function()
					textboxMeta = nil
					for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
				end)
			end)
		)
		

		if description ~= nil then textboxDescription.Visible = true
		else textboxDescription.Visible = false end	
	end


	function textboxMeta:SetTitle(content: { title: string })
		textboxMeta:Set(content.title, description, placeholder, callback)
	end


	function textboxMeta:SetDescription(content: { description: string })
		textboxMeta:Set(title, content.description, placeholder, callback)
	end


	function textboxMeta:SetParagraph(content: { title: string, description: string })
		textboxMeta:Set(content.title, content.description, placeholder, callback)
	end


	function textboxMeta:SetPlaceholder(content: { placeholder: string })
		textboxMeta:Set(title, description, content.placeholder, callback)
	end


	function textboxMeta:SetCallback(content: { callback: any })
		textboxMeta:Set(title, description, placeholder, content.callback)
	end


	function textboxMeta:Show() textbox.Visible = true end


	function textboxMeta:Hide() textbox.Visible = false end
	

	function textboxMeta:Destroy() textbox:Destroy() end


	textboxMeta:Set({title = title, description = description, placeholder = placeholder, callback = callback})


	return textboxMeta
end


function _G.UIL.Element.Element:CreateDropdown(pageMeta, title: string, description: string, default: string, options: { string }, callback)
	local dropdownMeta = setmetatable({}, _G.UIL.Element.Dropdown)


	--- [ Page.Dropdown (Pages) (Instance) ] ---


	local dropdown = Instance.new("Frame")
	dropdown.Parent = pageMeta.page
	dropdown.Name = "Dropdown"
	dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	dropdown.Size = UDim2.new(0.95, 0, 0.25, 0)
	dropdown.ZIndex = 1


	--- [ Page.Dropdown.UICorner (Pages) (Instance) ] ---


	local dropdownUiCorner = Instance.new("UICorner")
	dropdownUiCorner.Parent = dropdown
	dropdownUiCorner.CornerRadius = UDim.new(0.25, 0)


	--- [ Page.Dropdown.UIListLayout (Pages) (Instance) ] ---


	local dropdownUiListLayout = Instance.new("UIListLayout")
	dropdownUiListLayout.Parent = dropdown
	dropdownUiListLayout.FillDirection = Enum.FillDirection.Vertical
	dropdownUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	dropdownUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	dropdownUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center


	--- [ Page.Dropdown.UIStroke (Pages) (Instance) ] ---


	local dropdownUiStroke = Instance.new("UIStroke")
	dropdownUiStroke.Parent = dropdown
	dropdownUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	dropdownUiStroke.Color = Color3.fromRGB(81, 81, 81)
	dropdownUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	dropdownUiStroke.Thickness = 2


	--- [ Page.Dropdown.DropdownFrame (Pages) (Instance) ] ---


	local dropdownDropdownFrame = Instance.new("Frame")
	dropdownDropdownFrame.Parent = dropdown
	dropdownDropdownFrame.Name = "DropdownFrame"
	dropdownDropdownFrame.BackgroundTransparency = 1
	dropdownDropdownFrame.LayoutOrder = 3
	dropdownDropdownFrame.Size = UDim2.new(1, 0, 0.425, 0)
	dropdownDropdownFrame.ZIndex = 1


	--- [ Page.Dropdown.DropdownFrame.Dropdown (Pages) (Instance) ] ---


	local dropdownDropdownFrameDropdown = Instance.new("TextButton")
	dropdownDropdownFrameDropdown.Parent = dropdownDropdownFrame
	dropdownDropdownFrameDropdown.Name = "Dropdown"
	dropdownDropdownFrameDropdown.AutoButtonColor = false
	dropdownDropdownFrameDropdown.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
	dropdownDropdownFrameDropdown.Position = UDim2.new(0.05, 0, 0.1, 0)
	dropdownDropdownFrameDropdown.Size = UDim2.new(0.9, 0, 0.8, 0)
	dropdownDropdownFrameDropdown.ZIndex = 2
	dropdownDropdownFrameDropdown.TextTransparency = 1


	--- [ Page.Dropdown.DropdownFrame.Dropdown.UICorner (Pages) (Instance) ] ---


	local dropdownDropdownFrameDropdownUiCorner = Instance.new("UICorner")
	dropdownDropdownFrameDropdownUiCorner.Parent = dropdownDropdownFrameDropdown
	dropdownDropdownFrameDropdownUiCorner.CornerRadius = UDim.new(0.25, 0)


	--- [ Page.Dropdown.DropdownFrame.Dropdown.UIStroke (Pages) (Instance) ] ---


	local dropdownDropdownFrameDropdownUiStroke = Instance.new("UIStroke")
	dropdownDropdownFrameDropdownUiStroke.Parent = dropdownDropdownFrameDropdown
	dropdownDropdownFrameDropdownUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	dropdownDropdownFrameDropdownUiStroke.Color = Color3.fromRGB(36, 36, 36)
	dropdownDropdownFrameDropdownUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	dropdownDropdownFrameDropdownUiStroke.Thickness = 2


	--- [ Page.Dropdown.DropdownFrame.Dropdown.DropdownMenu (Pages) (Instance) ] ---


	local dropdownDropdownFrameDropdownDropdownMenu = Instance.new("ScrollingFrame")
	dropdownDropdownFrameDropdownDropdownMenu.Parent = dropdownDropdownFrameDropdown
	dropdownDropdownFrameDropdownDropdownMenu.Name = "DropdownMenu"
	dropdownDropdownFrameDropdownDropdownMenu.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
	dropdownDropdownFrameDropdownDropdownMenu.Position = UDim2.new(0, 0, 0.9, 0)
	dropdownDropdownFrameDropdownDropdownMenu.Size = UDim2.new(1, 0, 0, 0)
	dropdownDropdownFrameDropdownDropdownMenu.Visible = false
	dropdownDropdownFrameDropdownDropdownMenu.ZIndex = 1
	dropdownDropdownFrameDropdownDropdownMenu.ClipsDescendants = true
	dropdownDropdownFrameDropdownDropdownMenu.AutomaticCanvasSize = Enum.AutomaticSize.Y
	dropdownDropdownFrameDropdownDropdownMenu.CanvasSize = UDim2.new(0, 0, 0, 0)
	dropdownDropdownFrameDropdownDropdownMenu.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	dropdownDropdownFrameDropdownDropdownMenu.ScrollBarImageTransparency = 1
	dropdownDropdownFrameDropdownDropdownMenu.ScrollBarThickness = 0
	dropdownDropdownFrameDropdownDropdownMenu.ScrollingDirection = Enum.ScrollingDirection.Y


	--- [ Page.Dropdown.DropdownFrame.Dropdown.DropdownMenu.UIListLayout (Pages) (Instance) ] ---


	local dropdownDropdownFrameDropdownDropdownMenuUiListLayout = Instance.new("UIListLayout")
	dropdownDropdownFrameDropdownDropdownMenuUiListLayout.Parent = dropdownDropdownFrameDropdownDropdownMenu
	dropdownDropdownFrameDropdownDropdownMenuUiListLayout.FillDirection = Enum.FillDirection.Vertical
	dropdownDropdownFrameDropdownDropdownMenuUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	dropdownDropdownFrameDropdownDropdownMenuUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	dropdownDropdownFrameDropdownDropdownMenuUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top


	--- [ Page.Dropdown.DropdownFrame.Dropdown.DropdownMenu.UIStroke (Pages) (Instance) ] ---


	local dropdownDropdownFrameDropdownDropdownMenuUiStroke = Instance.new("UIStroke")
	dropdownDropdownFrameDropdownDropdownMenuUiStroke.Parent = dropdownDropdownFrameDropdownDropdownMenu
	dropdownDropdownFrameDropdownDropdownMenuUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	dropdownDropdownFrameDropdownDropdownMenuUiStroke.Color = Color3.fromRGB(36, 36, 36)
	dropdownDropdownFrameDropdownDropdownMenuUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	dropdownDropdownFrameDropdownDropdownMenuUiStroke.Thickness = 2


	--- [ Page.Dropdown.DropdownFrame.Dropdown.Indicator (Pages) (Instance) ] ---


	local dropdownDropdownFrameDropdownIndicator = Instance.new("ImageLabel")
	dropdownDropdownFrameDropdownIndicator.Parent = dropdownDropdownFrameDropdown
	dropdownDropdownFrameDropdownIndicator.Name = "Indicator"
	dropdownDropdownFrameDropdownIndicator.Active = true
	dropdownDropdownFrameDropdownIndicator.BackgroundTransparency = 1
	dropdownDropdownFrameDropdownIndicator.Position = UDim2.new(0.95, 0, 0, 0)
	dropdownDropdownFrameDropdownIndicator.Rotation = 180
	dropdownDropdownFrameDropdownIndicator.Size = UDim2.new(0.05, 0, 1, 0)
	dropdownDropdownFrameDropdownIndicator.ZIndex = 2
	dropdownDropdownFrameDropdownIndicator.Image = "rbxassetid://6993462605"
	dropdownDropdownFrameDropdownIndicator.ImageColor3 = Color3.fromRGB(221, 221, 221)
	dropdownDropdownFrameDropdownIndicator.ScaleType = Enum.ScaleType.Crop


	--- [ Page.Dropdown.DropdownFrame.Dropdown.SelectedItem (Pages) (Instance) ] ---


	local dropdownDropdownFrameDropdownSelectedItem = Instance.new("TextLabel")
	dropdownDropdownFrameDropdownSelectedItem.Parent = dropdownDropdownFrameDropdown
	dropdownDropdownFrameDropdownSelectedItem.Name = "SelectedItem"
	dropdownDropdownFrameDropdownSelectedItem.Active = true
	dropdownDropdownFrameDropdownSelectedItem.BackgroundTransparency = 1
	dropdownDropdownFrameDropdownSelectedItem.Size = UDim2.new(0.95, 0, 1, 0)
	dropdownDropdownFrameDropdownSelectedItem.ZIndex = 2
	dropdownDropdownFrameDropdownSelectedItem.Font = Enum.Font.SourceSans
	dropdownDropdownFrameDropdownSelectedItem.TextColor3 = Color3.fromRGB(221, 221, 221)
	dropdownDropdownFrameDropdownSelectedItem.TextScaled = true
	dropdownDropdownFrameDropdownSelectedItem.TextXAlignment = Enum.TextXAlignment.Left
	dropdownDropdownFrameDropdownSelectedItem.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Dropdown.DropdownFrame.Dropdown.SelectedItem.UIPadding (Pages) (Instance) ] ---


	local dropdownDropdownFrameDropdownSelectedItemUiPadding = Instance.new("UIPadding")
	dropdownDropdownFrameDropdownSelectedItemUiPadding.Parent = dropdownDropdownFrameDropdownSelectedItem
	dropdownDropdownFrameDropdownSelectedItemUiPadding.PaddingLeft = UDim.new(0.01, 0)


	--- [ Page.Dropdown.Title (Pages) (Instance) ] ---


	local dropdownTitle = Instance.new("TextLabel")
	dropdownTitle.Parent = dropdown
	dropdownTitle.Name = "Title"
	dropdownTitle.Active = true
	dropdownTitle.BackgroundTransparency = 1
	dropdownTitle.LayoutOrder = 1
	dropdownTitle.Size = UDim2.new(1, 0, 0.35, 0)
	dropdownTitle.ZIndex = 1
	dropdownTitle.Font = Enum.Font.SourceSansSemibold
	dropdownTitle.TextColor3 = Color3.fromRGB(221, 221, 221)
	dropdownTitle.TextScaled = true
	dropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
	dropdownTitle.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Dropdown.Title.UIPadding (Pages) (Instance) ] ---


	local dropdownTitleUiPadding = Instance.new("UIPadding")
	dropdownTitleUiPadding.Parent = dropdownTitle
	dropdownTitleUiPadding.PaddingLeft = UDim.new(0.025, 0)


	--- [ Page.Dropdown.Description (Pages) (Instance) ] ---


	local dropdownDescription = Instance.new("TextLabel")
	dropdownDescription.Parent = dropdown
	dropdownDescription.Name = "Description"
	dropdownDescription.Active = true
	dropdownDescription.BackgroundTransparency = 1
	dropdownDescription.LayoutOrder = 2
	dropdownDescription.Size = UDim2.new(1, 0, 0.225, 0)
	dropdownDescription.ZIndex = 1
	dropdownDescription.Font = Enum.Font.SourceSans
	dropdownDescription.TextColor3 = Color3.fromRGB(150, 150, 150)
	dropdownDescription.TextScaled = true
	dropdownDescription.TextXAlignment = Enum.TextXAlignment.Left
	dropdownDescription.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Page.Dropdown.Description.UIPadding (Pages) (Instance) ] ---


	local dropdownDescriptionUiPadding = Instance.new("UIPadding")
	dropdownDescriptionUiPadding.Parent = dropdownDescription
	dropdownDescriptionUiPadding.PaddingLeft = UDim.new(0.025, 0)
	
	
	local events: { string } = {}
	local OptionButtons = {}
	OptionButtons.__index = OptionButtons
	OptionButtons.buttons = {}
	setmetatable({}, OptionButtons)


	function dropdownMeta:Set(content: { title: string, description: string, default: string, options: { string }, replace: boolean, callback: any })
		for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
		
		
		local animation: Tween = nil
		local isVisible = false


		if content.replace then
			for _, optionButton in pairs(OptionButtons.buttons) do optionButton:Destroy() end
			OptionButtons = {}
			OptionButtons.__index = OptionButtons
			OptionButtons.buttons = {}
			setmetatable({}, OptionButtons)
		end


		title = content.title
		description = content.description
		default = content.default
		options = content.options
		callback = content.callback


		dropdownTitle.Text = "Title"
		dropdownTitle.TextSize = dropdownTitle.TextBounds.Y
		dropdownTitle.TextScaled = false
		dropdownTitle.Text = title


		if description ~= nil then
			dropdownDescription.Text = "Description"
			dropdownDescription.TextSize = dropdownDescription.TextBounds.Y
			dropdownDescription.TextScaled = false
			dropdownDescription.Text = description
		end


		local titleTextSize = dropdownTitle.TextSize
		local descriptionTextSize = dropdownDescription.TextSize
		local oldTitleLines = 0
		local newTitleLines = 1
		local oldDescriptionLines = 0
		local newDescriptionLines = 1
		local totalTitleHeightOffset = 0
		local totalDescriptionHeightOffset = 0


		while newTitleLines > oldTitleLines do
			oldTitleLines = newTitleLines
			totalTitleHeightOffset = titleTextSize * oldTitleLines
			dropdownTitle.Size = UDim2.new(dropdownTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			newTitleLines = 1 + math.floor(((dropdownTitle.TextBounds.X * 1.15) * (math.round(dropdownTitle.TextBounds.Y / titleTextSize))) / dropdownTitle.AbsoluteSize.X)
		end


		if description ~= nil then
			while newDescriptionLines > oldDescriptionLines do
				oldDescriptionLines = newDescriptionLines
				totalDescriptionHeightOffset = descriptionTextSize * oldDescriptionLines
				dropdownDescription.Size = UDim2.new(dropdownDescription.Size.X.Scale, 0, 0, totalDescriptionHeightOffset)
				newDescriptionLines = 1 + math.floor(((dropdownDescription.TextBounds.X * 1.1) * (math.round(dropdownDescription.TextBounds.Y / descriptionTextSize))) / dropdownDescription.AbsoluteSize.X)
			end
		end


		if newTitleLines > 1 then
			totalTitleHeightOffset -= titleTextSize
			dropdownTitle.Size = UDim2.new(dropdownTitle.Size.X.Scale, 0, 0, totalTitleHeightOffset)
			dropdownUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		if newDescriptionLines > 1 then
			totalDescriptionHeightOffset -= descriptionTextSize
			dropdownDescription.Size = UDim2.new(dropdownDescription.Size.X.Scale, 0, 0, totalDescriptionHeightOffset)
			dropdownUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
		end


		dropdownDropdownFrame.Size = UDim2.new(dropdownDropdownFrame.Size.X.Scale, 0, 0, dropdownDropdownFrame.AbsoluteSize.Y)
		dropdown.Size = UDim2.new(dropdown.Size.X.Scale, 0, 0, totalTitleHeightOffset + totalDescriptionHeightOffset + dropdownDropdownFrame.AbsoluteSize.Y)
		dropdownDropdownFrameDropdownSelectedItem.Text = default
		
		
		local function Open()
			dropdownDropdownFrameDropdownDropdownMenu.Visible = true
			_G.UIL.Function.Animate(dropdownDropdownFrameDropdownIndicator, "Rotation", 90)
			_G.UIL.Function.Animate(dropdownDropdownFrameDropdownDropdownMenu, "Size", UDim2.new(dropdownDropdownFrameDropdownDropdownMenu.Size.X.Scale, 0, 4, 0))
		end
		
		
		local function Close()
			spawn(function()
				isVisible = false
				_G.UIL.Function.Animate(dropdownDropdownFrameDropdownIndicator, "Rotation", 180)
				local anim: TweenService = _G.UIL.Function.Animate(dropdownDropdownFrameDropdownDropdownMenu, "Size", UDim2.new(dropdownDropdownFrameDropdownDropdownMenu.Size.X.Scale, 0, 0, 0))
				anim.Completed:Wait()
				dropdownDropdownFrameDropdownDropdownMenu.Visible = false
			end)
		end
		
		
		if isVisible then Open() else Close() end
		
		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Dropdown (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseEnter)",
			dropdownDropdownFrameDropdown.MouseEnter,
			function()
				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(dropdownDropdownFrameDropdown, "BackgroundColor3", Color3.fromRGB(56, 56, 56))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Dropdown (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseLeave)",
			dropdownDropdownFrameDropdown.MouseLeave,
			function()
				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(dropdownDropdownFrameDropdown, "BackgroundColor3", Color3.fromRGB(41, 41, 41))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		

		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Dropdown (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseButton1Click)",
			dropdownDropdownFrameDropdown.MouseButton1Click,
			function()
				if isVisible then Close()
				else Open() end
				isVisible = not isVisible

				if animation ~= nil then animation:Cancel() end
				animation = _G.UIL.Function.Animate(dropdownDropdownFrameDropdown, "BackgroundColor3", Color3.fromRGB(71, 71, 71))
				animation.Completed:Wait()
				animation = _G.UIL.Function.Animate(dropdownDropdownFrameDropdown, "BackgroundColor3", Color3.fromRGB(56, 56, 56))
				animation.Completed:Wait()
				animation = nil
			end)
		)
		
		
		local function RunCallback(selectedItem: string)
			_G.UIL.Function.RunCallback(pageMeta.name .. " Dropdown (Callback) (" .. tostring(string.len(content.title) + string.len(content.description)) .. ")", function() callback(selectedItem) end)
		end
		
		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Dropdown (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (GetPropertyChangedSignal)",
			dropdownDropdownFrameDropdownSelectedItem:GetPropertyChangedSignal("Text"),
			function() RunCallback(dropdownDropdownFrameDropdownSelectedItem.Text) end)
		)
		

		function OptionButtons:CreateOption(option: string)
			local optionButtonsMeta = setmetatable({}, OptionButtons)
			table.insert(OptionButtons.buttons, optionButtonsMeta)
			
			
			--- [ DropdownMenu.Option (Dropdown) (Instance) ] ---


			local optionButton = Instance.new("TextButton")
			optionButton.Parent = dropdownDropdownFrameDropdownDropdownMenu
			optionButton.Name = "Option"
			optionButton.AutoButtonColor = false
			optionButton.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
			optionButton.BorderSizePixel = 0
			optionButton.Size = UDim2.new(1, 0, 0.25, 0)
			optionButton.ZIndex = 1
			optionButton.Font = Enum.Font.SourceSans
			optionButton.Text = option
			optionButton.TextColor3 = Color3.fromRGB(221, 221, 221)
			optionButton.TextScaled = true
			optionButton.TextXAlignment = Enum.TextXAlignment.Left
			optionButton.TextYAlignment = Enum.TextYAlignment.Center


			--- [ DropdownMenu.Option.UIPadding (Dropdown) (Instance) ] ---


			local optionButtonUiPadding = Instance.new("UIPadding")
			optionButtonUiPadding.Parent = optionButton
			optionButtonUiPadding.PaddingLeft = UDim.new(0.01, 0)


			--- [ DropdownMenu.Option.Script (Dropdown) (Script) ] ---


			dropdownDropdownFrameDropdownDropdownMenu.Size = UDim2.new(dropdownDropdownFrameDropdownDropdownMenu.Size.X.Scale, 0, 1, 0)
			optionButton.Size = UDim2.new(1, 0, 0, dropdownDropdownFrameDropdownDropdownMenu.AbsoluteSize.Y)
			dropdownDropdownFrameDropdownDropdownMenu.Size = UDim2.new(dropdownDropdownFrameDropdownDropdownMenu.Size.X.Scale, 0, 0, 0)


			if default == option then
				optionButton:SetAttribute("Selected", true)
				optionButton.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
			else optionButton:SetAttribute("Selected", false) end

			
			local buttonEvents: { string } = {}
			

			--- [ DropdownMenu.Option.Script (Dropdown) (Event) ] ---

			
			table.insert(buttonEvents, _G.UIL.Function.CreateEvent(
				pageMeta.name .. " Dropdown Option (" .. option .. ") (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseEnter)",
				optionButton.MouseEnter,
				function()
					if not optionButton:GetAttribute("Selected") then
						_G.UIL.Function.Animate(optionButton, "BackgroundColor3", Color3.fromRGB(61, 61, 61))
					end
				end)
			)


			table.insert(buttonEvents, _G.UIL.Function.CreateEvent(
				pageMeta.name .. " Dropdown Option (" .. option .. ") (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseLeave)",
				optionButton.MouseLeave,
				function()
					if not optionButton:GetAttribute("Selected") then
						_G.UIL.Function.Animate(optionButton, "BackgroundColor3", Color3.fromRGB(46, 46, 46))
					end
				end)
			)


			table.insert(buttonEvents, _G.UIL.Function.CreateEvent(
				pageMeta.name .. " Dropdown Option (" .. option .. ") (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (MouseButton1Click)",
				optionButton.MouseButton1Click,
				function()
					dropdownDropdownFrameDropdownSelectedItem.Text = option
					optionButton:SetAttribute("Selected", true)
					_G.UIL.Function.Animate(optionButton, "BackgroundColor3", Color3.fromRGB(76, 76, 76))
					for _, v in pairs(dropdownDropdownFrameDropdownDropdownMenu:GetChildren()) do
						if v:IsA("TextButton") and option ~= v.Text then
							v:SetAttribute("Selected", false)
							_G.UIL.Function.Animate(v, "BackgroundColor3", Color3.fromRGB(46, 46, 46))
						end
					end
				end)
			)
			
			
			table.insert(buttonEvents, _G.UIL.Function.CreateEvent(
				pageMeta.name .. " Dropdown Option (" .. option .. ") (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (Destroying)",
				optionButton.Destroying,
				function()
					_G.UIL.Function.CreateProcess(pageMeta.name .. " Dropdown Option (" .. option .. ") (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (Destroying)", function()
						optionButtonsMeta = nil
						for _, buttonEvent in pairs(buttonEvents) do _G.UIL.Function.CloseEvent(buttonEvent) end
					end)
				end)
			)
			
			
			function optionButtonsMeta:Destroy() optionButton:Destroy() end


			return optionButtonsMeta
		end
		
		
		table.insert(events, _G.UIL.Function.CreateEvent(
			pageMeta.name .. " Dropdown (" .. tostring(string.len(content.title) + string.len(content.description)) .. ") (Destroying)",
			dropdown.Destroying,
			function()
				_G.UIL.Function.CreateProcess(pageMeta.name .. " Dropdown (Destroying) (" .. tostring(string.len(content.title) + string.len(content.description)) .. ")", function()
					dropdownMeta = nil
					for _, event in pairs(events) do _G.UIL.Function.CloseEvent(event) end
				end)
			end)
		)
		
		
		for _, option in pairs(options) do
			OptionButtons:CreateOption(option)
		end
		
		
		RunCallback(dropdownDropdownFrameDropdownSelectedItem.Text)


		if description ~= nil then dropdownDescription.Visible = true
		else dropdownDescription.Visible = false end
	end


	function dropdownMeta:SetTitle(content: { title: string })
		dropdownMeta:Set({title = content.title, description = description, default = default, options = options, replace = false, callback = callback})
	end


	function dropdownMeta:SetDescription(content: { description: string })
		dropdownMeta:Set({title = title, description = content.description, default = default, options = options, replace = false, callback = callback})
	end


	function dropdownMeta:SetParagraph(content: { title: string, description: string })
		dropdownMeta:Set({title = content.title, description = content.description, default = default, options = options, replace = false, callback = callback})
	end


	function dropdownMeta:SetOptions(content: { default: string, options: { string }, replace: boolean })
		dropdownMeta:Set({title = title, description = description, default = content.default, options = content.options, replace = content.replace, callback = callback})
	end


	function dropdownMeta:SetSelected(content: { selected: string })
		dropdownMeta:Set({title = title, description = description, default = content.selected, options = options, replace = false, callback = callback})
	end


	function dropdownMeta:SetCallback(content: { callback: any })
		dropdownMeta:Set({title = content.title, description = description, default = default, options = options, replace = false, callback = content.callback})
	end


	function dropdownMeta:Show() dropdown.Visible = true end


	function dropdownMeta:Hide() dropdown.Visible = false end
	

	function dropdownMeta:Destroy() dropdown:Destroy() end


	dropdownMeta:Set({title = title, description = description, default = default, options = options,  replace = false, callback = callback})


	return dropdownMeta
end


_G.Synergia = {}
_G.Synergia.__index = _G.Synergia


function _G.Synergia:CreateWindow()
	_G.Synergia.Window = setmetatable({}, _G.Synergia)


	local GUI = Instance.new("ScreenGui")
	local window = Instance.new("Frame")
	local pages = Instance.new("Frame")
	local titleBar = Instance.new("Frame")


	GUI.Parent = _G.UIL.Service.Player.PlayerGui
	window.Parent = GUI
	pages.Parent = window
	titleBar.Parent = window


	------------------------- [ Window ] -------------------------


	window.Name = "Window"
	window.Active = true
	window.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
	window.Position = UDim2.new(0.25, 0, 0.25, 0)
	window.Size = UDim2.new(0.5, 0, 0.55, 0)
	window.ClipsDescendants = true
	window.ZIndex = 0
	window.Draggable = true


	local windowUiCorner = Instance.new("UICorner")
	windowUiCorner.Parent = window
	windowUiCorner.CornerRadius = UDim.new(0.025, 0)


	------------------------- [ Tooltip ] -------------------------


	local tooltip = Instance.new("TextLabel")
	tooltip.Parent = GUI
	tooltip.Name = "Tooltip"
	tooltip.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	tooltip.Size = UDim2.new(1, 0, 0.03, 0)
	tooltip.Visible = false
	tooltip.ZIndex = 5
	tooltip.Font = Enum.Font.SourceSans
	tooltip.TextColor3 = Color3.fromRGB(221, 221, 221)
	tooltip.TextScaled = true
	tooltip.TextXAlignment = Enum.TextXAlignment.Center
	tooltip.TextYAlignment = Enum.TextYAlignment.Center


	--- [ Tooltip.UICorner (GUI) (Instance) ] ---


	local tooltipUiCorner = Instance.new("UICorner")
	tooltipUiCorner.Parent = tooltip
	tooltipUiCorner.CornerRadius = UDim.new(0.25, 0)
	
	
	------------------------- [ NotificationPanel ] -------------------------
	
	
	local notificationPanel = Instance.new("Frame")
	notificationPanel.Parent = GUI
	notificationPanel.Name = "NotificationPanel"
	notificationPanel.BackgroundTransparency = 1
	notificationPanel.Position = UDim2.new(0.82, 0, -0.01, 0)
	notificationPanel.Size = UDim2.new(0.175, 0, 1, 0)
	notificationPanel.ZIndex = 0
	
	
	--- [ UIListLayout (NotificationPanel) (Instance) ] ---
	
	
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = notificationPanel
	UIListLayout.Padding = UDim.new(0.015, 0)
	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	
	
	function _G.Synergia.Window:Notify(content: { title: string, description: string, icon: number, duration: number })
		
		
		--- [ NotificationHolder (NotificationPanel) (Instance) ] ---
		
		
		local notificationHolder = Instance.new("Frame")
		notificationHolder.Parent = notificationPanel
		notificationHolder.Name = "NotificationHolder"
		notificationHolder.BackgroundTransparency = 1
		notificationHolder.Size = UDim2.new(2, 0, 0.07, 0)
		notificationHolder.ZIndex = 1
		
		
		--- [ NotificationHolder.UIPageLayout (NotificationPanel) (Instance) ] ---
		
		
		local notificationHolderUiPageLayout = Instance.new("UIPageLayout")
		notificationHolderUiPageLayout.Parent = notificationHolder
		notificationHolderUiPageLayout.Animated = true
		notificationHolderUiPageLayout.Circular = false
		notificationHolderUiPageLayout.EasingDirection = Enum.EasingDirection.In
		notificationHolderUiPageLayout.EasingStyle = Enum.EasingStyle.Linear
		notificationHolderUiPageLayout.TweenTime = 0.5
		notificationHolderUiPageLayout.FillDirection = Enum.FillDirection.Horizontal
		notificationHolderUiPageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		notificationHolderUiPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		notificationHolderUiPageLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		notificationHolderUiPageLayout.GamepadInputEnabled = false
		notificationHolderUiPageLayout.ScrollWheelInputEnabled = false
		notificationHolderUiPageLayout.TouchInputEnabled = false
		
		
		--- [ NotificationHolder.NotificationPlaceholder (NotificationPanel) (Instance) ] ---


		local notificationHolderNotificationPlaceholder = Instance.new("Frame")
		notificationHolderNotificationPlaceholder.Parent = notificationHolder
		notificationHolderNotificationPlaceholder.Name = "NotificationPlaceholder"
		notificationHolderNotificationPlaceholder.BackgroundTransparency = 1
		notificationHolderNotificationPlaceholder.Size = UDim2.new(0.5, 0, 1, 0)
		notificationHolderNotificationPlaceholder.ZIndex = 1
		
		
		--- [ NotificationHolder.Notification (NotificationPanel) (Instance) ] ---
		
		
		local notificationHolderNotification = Instance.new("Frame")
		notificationHolderNotification.Parent = notificationHolder
		notificationHolderNotification.Name = "Notification"
		notificationHolderNotification.LayoutOrder = 1
		notificationHolderNotification.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
		notificationHolderNotification.Size = UDim2.new(0.5, 0, 1, 0)
		notificationHolderNotification.ZIndex = 1
		
		
		--- [ NotificationHolder.Notification.UICorner (NotificationPanel) (Instance) ] ---
		
		
		local notificationHolderNotificationUiCorner = Instance.new("UICorner")
		notificationHolderNotificationUiCorner.Parent = notificationHolderNotification
		notificationHolderNotificationUiCorner.CornerRadius = UDim.new(0.15, 0)
		
		
		--- [ NotificationHolder.Notification.UIPadding (NotificationPanel) (Instance) ] ---
		
		
		local notificationHolderNotificationUiPadding = Instance.new("UIPadding")
		notificationHolderNotificationUiPadding.Parent = notificationHolderNotification
		notificationHolderNotificationUiPadding.PaddingTop = UDim.new(0.1, 0)
		
		
		--- [ NotificationHolder.Notification.UIStroke (NotificationPanel) (Instance) ] ---
		
		
		local notificationHolderNotificationUiStroke = Instance.new("UIStroke")
		notificationHolderNotificationUiStroke.Parent = notificationHolderNotification
		notificationHolderNotificationUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		notificationHolderNotificationUiStroke.Color = Color3.fromRGB(21, 21, 21)
		notificationHolderNotificationUiStroke.LineJoinMode = Enum.LineJoinMode.Round
		notificationHolderNotificationUiStroke.Thickness = 2
		
		
		--- [ NotificationHolder.Notification.Icon (NotificationPanel) (Instance) ] ---
		
		
		local notificationHolderNotificationIcon = Instance.new("ImageLabel")
		notificationHolderNotificationIcon.Parent = notificationHolderNotification
		notificationHolderNotificationIcon.Name = "Icon"
		notificationHolderNotificationIcon.BackgroundTransparency = 1
		notificationHolderNotificationIcon.Position = UDim2.new(0.03, 0, 0, 0)
		notificationHolderNotificationIcon.Size = UDim2.new(0.09, 0, 0.4, 0)
		notificationHolderNotificationIcon.ZIndex = 1
		notificationHolderNotificationIcon.Image = "rbxassetid://" .. content.icon
		notificationHolderNotificationIcon.ScaleType = Enum.ScaleType.Fit
		
		
		--- [ NotificationHolder.Notification.TextFrame (NotificationPanel) (Instance) ] ---
		
		
		local notificationHolderNotificationTextFrame = Instance.new("Frame")
		notificationHolderNotificationTextFrame.Parent = notificationHolderNotification
		notificationHolderNotificationTextFrame.Name = "TextFrame"
		notificationHolderNotificationTextFrame.BackgroundTransparency = 1
		notificationHolderNotificationTextFrame.Position = UDim2.new(0, 0, 0, 0)
		notificationHolderNotificationTextFrame.Size = UDim2.new(1, 0, 0.9, 0)
		notificationHolderNotificationTextFrame.ZIndex = 1
		
		
		--- [ NotificationHolder.Notification.TextFrame.UIListLayout (NotificationPanel) (Instance) ] ---

		
		local notificationHolderNotificationTextFrameUiListLayout = Instance.new("UIListLayout")
		notificationHolderNotificationTextFrameUiListLayout.Parent = notificationHolderNotificationTextFrame
		notificationHolderNotificationTextFrameUiListLayout.Padding = UDim.new(-0.1, 0)
		notificationHolderNotificationTextFrameUiListLayout.FillDirection = Enum.FillDirection.Vertical
		notificationHolderNotificationTextFrameUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
		notificationHolderNotificationTextFrameUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		notificationHolderNotificationTextFrameUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
		
		
		--- [ NotificationHolder.Notification.TextFrame.Title (NotificationPanel) (Instance) ] ---


		local notificationHolderNotificationTextFrameTitle = Instance.new("TextLabel")
		notificationHolderNotificationTextFrameTitle.Parent = notificationHolderNotificationTextFrame
		notificationHolderNotificationTextFrameTitle.Name = "Title"
		notificationHolderNotificationTextFrameTitle.BackgroundTransparency = 1
		notificationHolderNotificationTextFrameTitle.Size = UDim2.new(1, 0, 0.562, 0)
		notificationHolderNotificationTextFrameTitle.ZIndex = 1
		notificationHolderNotificationTextFrameTitle.Font = Enum.Font.SourceSansSemibold
		notificationHolderNotificationTextFrameTitle.Text = content.title
		notificationHolderNotificationTextFrameTitle.TextColor3 = Color3.fromRGB(221, 221, 221)
		notificationHolderNotificationTextFrameTitle.TextScaled = true
		notificationHolderNotificationTextFrameTitle.TextTruncate = Enum.TextTruncate.AtEnd
		notificationHolderNotificationTextFrameTitle.TextXAlignment = Enum.TextXAlignment.Left
		notificationHolderNotificationTextFrameTitle.TextYAlignment = Enum.TextYAlignment.Center
		
		
		--- [ NotificationHolder.Notification.TextFrame.Title.UIPadding (NotificationPanel) (Instance) ] ---


		local notificationHolderNotificationTextFrameTitleUiPadding = Instance.new("UIPadding")
		notificationHolderNotificationTextFrameTitleUiPadding.Parent = notificationHolderNotificationTextFrameTitle
		notificationHolderNotificationTextFrameTitleUiPadding.PaddingLeft = UDim.new(0.15, 0)


		--- [ NotificationHolder.Notification.TextFrame.Description (NotificationPanel) (Instance) ] ---


		local notificationHolderNotificationTextFrameDescription = Instance.new("TextLabel")
		notificationHolderNotificationTextFrameDescription.Parent = notificationHolderNotificationTextFrame
		notificationHolderNotificationTextFrameDescription.Name = "Description"
		notificationHolderNotificationTextFrameDescription.BackgroundTransparency = 1
		notificationHolderNotificationTextFrameDescription.Size = UDim2.new(1, 0, 0.438, 0)
		notificationHolderNotificationTextFrameDescription.ZIndex = 1
		notificationHolderNotificationTextFrameDescription.Font = Enum.Font.SourceSans
		notificationHolderNotificationTextFrameDescription.TextColor3 = Color3.fromRGB(150, 150, 150)
		notificationHolderNotificationTextFrameDescription.TextScaled = true
		notificationHolderNotificationTextFrameDescription.TextXAlignment = Enum.TextXAlignment.Left
		notificationHolderNotificationTextFrameDescription.TextYAlignment = Enum.TextYAlignment.Center
		
		
		--- [ NotificationHolder.Notification.TextFrame.Description.UIPadding (NotificationPanel) (Instance) ] ---


		local notificationHolderNotificationTextFrameDescriptionUiPadding = Instance.new("UIPadding")
		notificationHolderNotificationTextFrameDescriptionUiPadding.Parent = notificationHolderNotificationTextFrameDescription
		notificationHolderNotificationTextFrameDescriptionUiPadding.PaddingLeft = UDim.new(0.03, 0)
		
		
		notificationHolderNotificationUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.015)
		
		
		--- [ NotificationHolder.Notification.Script (NotificationPanel) (Script) ] ---

		
		notificationHolderNotificationTextFrameTitle.TextSize = notificationHolderNotificationTextFrameTitle.TextBounds.Y
		notificationHolderNotificationTextFrameTitle.TextScaled = false
		notificationHolderNotificationTextFrameTitle.TextWrapped = false
		notificationHolderNotificationTextFrameTitle.Size = UDim2.new(notificationHolderNotificationTextFrameTitle.Size.X.Scale, 0, 0, notificationHolderNotificationTextFrameTitle.AbsoluteSize.Y)
		notificationHolderNotificationTextFrameTitleUiPadding.PaddingBottom = UDim.new(0.3, 0)
		

		notificationHolderNotificationTextFrameDescription.Text = "Description"
		notificationHolderNotificationTextFrameDescription.TextSize = notificationHolderNotificationTextFrameDescription.TextBounds.Y
		notificationHolderNotificationTextFrameDescription.TextScaled = false
		notificationHolderNotificationTextFrameDescription.Text = content.description
		
		
		notificationHolderNotificationIcon.Size = UDim2.new(notificationHolderNotificationIcon.Size.X.Scale, 0, 0, notificationHolderNotificationIcon.AbsoluteSize.Y)
		notificationHolderNotificationTextFrameUiListLayout.Padding = UDim.new(0, notificationHolderNotificationTextFrameDescription.AbsolutePosition.Y - (notificationHolderNotificationTextFrameTitle.AbsolutePosition.Y + notificationHolderNotificationTextFrameTitle.AbsoluteSize.Y))
		

		local descriptionTextSize = notificationHolderNotificationTextFrameDescription.TextSize
		local oldDescriptionLines = 0
		local newDescriptionLines = 1
		local totaldescriptionHeightOffset = 0


		while newDescriptionLines > oldDescriptionLines do
			oldDescriptionLines = newDescriptionLines
			totaldescriptionHeightOffset = descriptionTextSize * oldDescriptionLines
			notificationHolderNotificationTextFrameDescription.Size = UDim2.new(notificationHolderNotificationTextFrameDescription.Size.X.Scale, 0, 0, totaldescriptionHeightOffset)
			newDescriptionLines = 1 + math.floor(((notificationHolderNotificationTextFrameDescription.TextBounds.X * 1.1) * (math.round(notificationHolderNotificationTextFrameDescription.TextBounds.Y / descriptionTextSize))) / notificationHolderNotificationTextFrameDescription.AbsoluteSize.X)
		end


		if newDescriptionLines > 1 then
			totaldescriptionHeightOffset -= descriptionTextSize
			notificationHolderNotificationTextFrameDescription.Size = UDim2.new(notificationHolderNotificationTextFrameDescription.Size.X.Scale, 0, 0, totaldescriptionHeightOffset)
		end

		
		notificationHolderNotificationUiPadding.PaddingTop = UDim.new(0, notificationHolderNotificationTextFrame.AbsolutePosition.Y - notificationHolderNotification.AbsolutePosition.Y)
		notificationHolder.Size = UDim2.new(notificationHolder.Size.X.Scale, 0, 0, notificationHolder.AbsoluteSize.Y + totaldescriptionHeightOffset - descriptionTextSize)
		
		
		_G.UIL.Function.CreateProcess(content.title .. " Notification (" .. tostring(string.len(content.title) + string.len(content.description)) .. ")", function()
			notificationHolderUiPageLayout:Next()
			task.wait(content.duration)
			notificationHolderUiPageLayout:Previous()
			task.wait(notificationHolderUiPageLayout.TweenTime)
			notificationHolder:Destroy()
		end)
	end


	------------------------- [ Pages ] -------------------------


	pages.Name = "Pages"
	pages.BackgroundTransparency = 1
	pages.Position = UDim2.new(0, 0, 0.1, 0)
	pages.Size = UDim2.new(1, 0, 0.9, 0)
	pages.ZIndex = 1
	pages.ClipsDescendants = true


	--- [ UICorner (Pages) (Instance) ] ---


	local PagesUiCorner = Instance.new("UICorner")
	PagesUiCorner.Parent = pages
	PagesUiCorner.CornerRadius = UDim.new(0.05, 0)


	--- [ UIPageLayout (Pages) (Instance) ] ---


	local pagesUiPageLayout = Instance.new("UIPageLayout")
	pagesUiPageLayout.Parent = pages
	pagesUiPageLayout.Animated = false
	pagesUiPageLayout.FillDirection = Enum.FillDirection.Horizontal
	pagesUiPageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	pagesUiPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	pagesUiPageLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	pagesUiPageLayout.GamepadInputEnabled = false
	pagesUiPageLayout.ScrollWheelInputEnabled = false
	pagesUiPageLayout.TouchInputEnabled = false


	------------------------- [ Title Bar ] -------------------------


	titleBar.Name = "TitleBar"
	titleBar.Active = true
	titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	titleBar.Size = UDim2.new(1, 0, 0.1, 0)
	titleBar.ZIndex = 1


	--- [ UICorner (Title Bar) (Instance) ] ---


	local titleBarUiCorner = Instance.new("UICorner")
	titleBarUiCorner.Parent = titleBar
	titleBarUiCorner.CornerRadius = UDim.new(0.25, 0)


	--- [ Tabs (Title Bar) (Instance) ] ---


	local tabs = Instance.new("ScrollingFrame")
	tabs.Parent = titleBar
	tabs.Name = "Tabs"
	tabs.BackgroundTransparency = 1
	tabs.Position = UDim2.new(0.005, 0, 0, 0)
	tabs.Size = UDim2.new(0.925, 0, 1, 0)
	tabs.ZIndex = 1
	tabs.ClipsDescendants = true
	tabs.AutomaticCanvasSize = Enum.AutomaticSize.X
	tabs.CanvasSize = UDim2.new(0, 0, 1, 0)
	tabs.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	tabs.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
	tabs.ScrollBarImageTransparency = 1
	tabs.ScrollBarThickness = 0
	tabs.ScrollingDirection = Enum.ScrollingDirection.X
	tabs.VerticalScrollBarInset = Enum.ScrollBarInset.None
	tabs.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right


	--- [ Tabs.UIListLayout (Title Bar) (Instance) ] ---


	local tabsUiListLayout = Instance.new("UIListLayout")
	tabsUiListLayout.Parent = tabs
	tabsUiListLayout.Padding = UDim.new(0.005, 0)
	tabsUiListLayout.FillDirection = Enum.FillDirection.Horizontal
	tabsUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	tabsUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabsUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center


	--- [ TitleBarBottomCover (Title Bar) (Instance) ] ---


	local titleBarBottomCover = Instance.new("Frame")
	titleBarBottomCover.Parent = titleBar
	titleBarBottomCover.Name = "TitleBarBottomCover"
	titleBarBottomCover.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	titleBarBottomCover.Position = UDim2.new(0, 0, 0.5, 0)
	titleBarBottomCover.Size = UDim2.new(1, 0, 0.5, 0)
	titleBarBottomCover.ZIndex = 0


	--- [ CloseWindowButton (Title Bar) (Instance) ] ---


	local closeWindowButton = Instance.new("TextButton")
	closeWindowButton.Parent = titleBar
	closeWindowButton.Name = "CloseWindowButton"
	closeWindowButton.AutoButtonColor = false
	closeWindowButton.BackgroundTransparency = 1
	closeWindowButton.Position = UDim2.new(0.955, 0, 0.3, 0)
	closeWindowButton.Size = UDim2.new(0.025, 0, 0.4, 0)
	closeWindowButton.ZIndex = 1
	closeWindowButton.TextTransparency = 1


	--- [ CloseWindowButton.Label (Title Bar) (Instance) ] ---


	local closeWindowLabel = Instance.new("TextLabel")
	closeWindowLabel.Parent = closeWindowButton
	closeWindowLabel.Name = "CloseWindowLabel"
	closeWindowLabel.BackgroundTransparency = 1
	closeWindowLabel.Position = UDim2.new(-0.75, 0, -0.75, 0)
	closeWindowLabel.Size = UDim2.new(2.5, 0, 2.5, 0)
	closeWindowLabel.ZIndex = 1
	closeWindowLabel.Font = Enum.Font.SourceSans
	closeWindowLabel.Text = "×"
	closeWindowLabel.TextColor3 = Color3.fromRGB(221, 221, 221)
	closeWindowLabel.TextScaled = true
	closeWindowLabel.TextXAlignment = Enum.TextXAlignment.Center
	closeWindowLabel.TextYAlignment = Enum.TextYAlignment.Center


	--- [ CloseWindowButton.Label.UIPadding (Title Bar) (Instance) ] ---


	local closeWindowLabelUIPadding = Instance.new("UIPadding")
	closeWindowLabelUIPadding.Parent = closeWindowLabel
	closeWindowLabelUIPadding.PaddingBottom = UDim.new(0.1, 0)


	--- [ CloseWindowButton.Script (Title Bar) (Event) ] ---

	
	_G.UIL.Function.CreateEvent(
		"Close Window Button (MouseEnter)",
		closeWindowButton.MouseEnter,
		function() _G.UIL.Function.Animate(closeWindowLabel, "TextColor3", Color3.fromRGB(204, 51, 51)) end
	)

	
	_G.UIL.Function.CreateEvent(
		"Close Window Button (MouseLeave)",
		closeWindowButton.MouseLeave,
		function() _G.UIL.Function.Animate(closeWindowLabel, "TextColor3", Color3.fromRGB(221, 221, 221)) end
	)

	
	_G.UIL.Function.CreateEvent(
		"Close Window Button (MouseButton1Click)",
		closeWindowButton.MouseButton1Click,
		function() _G.Synergia.Window:Hide() end
	)


	--- [ HomeTab (Tabs) (Instance) ] ---


	local homeTabTitle = "Home"
	local homeTabIcon = 14456045412
	local HomeTab = Instance.new("Frame")
	HomeTab.Parent = tabs
	HomeTab.Name = homeTabTitle
	HomeTab.Active = true
	HomeTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	HomeTab.Size = UDim2.new(0.25, 0, 0.8, 0)
	HomeTab.ZIndex = 1
	HomeTab:SetAttribute("Enabled", false)


	--- [ HomeTab.UICorner (Tabs) (Instance) ] ---


	local UiCorner = Instance.new("UICorner")
	UiCorner.Parent = HomeTab
	UiCorner.CornerRadius = UDim.new(0.2, 0)


	--- [ HomeTab.SwitchTabButton (Tabs) (Instance) ] ---


	local switchTabButton = Instance.new("TextButton")
	switchTabButton.Parent = HomeTab
	switchTabButton.Name = "SwitchTabButton"
	switchTabButton.AutoButtonColor = false
	switchTabButton.BackgroundTransparency = 1
	switchTabButton.Size = UDim2.new(1, 0, 1, 0)
	switchTabButton.ZIndex = 1
	switchTabButton.TextTransparency = 1


	--- [ HomeTab.SwitchTabButton.UICorner (Tabs) (Instance) ] ---


	local switchTabButtonUiCorner = Instance.new("UICorner")
	switchTabButtonUiCorner.Parent = switchTabButton
	switchTabButtonUiCorner.CornerRadius = UDim.new(0.2, 0)


	--- [ HomeTab.SwitchTabButton.TabDisplay (Tabs) (Instance) ] ---


	local switchTabButtonTabDisplay = Instance.new("Frame")
	switchTabButtonTabDisplay.Parent = switchTabButton
	switchTabButtonTabDisplay.Name = "TabDisplay"
	switchTabButtonTabDisplay.Active = true
	switchTabButtonTabDisplay.BackgroundTransparency = 1
	switchTabButtonTabDisplay.Position = UDim2.new(0.05, 0, 0, 0)
	switchTabButtonTabDisplay.Size = UDim2.new(0.95, 0, 1, 0)
	switchTabButtonTabDisplay.ZIndex = 1


	--- [ HomeTab.SwitchTabButton.TabDisplay.UIListLayout (Tabs) (Instance) ] ---


	local switchTabButtonTabDisplayUiListLayout = Instance.new("UIListLayout")
	switchTabButtonTabDisplayUiListLayout.Parent = switchTabButtonTabDisplay
	switchTabButtonTabDisplayUiListLayout.Padding = UDim.new(0.05, 0)
	switchTabButtonTabDisplayUiListLayout.FillDirection = Enum.FillDirection.Horizontal
	switchTabButtonTabDisplayUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	switchTabButtonTabDisplayUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	switchTabButtonTabDisplayUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center


	--- [ HomeTab.SwitchTabButton.TabDisplay.TabIcon (Tabs) (Instance) ] ---


	local switchTabButtonTabDisplayTabIcon = Instance.new("ImageLabel")
	switchTabButtonTabDisplayTabIcon.Parent = switchTabButtonTabDisplay
	switchTabButtonTabDisplayTabIcon.Name = "TabIcon"
	switchTabButtonTabDisplayTabIcon.Active = true
	switchTabButtonTabDisplayTabIcon.BackgroundTransparency = 1
	switchTabButtonTabDisplayTabIcon.LayoutOrder = 1
	switchTabButtonTabDisplayTabIcon.Size = UDim2.new(0.125, 0, 0.55, 0)
	switchTabButtonTabDisplayTabIcon.ZIndex = 1
	switchTabButtonTabDisplayTabIcon.Image = "rbxassetid://" .. tostring(homeTabIcon)
	switchTabButtonTabDisplayTabIcon.ScaleType = Enum.ScaleType.Crop


	--- [ HomeTab.SwitchTabButton.TabDisplay.TabLabel (Tabs) (Instance) ] ---


	local switchTabButtonTabDisplayTabLabel = Instance.new("TextLabel")
	switchTabButtonTabDisplayTabLabel.Parent = switchTabButtonTabDisplay
	switchTabButtonTabDisplayTabLabel.Name = "TabLabel"
	switchTabButtonTabDisplayTabLabel.Active = true
	switchTabButtonTabDisplayTabLabel.BackgroundTransparency = 1
	switchTabButtonTabDisplayTabLabel.LayoutOrder = 2
	switchTabButtonTabDisplayTabLabel.Size = UDim2.new(0.625, 0, 0.65, 0)
	switchTabButtonTabDisplayTabLabel.ZIndex = 1
	switchTabButtonTabDisplayTabLabel.Font = Enum.Font.SourceSans
	switchTabButtonTabDisplayTabLabel.Text = homeTabTitle
	switchTabButtonTabDisplayTabLabel.TextColor3 = Color3.fromRGB(221, 221, 221)
	switchTabButtonTabDisplayTabLabel.TextScaled = true
	switchTabButtonTabDisplayTabLabel.TextXAlignment = Enum.TextXAlignment.Left
	switchTabButtonTabDisplayTabLabel.TextYAlignment = Enum.TextYAlignment.Center


	--- [ HomePage (Pages) (Instance) ] ---


	local homePage = Instance.new("ScrollingFrame")
	homePage.Parent = pages
	homePage.Name = homeTabTitle
	homePage.BackgroundTransparency = 1
	homePage.Size = UDim2.new(1, 0, 1, 0)
	homePage.ZIndex = 1
	homePage.ClipsDescendants = true
	homePage.AutomaticCanvasSize = Enum.AutomaticSize.Y
	homePage.CanvasSize = UDim2.new(0, 0, 0, 0)
	homePage.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	homePage.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	homePage.ScrollBarImageTransparency = 1
	homePage.ScrollBarThickness = 0
	homePage.ScrollingDirection = Enum.ScrollingDirection.Y
	homePage.VerticalScrollBarInset = Enum.ScrollBarInset.None
	homePage.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left


	--- [ HomePage.TabsFrame (Pages) (Instance) ] ---


	local homePageTabsFrame = Instance.new("ScrollingFrame")
	homePageTabsFrame.Parent = homePage
	homePageTabsFrame.Name = "TabsFrame"
	homePageTabsFrame.BackgroundTransparency = 1
	homePageTabsFrame.Position = UDim2.new(0, 0, 0.475, 0)
	homePageTabsFrame.Size = UDim2.new(1, 0, 0.425, 0)
	homePageTabsFrame.ZIndex = 1
	homePageTabsFrame.ClipsDescendants = true
	homePageTabsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	homePageTabsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	homePageTabsFrame.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	homePageTabsFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	homePageTabsFrame.ScrollBarImageTransparency = 1
	homePageTabsFrame.ScrollBarThickness = 0
	homePageTabsFrame.ScrollingDirection = Enum.ScrollingDirection.Y
	homePageTabsFrame.VerticalScrollBarInset = Enum.ScrollBarInset.None
	homePageTabsFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left


	--- [ HomePage.TabsFrame.UIGridLayout (Pages) (Instance) ] ---


	local homePageTabsFrameUiGridLayout = Instance.new("UIGridLayout")
	homePageTabsFrameUiGridLayout.Parent = homePageTabsFrame
	homePageTabsFrameUiGridLayout.CellPadding = UDim2.new(0.03, 0, 0.115, 0)
	homePageTabsFrameUiGridLayout.CellSize = UDim2.new(0.095, 0, 0.39, 0)
	homePageTabsFrameUiGridLayout.FillDirection = Enum.FillDirection.Horizontal
	homePageTabsFrameUiGridLayout.FillDirectionMaxCells = 6
	homePageTabsFrameUiGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	homePageTabsFrameUiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	homePageTabsFrameUiGridLayout.StartCorner = Enum.StartCorner.TopLeft
	homePageTabsFrameUiGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top


	--- [ HomePage.TabsFrame.UIPadding (Pages) (Instance) ] ---


	local homePageTabsFrameUiPadding = Instance.new("UIPadding")
	homePageTabsFrameUiPadding.Parent = homePageTabsFrame
	homePageTabsFrameUiPadding.PaddingTop = UDim.new(0.04, 0)


	--- [ HomePage.WelcomeFrame (Pages) (Instance) ] ---


	local homePageWelcomeFrame = Instance.new("Frame")
	homePageWelcomeFrame.Parent = homePage
	homePageWelcomeFrame.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
	homePageWelcomeFrame.Position = UDim2.new(0.025, 0, 0.05, 0)
	homePageWelcomeFrame.Size = UDim2.new(0.95, 0, 0.35, 0)
	homePageWelcomeFrame.ZIndex = 1


	--- [ HomePage.WelcomeFrame.UICorner (Pages) (Instance) ] ---


	local homePageWelcomeFrameUiCorner = Instance.new("UICorner")
	homePageWelcomeFrameUiCorner.Parent = homePageWelcomeFrame
	homePageWelcomeFrameUiCorner.CornerRadius = UDim.new(0.1, 0)


	--- [ HomePage.WelcomeFrame.ProfileButton (Pages) (Instance) ] ---


	local homePageWelcomeFrameProfileButton = Instance.new("ImageButton")
	homePageWelcomeFrameProfileButton.Parent = homePageWelcomeFrame
	homePageWelcomeFrameProfileButton.Name = "ProfileButton"
	homePageWelcomeFrameProfileButton.AutoButtonColor = false
	homePageWelcomeFrameProfileButton.BackgroundTransparency = 1
	homePageWelcomeFrameProfileButton.Position = UDim2.new(0.85, 0, 0.675, 0)
	homePageWelcomeFrameProfileButton.Size = UDim2.new(0.06, 0, 0.2, 0)
	homePageWelcomeFrameProfileButton.ZIndex = 1
	homePageWelcomeFrameProfileButton.Image = "rbxassetid://14763739840"
	homePageWelcomeFrameProfileButton.ImageColor3 = Color3.fromRGB(150, 150, 150)
	homePageWelcomeFrameProfileButton.ScaleType = Enum.ScaleType.Crop
	
	
	--- [ ProfilePage (Pages) (Instance) ] ---
	
	
	local ProfilePage = _G.UIL.Element.Element:CreatePage("Profile", 14763739840, tabs, pages, tooltip, pagesUiPageLayout, homePage, HomeTab)
	
	
	--- [ ProfilePage.PlayerInformation (Pages) (Instance) ] ---

	
	local profilePagePlayerInformation = Instance.new("Frame")
	profilePagePlayerInformation.Parent = ProfilePage.page
	profilePagePlayerInformation.Name = "PlayerInformation"
	profilePagePlayerInformation.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	profilePagePlayerInformation.Size = UDim2.new(0.95, 0, 0.15, 0)
	profilePagePlayerInformation.ZIndex = 1


	--- [ ProfilePage.PlayerInformation.UICorner (Pages) (Instance) ] ---


	local profilePagePlayerInformationUiCorner = Instance.new("UICorner")
	profilePagePlayerInformationUiCorner.Parent = profilePagePlayerInformation
	profilePagePlayerInformationUiCorner.CornerRadius = UDim.new(0.25, 0)


	--- [ ProfilePage.PlayerInformation.UIListLayout (Pages) (Instance) ] ---


	local profilePagePlayerInformationUiListLayout = Instance.new("UIListLayout")
	profilePagePlayerInformationUiListLayout.Parent = profilePagePlayerInformation
	profilePagePlayerInformationUiListLayout.FillDirection = Enum.FillDirection.Vertical
	profilePagePlayerInformationUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	profilePagePlayerInformationUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	profilePagePlayerInformationUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center


	--- [ ProfilePage.PlayerInformation.UIStroke (Pages) (Instance) ] ---


	local profilePagePlayerInformationUiStroke = Instance.new("UIStroke")
	profilePagePlayerInformationUiStroke.Parent = profilePagePlayerInformation
	profilePagePlayerInformationUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	profilePagePlayerInformationUiStroke.Color = Color3.fromRGB(81, 81, 81)
	profilePagePlayerInformationUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	profilePagePlayerInformationUiStroke.Thickness = 2
	
	
	--- [ ProfilePage.PlayerInformation.Title (Pages) (Instance) ] ---


	local profilePagePlayerInformationTitle = Instance.new("TextLabel")
	profilePagePlayerInformationTitle.Parent = profilePagePlayerInformation
	profilePagePlayerInformationTitle.Name = "Title"
	profilePagePlayerInformationTitle.BackgroundTransparency = 1
	profilePagePlayerInformationTitle.LayoutOrder = 1
	profilePagePlayerInformationTitle.Size = UDim2.new(1, 0, 0.6, 0)
	profilePagePlayerInformationTitle.ZIndex = 1
	profilePagePlayerInformationTitle.Font = Enum.Font.SourceSansSemibold
	profilePagePlayerInformationTitle.Text = "Player Information"
	profilePagePlayerInformationTitle.TextColor3 = Color3.fromRGB(221, 221, 221)
	profilePagePlayerInformationTitle.TextScaled = true
	profilePagePlayerInformationTitle.TextXAlignment = Enum.TextXAlignment.Left
	profilePagePlayerInformationTitle.TextYAlignment = Enum.TextYAlignment.Center


	--- [ ProfilePage.PlayerInformation.Title.UIPadding (Pages) (Instance) ] ---


	local profilePagePlayerInformationTitleUiPadding = Instance.new("UIPadding")
	profilePagePlayerInformationTitleUiPadding.Parent = profilePagePlayerInformationTitle
	profilePagePlayerInformationTitleUiPadding.PaddingLeft = UDim.new(0.025, 0)
	
	
	profilePagePlayerInformationUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)
	
	
	--- [ ProfilePage.PlayerInformation.Script (Pages) (Script) ] ---
	
	
	local function CreateInformation(key: string, value: string)
		
		
		--- [ ProfilePage.PlayerInformation.Information (Pages) (Instance) ] ---
		
		
		local profilePagePlayerInformationInformation = Instance.new("Frame")
		profilePagePlayerInformationInformation.Parent = profilePagePlayerInformation
		profilePagePlayerInformationInformation.Name = "Information"
		profilePagePlayerInformationInformation.BackgroundTransparency = 1
		profilePagePlayerInformationInformation.LayoutOrder = 2
		profilePagePlayerInformationInformation.Size = UDim2.new(1, 0, 0.4, 0)
		profilePagePlayerInformationInformation.ZIndex = 1
		
		
		--- [ ProfilePage.PlayerInformation.Information.Key (Pages) (Instance) ] ---
		
		
		local profilePagePlayerInformationInformationKey = Instance.new("TextLabel")
		profilePagePlayerInformationInformationKey.Parent = profilePagePlayerInformationInformation
		profilePagePlayerInformationInformationKey.Name = "Key"
		profilePagePlayerInformationInformationKey.BackgroundTransparency = 1
		profilePagePlayerInformationInformationKey.Size = UDim2.new(0.25, 0, 1, 0)
		profilePagePlayerInformationInformationKey.ZIndex = 1
		profilePagePlayerInformationInformationKey.Font = Enum.Font.SourceSansSemibold
		profilePagePlayerInformationInformationKey.Text = key
		profilePagePlayerInformationInformationKey.TextColor3 = Color3.fromRGB(221, 221, 221)
		profilePagePlayerInformationInformationKey.TextScaled = 1
		profilePagePlayerInformationInformationKey.TextXAlignment = Enum.TextXAlignment.Left
		profilePagePlayerInformationInformationKey.TextYAlignment = Enum.TextYAlignment.Center
		
		
		--- [ ProfilePage.PlayerInformation.Information.Key.UIPadding (Pages) (Instance) ] ---


		local profilePagePlayerInformationInformationKeyUiPadding = Instance.new("UIPadding")
		profilePagePlayerInformationInformationKeyUiPadding.Parent = profilePagePlayerInformationInformationKey
		profilePagePlayerInformationInformationKeyUiPadding.PaddingLeft = UDim.new(0.1, 0)
		
		
		--- [ ProfilePage.PlayerInformation.Information.Value (Pages) (Instance) ] ---


		local profilePagePlayerInformationInformationValue = Instance.new("TextLabel")
		profilePagePlayerInformationInformationValue.Parent = profilePagePlayerInformationInformation
		profilePagePlayerInformationInformationValue.Name = "Value"
		profilePagePlayerInformationInformationValue.BackgroundTransparency = 1
		profilePagePlayerInformationInformationValue.Position = UDim2.new(0.25, 0, 0, 0)
		profilePagePlayerInformationInformationValue.Size = UDim2.new(0.75, 0, 1, 0)
		profilePagePlayerInformationInformationValue.ZIndex = 1
		profilePagePlayerInformationInformationValue.Font = Enum.Font.SourceSans
		profilePagePlayerInformationInformationValue.Text = value
		profilePagePlayerInformationInformationValue.TextColor3 = Color3.fromRGB(150, 150, 150)
		profilePagePlayerInformationInformationValue.TextScaled = 1
		profilePagePlayerInformationInformationValue.TextXAlignment = Enum.TextXAlignment.Left
		profilePagePlayerInformationInformationValue.TextYAlignment = Enum.TextYAlignment.Center
		
		
		--- [ ProfilePage.PlayerInformation.Information.Value.UIPadding (Pages) (Instance) ] ---


		local profilePagePlayerInformationInformationValueUiPadding = Instance.new("UIPadding")
		profilePagePlayerInformationInformationValueUiPadding.Parent = profilePagePlayerInformationInformationValue
		profilePagePlayerInformationInformationValueUiPadding.PaddingLeft = UDim.new(0.035, 0)
	end
	
	
	local function UpdatePlayerInformationSize()
		local totalPlayerInformationHeight = 0
		for _, v in pairs(profilePagePlayerInformation:GetChildren()) do
			if v.Name == "Information" then
				v.Size = UDim2.new(v.Size.X.Scale, 0, 0, v.AbsoluteSize.Y)
				totalPlayerInformationHeight += v.AbsoluteSize.Y
			end
		end
		profilePagePlayerInformationTitle.Size = UDim2.new(profilePagePlayerInformationTitle.Size.X.Scale, 0, 0, profilePagePlayerInformationTitle.AbsoluteSize.Y)
		profilePagePlayerInformation.Size = UDim2.new(profilePagePlayerInformation.Size.X.Scale, 0, 0, profilePagePlayerInformationTitle.AbsoluteSize.Y + totalPlayerInformationHeight)
	end
	
	
	local timeTable = os.date("*t", _G.UIL.Service.Player.AccountAge * 86400)
	
	
	CreateInformation("Account Age",  string.format("%02d Years %02d Months %02d Days", timeTable.year - 1970, timeTable.month - 1, timeTable.day - 1))
	CreateInformation("Username", _G.UIL.Service.Player.Name)
	CreateInformation("Displayname", _G.UIL.Service.Player.DisplayName)
	CreateInformation("Locale ID", _G.UIL.Service.Player.LocaleId)
	CreateInformation("User ID", _G.UIL.Service.Player.UserId)
	CreateInformation("Verified", _G.UIL.Service.Player.HasVerifiedBadge and "Verified" or "Not Verified")
	CreateInformation("Membership", _G.UIL.Service.Player.MembershipType.Name)


	UpdatePlayerInformationSize()


	--- [ HomePage.WelcomeFrame.ProfileButton.Script (Pages) (Event) ] ---
	
	
	local animation: Tween = nil
	
	
	_G.UIL.Function.CreateEvent(
		"Profile Button (MouseEnter)",
		homePageWelcomeFrameProfileButton.MouseEnter,
		function()
			if animation ~= nil then animation:Cancel() end
			animation = _G.UIL.Function.Animate(homePageWelcomeFrameProfileButton, "ImageColor3", Color3.fromRGB(200, 200, 200))
			animation.Completed:Wait()
			animation = nil
		end
	)

	
	_G.UIL.Function.CreateEvent(
		"Profile Button (MouseLeave)",
		homePageWelcomeFrameProfileButton.MouseLeave,
		function()
			if animation ~= nil then animation:Cancel() end
			animation = _G.UIL.Function.Animate(homePageWelcomeFrameProfileButton, "ImageColor3", Color3.fromRGB(150, 150, 150))
			animation.Completed:Wait()
			animation = nil
		end
	)

	
	_G.UIL.Function.CreateEvent(
		"Profile Button (MouseButton1Click)",
		homePageWelcomeFrameProfileButton.MouseButton1Click,
		function()
			ProfilePage:Select()
			if animation ~= nil then animation:Cancel() end
			animation = _G.UIL.Function.Animate(homePageWelcomeFrameProfileButton, "ImageColor3", Color3.fromRGB(250, 250, 250))
			animation.Completed:Wait()
			animation = _G.UIL.Function.Animate(homePageWelcomeFrameProfileButton, "ImageColor3", Color3.fromRGB(200, 200, 200))
			animation.Completed:Wait()
			animation = nil
		end
	)
	

	--- [ HomePage.WelcomeFrame.SettingsButton (Pages) (Instance) ] ---


	local homePageWelcomeFrameSettingsButton = Instance.new("ImageButton")
	homePageWelcomeFrameSettingsButton.Parent = homePageWelcomeFrame
	homePageWelcomeFrameSettingsButton.Name = "SettingsButton"
	homePageWelcomeFrameSettingsButton.AutoButtonColor = false
	homePageWelcomeFrameSettingsButton.BackgroundTransparency = 1
	homePageWelcomeFrameSettingsButton.Position = UDim2.new(0.93, 0, 0.675, 0)
	homePageWelcomeFrameSettingsButton.Size = UDim2.new(0.04, 0, 0.2, 0)
	homePageWelcomeFrameSettingsButton.ZIndex = 1
	homePageWelcomeFrameSettingsButton.Image = "rbxassetid://14763766487"
	homePageWelcomeFrameSettingsButton.ImageColor3 = Color3.fromRGB(150, 150, 150)
	homePageWelcomeFrameSettingsButton.ScaleType = Enum.ScaleType.Crop
	
	
	--- [ SettingsPage (Pages) (Instance) ] ---


	_G.Synergia.Window.Settings = _G.UIL.Element.Element:CreatePage("Settings", 14763766487, tabs, pages, tooltip, pagesUiPageLayout, homePage, HomeTab)
	
	
	local isWindowVisible = true
	
	
	_G.Synergia.Window.Settings:CreateKeybind({
		title = "Show/Hide Main Window",
		description = "Used to show or hide the main window.",
		default = Enum.KeyCode.R,
		callback = function()
			if isWindowVisible then _G.Synergia.Window:Hide()
			else _G.Synergia.Window:Show() end
		end
	})
	

	--- [ HomePage.WelcomeFrame.SettingsButton.Script (Pages) (Event) ] ---


	local animation: Tween = nil

	
	_G.UIL.Function.CreateEvent(
		"Settings Button (MouseEnter)",
		homePageWelcomeFrameSettingsButton.MouseEnter,
		function()
			if animation ~= nil then animation:Cancel() end
			animation = _G.UIL.Function.Animate(homePageWelcomeFrameSettingsButton, "ImageColor3", Color3.fromRGB(200, 200, 200))
			animation.Completed:Wait()
			animation = nil
		end
	)

	
	_G.UIL.Function.CreateEvent(
		"Settings Button (MouseLeave)",
		homePageWelcomeFrameSettingsButton.MouseLeave,
		function()
			if animation ~= nil then animation:Cancel() end
			animation = _G.UIL.Function.Animate(homePageWelcomeFrameSettingsButton, "ImageColor3", Color3.fromRGB(150, 150, 150))
			animation.Completed:Wait()
			animation = nil
		end
	)

	
	_G.UIL.Function.CreateEvent(
		"Settings Button (MouseButton1Click)",
		homePageWelcomeFrameSettingsButton.MouseButton1Click,
		function()
			_G.Synergia.Window.Settings:Select()
			if animation ~= nil then animation:Cancel() end
			animation = _G.UIL.Function.Animate(homePageWelcomeFrameSettingsButton, "ImageColor3", Color3.fromRGB(250, 250, 250))
			animation.Completed:Wait()
			animation = _G.UIL.Function.Animate(homePageWelcomeFrameSettingsButton, "ImageColor3", Color3.fromRGB(200, 200, 200))
			animation.Completed:Wait()
			animation = nil
		end
	)
	
	
	--- [ HomePage.WelcomeFrame.ProfilePicture (Pages) (Instance) ] ---


	local homePageWelcomeFrameProfilePicture = Instance.new("ImageLabel")
	homePageWelcomeFrameProfilePicture.Parent = homePageWelcomeFrame
	homePageWelcomeFrameProfilePicture.Name = "ProfilePicture"
	homePageWelcomeFrameProfilePicture.BackgroundColor3 = Color3.fromRGB(56, 56, 56)
	homePageWelcomeFrameProfilePicture.Position = UDim2.new(0.025, 0, 0.1, 0)
	homePageWelcomeFrameProfilePicture.Size = UDim2.new(0.164, 0, 0.8, 0)
	homePageWelcomeFrameProfilePicture.ZIndex = 1
	homePageWelcomeFrameProfilePicture.ScaleType = Enum.ScaleType.Crop


	--- [ HomePage.WelcomeFrame.ProfilePicture.UICorner (Pages) (Instance) ] ---


	local homePageWelcomeFrameProfilePictureUiCorner = Instance.new("UICorner")
	homePageWelcomeFrameProfilePictureUiCorner.Parent = homePageWelcomeFrameProfilePicture
	homePageWelcomeFrameProfilePictureUiCorner.CornerRadius = UDim.new(1, 0)


	--- [ HomePage.WelcomeFrame.ProfilePicture.UIStroke (Pages) (Instance) ] ---


	local homePageWelcomeFrameProfilePictureUiStroke = Instance.new("UIStroke")
	homePageWelcomeFrameProfilePictureUiStroke.Parent = homePageWelcomeFrameProfilePicture
	homePageWelcomeFrameProfilePictureUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	homePageWelcomeFrameProfilePictureUiStroke.Color = Color3.fromRGB(41, 41, 41)
	homePageWelcomeFrameProfilePictureUiStroke.LineJoinMode = Enum.LineJoinMode.Round
	homePageWelcomeFrameProfilePictureUiStroke.Thickness = 5


	--- [ HomePage.WelcomeFrame.Displayname (Pages) (Instance) ] ---


	local homePageWelcomeFrameDisplayname = Instance.new("TextLabel")
	homePageWelcomeFrameDisplayname.Parent = homePageWelcomeFrame
	homePageWelcomeFrameDisplayname.Name = "Displayname"
	homePageWelcomeFrameDisplayname.BackgroundTransparency = 1
	homePageWelcomeFrameDisplayname.Position = UDim2.new(0.44, 0, 0.1, 0)
	homePageWelcomeFrameDisplayname.Size = UDim2.new(0.56, 0, 0.3, 0)
	homePageWelcomeFrameDisplayname.ZIndex = 1
	homePageWelcomeFrameDisplayname.Font = Enum.Font.SourceSansBold
	homePageWelcomeFrameDisplayname.TextColor3 = Color3.fromRGB(0, 191, 191)
	homePageWelcomeFrameDisplayname.TextScaled = true
	homePageWelcomeFrameDisplayname.TextXAlignment = Enum.TextXAlignment.Left
	homePageWelcomeFrameDisplayname.TextYAlignment = Enum.TextYAlignment.Center


	--- [ HomePage.WelcomeFrame.Time (Pages) (Instance) ] ---


	local homePageWelcomeFrameTime = Instance.new("TextLabel")
	homePageWelcomeFrameTime.Parent = homePageWelcomeFrame
	homePageWelcomeFrameTime.Name = "Time"
	homePageWelcomeFrameTime.BackgroundTransparency = 1
	homePageWelcomeFrameTime.Position = UDim2.new(0.225, 0, 0.6, 0)
	homePageWelcomeFrameTime.Size = UDim2.new(0.775, 0, 0.2, 0)
	homePageWelcomeFrameTime.ZIndex = 1
	homePageWelcomeFrameTime.Font = Enum.Font.SourceSans
	homePageWelcomeFrameTime.TextColor3 = Color3.fromRGB(192, 192, 192)
	homePageWelcomeFrameTime.TextScaled = true
	homePageWelcomeFrameTime.TextXAlignment = Enum.TextXAlignment.Left
	homePageWelcomeFrameTime.TextYAlignment = Enum.TextYAlignment.Center


	--- [ HomePage.WelcomeFrame.Username (Pages) (Instance) ] ---


	local homePageWelcomeFrameUsername = Instance.new("TextLabel")
	homePageWelcomeFrameUsername.Parent = homePageWelcomeFrame
	homePageWelcomeFrameUsername.Name = "Username"
	homePageWelcomeFrameUsername.BackgroundTransparency = 1
	homePageWelcomeFrameUsername.Position = UDim2.new(0.225, 0, 0.4, 0)
	homePageWelcomeFrameUsername.Size = UDim2.new(0.775, 0, 0.2, 0)
	homePageWelcomeFrameUsername.ZIndex = 1
	homePageWelcomeFrameUsername.Font = Enum.Font.SourceSans
	homePageWelcomeFrameUsername.TextColor3 = Color3.fromRGB(128, 128, 255)
	homePageWelcomeFrameUsername.TextScaled = true
	homePageWelcomeFrameUsername.TextXAlignment = Enum.TextXAlignment.Left
	homePageWelcomeFrameUsername.TextYAlignment = Enum.TextYAlignment.Center


	--- [ HomePage.WelcomeFrame.Welcome (Pages) (Instance) ] ---


	local homePageWelcomeFrameWelcome = Instance.new("TextLabel")
	homePageWelcomeFrameWelcome.Parent = homePageWelcomeFrame
	homePageWelcomeFrameWelcome.Name = "Welcome"
	homePageWelcomeFrameWelcome.BackgroundTransparency = 1
	homePageWelcomeFrameWelcome.Position = UDim2.new(0.225, 0, 0.1, 0)
	homePageWelcomeFrameWelcome.Size = UDim2.new(0.518, 0, 0.3, 0)
	homePageWelcomeFrameWelcome.ZIndex = 1
	homePageWelcomeFrameWelcome.Font = Enum.Font.SourceSans
	homePageWelcomeFrameWelcome.Text = "Welcome,"
	homePageWelcomeFrameWelcome.TextColor3 = Color3.fromRGB(255, 165, 0)
	homePageWelcomeFrameWelcome.TextScaled = true
	homePageWelcomeFrameWelcome.TextXAlignment = Enum.TextXAlignment.Left
	homePageWelcomeFrameWelcome.TextYAlignment = Enum.TextYAlignment.Center

	
	--- [ HomeTab.Script (Tabs) (Script) ] ---


	local wordThreshold = 11
	local numWords = string.len(homeTabTitle)
	local isTruncated = numWords > wordThreshold


	if isTruncated then
		switchTabButtonTabDisplayTabLabel.Text = homeTabTitle:sub(1, wordThreshold - 1) .. "..."
	end


	--- [ HomeTab.Script (Tabs) (Event) ] ---

	
	HomeTab:SetAttribute("Enabled", true)
	pagesUiPageLayout:JumpTo(homePage)
	_G.UIL.Function.Animate(HomeTab, "BackgroundColor3", Color3.fromRGB(68, 68, 68))

	
	_G.UIL.Function.CreateEvent(
		"Home Switch Tab Button (MouseButton1Click)",
		switchTabButton.MouseButton1Click,
		function()
			HomeTab:SetAttribute("Enabled", true)
			pagesUiPageLayout:JumpTo(homePage)
			_G.UIL.Function.Animate(HomeTab, "BackgroundColor3", Color3.fromRGB(68, 68, 68))
			for _, v in pairs(tabs:GetChildren()) do
				if v:IsA("Frame") and v.Name ~= homeTabTitle then
					v:SetAttribute("Enabled", false)
					_G.UIL.Function.Animate(v, "BackgroundColor3", Color3.fromRGB(30, 30, 30))
				end
			end
		end
	)

	
	_G.UIL.Function.CreateEvent(
		"Home Switch Tab Button (MouseEnter)",
		switchTabButton.MouseEnter,
		function()
			if not HomeTab:GetAttribute("Enabled") then
				_G.UIL.Function.Animate(HomeTab, "BackgroundColor3", Color3.fromRGB(49, 49, 49))
			end
			if isTruncated then
				tooltip.Text = homeTabTitle
				tooltip.Size = UDim2.new(0, tooltip.TextBounds.X * 1.05, 0.03, 0)
				tooltip.Visible = true
			end
		end
	)

	
	_G.UIL.Function.CreateEvent(
		"Home Switch Tab Button (MouseMoved)",
		switchTabButton.MouseMoved,
		function()
			if not isTruncated then return end
			local cursorPosition = game:GetService("UserInputService"):GetMouseLocation()
			tooltip.Position = UDim2.new(0, cursorPosition.X - tooltip.AbsoluteSize.X / 2, 0, cursorPosition.Y * 1.7 - cursorPosition.Y)
		end
	)

	
	_G.UIL.Function.CreateEvent(
		"Home Switch Tab Button (MouseLeave)",
		switchTabButton.MouseLeave,
		function()
			if not HomeTab:GetAttribute("Enabled") then
				_G.UIL.Function.Animate(HomeTab, "BackgroundColor3", Color3.fromRGB(30, 30, 30))
			end
			tooltip.Visible = false
			tooltip.Size = UDim2.new(1, 0, 0.03, 0)
		end
	)


	--- [ HomePage.Script (Tabs) (Script) ] ---


	local time = os.date("*t")
	local ampm = "AM"
	local hour = time.hour
	local lastMinute = os.date("*t").min


	homePageWelcomeFrameProfilePicture.Image = _G.UIL.Service.Players:GetUserThumbnailAsync(_G.UIL.Service.Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	homePageWelcomeFrameDisplayname.Text = _G.UIL.Service.Player.DisplayName
	homePageWelcomeFrameUsername.Text = "@" .. _G.UIL.Service.Player.Name


	local function updateTime()
		local time = os.date("*t")
		local hour = time.hour

		if hour >= 12 then ampm = "PM"
			if hour > 12 then hour -= 12 end
		else ampm = "AM"
			if hour == 0 then
				homePageWelcomeFrameTime.Text = string.format("%02d:%02d %s", 12, time.min, ampm)
				return
			end
		end
		homePageWelcomeFrameTime.Text = string.format("%02d:%02d %s", hour, time.min, ampm)
	end


	updateTime()


	--- [ HomePage.Script (Tabs) (Event) ] ---

	
	_G.UIL.Function.CreateEvent(
		"Heartbeat",
		_G.UIL.Service.RunService.Heartbeat,
		function()
			local currentTime = os.date("*t")
			if currentTime.min ~= lastMinute then
				lastMinute = currentTime.min
				updateTime()
			end
		end
	)
	
	
	function _G.Synergia.Window:CreateTab(content: { title: string, icon: number })
		assert(content.title and content.icon, "Missing arguments while trying to create a tab.")
		return _G.UIL.Element.Element:CreateTab(content.title, content.icon, tabs, pages, homePageTabsFrame, tooltip, pagesUiPageLayout, homePage, HomeTab)
	end


	function _G.Synergia.Window:Destroy()
		GUI:Destroy()
		for name, _ in pairs(_G.UIL.Service.Processes) do _G.UIL.Function.CloseProcess(name) end
		for name, _ in pairs(_G.UIL.Service.Events) do _G.UIL.Function.CloseEvent(name) end
		_G.UIL.Service.Processes = {}
		_G.UIL.Service.Events = {}
		_G.Synergia.Window = nil
	end
	
	
	function _G.Synergia.Window:Show()
		window.Visible = true
		isWindowVisible = true
	end
	
	
	function _G.Synergia.Window:Hide()
		window.Visible = false
		isWindowVisible = false
	end
	
	
	local Changelog = nil

	
	function _G.Synergia.Window:CreateChangelog()
		assert(not Changelog, "Attempted to create changelog when it had already been created.")
		local changelogMeta = setmetatable({}, Changelog)
		local changelogTab = _G.Synergia.Window:CreateTab({
			title = "Changelog",
			icon = 14757049793
		})
		
		
		Changelog = {}
		Changelog.__index = Changelog
		
		
		local Changelogs = {}
		Changelogs.__index = Changelogs
		setmetatable({}, Changelogs)
		
		
		function changelogMeta:Add(content: { title: string, changes: { string } })
			local changelogsMeta = setmetatable({}, Changelogs)


			--- [ Page.Changelog (Pages) (Instance) ] ---


			local changelog = Instance.new("Frame")
			changelog.Parent = changelogTab.page
			changelog.Name = "Changelog"
			changelog.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			changelog.Size = UDim2.new(0.95, 0, 0.15, 0)
			changelog.ZIndex = 1


			--- [ Page.Changelog.UICorner (Pages) (Instance) ] ---


			local changelogUiCorner = Instance.new("UICorner")
			changelogUiCorner.Parent = changelog
			changelogUiCorner.CornerRadius = UDim.new(0.25, 0)


			--- [ Page.Changelog.UIListLayout (Pages) (Instance) ] ---


			local changelogUiListLayout = Instance.new("UIListLayout")
			changelogUiListLayout.Parent = changelog
			changelogUiListLayout.FillDirection = Enum.FillDirection.Vertical
			changelogUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			changelogUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			changelogUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center


			--- [ Page.Changelog.UIStroke (Pages) (Instance) ] ---


			local changelogUiStroke = Instance.new("UIStroke")
			changelogUiStroke.Parent = changelog
			changelogUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			changelogUiStroke.Color = Color3.fromRGB(81, 81, 81)
			changelogUiStroke.LineJoinMode = Enum.LineJoinMode.Round
			changelogUiStroke.Thickness = 2


			--- [ Page.Changelog.Title (Pages) (Instance) ] ---


			local changelogTitle = Instance.new("TextLabel")
			changelogTitle.Parent = changelog
			changelogTitle.Name = "Title"
			changelogTitle.BackgroundTransparency = 1
			changelogTitle.LayoutOrder = 1
			changelogTitle.Size = UDim2.new(1, 0, 0.6, 0)
			changelogTitle.ZIndex = 1
			changelogTitle.Font = Enum.Font.SourceSansSemibold
			changelogTitle.Text = content.title
			changelogTitle.TextColor3 = Color3.fromRGB(221, 221, 221)
			changelogTitle.TextScaled = true
			changelogTitle.TextXAlignment = Enum.TextXAlignment.Left
			changelogTitle.TextYAlignment = Enum.TextYAlignment.Center


			--- [ Page.Changelog.Title.UIPadding (Pages) (Instance) ] ---


			local changelogTitleUiPadding = Instance.new("UIPadding")
			changelogTitleUiPadding.Parent = changelogTitle
			changelogTitleUiPadding.PaddingLeft = UDim.new(0.025, 0)


			changelogUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)


			local function updateChangelogSize()
				local totalChangelogHeight = 0
				for _, v in pairs(changelog:GetChildren()) do
					if v.Name == "Change" then
						v.Size = UDim2.new(v.Size.X.Scale, 0, 0, v.AbsoluteSize.Y)
						totalChangelogHeight += v.AbsoluteSize.Y
					end
				end
				changelogTitle.Size = UDim2.new(changelogTitle.Size.X.Scale, 0, 0, changelogTitle.AbsoluteSize.Y)
				changelog.Size = UDim2.new(changelog.Size.X.Scale, 0, 0, changelogTitle.AbsoluteSize.Y + totalChangelogHeight)
			end


			local function CreateChange(change: string)


				--- [ Changelog.Change (Page) (Instance) ] ---


				local changelogChange = Instance.new("TextLabel")
				changelogChange.Parent = changelog
				changelogChange.Name = "Change"
				changelogChange.BackgroundTransparency = 1
				changelogChange.LayoutOrder = 2
				changelogChange.Size = UDim2.new(1, 0, 0.4, 0)
				changelogChange.ZIndex = 1
				changelogChange.Font = Enum.Font.SourceSans
				changelogChange.Text = change
				changelogChange.TextColor3 = Color3.fromRGB(150, 150, 150)
				changelogChange.TextScaled = true
				changelogChange.TextXAlignment = Enum.TextXAlignment.Left
				changelogChange.TextYAlignment = Enum.TextYAlignment.Center


				--- [ Page.Changelog.Change.UIPadding (Pages) (Instance) ] ---


				local changelogChangeUiPadding = Instance.new("UIPadding")
				changelogChangeUiPadding.Parent = changelogChange
				changelogChangeUiPadding.PaddingLeft = UDim.new(0.025, 0)
			end


			for _, change in pairs(content.changes) do CreateChange(change) end


			updateChangelogSize()
			

			function changelogsMeta:Destroy() changelog:Destroy() end
			
			
			return changelogsMeta
		end
		
		
		function changelogMeta:Destroy()
			spawn(function()
				changelogMeta = nil
				changelogTab:Destroy()
				Changelog = {}
				Changelog.__index = Changelog
			end)
		end
		
		
		return changelogMeta
	end


	local Credits = nil
	
	
	function _G.Synergia.Window:CreateCredits()
		assert(not Credits, "Attempted to create credits when it had already been created.")
		local creditsMeta = setmetatable({}, Credits)
		local creditsTab = _G.Synergia.Window:CreateTab({
			title = "Credits",
			icon = 14757105352
		})


		Credits = {}
		Credits.__index = Credits


		local Credit = {}
		Credit.__index = Credit
		setmetatable({}, Credit)


		function creditsMeta:Add(content: { title: string, contributors: { string } })
			local creditMeta = setmetatable({}, Credit)


			--- [ Page.Credits (Pages) (Instance) ] ---


			local credits = Instance.new("Frame")
			credits.Parent = creditsTab.page
			credits.Name = "Credits"
			credits.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			credits.Size = UDim2.new(0.95, 0, 0.15, 0)
			credits.ZIndex = 1


			--- [ Page.Credits.UICorner (Pages) (Instance) ] ---


			local creditsUiCorner = Instance.new("UICorner")
			creditsUiCorner.Parent = credits
			creditsUiCorner.CornerRadius = UDim.new(0.25, 0)


			--- [ Page.Credits.UIListLayout (Pages) (Instance) ] ---


			local creditsUiListLayout = Instance.new("UIListLayout")
			creditsUiListLayout.Parent = credits
			creditsUiListLayout.FillDirection = Enum.FillDirection.Vertical
			creditsUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			creditsUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			creditsUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center


			--- [ Page.Credits.UIStroke (Pages) (Instance) ] ---


			local creditsUiStroke = Instance.new("UIStroke")
			creditsUiStroke.Parent = credits
			creditsUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			creditsUiStroke.Color = Color3.fromRGB(81, 81, 81)
			creditsUiStroke.LineJoinMode = Enum.LineJoinMode.Round
			creditsUiStroke.Thickness = 2


			--- [ Page.Credits.Title (Pages) (Instance) ] ---


			local creditsTitle = Instance.new("TextLabel")
			creditsTitle.Parent = credits
			creditsTitle.Name = "Title"
			creditsTitle.BackgroundTransparency = 1
			creditsTitle.LayoutOrder = 1
			creditsTitle.Size = UDim2.new(1, 0, 0.6, 0)
			creditsTitle.ZIndex = 1
			creditsTitle.Font = Enum.Font.SourceSansSemibold
			creditsTitle.Text = content.title
			creditsTitle.TextColor3 = Color3.fromRGB(221, 221, 221)
			creditsTitle.TextScaled = true
			creditsTitle.TextXAlignment = Enum.TextXAlignment.Center
			creditsTitle.TextYAlignment = Enum.TextYAlignment.Center


			creditsUiCorner.CornerRadius = UDim.new(0, (_G.UIL.Service.MonitorSize.X - _G.UIL.Service.MonitorSize.Y) * 0.0275)


			local function updateCreditsSize()
				local totalCreditsHeight = 0
				for _, v in pairs(credits:GetChildren()) do
					if v.Name == "Contributor" then
						v.Size = UDim2.new(v.Size.X.Scale, 0, 0, v.AbsoluteSize.Y)
						totalCreditsHeight += v.AbsoluteSize.Y
					end
				end
				creditsTitle.Size = UDim2.new(creditsTitle.Size.X.Scale, 0, 0, creditsTitle.AbsoluteSize.Y)
				credits.Size = UDim2.new(credits.Size.X.Scale, 0, 0, creditsTitle.AbsoluteSize.Y + totalCreditsHeight)
			end


			local function CreateContributor(contributor: string)


				--- [ Credits.Contributor (Page) (Instance) ] ---


				local creditsContributor = Instance.new("TextLabel")
				creditsContributor.Parent = credits
				creditsContributor.Name = "Contributor"
				creditsContributor.BackgroundTransparency = 1
				creditsContributor.LayoutOrder = 2
				creditsContributor.Size = UDim2.new(1, 0, 0.4, 0)
				creditsContributor.ZIndex = 1
				creditsContributor.Font = Enum.Font.SourceSans
				creditsContributor.Text = contributor
				creditsContributor.TextColor3 = Color3.fromRGB(150, 150, 150)
				creditsContributor.TextScaled = true
				creditsContributor.TextXAlignment = Enum.TextXAlignment.Center
				creditsContributor.TextYAlignment = Enum.TextYAlignment.Center
			end


			for _, contributor in pairs(content.contributors) do CreateContributor(contributor) end


			updateCreditsSize()


			function creditMeta:Destroy() credits:Destroy() end


			return creditMeta
		end


		function creditsMeta:Destroy()
			spawn(function()
				creditsMeta = nil
				creditsTab:Destroy()
				Credits = {}
				Credits.__index = Credits
			end)
		end


		return creditsMeta
	end
	
	
	_G.UIL.Function.CreateProcess("Cleanup", function()
		while true do task.wait(5)
			for name: string, process: thread in pairs(_G.UIL.Service.Processes) do
				if coroutine.status(process) == "dead" then _G.UIL.Function.CloseProcess(name) end
			end


			for name: string, event: RBXScriptConnection in pairs(_G.UIL.Service.Events) do
				if not event.Connected then _G.UIL.Function.CloseEvent(name) end
			end
		end
	end)
	
	
	function _G.Synergia.Window:CreateProcess(name: string, process: any)
		_G.UIL.Function.CreateProcess(name, process)
	end
	
	
	function _G.Synergia.Window:CloseProcess(name: string)
		_G.UIL.Function.CloseProcess(name)
	end
	
	
	function _G.Synergia.Window:CreateEvent(name: string, event: RBXScriptSignal, callback: any)
		_G.UIL.Function.CreateEvent(name, event, callback)
	end


	function _G.Synergia.Window:CloseEvent(name: string)
		_G.UIL.Function.CloseEvent(name)
	end
	
	
	return _G.Synergia.Window
end


return _G.Synergia
