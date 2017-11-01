# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener "turbolinks:load", ->
  field  = $('#mi-editor')[0]
  editor = CodeMirror.fromTextArea(field, lineNumbers: true, autofocus: true, mode: 'coffeescript')

  canvas = new fabric.Canvas('mi-canvas')
  canvas.setHeight(300)
  canvas.setWidth(500)
  x = 0

  sample = """
# obdelnik(10,10, 300,300,'blue')
# kruh(34,20,50,'red')
cara(0,5,100,50,'black',45)
  """

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

  draw = ->
    cara(150,200,150,150,'orange')

  $('#mi-run-btn').click (e) ->
    e.preventDefault()
    console.info 'Compiling'
    source = editor.getValue()
    js = CoffeeScript.compile(source, { bare: true })
    console.info js

    console.info 'Drawing'
    eval(js)

  $('#mi-clear-btn').click (e) ->
    e.preventDefault()
    canvas.clear()          

    
  # setInterval draw, 10
  editor.setValue(sample)
  console.info 'loaded'
