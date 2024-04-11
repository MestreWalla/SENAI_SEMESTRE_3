package webapp.helloworld.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import webapp.helloworld.model.Aluno;
import webapp.helloworld.model.Professor;
import webapp.helloworld.repository.AlunoRepository;
import webapp.helloworld.repository.ProfessorRepository;

@Controller
public class DashboardAdmController {

    private static final Logger logger = LoggerFactory.getLogger(DashboardAdmController.class);

    @Autowired
    private AlunoRepository alunoRepository;

    @Autowired
    private ProfessorRepository professorRepository;

    @GetMapping("/dashboard-adm")
    public String showDashboard(Model model) {
        // Obter os alunos do banco de dados
        Iterable<Aluno> alunosIterable = alunoRepository.findAll();
        List<Aluno> alunosList = new ArrayList<>();
        alunosIterable.forEach(alunosList::add);

        // Obter os professores do banco de dados
        Iterable<Professor> professoresIterable = professorRepository.findAll();
        List<Professor> professoresList = new ArrayList<>();
        professoresIterable.forEach(professoresList::add);

        // Adicionar alunos e professores ao modelo
        model.addAttribute("alunos", alunosList);
        model.addAttribute("professores", professoresList);

        // Log do número de alunos recuperados do banco de dados
        int numAlunos = alunosList.size();
        logger.info("Número de alunos recuperados do banco de dados: {}", numAlunos);

        // Log dos nomes dos alunos recuperados
        for (Aluno aluno : alunosList) {
            logger.info("Nome do aluno: {}", aluno.getUsername());
        }

        // Log do número de professores recuperados do banco de dados
        int numProfessores = professoresList.size();
        logger.info("Número de professores recuperados do banco de dados: {}", numProfessores);

        // Log dos nomes dos professores recuperados
        for (Professor professor : professoresList) {
            logger.info("Nome do professor: {}", professor.getUsername());
        }

        return "dashboard-adm";
    }
}
