package webapp.helloworld.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import webapp.helloworld.model.Professor;
import webapp.helloworld.repository.ProfessorRepository;

import java.util.ArrayList;
import java.util.List;

@Controller
public class DashboardProfessorController {

    private static final Logger logger = LoggerFactory.getLogger(DashboardProfessorController.class);

    @Autowired
    private ProfessorRepository professorRepository;

    @GetMapping("/professor-dash")
    public String dashboardProfessor(Model model) {
        Iterable<Professor> professoresIterable = professorRepository.findAll();

        List<Professor> professoresList = new ArrayList<>();
        professoresIterable.forEach(professoresList::add);

        model.addAttribute("professores", professoresList);

        int numProfessores = professoresList.size();
        logger.info("Número de professores recuperados do banco de dados: {}", numProfessores);

        for (Professor professor : professoresList) {
            logger.info("Nome do professor: {}", professor.getUsername());
        }

        return "professor-dash";
    }

    @GetMapping("/editar-professor/{cpf}")
    public String editarProfessor(@PathVariable String cpf, Model model) {
        Professor professor = professorRepository.findByCpf(cpf);

        if (professor != null) {
            model.addAttribute("professor", professor);
            return "editar-professor";
        } else {
            return "redirect:/professores-dash?error=Professor não encontrado";
        }
    }

    @GetMapping("/excluir-professor/{cpf}")
    public String excluirProfessor(@PathVariable String cpf) {
        Professor professor = professorRepository.findByCpf(cpf);

        if (professor != null) {
            professorRepository.delete(professor);
            return "redirect:/professores-dash?success=Professor excluído com sucesso";
        } else {
            return "redirect:/professores-dash?error=Professor não encontrado";
        }
    }
}
