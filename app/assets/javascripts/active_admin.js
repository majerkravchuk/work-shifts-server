//= require active_admin/base
//= require activeadmin_addons/all

$(function() {
  if (location.pathname === "/admin/employees" || location.pathname === "/admin") {
    $('#employees').addClass("current");
  }
});
