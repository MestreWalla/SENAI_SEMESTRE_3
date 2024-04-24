package webapp.helloworld.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import webapp.helloworld.model.Disciplina;

public interface DisciplinaRepository extends JpaRepository<Disciplina, Integer> {
    Disciplina findByNome(String nome);
}