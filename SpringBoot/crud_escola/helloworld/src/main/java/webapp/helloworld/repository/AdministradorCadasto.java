package webapp.helloworld.repository;

import org.springframework.data.repository.CrudRepository;

import webapp.helloworld.model.Administrador;

public interface AdministradorCadasto extends CrudRepository<Administrador, String> {
    Administrador findByUsername(String username);
}
