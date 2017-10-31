timesFunction = (block) ->
  if typeof block is not 'function'
    throw new TypeError('Callback is not a function')
  else if isNaN(parseInt(Number(this.valueOf())))
    throw new TypeError("Object is not a valid number")
  else  
    for i in [1..this.valueOf()]
      block(i)
      

Number.prototype.krat = timesFunction

# Number.prototype.times = timesFunction
# home.coffeeNumber.prototype.times = timesFunction

5.krat (i) ->
  console.info i  
