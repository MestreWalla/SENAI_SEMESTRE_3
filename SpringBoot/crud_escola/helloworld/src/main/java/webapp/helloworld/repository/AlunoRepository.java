package webapp.helloworld.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import webapp.helloworld.model.Administrador;
import webapp.helloworld.model.Aluno;
import java.util.List;


@Repository
public interface AlunoRepository extends CrudRepository<Aluno, String> {
    Aluno findByUserName(String username);
    Aluno findByCpf(String cpf);
    Aluno findByEmail(String email);
    Aluno findByProfessor01(String professor01);
    Aluno findByProfessor02(String professor02);
    Aluno findByMateria01(String materia01);
    Aluno findByMateria02(String materia02);
    
    // Correção na consulta por nome de usuário
    @Query("SELECT a FROM Aluno a WHERE a.username LIKE %:username%")
    List<Aluno> findByUsername(@Param("username") String username);
    void save(Administrador adm);
}
