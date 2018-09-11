document.addEventListener('DOMContentLoaded', function() {
  if (location.pathname === '/admin/employees' || location.pathname === '/admin') {
    document.getElementById('employees').classList.add('current');
  }

  if (gon.availableBusinesses.length > 0) {
    let parentMenu = document.getElementById('switch_current_business');
    let list = parentMenu.querySelector('ul');
    list.innerHTML = '';

    gon.availableBusinesses.forEach(function(business) {
      let item = document.createElement('li');
      item.setAttribute('id', `business_${business.id}`);

      let link = document.createElement('a');
      link.setAttribute('href', `/admin/businesses/switch?business=${business.id}`);
      link.innerText = business.name;

      item.appendChild(link);
      list.appendChild(item);
    });
  }
});
