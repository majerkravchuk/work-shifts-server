document.addEventListener('DOMContentLoaded', function() {
  if (location.pathname === '/admin/employees' || location.pathname === '/admin') {
    document.getElementById('employees').classList.add('current');
  }

  if (gon.availableBusinesses.length > 0) {
    const parentMenu = document.getElementById('switch_current_business');
    const list = parentMenu.querySelector('ul');
    list.innerHTML = '';

    gon.availableBusinesses.forEach(function(business) {
      const item = document.createElement('li');
      item.setAttribute('id', `business_${business.id}`);

      const link = document.createElement('a');
      link.setAttribute('href', `/admin/businesses/switch?business=${business.id}`);
      link.innerText = business.name;

      item.appendChild(link);
      list.appendChild(item);
    });
  }
});
