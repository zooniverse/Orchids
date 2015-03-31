translate = require 'zooniverse/lib/translate'

module.exports = -> """
  <div class="drawing-controls">
    
    <label class="readymade-has-clickable" title="Help">
      <input type="checkbox" name="help" />
      <span class="readymade-clickable small">
        <i class="fa fa-question readymade-clickable-not-checked"></i>
        <i class="fa fa-question readymade-clickable-checked" style="color: gold;"></i>
        <span>Help</span>
      </span>
    </label>
    
    <label class="readymade-has-clickable" title="Favourite">
      <input type="checkbox" name="favorite" />
      <span class="readymade-clickable small">
        #{translate 'readymade.favoriteIcon'}
        #{translate 'readymade.favoriteIconChecked'}
        <span>#{translate 'readymade.favorite'}</span>
      </span>
    </label>

    <button name="restart-tutorial" title="Restart tutorial">
      <span class="readymade-clickable small">
        #{translate 'readymade.tutorialIcon'}
        <span>#{translate 'readymade.restartTutorial'}</span>
      </span>
    </button>
    
  </div>

  <div class="readymade-marking-surface-container">
    <div class="drawing-controls">
      <button name="zoom-in" title="Zoom in">
        <span class="readymade-clickable small">
          <i class="fa fa-search-plus"></i>
          <span>Zoom in</span>
        </span>
      </button>
    
      <button name="zoom-out" title="Zoom out">
        <span class="readymade-clickable small">
          <i class="fa fa-search-minus"></i>
          <span>Zoom out</span>
        </span>
      </button>
    </div>
  </div>

  <div class="readymade-frame-controls">
    <div class="readymade-frame-play-controls">
      <button name="play-frames">►</button>
      <button name="pause-frames">◼</button>
    </div>

    <div class="readymade-frame-toggles-list"></div>
  </div>
"""
