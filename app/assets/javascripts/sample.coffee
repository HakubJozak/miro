x = 0
y = 0
sx = 5
sy = 5

VYSKA = 300
SIRKA = 500 

snimek = ->
  vymaz()
  kruh(x,y,25,'green')

  if x > SIRKA
    sx = -5
  else if x < 0
    sx = 5  

  if y > VYSKA
    sy = -sy
  else if y < 0
    sy = 5
              
  x += sx
  y += sy
