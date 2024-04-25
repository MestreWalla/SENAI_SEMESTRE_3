package webapp.helloworld.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import webapp.helloworld.model.Disciplina;
import webapp.helloworld.model.Professor;

@Repository
public interface ProfessorRepository extends CrudRepository<Professor, Long> {
    Professor findByUsername(String username);
    Professor findByCpf(String cpf);
    Professor findByEmail(String email);
     // Método para encontrar um professor por disciplina
    Professor findByDisciplina(Disciplina disciplina);
}

