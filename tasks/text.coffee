DecisionTree = require 'zooniverse-decision-tree'

class TextTask extends DecisionTree.Task
  @type: 'text'
  
  defaults: {}
  
  choiceTemplate: (choice, i) -> "
  <label class=''>

      #{if choice.image? then "<div class='readymade-choice-image'><img src='#{choice.image}' /></div>" else ''}

      <span class='readymade-choice-label'>#{choice.label ? choice.value ? i}</span>
      
      <input type= #{choice.type ? 'text'}
        name='#{choice.key}'
        value='#{choice.value}'
        data-choice-index='#{i}'
        #{ if choice.length then "size=" + choice.length else ""}
        #{ if choice.disabled then "disabled" else ""}
      />
  </label>
  "
  
  getValue: ->
    output = {}
    inputs = @el.querySelectorAll "input[type]"
    output[input.name] = input.value for input in inputs
    
    output
    
  reset: (values) ->
    values ?= @defaults
    inputs = @el.querySelectorAll "input[type]"
    input.value = '' for input in inputs
    
    for name of values
      input = @el.querySelector "input[name=#{name}]"
      input.value = values[name] if input
  
  setDefaults: (values) ->
    @defaults[name] = values[name] for name of values
    
    
DecisionTree.registerTask TextTask

DecisionTree.TextTask = TextTask
module.exports = TextTask