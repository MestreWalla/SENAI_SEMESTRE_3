package webapp.helloworld.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import webapp.helloworld.model.Disciplina;
import webapp.helloworld.model.Professor;
import webapp.helloworld.repository.DisciplinaRepository;
import webapp.helloworld.repository.ProfessorRepository;

import java.util.ArrayList;
import java.util.List;

@Controller
public class DashboardProfessorController {

    private static final Logger logger = LoggerFactory.getLogger(DashboardProfessorController.class);

    @Autowired
    private ProfessorRepository professorRepository;
    @Autowired
    private DisciplinaRepository disciplinaRepository; // Adicione esta linha

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
            // Recuperar as disciplinas do banco de dados
            List<Disciplina> disciplinas = disciplinaRepository.findAll();

            // Passar as disciplinas para a visualização
            model.addAttribute("disciplinas", disciplinas);

            model.addAttribute("professor", professor);
            return "editar-professor";
        } else {
            return "redirect:/professores-dash?error=Professor não encontrado";
        }
    }

    @PostMapping("/salvar-edicao-professor")
    public String salvarEdicaoProfessor(Professor professor) {
        // Verifica se o professor existe no banco de dados
        Professor professorExistente = professorRepository.findByCpf(professor.getCpf());
        if (professorExistente != null) {
            // Atualiza os dados do professor
            professorExistente.setUsername(professor.getUsername());
            professorExistente.setEmail(professor.getEmail());
            professorExistente.setDisciplina(professor.getDisciplina());

            // Salva as alterações no banco de dados
            professorRepository.save(professorExistente);

            // Redireciona para a página do painel de professores com uma mensagem de
            // sucesso
            return "redirect:/professor-dash?success=Professor editado com sucesso";
        } else {
            // Se o professor não for encontrado, redireciona com uma mensagem de erro
            return "redirect:/professor-dash?error=Professor não encontrado";
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
