document.addEventListener('DOMContentLoaded', function () {
    const loginLink = document.getElementById('loginLink');
    const modal = document.querySelector('.modal');

    loginLink.addEventListener('click', function (event) {
        event.preventDefault(); // Evita a ação padrão do link (navegar para "#" no topo da página)
        modal.style.display = 'block'; // Exibe o modal
    });
});
