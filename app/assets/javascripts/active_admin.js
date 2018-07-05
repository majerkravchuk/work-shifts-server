//= require active_admin/base
//= require imask/dist/imask.min
//= require activeadmin/trumbowyg/trumbowyg
//= require activeadmin/trumbowyg_input

$(function() {
  if (location.pathname === "/admin/employees" || location.pathname === "/admin") {
    $('#employees').addClass("current");
  }

  $('.admin_shifts .time-input').each(function(_i, input) {
    new IMask(input, {
      mask: 'HH:MM D{m}',
      lazy: false,
      groups: {
        HH: new IMask.MaskedPattern.Group.Range([0, 12]),
        MM: new IMask.MaskedPattern.Group.Range([0, 59]),
        D: new IMask.MaskedPattern.Group.Enum(['a', 'p'])
      }
    });
  });

  $('#allowed_email_role_input #allowed_email_role').on('change', function() {
    if (this.value === 'employee') {
      $('#allowed_email_facilities_input').show();
      $('.employee-position').show();
      $('#allowed_email_position_id').val($('.employee-position')[0].value);
      $('.manager-position').hide();
    } else if (this.value === 'manager') {
      $('#allowed_email_facilities_input').hide();
      $('.manager-position').show();
      $('#allowed_email_position_id').val($('.manager-position')[0].value);
      $('.employee-position').hide();
    }
  });
});
