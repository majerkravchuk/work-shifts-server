//= require active_admin/base
//= require imask/dist/imask.min
//= require simple-jscalendar/source/jsCalendar

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
});
