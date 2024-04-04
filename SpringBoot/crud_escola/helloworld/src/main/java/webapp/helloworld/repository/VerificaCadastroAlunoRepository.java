package webapp.helloworld.repository;

import org.springframework.data.repository.CrudRepository;
import webapp.helloworld.model.VerificaCadastroAdm;
import webapp.helloworld.model.VerificaCadastroAluno;

public interface VerificaCadastroAlunoRepository extends CrudRepository<VerificaCadastroAdm, String> {
    VerificaCadastroAluno findByCpf (String cpf);
    VerificaCadastroAdm findByUsername (String username);
}