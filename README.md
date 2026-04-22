# Luau-ASCIIPaint

Create **ASCII images** on Luau

### Example: 
```luau
local Paint = ASCIIPaint.new(50, 50)

Paint:drawLine(
  vector.create(5, 5),
  vector.create(-5, -5),

  '$'
)

print(Paint:render())
```
