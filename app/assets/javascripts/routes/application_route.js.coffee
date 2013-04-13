Sks.ApplicationRoute = Ember.Route.extend
  events:
    addKudo: (user) ->
      self = @
      token = $('meta[name="csrf-token"]').attr 'content'
      currentUserCon = @controllerFor 'currentUser'
      kudosLeft = currentUserCon.get 'kudosLeft'
      $kudoSelect = $ '#kudos-add'
      $kudoComment = $ '#kudos-comment'
      kudoNum = parseInt $kudoSelect.val() || 1
      kudoComment = $kudoComment.val()

      showFlash = (type, message) ->
        $("#flash")
          .addClass(type)
          .empty()
          .append(message)
          .show()
          .fadeIn()
          .delay(2000)
          .fadeOut 'slow'

      kudo = Sks.Kudo.createRecord receiver_id: user.get('id'), value: kudoNum, comment: kudoComment
      $.post("/kudos", kudo: kudo.serialize(), authenticity_token: token)
      .done((data, status) =>
        if kudosLeft > 0
          currentUserCon.decrementKudos kudoNum
          #todo update view with a new current week kudo
          showFlash 'alert-success', 'You\'ve added a kudo!'
        else
          showFlash 'alert-error', 'There\'re no kudos left!'
      )
      .fail (data, status) ->
        showFlash 'alert-error', 'Oops! An error occured!'
      .always ->
          $kudoComment.val ''
