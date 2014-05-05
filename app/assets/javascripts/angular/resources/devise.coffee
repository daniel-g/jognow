window.app.service('Session', ['$resource', ($resource)->
  $resource('users/:id.json', {}, {
    signIn: {
      params: { id: 'sign_in' },
      method: 'POST',
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      }
    }
    signOut: {
      params: { id: 'sign_out' },
      method: 'DELETE',
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      }
    }
  })
])

window.app.service('User', ['$resource', ($resource)->
  $resource('users/:id.json', {}, {
  })
])
