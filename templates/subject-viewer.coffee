translate = require 'zooniverse/lib/translate'

module.exports = -> """
  <div class="drawing-controls">
    <label class="readymade-has-clickable">
      <input type="checkbox" name="favorite" />
      <span class="readymade-clickable">
        #{translate 'readymade.favoriteIcon'}
        #{translate 'readymade.favoriteIconChecked'}
        <span>#{translate 'readymade.favorite'}</span>
      </span>
    </label>

    <label class="readymade-has-clickable">
      <input type="checkbox" name="hide-old-marks" />
      <span class="readymade-clickable">
        #{translate 'readymade.hideOldMarksIcon'}
        #{translate 'readymade.hideOldMarksIconChecked'}
        <span>#{translate 'readymade.hideOldMarks'}</span>
      </span>
    </label>

    <button name="restart-tutorial">
      <span class="readymade-clickable">
        #{translate 'readymade.tutorialIcon'}
        <span>#{translate 'readymade.restartTutorial'}</span>
      </span>
    </button>
    
    <button id="zoom-in" class="readymade-clickable">
        <i class="fa fa-search-plus"></i>
        <span>Zoom in</span>
      </span>
    </button>
    
    <button id="zoom-out" class="readymade-clickable">
        <i class="fa fa-search-minus"></i>
        <span>Zoom out</span>
      </span>
    </button>
  </div>

  <div class="readymade-marking-surface-container"></div>

  <div class="readymade-frame-controls">
    <div class="readymade-frame-play-controls">
      <button name="play-frames">►</button>
      <button name="pause-frames">◼</button>
    </div>

    <div class="readymade-frame-toggles-list"></div>
  </div>
"""
