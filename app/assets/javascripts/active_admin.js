//= require active_admin/base

document.addEventListener("DOMContentLoaded", function() {
  if (location.pathname === "/admin/employees") {
    var el = document.getElementById('employees');

    if (el && !el.classList.contains('current')) {
      el.classList.add('current');
    }
  }
});
