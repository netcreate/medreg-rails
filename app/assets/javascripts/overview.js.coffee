window.changeGroup = (event) ->
  groupId = event.target.options[event.target.selectedIndex].value

  unless isNaN(groupId)
    Turbolinks.visit '?group_id=' + groupId
