package webapp.crud_escola.repository;

import org.springframework.data.repository.CrudRepository;

import webapp.crud_escola.model.Administrador;

public interface AdministradorCadasto extends CrudRepository<Administrador, String> {
    Administrador findByUsername(String username);
}
