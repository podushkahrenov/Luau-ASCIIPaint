local vdot = vector.dot
local vlerp = vector.lerp
local ceil = math.ceil
local abs = math.abs
local writestring = buffer.writestring
local readstring = buffer.readstring

local ASCIIPaint, __class = {}, {}

function __class.setChar(self: ASCIIPaint, 
  pos: vector, char: string)

  local x = ceil(pos.x+self.width/2)
  local y = ceil(pos.y+self.height/2)

  if x < 1 or x > self.width-1 then return end
  if y < 1 or y > self.height then return end

  local index = (y-1) * (self.width+1) + x
  writestring(self.buffer, index, char, 1)
end

function __class.drawLine(self: ASCIIPaint, 
  v1: vector, v2: vector, char: string)

  local dir = v1 - v2
  if vdot(dir, dir) == 0 then return end

  local coord = if abs(dir.x) > abs(dir.y) then 
     dir.x else dir.y

  for i = 0, abs(coord) do
    self:setChar(vlerp(v1, v2, i/coord), char)
  end
end

function __class.render(self: ASCIIPaint): string
  return readstring(self.buffer, 0, 
    self.height*(self.width+1)
  )
end

export type ASCIIPaint = {
  read buffer: buffer,
  read width: number,
  read height: number,
  
} & typeof(table.freeze(__class))

function ASCIIPaint.new(width: number, 
  height: number): ASCIIPaint

  local self = table.clone(__class)
  self.buffer = buffer.create(height*(width+1))
  self.width, self.height = width, height

  for y = 1, height-1 do
    writestring(self.buffer, y*(width+1), '\n', 1)
  end

  return table.freeze(self)
end

return table.freeze(ASCIIPaint)
