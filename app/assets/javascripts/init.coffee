class Page
  controller: () =>
    $('meta[name=psj]').attr('controller')

  action: () =>
    $('meta[name=psj]').attr('action')

@page = new Page
