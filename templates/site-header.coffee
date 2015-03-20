module.exports = (context) ->
  template = ->
    """
      <div class='readymade-creator'>
        <a href='#/'>
          <h1 class='readymade-project-title'><img src="logo.png" alt="#{@title}" width=200></h1>
        </a>
      </div>

      <ul class='readymade-site-links' role='navigation'></ul>
    """
  template.call context
