jQuery ->
    $('#company_company_name').autocomplete
    source: $('#company_company_name').data('autocomplete-source')