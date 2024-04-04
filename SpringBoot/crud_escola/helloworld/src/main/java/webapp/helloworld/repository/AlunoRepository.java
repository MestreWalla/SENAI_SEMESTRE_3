package webapp.helloworld.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import webapp.helloworld.model.Aluno;

@Repository
public interface AlunoRepository extends CrudRepository<Aluno, String> {
    Aluno findByUsername(String username);

    Aluno findByCpf(String cpf);

    Aluno findByEmail(String email);

    Aluno findByProfessor01(String professor01);

    Aluno findByProfessor02(String professor02);

    Aluno findByMateria01(String materia01);

    Aluno findByMateria02(String materia02);
}
