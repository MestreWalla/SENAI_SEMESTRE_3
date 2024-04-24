package webapp.helloworld.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import webapp.helloworld.model.Disciplina;
import webapp.helloworld.repository.DisciplinaRepository;

@Controller
public class CadastroDisciplinaController {
    @Autowired
    private DisciplinaRepository disciplinaRepository;

    @PostMapping("/salvar-disciplina")
    public String postCadastroDisciplina(Disciplina disciplina) {
        disciplinaRepository.save(disciplina);
        // Após o cadastro ser realizado com sucesso, redirecionar para a página de sucesso
        return "redirect:/cadastro-disciplina?success=true";
    }
}
