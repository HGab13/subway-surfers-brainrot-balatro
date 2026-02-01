--- STEAMODDED HEADER
--- MOD_NAME: Subway Surfers Brainrot
--- MOD_ID: SubwayS
--- MOD_AUTHOR: [HGab13]
--- MOD_DESCRIPTION: Skibidi ohio rizz stimulation a gif of subway surfers has appeared on the top left of your screen matcha labubu dubai chocolate

----------------------------------------------
------------MOD CODE -------------------------


local gameUpdateRef = Game.update
local gameDrawRef = Game.draw


G.SubwayGif = {
    show_gif = true,
    subway_current_frame = 1,
    subway_frames = {},
    subway_frame_time = 0,
    subway_frame_delay = 0.05,
    mod_path = SMODS.current_mod.path,

    pos_x = 0,
    pos_y = 0,
    opacity = 255
}

for i = 0, (83 - 1) do
    local full_path = G.SubwayGif.mod_path .. "assets/customimages/subway_" .. i .. ".png"
    local file_data = assert(NFS.newFileData(full_path))
    local image_data = assert(love.image.newImageData(file_data))
    G.SubwayGif.subway_frames[i + 1] = love.graphics.newImage(image_data)
end

SMODS.Sound({
    key = "jumpscaresfx",
    path = {
        ["default"] = "subway-surfers.mp3"
    }
})

local function check_pos_collision(x1, y1, x2, y2, w2, h2)
    if (x1 >= x2 and x1 <= x2 + w2) and (y1 >= y2 and y1 <= y2 + h2) then
        return true
    end
    return false
end

local function clamp(min, val, max)
    if val < min then
        return min
    elseif val > max then
        return max
    end
    return val
end

function Game:update(dt)
    gameUpdateRef(self, dt)

    local mouse_x, mouse_y = love.mouse.getPosition()

    G.SubwayGif.subway_frame_time = math.fmod(G.SubwayGif.subway_frame_time + dt, 83 * G.SubwayGif.subway_frame_delay)
    G.SubwayGif.subway_current_frame = math.fmod(math.floor(G.SubwayGif.subway_frame_time / G.SubwayGif.subway_frame_delay), 83 + 1) + 1

    local curFrame = G.SubwayGif.subway_frames[G.SubwayGif.subway_current_frame]

    if check_pos_collision(mouse_x, mouse_y, G.SubwayGif.pos_x, G.SubwayGif.pos_y, curFrame:getWidth(), curFrame:getHeight()) then
        G.SubwayGif.opacity = clamp(25, G.SubwayGif.opacity - (1000 * dt), 255)
    elseif check_pos_collision(mouse_x - 100, mouse_y - 100, G.SubwayGif.pos_x, G.SubwayGif.pos_y, curFrame:getWidth() + 100, curFrame:getHeight() + 100) then
        G.SubwayGif.opacity = clamp(25, G.SubwayGif.opacity - (500 * dt), 255)
    else 
        G.SubwayGif.opacity = clamp(25, G.SubwayGif.opacity + (1000 * dt), 255)
    end

    if math.random(1, 50000) == 1 then
        -- wfoxy.activate()
        play_sound('SubwayS_jumpscaresfx', 1, 0.8)
    end

end

function Game:draw()
    gameDrawRef(self)

    local _xscale = love.graphics.getWidth() / 1920
    local _yscale = love.graphics.getHeight() / 1080

    if G.SubwayGif.show_gif then
        local frame = G.SubwayGif.subway_frames[G.SubwayGif.subway_current_frame]
        if frame then
            love.graphics.setColor(1, 1, 1, G.SubwayGif.opacity / 255)
            love.graphics.draw(frame, G.SubwayGif.pos_x, G.SubwayGif.pos_y, 0, _xscale, _yscale)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end
end

----------------------------------------------
------------MOD CODE END----------------------