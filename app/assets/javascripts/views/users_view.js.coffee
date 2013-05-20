Sks.UsersView = Ember.View.extend
  elementId: 'kudos-users-view'

  didInsertElement: ->
    showRow = ($row) ->
      $active = $row.siblings('.form-visible')

      # first hide all the active element
      $active.toggleView()

      # then show the clicked one
      $row.toggleView() if $row.get() isnt $active.get()

    # show hidden content on more button click
    @.$('#users-list').on 'click', '.more', (event) ->
      $row = $(this).parents '.coworker'
      showRow $row

      return false

    @.$('#users-list').on 'click', '.coworker', (event) ->
      showRow $ this

      return false