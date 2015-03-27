DecisionTree = require 'zooniverse-decision-tree'
RadioTask = require 'zooniverse-readymade/lib/tasks/radio'

class OrchidFilterTask extends RadioTask
  @type: 'accessible-filter'
  
  choiceTemplate: require '../templates/filter-choice'

  filters: null

  currentFilters: null

  buttons: null
  menus: null
  clearButtons: null
  dropdowns: null

  filtersTemplate: -> "
    <div class='readymade-classification-filters'>
      #{("
        <div class='readymade-classification-filter'>
          <label for='#{filter.key}-filter' class='readymade-filter-button'>#{filter.label}</label>

          <select id=#{filter.key}-filter class='readymade-filter-menu'>
              <option value=''>Any</option>
              #{("<option value=#{option.value}>#{option.label}</option>" for option, o in filter.values).join '\n'}
          </select>
        </div>
      " for filter, i in @filters).join '\n'}
    </div>
  "

  constructor: ->
    super
    @currentFilters ?= {}
    @reflectFilter()

  renderTemplate: ->
    super
    questionEl = @el.querySelector '.decision-tree-question'
    questionEl.insertAdjacentHTML 'afterEnd', @filtersTemplate()

    filtersEl = @el.querySelector '.readymade-classification-filters'

    @buttons = Array::slice.call filtersEl.querySelectorAll '.readymade-filter-button'
    @menus = Array::slice.call filtersEl.querySelectorAll '.readymade-filter-menu'
    
  getChoice: ->
    checkedInput = @el.querySelector 'input[type=radio]:checked'
    choiceIndex = checkedInput?.getAttribute 'data-choice-index'
    @choices[choiceIndex]

  enter: ->
    super
    for i in [0...@menus.length]
      @menus[i].addEventListener 'change', this

  exit: ->
    for i in [0...@menus.length]
      @menus[i].removeEventListener 'change', this
    super

  handleEvent: (e) ->
    if e.type is 'change' and e.currentTarget in @menus
      @handleFilterChange @menus.indexOf e.currentTarget
    else
      super

  handleFilterChange: (index) ->
    value = @menus[index].value
    if value
      @currentFilters[@filters[index].key] = value
    else
      @clearFilter index

    @reflectFilter @currentFilters

  clearFilter: (index) ->
    @menus[index].value = ''
    delete @currentFilters[@filters[index].key]
    @reflectFilter @currentFilters
  
  clearFilters: ->
    @clearFilter i for filter, i in @filters

  reflectFilter: (filterSettings) ->
    choiceEls = @el.querySelectorAll '.decision-tree-choice'
    for choice, i in choiceEls
      choice.removeAttribute 'aria-hidden'
      for key, value of filterSettings
        unless value in @choices[i].traits[key]
          choice.setAttribute 'aria-hidden', true

DecisionTree.registerTask OrchidFilterTask

DecisionTree.FilterTask = OrchidFilterTask
module.exports = OrchidFilterTask
