# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.snimek  = null


# document.addEventListener "turbolinks:load", ->
$(document).ready ->
  field  = $('#mi-editor')[0]
  editor = CodeMirror.fromTextArea(field, lineNumbers: true, autofocus: true, mode: 'coffeescript')

  canvas = new fabric.Canvas('mi-canvas', renderOnAddRemove: false)
  canvas.setHeight(300)
  canvas.setWidth(500)
  x = 0

  sample = """
x = 0
y = 0
sx = 5
sy = 5

VYSKA = 500
SIRKA = 300 

snimek = ->
  vymaz()
  obdelnik(x,y,25,100, 'red')

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
  """

  vymaz = ->
    canvas.clear()

  obdelnik = (x,y,w,h,color = 'black',angle = 0) ->
    canvas.add new fabric.Rect(
      left: x,
      top: y,
      fill: color,
      width: w,
      height: h,
      angle: angle
    )

  kruh = (x,y,r,color = 'black') ->
    canvas.add new fabric.Circle(
      left: x,
      top: y,
      radius: r,
      fill: color,
    )

  trojuhelnik = (x,y,w,h,color = 'black',angle = 0) ->
    canvas.add new fabric.Triangle(
      left: x,
      top: y,
      width: w,
      height: h,
      angle: angle,
      fill: color
    )

  cara = (x,y,w,h,color = 'black',angle = 0) ->
    canvas.add(new fabric.Line([0,0,w,h], {
        left: x,
        top: y,
        stroke: color
        angle: angle
    }));

    canvas.add new fabric.Line(
      left: x,
      top: y,
      width: w,
      height: h,
      angle: angle,
      fill: color
    )

  stop = ->
    window.snimek = null

  drawFrame = ->
    if typeof window.snimek is 'function'
      window.snimek()
      canvas.renderAll()


  $('#mi-run-btn').click (e) ->
    e.preventDefault()

    try     
      console.info 'Compiling'
      source = editor.getValue()
      js = CoffeeScript.compile(source, { bare: true })
      console.info js

      console.info 'Evaluating'
      eval(js)
      window.snimek = snimek
    catch e
      alert "Chyba: #{e.message}"




  $('#mi-stop-btn').click (e) ->
    e.preventDefault()
    stop()

  $('#mi-clear-btn').click (e) ->
    e.preventDefault()
    canvas.clear()

  editor.setValue(sample)

  FPS = 30
  setInterval drawFrame, 1000 / FPS
