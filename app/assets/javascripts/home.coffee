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
obdelnik(10,10, 300,300,'blue')
kruh(34,20,50,'red')
cara(50,5,0,50,'black')
  """

  obdelnik = ->
    r = new fabric.Rect(
      left: 100,
      top: 100,
      fill: 'red',
      width: 20,
      height: 20
    )
    canvas.add(r)
  

  draw = ->
    x += 10
    obdelnik()
    
  setInterval draw, 100
  editor.setValue(sample)
    



