//= require active_admin/base
//= require imask/dist/imask.min

$(function() {
  if (location.pathname === "/admin/employees" || location.pathname === "/admin") {
    $('#employees').addClass("current");
  }

  $('.admin_shifts .time-input').each(function(_i, input) {
    new IMask(input, {
      mask: 'HH:MM D{M}',
      lazy: false,
      groups: {
        HH: new IMask.MaskedPattern.Group.Range([0, 12]),
        MM: new IMask.MaskedPattern.Group.Range([0, 59]),
        D: new IMask.MaskedPattern.Group.Enum(['A', 'P'])
      }
    });
  });

  $('#email_role_input #email_role').on('change', function() {
    if (this.value === 'employee') {
      $('#email_facilities_input').show();
      $('.employee-position').show();
      $('#email_position_id').val($('.employee-position')[0].value);
      $('.manager-position').hide();
    } else if (this.value === 'manager') {
      $('#email_facilities_input').hide();
      $('.manager-position').show();
      $('#email_position_id').val($('.manager-position')[0].value);
      $('.employee-position').hide();
    }
  });
});
