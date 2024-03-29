package webapp.helloworld.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import webapp.helloworld.model.Aluno;

@Repository
public interface AlunoRepository extends CrudRepository<Aluno, String> {
    Aluno findByCpf (String cpf);
    Aluno findByUsername (String username);
    Aluno findByEmail (String email);
}
