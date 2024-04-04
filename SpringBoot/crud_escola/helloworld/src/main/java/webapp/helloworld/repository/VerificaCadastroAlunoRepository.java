package webapp.helloworld.repository;

import org.springframework.data.repository.CrudRepository;
import webapp.helloworld.model.VerificaCadastroAdm;

public interface VerificaCadastroAlunoRepository extends CrudRepository<VerificaCadastroAdm, String> {
    VerificaCadastroAdm findByCpf (String cpf);
    VerificaCadastroAdm findByUsername (String username);
}