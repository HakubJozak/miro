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
snimek = ->
  vymaz()
  obdelnik(250,150,500,300,'blue')
  obdelnik(250,250,500,100,'green')
  obdelnik(200,250,200,100,'grey')
  trojuhelnik(100,250,100,100,'grey')
  trojuhelnik(300,250,100,100,'grey',180)

  obdelnik(250,150,80,150,'black')
  obdelnik(250,250,25,100)
  kruh(250,110,15,'green')
  kruh(250,150,15,'orange')
  kruh(250,190,15,'red')
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

    console.info 'Compiling'
    source = editor.getValue()
    js = CoffeeScript.compile(source, { bare: true })
    console.info js

    console.info 'Evaluating'
    eval(js)
    window.snimek = snimek


  $('#mi-stop-btn').click (e) ->
    e.preventDefault()
    stop()

  $('#mi-clear-btn').click (e) ->
    e.preventDefault()
    canvas.clear()

  editor.setValue(sample)

  FPS = 30
  setInterval drawFrame, 1000 / FPS
