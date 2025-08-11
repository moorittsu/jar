-- Define the player table to hold all player-related data and functions
player = {}

-- Initializes the player and its physics body
function player.load(world)
    -- Player position and size
    player.x = 100
    player.y = 100
    player.width = 20
    player.height = 20

    -- Player movement variables
    player.xvel = 0
    player.yvel = 0
    player.maxspeed = 200
    player.acceleration = 4000
    player.friction = 3500

    -- Physics setup for the player
    player.physics = {}
    -- Create a new physics body in the world at (player.x, player.y)
    player.physics.body = love.physics.newBody(world, player.x, player.y, "dynamic")
    -- Prevent the body from rotating
    player.physics.body:setFixedRotation(true)
    -- Define the shape of the physics body (rectangle)
    player.physics.shape = love.physics.newRectangleShape(player.width, player.height)
    -- Attach the shape to the body as a fixture
    player.physics.fixture = love.physics.newFixture(player.physics.body, player.physics.shape)
end

-- Updates the player's state every frame
function player:update(dt)
 -- Update player movement based on input
    self:move(dt)
    self:syncPhysics()
end

function player:move(dt)
    local vx, vy = self.physics.body:getLinearVelocity()

    -- Handle left/right movement
    if love.keyboard.isDown("left") then
        vx = vx - self.acceleration * dt
    elseif love.keyboard.isDown("right") then
        vx = vx + self.acceleration * dt
    else
        -- Apply friction when no keys are pressed
        vx = vx * (1 - self.friction * dt)
    end

    -- Clamp the player's velocity to the maximum speed
    if math.abs(vx) > self.maxspeed then
        vx = self.maxspeed * (vx < 0 and -1 or 1)
    end

    -- Set the new velocity, keeping the current vertical (y) velocity
    self.physics.body:setLinearVelocity(vx, vy)
end

-- Synchronizes the player's position and velocity with its physics body
function player:syncPhysics()
    -- Get the current position from the physics body
    self.x, self.y = self.physics.body:getPosition()
    -- No need to set velocity here!
end

-- Draws the player as a white rectangle
function player:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
