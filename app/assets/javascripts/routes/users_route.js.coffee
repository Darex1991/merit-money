Sks.UsersRoute = Ember.Route.extend
  setupController: (controller, model) ->
    @controllerFor('users').set 'content', Sks.User.find()
    @controllerFor('currentUser').set 'content', Sks.CurrentUser.find(1)
    @controllerFor('top').set 'content', Sks.Top.find()
    @controllerFor('hamsters').set 'content', Sks.Hamster.find()