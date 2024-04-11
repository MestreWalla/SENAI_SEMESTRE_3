package webapp.helloworld.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import webapp.helloworld.model.Professor;
import webapp.helloworld.repository.ProfessorRepository;

@Controller
public class CadastroProfessorController {
    @Autowired
    private ProfessorRepository professorRepository;

    @PostMapping("/cadastro-professor")
    public String postCadastroProfessor(Professor professor) {
        // Definir manualmente o identificador
        professor.setId(1L); // Por exemplo, atribuindo o valor 1

        // Salvar o professor no banco de dados
        professorRepository.save(professor);

        // Após o cadastro ser realizado com sucesso
        return "redirect:/dashboard-adm?success=true";
    }

}
