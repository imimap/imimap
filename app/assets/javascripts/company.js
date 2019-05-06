jQuery(function() {
  return $('#company_name').autocomplete({
    source: $('#company_name').data('autocomplete-source')
  });
});
