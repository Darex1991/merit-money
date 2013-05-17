Sks.UserInUsersView = Em.View.extend
  tagName: 'li'
  templateName: 'user_in_users'
  classNames: 'coworker'
  attributeBindings: ['data-userid']
  'data-useridBinding': 'content.id'

  didInsertElement: ->
    # todo - init only once per element
    $('.stars').raty
      path: 'assets/raty'
      size: 54
      score: 1
      hints: ['', '', '', '', '']
