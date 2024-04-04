package webapp.helloworld.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import webapp.helloworld.model.Aluno;
import webapp.helloworld.repository.AlunoRepository;

import java.util.ArrayList;
import java.util.List;

@Controller
public class DashboardAlunoController {

    private static final Logger logger = LoggerFactory.getLogger(DashboardAlunoController.class);

    @Autowired
    private AlunoRepository alunoRepository;

    // Mantendo o mapeamento para /dashboard-aluno neste controlador
    @GetMapping("/alunos-dash")
    public String dashboardAluno(Model model) {
        Iterable<Aluno> alunosIterable = alunoRepository.findAll();

        List<Aluno> alunosList = new ArrayList<>();
        alunosIterable.forEach(alunosList::add);

        model.addAttribute("alunos", alunosList);

        int numAlunos = alunosList.size();
        System.out.println(String.format("Número de alunos recuperados do banco de dados: %d", numAlunos));
        logger.info("Número de alunos recuperados do banco de dados: {}", numAlunos);

        for (Aluno aluno : alunosList) {
            logger.info("Nome do aluno: {}", aluno.getUsername());
        }

        return "alunos-dash";
    }
}
