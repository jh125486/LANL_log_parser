@UI =
  all: (context="body") ->
    instanceMethods = (v for k, v of @ when typeof v is "function") # grab all methods from class
    instanceMethods.shift() # remove 'all' method from array
    window[method(context)] for method in instanceMethods # fire off each method

  once: (context="body") ->
    $(context).popover selector: '[data-toggle="popover"]'
    $(context).tooltip selector: '[data-toggle="tooltip"]'

  bootstrap: (context="body") ->
    $('body').on 'click', 'button.close-popover', (event) ->
      $(@).closest('div.popover').prev('[data-toggle="popover"]').popover 'hide'

    $('body').on 'click', 'a.disabled', (event) ->
      event.preventDefault()

    $('form').on 'click', '.remove_fields', (event) ->
      $(@).next('input[type=hidden]').val('1')
      $(@).closest('fieldset').hide 'blind'

    $('form').on 'click', '.add_fields', (event) ->
      time = new Date().getTime()
      regexp = new RegExp($(@).data('id'), 'g')
      orderedFood = $(@).data('fields').replace(regexp, time)
      $(orderedFood).insertBefore($(@)).hide().slideDown('slow')

    $('.editable', context).editable()

    updateOrderTotal = ->
      sum = 0.0
      $('.ordered-food:visible select :selected').each ->
        sum += Number($(@).data('price'))
      $('#order-total').html '$' + sum.toFixed(2).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")
      $('#order-total').effect 'highlight'

    $('form').on 'change', '.ordered-food select', (event) ->
      updateOrderTotal()
    $('form').on 'click', '.ordered-food .remove_fields', (event) ->
      $(@).closest('.ordered-food').promise().done ->
        updateOrderTotal()

    $('.button-checkbox').each ->
      new CheckBox($(@))

  moment: (context="body") ->
    $('.timestamp', context).each ->
      dateFormat = 'LLL'
      $(@).html moment($(@).text()).format dateFormat

  datatables: (context="body") ->
    $('table[data-source]:not(.dataTable)', context).each ->
      resourceNames = $(@).data('resourcenames') || ['items', 'item', 'items']
      initialSortCol = $(@).find('thead > tr > th').not('[data-orderable="false"]').first().index()
      table = $(@).DataTable
        processing: true
        serverSide: true
        order: [initialSortCol, 'asc']
        ajax: $(@).data('source')
        pagingType: 'full_numbers'
        dom: $(@).data('dom') || 'lfrtip'
        saveState: false
        reponsive: true
        language:
          emptyTable: 'No ' + resourceNames[0] + ' available'
          info: 'Showing _START_ to _END_ of _TOTAL_ ' + resourceNames[2]
          infoEmpty: 'Showing 0 to 0 of 0 ' + resourceNames[0]
          infoFiltered: '(filtered from _MAX_ total ' + resourceNames[2] + ')'
          lengthMenu: 'Show _MENU_ ' + resourceNames[2]
          loadingRecords: 'Loading ' + resourceNames[2]
          processing: 'Crunching!'
          search: 'Search:'
          zeroRecords: 'No matching ' + resourceNames[2]
        drawCallback: (settings) ->
          UI.bootstrap(@)
      clearButton = $('<button type="button" disabled="disabled" class="btn btn-default"/>')
      clearButton.append $('<span class="glyphicon glyphicon-remove"/>')
      clearButton.click ->
        unless search.val() == ''
          $(@).prop 'disabled', true
          table.search('').draw()
      searchGroup = $('<div class="input-group col-md-6 col-sm-5"/>')
      lengthMenu = $(@).closest('.dataTables_wrapper').find('.dataTables_length')
      lengthMenu.addClass 'col-md-3 col-sm-4'
      filter = $(@).closest('.dataTables_wrapper').find('.dataTables_filter')
      filter.toggleClass 'dataTables_filter dataTables-toolbar well'
      search = filter.find 'input[type="search"]'
      search.attr 'placeholder', 'Search'
      search.removeClass 'input-sm'
      search.on 'keyup change cut paste', ->
        clearButton.prop 'disabled', (search.val() == '')
      row = $('<div class="row"/>')
      refreshGroup = $('<div class="col-md-3 col-sm-3"/>')
      refreshButton = $('<button class="btn btn-default" type="button"/>')
      refreshIcon = $('<span class="glyphicon glyphicon-refresh"/>')
      refreshButton.html refreshIcon
      refreshButton.click ->
        table.ajax.reload()
      refreshGroup.append refreshButton
      searchGroup.append search
      searchGroup.append $('<span class="input-group-btn"/>').append(clearButton)
      filter.empty()
      filter.append lengthMenu
      filter.append refreshGroup
      filter.append searchGroup
      table.on('preXhr.dt', (e, settings, data) ->
        refreshIcon.addClass 'active'
      )
      table.on('xhr.dt', (e, settings, json, xhr) ->
        refreshIcon.removeClass 'active', 400
      )
    $('table.table:not(.simple):not(.dataTable)', context).each ->
      $(@).DataTable()
    $('table.table.simple:not(.dataTable)', context).each ->
      $(@).DataTable
        dom: 't'

  alerts: (context="body") ->
    window.setTimeout (->
      $('.alert:not(.stay)', context).fadeTo 500, 0, ->
        $(@).remove()
    ), 3500
