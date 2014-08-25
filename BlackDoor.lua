local Entity = require("Entity")
local BoxCollider = require("BoxCollider")

local BlackDoor = class("BlackDoor", Entity)

function BlackDoor:initialize(x, y, left, right, id)
	self.x, self.y = x, y
	self.z = 1
	self.left, self.right = left, right
	self.name = "blackdoor"
	self.id = id
	self.open = false
	self.blink = 0

	self.collider = BoxCollider(40, 80)

	self.quad_closed = love.graphics.newQuad(0, 0, 40, 80, 80, 80)
	self.quad_open = love.graphics.newQuad(40, 0, 40, 80, 80, 80)
	self.sprite = Resources.static:getImage("blackdoor.png")
end

function BlackDoor:update(dt)
	if self.blink > 0 then
		self.blink = self.blink - dt
	end
end

function BlackDoor:draw()
	if self.blink > 0 then
		love.graphics.draw(self.sprite, self.quad_open, self.x, self.y, 0, 1, 1, 20, 40)
		if math.cos(self.blink*50) < 0 then
			love.graphics.setBlendMode("additive")
			love.graphics.draw(self.sprite, self.quad_open, self.x, self.y, 0, 1, 1, 20, 40)
			love.graphics.setBlendMode("alpha")
		end
	elseif self.open then
		love.graphics.draw(self.sprite, self.quad_open, self.x, self.y, 0, 1, 1, 20, 40)
	else
		love.graphics.draw(self.sprite, self.quad_closed, self.x, self.y, 0, 1, 1, 20, 40)
	end
end

function BlackDoor:onCollide(collider)
	if collider.name == "superslash" and self.open == false then
		self.open = true
		self.collider.w = 10
		self.blink = 0.5
		Sound.play("door")
	elseif collider.name == "player" and self.open == true then
		local world = self.scene:find("world")
		local player = self.scene:find("player")
		if world:getRoom().id == self.left then
			world:goToRoom(self.right, self)
		else
			world:goToRoom(self.left, self)
		end
	end
end

return BlackDoor
