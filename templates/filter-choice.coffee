# This is not a proper eco template at the moment because it takes arguments.

module.exports = (choice, i) -> "
  <label class='readymade-choice-input-wrapper'>
    <input type='radio'
      name='#{@key}'
      value='#{choice.value}'
      #{if choice.checked then 'checked="checked"' else ''}
      data-choice-index='#{i}'
    />

    <span class='readymade-choice-clickable readymade-choice-#{@constructor.type ? @type}'>

      #{if choice.image? then "<span class='readymade-choice-image'><img src='#{choice.image}' /></span>" else ''}

      <span class='readymade-choice-label'>#{choice.label ? choice.value ? i}</span>

      #{if choice.color? then "<span class='readymade-choice-color' style='color: #{choice.color};'></span>" else ''}
    </span>
  </label>
"
